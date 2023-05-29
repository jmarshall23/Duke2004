/**
 * Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 */

#include "UDKBase.h"
#include "EngineMaterialClasses.h"
#include "EngineAnimClasses.h"
#include "UnPath.h"
#include "FConfigCacheIni.h"
#include "UDKBaseClasses.h"
#include "UDKBaseAnimationClasses.h"

#define STATIC_LINKING_MOJO 1

// Register things.
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name) FName UDKBASE_##name;
#define AUTOGENERATE_FUNCTION(cls,idx,name) IMPLEMENT_FUNCTION(cls,idx,name)
#include "UDKBaseClasses.h"
#undef AUTOGENERATE_NAME
#include "UDKBaseAnimationClasses.h"
#undef AUTOGENERATE_FUNCTION
#undef NAMES_ONLY

// Register natives.
#define NATIVES_ONLY
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name)
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#include "UDKBaseClasses.h"
#undef AUTOGENERATE_NAME
#include "UDKBaseAnimationClasses.h"
#undef AUTOGENERATE_FUNCTION
#undef NATIVES_ONLY
#undef NAMES_ONLY

void AutoInitializeRegistrantsUDKBase( INT& Lookup )
{
	AUTO_INITIALIZE_REGISTRANTS_UDKBASE;
	AUTO_INITIALIZE_REGISTRANTS_UDKBASE_ANIMATION;
}

/**
 * Auto generates names.
 */
void AutoGenerateNamesUDKBase()
{
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name) UDKBASE_##name = FName(TEXT(#name));
#include "UDKBaseNames.h"
#undef AUTOGENERATE_NAME
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#include "UDKBaseClasses.h"
#include "UDKBaseAnimationClasses.h"
#undef AUTOGENERATE_FUNCTION
#undef NAMES_ONLY
}

#if CHECK_NATIVE_CLASS_SIZES
#if _MSC_VER
#pragma optimize( "", off )
#endif

void AutoCheckNativeClassSizesUDKBase( UBOOL& Mismatch )
{
#define NAMES_ONLY
#define AUTOGENERATE_NAME( name )
#define AUTOGENERATE_FUNCTION( cls, idx, name )
#define VERIFY_CLASS_SIZES
#include "UDKBaseClasses.h"
#include "UDKBaseAnimationClasses.h"
#undef AUTOGENERATE_FUNCTION
#undef AUTOGENERATE_NAME
#undef VERIFY_CLASS_SIZES
#undef NAMES_ONLY
}

#if _MSC_VER
#pragma optimize( "", on )
#endif
#endif

IMPLEMENT_CLASS(AUDKCarriedObject);
IMPLEMENT_CLASS(AUDKGameObjective);
IMPLEMENT_CLASS(AUDKPickupFactory);
IMPLEMENT_CLASS(UUDKParticleSystemComponent);
IMPLEMENT_CLASS(UUDKProfileSettings);
IMPLEMENT_CLASS(AUDKTeamOwnedInfo);
IMPLEMENT_CLASS(AUDKForcedDirectionVolume);
IMPLEMENT_CLASS(AUDKKActorBreakable);
IMPLEMENT_CLASS(ASimpleGame);
IMPLEMENT_CLASS(AUDKGame);
IMPLEMENT_CLASS(AUDKTeleporterBase);
IMPLEMENT_CLASS(UUDKGameViewportClient);
IMPLEMENT_CLASS(UUDKMapInfo);
IMPLEMENT_CLASS(UUDKMapMusicInfo);

/**
 * Locates a random localized hint message string for the specified two game types.  Usually the first game type
 * should always be "DM", since you always want those strings included regardless of game type
 *
 * @param GameType1Name Name of the first game type we're interested in
 * @param GameType2Name Name of the second game type we're interested in
 *
 * @return Returns random hint string for the specified game types
 */
