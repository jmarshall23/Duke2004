/**
 * Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 */

#include "UDKBase.h"

#if WITH_REALD
	#include "RealD/RealD.h"
#endif
 
IMPLEMENT_CLASS(AUDKEmitCameraEffect);
IMPLEMENT_CLASS(UUDKSkeletalMeshComponent);
IMPLEMENT_CLASS(UUDKExplosionLight);
IMPLEMENT_CLASS(AUDKEmitterPool);
IMPLEMENT_CLASS(AUDKVehicleMovementEffect);

void AUDKEmitCameraEffect::UpdateLocation( const FVector& CamLoc, const FRotator& CamRot, FLOAT CamFOVDeg )
{
	FRotationMatrix M(CamRot);

	// the particle is FACING X being parallel to the Y axis.  So we just flip the entire thing to face toward the player who is looking down X
 	const FVector& X = M.GetAxis(0);
	M.SetAxis(0, -M.GetAxis(0));
	M.SetAxis(1, -M.GetAxis(1));

  	const FRotator& NewRot = M.Rotator();

	const FLOAT DistAdjustedForFOV = DistFromCamera * appTan(float(CamFOVDeg*0.5f*PI/180.f)) / appTan(float(CamFOVDeg*0.5f*PI/180.f));

	SetLocation( CamLoc + X * DistAdjustedForFOV );
	SetRotation( NewRot );

	// have to do this, since in UWorld::Tick the actors do the component update for all
	// actors before the camera ticks.  without this, the blood appears to be a frame behind
	// the camera.
	ConditionalUpdateComponents();
}

void UUDKParticleSystemComponent::SetTransformedToWorld()
{
	// Only worry about this custom stuff if a custom FOV is set
	if (FOV != 0.0f)
	{
		if (bHasSavedScale3D)
		{
			Scale3D = SavedScale3D;
		}
		// call inherited implementation
		UParticleSystemComponent::SetTransformedToWorld();
		SavedScale3D = Scale3D;
		bHasSavedScale3D = TRUE;

		// WRH - 2007/07/25 - Assume that custom FOVs are only placed for 1st-person weapons, so we can get the
		// associated player controller and use that information to hack the local to world matrix with the custom
		// fov calculations
		if (Owner)
		{
			AActor* TopOwner = Owner->GetTopOwner();
			APlayerController* PC = Cast<APlayerController>(TopOwner);
			if (PC)
			{
				FVector ViewLocation(0,0,0);
				FRotator ViewRotation(0,0,0);
				PC->eventGetPlayerViewPoint( ViewLocation, ViewRotation );

				// WRH - 2007/07/25 - This code to calculate the View and Projection matrix is essentially copied from
				// ULocalPlayer::CalcSceneView().
				FMatrix ViewMatrix = FTranslationMatrix(-ViewLocation);
				ViewMatrix = ViewMatrix * FInverseRotationMatrix(ViewRotation);
				ViewMatrix = ViewMatrix * FMatrix(
					FPlane(0,	0,	1,	0),
					FPlane(1,	0,	0,	0),
					FPlane(0,	1,	0,	0),
					FPlane(0,	0,	0,	1));
				FLOAT PlayerFOV = PC->eventGetFOVAngle();
				
				// Don't need to consider aspect ratio when applying the custom FOV
				FPerspectiveMatrix ProjectionMatrix( PlayerFOV * (FLOAT)PI / 360.0f, 1, 1, GNearClippingPlane );
				FPerspectiveMatrix WarpedProjectionMatrix( FOV * (FLOAT)PI / 360.0f, 1, 1, GNearClippingPlane );

				LocalToWorld = LocalToWorld * ViewMatrix * WarpedProjectionMatrix * ProjectionMatrix.Inverse() * ViewMatrix.Inverse();
				LocalToWorldDeterminant = LocalToWorld.Determinant();

				// Determine the scale imparted by this warped matrix and set it in the component so particle updates will use it properly, since they
				// currently bypass the LocalToWorld matrix and use the Scale3D and Scale directly.
				FVector NewScale3D;
				for(INT i=0; i<3; i++)
				{
					const FLOAT SquareSum = (LocalToWorld.M[i][0] * LocalToWorld.M[i][0]) + (LocalToWorld.M[i][1] * LocalToWorld.M[i][1]) + (LocalToWorld.M[i][2] * LocalToWorld.M[i][2]);
					NewScale3D[i] = appSqrt(SquareSum);
				}
				Scale3D = NewScale3D;
			}
		}
	}
	else
	{
		UParticleSystemComponent::SetTransformedToWorld();
	}
}

