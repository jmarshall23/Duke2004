//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// Confidential.
//=============================================================================

#include "UDKBase.h"

IMPLEMENT_CLASS(AUDKProjectile);
IMPLEMENT_CLASS(AUDKWeapon);
IMPLEMENT_CLASS(AUDKWeaponShield);

//--------------------------------------------------------------
// Projectiles

FLOAT AUDKProjectile::GetGravityZ()
{
	return Super::GetGravityZ() * CustomGravityScaling;
}

void AUDKProjectile::TickSpecial( FLOAT DeltaSeconds )
{
	Super::TickSpecial(DeltaSeconds);

	if ( bShuttingDown )
	{
		return;
	}

	if (bWideCheck && bCollideActors && (Instigator != NULL || InstigatorBaseVehicle != NULL))
	{
		APlayerReplicationInfo* InstigatorPRI = (Instigator != NULL) ? Instigator->PlayerReplicationInfo : InstigatorBaseVehicle->PlayerReplicationInfo;
		// hit enemy if just nearby (for console games)
		FMemMark Mark(GMainThreadMemStack);

#if MOBILE
		// give mobile some extra-easy-to-hit collision
		const FLOAT PlatformMultiplier = 3.0f;
		const UBOOL bReduceRadiusOnStop = FALSE;
#else
		const FLOAT PlatformMultiplier = 1.0f;
		const UBOOL bReduceRadiusOnStop = TRUE;
#endif

		FCheckResult* Link = GWorld->Hash->PawnOverlapCheck(GMainThreadMemStack, this, Location, CheckRadius * PlatformMultiplier);
		for( FCheckResult* result=Link; result; result=result->GetNext())
		{
			APawn* TargetPawn = Link->Actor ? Link->Actor->GetAPawn() : NULL;
			if ( TargetPawn && !IgnoreBlockingBy(TargetPawn) && TargetPawn->IsValidEnemyTargetFor(InstigatorPRI, FALSE) )
			{
				UBOOL bDoTouch = TRUE;
				if ( bReduceRadiusOnStop && TargetPawn->Velocity.IsNearlyZero() )
				{
					// reduce effective radius if target not moving
					const FLOAT EffectiveRadius = 0.3f * CheckRadius;

					// find nearest point projectile will pass
					if ( Abs(Location.Z - TargetPawn->Location.Z) > TargetPawn->CylinderComponent->CollisionHeight + EffectiveRadius )
					{
						bDoTouch = FALSE;
					}
					else
					{
						FVector ClosestPoint;
						PointDistToLine(TargetPawn->Location, Velocity, Location, ClosestPoint);
						bDoTouch = (ClosestPoint - TargetPawn->Location).Size2D() < TargetPawn->CylinderComponent->CollisionRadius + EffectiveRadius;
					}
				}
				if ( bDoTouch )
				{
					eventTouch( TargetPawn, TargetPawn->CylinderComponent, Location, (Location - TargetPawn->Location).SafeNormal() );
					break;
				}
			}
		}
		Mark.Pop();
	}
	if ( bCheckProjectileLight && Instigator )
	{
		bCheckProjectileLight = FALSE;
		if ( Instigator->IsHumanControlled() && Instigator->IsLocallyControlled() )
		{
			eventCreateProjectileLight();
		}
	}

	if ( SeekTarget )
	{
		if ( InitialDir.IsZero() )
		{
			InitialDir = Velocity.SafeNormal();
		}

		bRotationFollowsVelocity = TRUE;
		FVector	SeekingVector = SeekTarget->GetTargetLocation(this);
		FVector ForceDir = (SeekingVector - Location).SafeNormal();
		if( (ForceDir | InitialDir) > 0.f )
		{
			AUDKVehicle *V = Cast<AUDKVehicle>(SeekTarget);
			FLOAT TrackingStrength = BaseTrackingStrength;
			if ( V && V->bHomingTarget )
			{
				TrackingStrength = HomingTrackingStrength;

				// possibly warn target
				if ( WorldInfo->TimeSeconds - LastLockWarningTime > LockWarningInterval )
				{
					LastLockWarningTime = WorldInfo->TimeSeconds;

					// warning message for players
					V->eventLockOnWarning(this);
					
					// update LockWarningInterval based on target proximity
					LockWarningInterval = Clamp(0.25f*(Location - V->Location).Size()/Velocity.Size(), 0.1f, 1.5f);
				}
			}
			Acceleration = TrackingStrength *Velocity.Size() * ForceDir;
		}
		else
		{
			Acceleration = FVector(0.f, 0.f, 0.f);
		}
	}
}

UBOOL AUDKProjectile::IgnoreBlockingBy(const AActor* Other) const
{
	return ((!bBlockedByInstigator && InstigatorBaseVehicle == Other) || Super::IgnoreBlockingBy(Other));
}

/** returns terminal velocity (max speed while falling) for this actor.  Unless overridden, it returns the TerminalVelocity of the PhysicsVolume in which this actor is located.
*/
FLOAT AUDKProjectile::GetTerminalVelocity()
{
	return (PhysicsVolume && PhysicsVolume->bWaterVolume) ? PhysicsVolume->TerminalVelocity : TerminalVelocity;
}


/*
GetNetBuoyancy()
determine how deep in water actor is standing:
0 = not in water,
1 = fully in water
*/
void AUDKProjectile::GetNetBuoyancy(FLOAT &NetBuoyancy, FLOAT &NetFluidFriction)
{
	if ( PhysicsVolume->bWaterVolume )
	{
		NetBuoyancy = Buoyancy;
		NetFluidFriction = PhysicsVolume->FluidFriction;
	}
}

UBOOL AUDKWeapon::Tick( FLOAT DeltaSeconds, ELevelTick TickType )
{
	CustomTimeDilation = Instigator ? Instigator->CustomTimeDilation : 1.f;
	return Super::Tick(DeltaSeconds, TickType);
}

/** Util that makes sure the overlay component is last in the AllComponents and Components arrays. */
void AUDKWeapon::EnsureWeaponOverlayComponentLast()
{
	// Iterate over Components array looking for OverlayMesh
	for(INT i=0; i<Components.Num(); i++)
	{
		if(Components(i) == OverlayMesh)
		{
			// When/if we find it, remove it and add to the end instead.
			Components.Remove(i);
			Components.AddItem(OverlayMesh);
			continue;
		}
	}

	// Iterate over AllComponents array looking for OverlayMesh
	for(INT i=0; i<AllComponents.Num(); i++)
	{
		if(AllComponents(i) == OverlayMesh)
		{
			// When/if we find it, remove it and add to the end instead.
			AllComponents.Remove(i);
			AllComponents.AddItem(OverlayMesh);
			continue;
		}
	}
}

UBOOL AUDKWeaponShield::IgnoreBlockingBy(const AActor* Other) const
{
	if ( !Other->GetAProjectile() )
	{
		return TRUE;
	}

	if ( bIgnoreFlaggedProjectiles && Other->GetClass()->IsChildOf(AUDKProjectile::StaticClass()) )
	{
		return ((AUDKProjectile *)Other)->bNotBlockedByShield;
	}
	return FALSE;
}

UBOOL AUDKWeaponShield::ShouldTrace(UPrimitiveComponent* Primitive, AActor* SourceActor, DWORD TraceFlags)
{
	return (SourceActor != NULL && ((TraceFlags & TRACE_ComplexCollision) || SourceActor->GetAProjectile() || SourceActor->IsA(AWeapon::StaticClass())) && !IsOwnedBy(SourceActor)) ? TRUE : FALSE;
}