FString UUDKGameViewportClient::LoadRandomLocalizedHintMessage( const FString& GameType1Name, const FString& GameType2Name )
{
	// This string in the loc file will specify the total number of hint messages in this category.  We'll read
	// in its value string and convert it to an integer for our tests
	const FString HintCountVarName = TEXT( "Hint_Count" );

	// This is the prefix before the category name for hints (e.g. LoadingHints_UTDeathmatch)
	const FString HintCategoryPrefix = TEXT( "LoadingHints_" );

	// Prefix before each hint message, usually followed by a number (index of that hint)
	const FString HintMessageVarPrefix = TEXT( "Hint_" );


	// How many games are we dealing with?
	const INT MaxGameTypesForHints = 2;
	INT GameTypeHintCounts[ MaxGameTypesForHints ];

	// Figure out how many total hints we have available to us for the specified game types
	INT TotalHintCount = 0;
	for( INT GameIndex = 0; GameIndex < MaxGameTypesForHints; ++GameIndex )
	{
		// Setup category name
		const FString CurGameTypeName = ( GameIndex == 0 ) ? GameType1Name : GameType2Name;
		const FString HintCategoryName = HintCategoryPrefix + CurGameTypeName;

		// Load the number of available hints for this category
		FString HintCountValueString = Localize( *HintCategoryName, *HintCountVarName, *HintLocFileName );
		INT HintCountValue = 0;
		if( HintCountValueString.Len() > 0 )
		{
			// Convert the hint count from a string
			HintCountValue = appAtoi( *HintCountValueString );
		}
		else
		{
			warnf(
				TEXT( "Hint System: Unable to locate hint count [%s] for category [%s] in loc file [%s]." ),
				*HintCountVarName,
				*HintCategoryName,
				*HintLocFileName );
		}

		// Store hint count
		GameTypeHintCounts[ GameIndex ] = HintCountValue;

		// Also, total everything up!
		TotalHintCount += HintCountValue;
	}

	// OK, now choose a random hint!
	INT RandomHintIndex = TotalHintCount > 0 ? appRand() % TotalHintCount : 0;

	// Figure out which hint category we landed in and
	FString HintMessage;
	for( INT GameIndex = 0; GameIndex < MaxGameTypesForHints; ++GameIndex )
	{
		if( RandomHintIndex < GameTypeHintCounts[ GameIndex ] )
		{
			// Found it!  Select our hint!
			FString HintMessageVarName = HintMessageVarPrefix + appItoa( RandomHintIndex );

			// Setup category name
			const FString CurGameTypeName = ( GameIndex == 0 ) ? GameType1Name : GameType2Name;
			const FString HintCategoryName = HintCategoryPrefix + CurGameTypeName;

			HintMessage = Localize( *HintCategoryName, *HintMessageVarName, *HintLocFileName );
			if( HintMessage.Len() == 0 )
			{
				warnf(
					TEXT( "Hint System: Unable to locate hint message [%s] for category [%s] in loc file [%s]." ),
					*HintMessageVarName,
					*HintCategoryName,
					*HintLocFileName );
			}
			break;
		}

		RandomHintIndex -= GameTypeHintCounts[ GameIndex ];
	}

	// Done!  Return the hint message we found.
	return HintMessage;
}

void AUDKGame::AddSupportedGameTypes(AWorldInfo* Info, const TCHAR* WorldFilename, TArray<FString>& AdditionalPackagesToCook) const
{
	// match the map prefix
	FString BaseFilename = FFilename(WorldFilename).GetBaseFilename();
	TArray<FGameTypePrefix> Prefixes = DefaultMapPrefixes;
	Prefixes += CustomMapPrefixes;
	for (INT i = 0; i < Prefixes.Num(); i++)
	{
		if (BaseFilename.StartsWith(Prefixes(i).Prefix))
		{
			UClass* GameClass = StaticLoadClass(AGameInfo::StaticClass(), NULL, *Prefixes(i).GameType, NULL, LOAD_None, NULL);
			if (GameClass != NULL)
			{
				Info->GameTypesSupportedOnThisMap.AddUniqueItem(GameClass);
			}
			for (INT j = 0; j < Prefixes(i).AdditionalGameTypes.Num(); j++)
			{
				GameClass = StaticLoadClass(AGameInfo::StaticClass(), NULL, *Prefixes(i).AdditionalGameTypes(j), NULL, LOAD_None, NULL);
				if (GameClass != NULL)
				{
					Info->GameTypesSupportedOnThisMap.AddUniqueItem(GameClass);
				}
			}
			break;
		}
	}
}

BYTE AUDKTeamOwnedInfo::GetTeamNum()
{
	return Team ? Team->TeamIndex : 255;
}