/**
 * Helper function to set the IgnoreScale flag for mesh emitter instances
 */
static void SetIgnoreComponentsScale3D(const TArrayNoInit<FParticleEmitterInstance*>& EmitterInstances)
{
	for (INT i=0; i<EmitterInstances.Num(); i++)
	{
		FParticleEmitterInstance* Instance = EmitterInstances(i);
		FParticleMeshEmitterInstance* MeshInstance = CastEmitterInstance<FParticleMeshEmitterInstance>(Instance);
		if (MeshInstance)
		{
			MeshInstance->bIgnoreComponentScale = TRUE;
		}
	}
}

/**
 * Special version of init particles that ensures that meshes
 * spawned by this particle system will not inherit the custom FOV
 * of the component, since that is not desired.
 */
void UUDKParticleSystemComponent::InitParticles()
{
	UParticleSystemComponent::InitParticles();
	if (FOV != 0.0f)
	{
		SetIgnoreComponentsScale3D(EmitterInstances);
	}
}


void UUDKParticleSystemComponent::SetFOV(FLOAT NewFOV)
{
	FOV = NewFOV;
	if (FOV != 0.0f)
	{
		SetIgnoreComponentsScale3D(EmitterInstances);
	}
}

/*-----------------------------------------------------------------------------
  *	FUDKSkeletalMeshSceneProxy
  *	Support for rendering weapon at different FOV than world (for meshes drawn in first person view
  */
class FUDKSkeletalMeshSceneProxy : public FSkeletalMeshSceneProxy
{
public:
	FUDKSkeletalMeshSceneProxy(const USkeletalMeshComponent* Component, FLOAT InFOV )
	:	FSkeletalMeshSceneProxy(Component)
	,	FOV(InFOV)
	{
	}
	virtual ~FUDKSkeletalMeshSceneProxy()
	{
	}

	/**
	 * Returns the world transform to use for drawing.
	 * @param View - Current view
	 * @param OutLocalToWorld - Will contain the local-to-world transform when the function returns.
	 * @param OutWorldToLocal - Will contain the world-to-local transform when the function returns.
	 */
	virtual void GetWorldMatrices( const FSceneView* View, FMatrix& OutLocalToWorld, FMatrix& OutWorldToLocal )
	{
#if WITH_REALD
		if (FOV != 0.0f && !RealD::IsStereoEnabled())
#else
		if (FOV != 0.0f)
#endif
		{
			const FMatrix LocalToView = LocalToWorld * View->ViewMatrix;
			const FMatrix ViewToWarpedView =
				FPerspectiveMatrix(FOV * PI / 360.0f, View->SizeX, View->SizeY, View->NearClippingDistance) *
				View->ProjectionMatrix.Inverse();

			OutLocalToWorld = LocalToView * ViewToWarpedView * View->ViewMatrix.Inverse();
			OutWorldToLocal = OutLocalToWorld.Inverse();
		}
		else
		{
			OutLocalToWorld = LocalToWorld;
			OutWorldToLocal = LocalToWorld.Inverse();
		}
	}

	FORCEINLINE void SetFOV(FLOAT NewFOV)
	{
		FOV = NewFOV;
	}

	virtual DWORD GetMemoryFootprint( void ) const { return( sizeof( *this ) + GetAllocatedSize() ); }
	DWORD GetAllocatedSize( void ) const { return( FSkeletalMeshSceneProxy::GetAllocatedSize() ); }

private:
    FLOAT FOV;
};