BYTE AUDKGameObjective::GetTeamNum()
{
	return DefenderTeamIndex;
}

BYTE AUDKCarriedObject::GetTeamNum()
{
	return Team ? Team->TeamIndex : 255;
}

/**
  * Reset cloth so teleporting doesn't stretch flag
  */
void AUDKCarriedObject::PostNetReceiveLocation()
{
	Super::PostNetReceiveLocation();
	if ( SkelMesh )
	{	
		SkelMesh->ResetClothVertsToRefPose();
	}
}


void AUDKCarriedObject::PostNetReceiveBase(AActor* NewBase)
{	
	APawn* P = NewBase ? NewBase->GetAPawn() : NULL;
	if ( !P )
	{
		Super::PostNetReceiveBase(NewBase);
		return;
	}
	if ( NewBase != Base )
	{
		if (P->IsA(AUDKPawn::StaticClass()))
		{
			((AUDKPawn*)P)->eventHoldGameObject(this);
		}
		else if (P->IsA(AUDKVehicleBase::StaticClass()))
		{
			((AUDKVehicleBase*)P)->eventHoldGameObject(this);
		}

	}
	bJustTeleported = 0;
}

/*
 * Returns navigation anchor associated with this actor
 * (rather than actually checking if anchor is also reachable)
*/
ANavigationPoint* AUDKCarriedObject::SpecifyEndAnchor(APawn* RouteFinder)
{
	if (bHome && HomeBase != NULL && ((HomeBase->Location + HomeBaseOffset) - Location).SizeSquared() <= 100.0f)
	{
		LastAnchor = HomeBase;
		return HomeBase;
	}
	else if (WorldInfo->TimeSeconds - LastValidAnchorTime < 0.25f)
	{
		return LastAnchor;
	}
	else
	{
		return NULL;
	}
}

/*
 * Notify actor of anchor finding result
 * @PARAM EndAnchor is the anchor found
 * @PARAM RouteFinder is the pawn which requested the anchor finding
 */
void AUDKCarriedObject::NotifyAnchorFindingResult(ANavigationPoint* EndAnchor, APawn* RouteFinder)
{
	if ( EndAnchor )
	{
		// save valid anchor info
		LastValidAnchorTime = WorldInfo->TimeSeconds;
		LastAnchor = EndAnchor;
	}
	else
	{
		eventNotReachableBy(RouteFinder);
	}
}

/** Used to see when the 'base most' (ie end of Base chain) changes. */
void AUDKCarriedObject::TickSpecial(FLOAT DeltaSeconds)
{
	Super::TickSpecial(DeltaSeconds);

	AActor* NewBase = GetBase();
	AActor* NewBaseBase = NULL;
	if(NewBase)
	{
		NewBaseBase = NewBase->GetBase();
	}
	

	if(NewBase != OldBase || NewBaseBase != OldBaseBase)
	{
		// Call script event when this happens.
		eventOnBaseChainChanged();
		OldBase = NewBase;
		OldBaseBase = NewBaseBase;

	}
}

void AUDKCarriedObject::ForceUpdateComponents(UBOOL bCollisionUpdate,UBOOL bTransformOnly)
{
	// For carried objects, we update _all_ components.
	Super::ForceUpdateComponents(FALSE, TRUE);
}

void AUDKCarriedObject::SetHUDLocation(FVector NewHUDLocation)
{
	HUDLocation = NewHUDLocation;
}

void AUDKPickupFactory::PostEditMove(UBOOL bFinished)
{
	if ( bFinished )
	{
		// align pickupbase mesh to floor
		if ( BaseMesh )
		{
			FCheckResult Hit(1.f);
			FLOAT CollisionHeight, CollisionRadius;
			GetBoundingCylinder(CollisionRadius, CollisionHeight);
			GWorld->SingleLineCheck( Hit, this, Location - FVector(0.f,0.f,1.5f*CollisionHeight), Location, TRACE_World, GetCylinderExtent() );
			if ( Hit.Time < 1.f )
			{
				Rotation = FindSlopeRotation(Hit.Normal, Rotation);
				FVector DefaultTranslation = Cast<AUDKPickupFactory>(GetClass()->GetDefaultActor())->BaseMesh->Translation;
				BaseMesh->Translation = DefaultTranslation - FVector(CollisionRadius * (1.f - Hit.Normal.Z*Hit.Normal.Z));
				BaseMesh->ConditionalUpdateTransform();
			}
		}
	}

	Super::PostEditMove( bFinished );
}