FPrimitiveSceneProxy* UUDKSkeletalMeshComponent::CreateSceneProxy()
{
	FSkeletalMeshSceneProxy* Result = NULL;

	// Only create a scene proxy for rendering if properly initialized
	if( SkeletalMesh && 
		SkeletalMesh->LODModels.IsValidIndex(PredictedLODLevel) &&
		!bHideSkin &&
		MeshObject )
	{
		Result = ::new FUDKSkeletalMeshSceneProxy(this, FOV);
	}

	return Result;
}

void UUDKSkeletalMeshComponent::Tick(FLOAT DeltaTime)
{
	Super::Tick(DeltaTime);

	if ( bForceLoadTextures && (ClearStreamingTime < GWorld->GetWorldInfo()->TimeSeconds) )
	{
		eventPreloadTextures(FALSE, 0.f);
	}
}

void UUDKSkeletalMeshComponent::SetFOV(FLOAT NewFOV)
{
	if (FOV != NewFOV)
	{
		FOV = NewFOV;
		if (SceneInfo != NULL)
		{
			// tell the rendering thread to update the proxy's FOV
			ENQUEUE_UNIQUE_RENDER_COMMAND_TWOPARAMETER( UpdateFOVCommand, FPrimitiveSceneProxy*, Proxy, Scene_GetProxyFromInfo(SceneInfo), FLOAT, NewFOV, FOV,
														{
															((FUDKSkeletalMeshSceneProxy*)Proxy)->SetFOV(NewFOV);
														} );
		}
	}
}

/**
  * Reset light timeline position to start
  */
void UUDKExplosionLight::ResetLight()
{
	if ( !bEnabled)
	{
		bEnabled = TRUE;
		// flag as dirty to guarantee an update this frame
		BeginDeferredReattach();
	}

	TimeShiftIndex = 0;
	Lifetime = 0.f;
}

void UUDKExplosionLight::Attach()
{
	if (!bInitialized)
	{
		// pull initial light values from first TimeShift entry
		if (TimeShift.Num() > 0)
		{
			Radius = TimeShift(0).Radius;
			Brightness = TimeShift(0).Brightness;
			LightColor = TimeShift(0).LightColor;
		}
		bInitialized = TRUE;
	}

	Super::Attach();
}

/**
 * Updates time dependent state for this component.
 * Requires bAttached == true.
 * @param DeltaTime - The time since the last tick.
 */
void UUDKExplosionLight::Tick(FLOAT DeltaTime)
{
	DeltaTime *= GetOwner() ? GetOwner()->CustomTimeDilation : 1.f;

	Super::Tick(DeltaTime);

	if ( bEnabled )
	{
		if ( TimeShift.Num() <= TimeShiftIndex + 1 )
		{
			bEnabled = FALSE;
		}
		else
		{
			Lifetime += DeltaTime;
			if ( Lifetime > TimeShift(TimeShiftIndex+1).StartTime )
			{
				TimeShiftIndex++;
				if ( TimeShift.Num() <= TimeShiftIndex + 1 )
				{
					bEnabled = FALSE;
				}
			}
			if ( bEnabled )
			{
				// fade and color shift
				FLOAT InterpFactor = (Lifetime - TimeShift(TimeShiftIndex).StartTime)/(TimeShift(TimeShiftIndex+1).StartTime - TimeShift(TimeShiftIndex).StartTime);
				Radius = TimeShift(TimeShiftIndex).Radius * (1.f - InterpFactor) + TimeShift(TimeShiftIndex+1).Radius * InterpFactor;
				Brightness = TimeShift(TimeShiftIndex).Brightness * (1.f - InterpFactor) + TimeShift(TimeShiftIndex+1).Brightness * InterpFactor;
				LightColor.R = (BYTE)appTrunc(FLOAT(TimeShift(TimeShiftIndex).LightColor.R) * (1.f - InterpFactor) + FLOAT(TimeShift(TimeShiftIndex+1).LightColor.R) * InterpFactor);
				LightColor.G = (BYTE)appTrunc(FLOAT(TimeShift(TimeShiftIndex).LightColor.G) * (1.f - InterpFactor) + FLOAT(TimeShift(TimeShiftIndex+1).LightColor.G) * InterpFactor);
				LightColor.B = (BYTE)appTrunc(FLOAT(TimeShift(TimeShiftIndex).LightColor.B) * (1.f - InterpFactor) + FLOAT(TimeShift(TimeShiftIndex+1).LightColor.B) * InterpFactor);
				LightColor.A = (BYTE)appTrunc(FLOAT(TimeShift(TimeShiftIndex).LightColor.A) * (1.f - InterpFactor) + FLOAT(TimeShift(TimeShiftIndex+1).LightColor.A) * InterpFactor);
			}
		}
		BeginDeferredReattach();

		if (!bEnabled && DELEGATE_IS_SET(OnLightFinished))
		{
			delegateOnLightFinished(this);
		}
	}
}