void AUDKPickupFactory::Spawned()
{
	Super::Spawned();

	if ( !GWorld->HasBegunPlay() )
	{
		PostEditMove( TRUE );
	}
}


void AUDKPickupFactory::TickSpecial( FLOAT DeltaSeconds )
{
	Super::TickSpecial(DeltaSeconds);
	
	if ( WorldInfo->NetMode == NM_DedicatedServer )
	{
		// skip these visual effects
		return;
	}

	//@note: we don't check LastRenderTime here because otherwise the pickups always look like they just spawned in on clients
	if (BaseMesh && BaseMaterialInstance && BaseMaterialParamName != NAME_None) 
	{
		if(Glow != NULL && BasePulseTime > 0.0f)
		{
			Glow->SetFloatParameter(GlowEmissiveParam,BaseEmissive.A);
		}

		// if this pickup wants to fade in when respawning
		if( bIsRespawning && bDoVisibilityFadeIn )
		{
			if(MIC_Visibility != NULL)
			{
				FLOAT ResVal = 0.0f;
				MIC_Visibility->GetScalarParameterValue(VisibilityParamName,ResVal);
				if (ResVal != 0.0f)
				{
					ResVal *= 1.5;
					if (ResVal < 0.0f) //clamp
					{
						ResVal = 0.0f;
					}
					MIC_Visibility->SetScalarParameterValue(VisibilityParamName, (ResVal-DeltaSeconds)/1.5f  );
				}
			}

			if(MIC_VisibilitySecondMaterial != NULL)
			{
				FLOAT ResVal = 0.0f;
				MIC_VisibilitySecondMaterial->GetScalarParameterValue(VisibilityParamName,ResVal);
				if (ResVal != 0.0f)
				{
					ResVal *= 1.5;
					if (ResVal < 0.0f) //clamp
					{
						ResVal = 0.0f;
					}
					MIC_VisibilitySecondMaterial->SetScalarParameterValue(VisibilityParamName, (ResVal-DeltaSeconds)/1.5f  );
				}
			}
		}
	}

	// Pulse
	if ( BaseMesh && BaseMaterialInstance && BaseMaterialParamName != NAME_None )
	{
		//@note: we don't check LastRenderTime here so that the base doesn't wait to start the pulse until it becomes visible
		// which would defeat the purpose of it indicating when the pickup will respawn
		if (BasePulseTime > 0.0)
		{
			BaseEmissive.R += (BaseTargetEmissive.R - BaseEmissive.R) * (DeltaSeconds / BasePulseTime);
			BaseEmissive.G += (BaseTargetEmissive.G - BaseEmissive.G) * (DeltaSeconds / BasePulseTime);
			BaseEmissive.B += (BaseTargetEmissive.B - BaseEmissive.B) * (DeltaSeconds / BasePulseTime);
			BaseEmissive.A += (BaseTargetEmissive.A - BaseEmissive.A) * (DeltaSeconds / BasePulseTime);
			
			BasePulseTime -= DeltaSeconds;
			if ( bPulseBase && BasePulseTime <= 0.0f )
			{
				if ( BaseTargetEmissive == BaseDimEmissive )
				{
					BaseTargetEmissive = BaseBrightEmissive;
				}
				else
				{
					BaseTargetEmissive = BaseDimEmissive;
				}

				BasePulseTime = BasePulseRate;
			}
		}
		else
		{
			BaseEmissive = BaseTargetEmissive;
			BasePulseTime = 0.0f;
		}

		if (WorldInfo->TimeSeconds - LastRenderTime < 0.2f)
		{
			BaseMaterialInstance->SetVectorParameterValue(BaseMaterialParamName, BaseEmissive);
		}
	}

	// following effects only updated if recently rendered
	if ( WorldInfo->TimeSeconds - LastRenderTime > 0.2f )
	{
		return;
	}

	if ( bUpdatingPickup && PickupMesh && !PickupMesh->HiddenGame )
	{
		if ( bRotatingPickup )
		{
			PickupMesh->Rotation.Yaw += appRound(DeltaSeconds * YawRotationRate);

			// @TODO FIXMESTEVE Better way to change pivot point?
			FRotationMatrix R(PickupMesh->Rotation);
			PickupMesh->Translation = PivotTranslation.X * R.GetAxis(0) + PivotTranslation.Y * R.GetAxis(1) + FVector(0,0,PickupMesh->Translation.Z);

			if ( Spinner && !Spinner->HiddenGame )
			{
				Spinner->Rotation.Yaw += appRound(DeltaSeconds * YawRotationRate);
				// this is just visual, so we don't need to update it immediately
				Spinner->BeginDeferredUpdateTransform();
			}
			if ( SpinningParticleEffects && !SpinningParticleEffects->HiddenGame && PickupMesh )
			{
				SpinningParticleEffects->Rotation = PickupMesh->Rotation;

				// this is just visual, so we don't need to update it immediately
				SpinningParticleEffects->BeginDeferredUpdateTransform();
			}
		}

		if ( bFloatingPickup )
		{
			BobTimer += DeltaSeconds;
			const FLOAT Offset = BobOffset * appSin(BobTimer * BobSpeed);
			PickupMesh->Translation.Z = BobBaseOffset + Offset;
		}
		// this is just visual, so we don't need to update it immediately
		PickupMesh->BeginDeferredUpdateTransform();
	}
}


/**
 * Resets the current keybindings for the specified playerowner to the defaults specified in the INI.
 *
 * @param InPlayerOwner	Player to get the default keybindings for.
 */
void UUDKProfileSettings::ResetKeysToDefault(ULocalPlayer* InPlayerOwner)
{
	const FString ConfigName = TEXT( "Input" );

	if( GUseSeekFreeLoading && CONSOLE )
	{
		const FString IniPrefix = "";
		const FString DefaultIniFilename= appGameConfigDir() + FString(GGameName) + FString::Printf( TEXT( "%s%s.ini"), *ConfigName, TEXT("Defaults") );

		FConfigFile* ExistingConfigFile = GConfig->FindConfigFile(*DefaultIniFilename);
		check(ExistingConfigFile);
		// need to copy off the config file, as the SetFile below may reallocate memory that the ExistingConfigFile is inside of
		FConfigFile ConfigFileCopy = *ExistingConfigFile;

		GConfig->SetFile( TEXT("PlatformInput.ini"), &ConfigFileCopy);
		//warnf( TEXT( "UUTUIKeyBindingList DefaultIniFilename: %s" ), *DefaultIniFilename );
	}
	else
	{
		const FString IniPrefix = PC_DEFAULT_INI_PREFIX;
		const FString DefaultIniFilename = appGameConfigDir() * FString::Printf( TEXT( "%s%s.ini"), *IniPrefix, *ConfigName );

		// build a new .ini file for the specified platform
		FConfigFile PlatformWeaponIni;
		PlatformWeaponIni.NoSave = TRUE;
		LoadAnIniFile(*DefaultIniFilename, PlatformWeaponIni, FALSE);

		// add it to the config cache so that LoadConfig() can find it
		static_cast<FConfigCacheIni*>(GConfig)->Set(TEXT("PlatformInput.ini"), PlatformWeaponIni);

		//warnf( TEXT( "UUTUIKeyBindingList ConfigNameToBeReplaced: %s" ), *DefaultIniFilename );
	}

	// If no player owner was specified, just use player 0.
	if(InPlayerOwner==NULL && GEngine && GEngine->GamePlayers.Num()>0)
	{
		InPlayerOwner=GEngine->GamePlayers(0);
	}

	if(InPlayerOwner != NULL)
	{
		AUDKPlayerController* UTPC = Cast<AUDKPlayerController>(InPlayerOwner->Actor);

		if(UTPC != NULL && UTPC->PlayerInput != NULL)
		{
			UProperty* BindingProperty = Cast<UProperty>(UTPC->PlayerInput->FindObjectField(TEXT("Bindings")));
			UTPC->PlayerInput->ReloadConfig(NULL, TEXT("PlatformInput.ini"), UE3::LCPF_None,BindingProperty);

			/* Debug output of current state of input bindings */
			if (0)
			{
				for (INT i=0;i<UTPC->PlayerInput->Bindings.Num(); i++)
				{
					const FKeyBind& KeyBind = UTPC->PlayerInput->Bindings(i);
					debugf(TEXT("%s = %s"), *KeyBind.Name.ToString(), *KeyBind.Command);
				}
			}
		}
	}
}