void AUDKEmitterPool::TickSpecial(FLOAT DeltaTime)
{
	Super::TickSpecial(DeltaTime);

	INT i = 0;
	while (i < RelativeExplosionLights.Num())
	{
		if (RelativeExplosionLights(i).Light == NULL || RelativeExplosionLights(i).Base == NULL || RelativeExplosionLights(i).Base->bDeleteMe)
		{
			RelativeExplosionLights.Remove(i, 1);
		}
		else
		{
			FVector NewTranslation = RelativeExplosionLights(i).Base->Location + RelativeExplosionLights(i).RelativeLocation;
			if (RelativeExplosionLights(i).Light->Translation != NewTranslation)
			{
				RelativeExplosionLights(i).Light->Translation = NewTranslation;
				RelativeExplosionLights(i).Light->BeginDeferredUpdateTransform();
			}
			i++;
		}
	}
}


void AUDKVehicleMovementEffect::TickSpecial(FLOAT DeltaTime)
{
	if(AirEffect && Base)
	{
		FLOAT VelSq =Base->Velocity.SizeSquared();
		// First make sure we're moving fast enough to care:
		if(VelSq > MinVelocityForAirEffect)
		{
			UMaterialInstanceConstant* MIC = Cast<UMaterialInstanceConstant>(AirEffect->GetMaterial(0));
			// Set up the material data, if there is no material data create it.
			if(MIC)
			{
				FLOAT Result = Min(1.0f,Max(VelSq-MinVelocityForAirEffect,0.0f)/MaxVelocityForAirEffect);
				if(AirCurrentLevel - Result > 0)
				{
					AirCurrentLevel = Result;
				}
				else
				{
					FLOAT MaxDelta = AirMaxDelta*DeltaTime;
					if(Result-AirCurrentLevel > MaxDelta)
					{
						AirCurrentLevel = Result;
					}
					else
					{
						AirCurrentLevel += MaxDelta;
					}
				}
				MIC->SetScalarParameterValue(AirEffectScalar,AirCurrentLevel);
			}
			else
			{
				// EQUIVALENT TO: CreateAndSetMaterialInstanceConstant() in MeshComponent
				MIC = ConstructObject<UMaterialInstanceConstant>(UMaterialInstanceConstant::StaticClass(), AirEffect);
				if(MIC)
				{
					MIC->SetParent(AirEffect->GetMaterial(0));
					AirEffect->SetMaterial(0,MIC);
				}
			}
			AirEffect->SetHiddenGame(FALSE);
			
			// Here we take our current rotation, look at where we want to go, and set up a quaternion to perform the delta:
			FMatrix AirCurrentRotation = AirEffect->LocalToWorld; // where are
			AirCurrentRotation.SetAxis(2,FVector(0.f,0.f,0.f));
			FVector NewAirDir = -(Base->Velocity).SafeNormal(); // where want
			FVector CurrentAirDir = AirCurrentRotation.GetAxis(0).SafeNormal();
			FQuat DeltaAirQuat = FQuatFindBetween(CurrentAirDir,NewAirDir);
			FMatrix NewAirCurrentRotation = AirCurrentRotation * FQuatRotationTranslationMatrix(DeltaAirQuat,FVector(0,0,0));
			AirEffect->Rotation = NewAirCurrentRotation.Rotator();

			// Handy for debugging:
			//DrawDebugCoordinateSystem(Location,AirEffect->Rotation,500,FALSE);
			AirEffect->BeginDeferredUpdateTransform();
		}
		else
		{
			AirEffect->SetHiddenGame(TRUE);
		}
	}
}