/** 
 * Sets the specified profile id back to its default value.
 * 
 * @param ProfileId	Profile setting to reset to default.
 */
void UUDKProfileSettings::ResetToDefault(INT ProfileId)
{
	for(INT ProfileIdx=0; ProfileIdx<ProfileSettings.Num(); ProfileIdx++)
	{
		if(ProfileSettings(ProfileIdx).ProfileSetting.PropertyId==ProfileId)
		{
			if(DefaultSettings.Num()>ProfileIdx && DefaultSettings(ProfileIdx).ProfileSetting.PropertyId==ProfileId)
			{
				ProfileSettings(ProfileIdx)=DefaultSettings(ProfileIdx);
			}

			break;
		}
	}
}

void AUDKForcedDirectionVolume::PostEditChangeProperty(FPropertyChangedEvent& PropertyChangedEvent)
{
	if ( Arrow )
	{
		ArrowDirection = Arrow->Rotation.Vector();
	}
}

UBOOL AUDKForcedDirectionVolume::IgnoreBlockingBy( const AActor *Other ) const
{
	return (!bBlockPawns 
			|| (Other->GetAProjectile() != NULL)
			|| (Other->IsA(TypeToForce))); // ignore everything if we're not blocking pawns; if we are blocking them ignore projectiles and whatever we force in a direction.
}

void AUDKForcedDirectionVolume::TickSpecial(FLOAT DeltaSeconds)
{
	Super::TickSpecial(DeltaSeconds);

	// push any vehicles inside that aren't moving out of the volume fast enough
	for (INT i=0; i<TouchingVehicles.Num(); i++)
	{
		AUDKVehicle* V = TouchingVehicles(i);
		if ( !V || V->bDeleteMe )
		{
			TouchingVehicles.RemoveItem(V);
			i--;
		}
		else
		{
			FVector AdjustedVelocity = V->Velocity - (1100.f * ArrowDirection);
			FLOAT AdjVelMag = AdjustedVelocity.Size();
			if((AdjVelMag > KINDA_SMALL_NUMBER) && ((AdjustedVelocity | ArrowDirection) < 0.f))
			{
				V->Mesh->AddForce(ArrowDirection * AdjVelMag);
			}
		}
	}
}

void AUDKKActorBreakable::physRigidBody(FLOAT DeltaTime)
{
	Super::physRigidBody(DeltaTime);
	FRigidBodyState OutState;

	if ( bDamageOnEncroachment && bResetDOEWhenAsleep && ( !GetCurrentRBState(OutState) || ( DOEResetThreshold>0 && Velocity.Size() < DOEResetThreshold ) ) )
	{
		bDamageOnEncroachment = FALSE;
	}
}

/** utility for portals to update the VisiblePortals on Controllers */
static void CheckPortalVisible(AActor* Source, AActor* Destination, USceneCaptureComponent* PortalCaptureComponent)
{
	FVisiblePortalInfo PortalInfo(Source, Destination);
	for (AController* C = Source->WorldInfo->ControllerList; C != NULL; C = C->NextController)
	{
		if (C->SightCounter < 0.0f)
		{
			AActor* ViewTarget = C->GetViewTarget();
			if ((ViewTarget->Location - Source->Location).SizeSquared() <= Square(PortalCaptureComponent->MaxUpdateDist))
			{
				FCheckResult Hit(1.0f);
				if (GWorld->SingleLineCheck(Hit, Source, Source->Location, ViewTarget->Location, TRACE_World | TRACE_StopAtAnyHit | TRACE_ComplexCollision))
				{
					// we are visible to C
					C->VisiblePortals.AddUniqueItem(PortalInfo);
				}
				else
				{
					C->VisiblePortals.RemoveItem(PortalInfo);
				}
			}
		}
	}
}

void AUDKTeleporterBase::TickSpecial(FLOAT DeltaTime)
{
	Super::TickSpecial(DeltaTime);

#if !PS3
	if (PortalCaptureComponent != NULL && PortalViewTarget != NULL)
	{
		CheckPortalVisible(this, PortalViewTarget, PortalCaptureComponent);
	}
#endif
}


