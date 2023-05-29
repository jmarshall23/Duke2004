/**
 * Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 */

#include "UDKBase.h"
#include "EngineInterpolationClasses.h"

IMPLEMENT_CLASS(AUDKPlayerController);
IMPLEMENT_CLASS(UUDKPlayerInput);

/** 
 * HearSound()
 * If sound is audible, calls eventClientHearSound() so local or remote player will hear it.
 * UTPlayerController implementation determines audibility based on the closest to the sound location of 
 * the viewtarget or the controller's pawn if they are not the same
 */
UBOOL AUDKPlayerController::HearSound( USoundCue* InSoundCue, AActor* SoundPlayer, const FVector& SoundLocation, UBOOL bStopWhenOwnerDestroyed )
{
	if( SoundPlayer == this )
	{
		// always play sounds by the playercontroller
		eventClientHearSound(InSoundCue, SoundPlayer, (SoundPlayer->Location == SoundLocation) ? FVector(0.f) : SoundLocation, bStopWhenOwnerDestroyed, FALSE);
		return TRUE;
	}
	else if (bDedicatedServerSpectator)
	{
		// dedicated server spectator ignores sounds not played on self
		return FALSE;
	}

	// Get simple listener/speaker pair
	FVector ModifiedSoundLocation = SoundLocation;
	FVector HearLocation = Location;

	// Redirect through the view target if necessary
	if( ViewTarget )
	{
		HearLocation = ViewTarget->Location;

		if( Pawn && ( Pawn != ViewTarget ) && ( ( HearLocation - SoundLocation ).SizeSquared() > ( Pawn->Location - SoundLocation ).SizeSquared() ) )
		{
			// move sound location so that it's heard as if Pawn heard it.
			ModifiedSoundLocation = ModifiedSoundLocation + HearLocation - Pawn->Location;
		}
	}

	INT bIsOccluded = 0;

	if (!bAcuteHearing || (ModifiedSoundLocation - HearLocation).IsNearlyZero())
	{
		if( InSoundCue->IsAudible( ModifiedSoundLocation, HearLocation, SoundPlayer, bIsOccluded, bCheckSoundOcclusion ) )
		{
			ValidateSoundPlayer(SoundPlayer);
			eventClientHearSound( InSoundCue, SoundPlayer, (SoundPlayer != NULL && SoundPlayer->Location == ModifiedSoundLocation) ? FVector(0.f) : ModifiedSoundLocation, bStopWhenOwnerDestroyed, bIsOccluded );
			return TRUE;
		}
	}
	else
	{
		// play sound at closer location to increase volume
		const FVector SoundDir = ModifiedSoundLocation - HearLocation;
		const FLOAT SoundDist = SoundDir.Size();
		ModifiedSoundLocation = HearLocation + ::Min( 0.25f * SoundDist, 2000.f ) * SoundDir.SafeNormal();
		if( InSoundCue->IsAudible( ModifiedSoundLocation, HearLocation, SoundPlayer, bIsOccluded, bCheckSoundOcclusion ) )
		{
			ValidateSoundPlayer(SoundPlayer);
			eventClientHearSound( InSoundCue, NULL, ModifiedSoundLocation, bStopWhenOwnerDestroyed, FALSE );
			return TRUE;
		}
	}

	return FALSE;
}


UBOOL AUDKPlayerController::MoveWithInterpMoveTrack(UInterpTrackMove* MoveTrack, UInterpTrackInstMove* MoveInst, FLOAT CurTime, FLOAT DeltaTime)
{
	if (CameraAnimPlayer != NULL && CameraAnimPlayer->MoveTrack == MoveTrack)
	{
		// figure out the movement delta and put it in ShakeOffset and ShakeRot
		MoveTrack->GetKeyTransformAtTime(MoveInst, CurTime, ShakeOffset, ShakeRot);
		ShakeOffset *= CameraAnimPlayer->CurrentBlendWeight;
		ShakeRot *= CameraAnimPlayer->CurrentBlendWeight;
		return TRUE;
	}
	else
	{
		// use default behavior
		return Super::MoveWithInterpMoveTrack(MoveTrack, MoveInst, CurTime, DeltaTime);
	}
}

void AUDKPlayerController::BlendPostProcessSettings(FPostProcessSettings& PPSettings, const FPostProcessSettings& PPSettingsA, const FPostProcessSettings& PPSettingsB, const FLOAT BlendWeight) const
{
	PPSettings.Bloom_Scale += BlendWeight * (PPSettingsA.Bloom_Scale - PPSettingsB.Bloom_Scale);
	PPSettings.DOF_FalloffExponent += BlendWeight * (PPSettingsA.DOF_FalloffExponent - PPSettingsB.DOF_FalloffExponent);
	PPSettings.DOF_BlurKernelSize += BlendWeight * (PPSettingsA.DOF_BlurKernelSize - PPSettingsB.DOF_BlurKernelSize);
	PPSettings.DOF_MaxNearBlurAmount += BlendWeight * (PPSettingsA.DOF_MaxNearBlurAmount - PPSettingsB.DOF_MaxNearBlurAmount);
	PPSettings.DOF_MaxFarBlurAmount += BlendWeight * (PPSettingsA.DOF_MaxFarBlurAmount - PPSettingsB.DOF_MaxFarBlurAmount);
	PPSettings.DOF_FocusInnerRadius += BlendWeight * (PPSettingsA.DOF_FocusInnerRadius - PPSettingsB.DOF_FocusInnerRadius);
	PPSettings.DOF_FocusDistance += BlendWeight * (PPSettingsA.DOF_FocusDistance - PPSettingsB.DOF_FocusDistance);
	PPSettings.MotionBlur_MaxVelocity += BlendWeight * (PPSettingsA.MotionBlur_MaxVelocity - PPSettingsB.MotionBlur_MaxVelocity);
	PPSettings.MotionBlur_Amount += BlendWeight * (PPSettingsA.MotionBlur_Amount - PPSettingsB.MotionBlur_Amount);
	PPSettings.MotionBlur_CameraRotationThreshold += BlendWeight * (PPSettingsA.MotionBlur_CameraRotationThreshold - PPSettingsB.MotionBlur_CameraRotationThreshold);
	PPSettings.MotionBlur_CameraTranslationThreshold += BlendWeight * (PPSettingsA.MotionBlur_CameraTranslationThreshold - PPSettingsB.MotionBlur_CameraTranslationThreshold);
	PPSettings.Scene_Desaturation += BlendWeight * (PPSettingsA.Scene_Desaturation - PPSettingsB.Scene_Desaturation);
	PPSettings.Scene_HighLights += BlendWeight * (PPSettingsA.Scene_HighLights - PPSettingsB.Scene_HighLights);
	PPSettings.Scene_MidTones += BlendWeight * (PPSettingsA.Scene_MidTones - PPSettingsB.Scene_MidTones);
	PPSettings.Scene_Shadows += BlendWeight * (PPSettingsA.Scene_Shadows - PPSettingsB.Scene_Shadows);
	PPSettings.Scene_TonemapperScale += BlendWeight * (PPSettingsA.Scene_TonemapperScale - PPSettingsB.Scene_TonemapperScale);
	PPSettings.Scene_ImageGrainScale += BlendWeight * (PPSettingsA.Scene_ImageGrainScale - PPSettingsB.Scene_ImageGrainScale);
}

void AUDKPlayerController::AddPostProcessSettings(FPostProcessSettings& PPSettings, const FPostProcessSettings& PPSettingsA) const
{
	PPSettings.Bloom_Scale += PPSettingsA.Bloom_Scale;
	PPSettings.DOF_FalloffExponent += PPSettingsA.DOF_FalloffExponent;
	PPSettings.DOF_BlurKernelSize += PPSettingsA.DOF_BlurKernelSize;
	PPSettings.DOF_MaxNearBlurAmount += PPSettingsA.DOF_MaxNearBlurAmount;
	PPSettings.DOF_MaxFarBlurAmount += PPSettingsA.DOF_MaxFarBlurAmount;
	PPSettings.DOF_FocusInnerRadius += PPSettingsA.DOF_FocusInnerRadius;
	PPSettings.DOF_FocusDistance += PPSettingsA.DOF_FocusDistance;
	PPSettings.MotionBlur_MaxVelocity += PPSettingsA.MotionBlur_MaxVelocity;
	PPSettings.MotionBlur_Amount += PPSettingsA.MotionBlur_Amount;
	PPSettings.MotionBlur_CameraRotationThreshold += PPSettingsA.MotionBlur_CameraRotationThreshold;
	PPSettings.MotionBlur_CameraTranslationThreshold += PPSettingsA.MotionBlur_CameraTranslationThreshold;
	PPSettings.Scene_Desaturation += PPSettingsA.Scene_Desaturation;
	PPSettings.Scene_HighLights += PPSettingsA.Scene_HighLights;
	PPSettings.Scene_MidTones += PPSettingsA.Scene_MidTones;
	PPSettings.Scene_Shadows += PPSettingsA.Scene_Shadows;
	PPSettings.Scene_TonemapperScale += PPSettingsA.Scene_TonemapperScale;
	PPSettings.Scene_ImageGrainScale += PPSettingsA.Scene_ImageGrainScale;
}

void AUDKPlayerController::ModifyPostProcessSettings(FPostProcessSettings& PPSettings) const
{
	Super::ModifyPostProcessSettings(PPSettings);

	if (CameraAnimPlayer != NULL && !CameraAnimPlayer->bFinished)
	{
		ACameraActor const* const DefaultCamActor = ACameraActor::StaticClass()->GetDefaultObject<ACameraActor>();
		if (DefaultCamActor) 
		{
			BlendPostProcessSettings( PPSettings, CamOverridePostProcess, DefaultCamActor->CamOverridePostProcess, CameraAnimPlayer->CurrentBlendWeight);
		}
	}

	AddPostProcessSettings( PPSettings, PostProcessModifier );
}

void AUDKPlayerController::PreSave()
{
#if WITH_EDITORONLY_DATA
	if (IsTemplate())
	{
		// force PostProcessModifier to be zero in UTPlayerController defaults
		UProperty* Prop = FindField<UProperty>(GetClass(), FName(TEXT("PostProcessModifier")));
		checkSlow(Prop != NULL);
		Prop->ClearValue((BYTE*)this + Prop->Offset);
	}
#endif // WITH_EDITORONLY_DATA

	Super::PreSave();
}

/** Sets the display gamma. */
void AUDKPlayerController::SetGamma(FLOAT GammaValue)
{
	extern void SetDisplayGamma(FLOAT Gamma);

	// map value between 1.0 - 3.0
	GammaValue = GammaValue*2.0f + 1.0f;
	SetDisplayGamma(GammaValue);
}

/** 
 * Sets whether or not hardware physics are enabled.
 *
 * @param bEnabled	Whether to enable the physics or not.
 */
void AUDKPlayerController::SetHardwarePhysicsEnabled(UBOOL bEnabled)
{
	GEngine->bDisablePhysXHardwareSupport = (bEnabled==FALSE);
}

void AUDKPlayerController::UpdateHiddenActors(const FVector& ViewLocation)
{
	// hide orb if player camera clipping into it
	for( INT i=0; i< PotentiallyHiddenActors.Num(); i++ )
	{
		if ( (PotentiallyHiddenActors(i) == NULL) || PotentiallyHiddenActors(i)->bDeleteMe )
		{
			if ( PotentiallyHiddenActors(i) != NULL )
			{
				HiddenActors.RemoveItem(PotentiallyHiddenActors(i));
			}
			PotentiallyHiddenActors.Remove(i);
			i--;
		}
		else
		{
			// hide if too close
			if ( PotentiallyHiddenActors(i)->ShouldHideActor(ViewLocation) )
			{
				HiddenActors.AddUniqueItem(PotentiallyHiddenActors(i));
			}
			else
			{
				HiddenActors.RemoveItem(PotentiallyHiddenActors(i));
			}
		}
	}
}

/** @return whether or not this Controller has a keyboard available to be used **/
UBOOL AUDKPlayerController::IsKeyboardAvailable() const
{
	UBOOL Retval = FALSE;

	ULocalPlayer* LP = Cast<ULocalPlayer>(Player);

	if( LP && LP->ViewportClient && LP->ViewportClient->Viewport )
	{
		Retval = LP->ViewportClient->Viewport->IsKeyboardAvailable( LP->ControllerId );
	}

	return Retval;
}

/** @return whether or not this Controller has a mouse available to be used **/
UBOOL AUDKPlayerController::IsMouseAvailable() const
{
	UBOOL Retval = FALSE;

	ULocalPlayer* LP = Cast<ULocalPlayer>(Player);

	if( LP && LP->ViewportClient && LP->ViewportClient->Viewport )
	{
		Retval = LP->ViewportClient->Viewport->IsMouseAvailable( LP->ControllerId );
	}

	return Retval;
}


/** Determines whether this Pawn can be used for Adhesion or Friction **/
UBOOL AUDKPlayerController::IsValidTargetAdhesionFrictionTarget( APawn* P, FLOAT MaxDistance )
{
	UBOOL Retval = FALSE;

	// check for self before we do any computation
	if( ( P != NULL ) && ( P != Pawn ) ) 
	{
		const FVector ToTargetNorm = P->Location - Pawn->Location;
		const FLOAT DistToTarget = ToTargetNorm.Size();

		//warnf( TEXT( "IsValidTargetAdhesionFrictionTarget: %s %i" ), *GP->GetName(), GP->PlayerReplicationInfo->eventGetTeamNum() );

		Retval = ( 
			 ( P->IsValidEnemyTargetFor( PlayerReplicationInfo, FALSE ) == TRUE )
			&& ( P->bCanBeAdheredTo == TRUE )
			&& ( P->bCanBeFrictionedTo == TRUE )
			&& ( DistToTarget < MaxDistance )
			&& ( P->Health > 0 ) 
			&& ( P->bHidden == FALSE )
			&& ( P->bDeleteMe == FALSE )
			&& ( const_cast<AUDKPlayerController*>(this)->LineOfSightTo( P ) == TRUE )
			);
	}

	return Retval;
}

/** 
 * This will look to see if the player is aiming directly at a projectile which does not want to
 * be adhered to. 
 **/
UBOOL IsDirectlyAimingAtAProjectile( const AUDKPlayerController* C, const FRotator& CamRot )
{
	UBOOL RetVal = FALSE;

	AActor*	ViewTarg = const_cast<AUDKPlayerController*>(C)->GetViewTarget();

	if( C->Pawn != NULL )
	{
		const FVector StartPoint = ViewTarg->Location + FVector(0,0,C->Pawn->BaseEyeHeight);
		const FVector EndPoint = StartPoint + CamRot.Vector() * 3000.0f; // @todo get this from the weapon

		FCheckResult HitProjectile;
		GWorld->SingleLineCheck( HitProjectile, const_cast<AUDKPlayerController*>(C), EndPoint, StartPoint, TRACE_Actors );

		if( (HitProjectile.Actor != NULL )
			&& ( HitProjectile.Actor->GetAProjectile() != NULL )
			&& ( !HitProjectile.Actor->bCanBeAdheredTo || !HitProjectile.Actor->bCanBeFrictionedTo) )
		{
			//warnf( TEXT("aiming at a non adhere-to and non friction-to Projectile!!!" ) );
			RetVal = TRUE;
		}
	}

	return RetVal;
}

/**
 * This will find the best AdhesionFriction target based on the params passed in.
 **/
APawn* AUDKPlayerController::GetTargetAdhesionFrictionTarget( FLOAT MaxDistance, const FVector& CamLoc, const FRotator& CamRot )
{
	APawn* BestTarget = NULL;
	
	// how to deal with other objects that are not GamePawns  (e.g. shock ball, magic objects)
	// a shock ball should "always?" be the best

	const UBOOL bDirectlyAimingAtAProjectile = IsDirectlyAimingAtAProjectile( this, CamRot );

	if( bDirectlyAimingAtAProjectile == TRUE )
	{
		return NULL;
	}

	const ULocalPlayer* LocalPlayer = ConstCast<ULocalPlayer>(Player); // do this cast only once
 
	if( LocalPlayer != NULL )
	{
		FLOAT BestFrictionTargetScore = 0.0f;

		for( APawn* TempP = GWorld->GetWorldInfo()->PawnList; TempP != NULL; TempP = TempP->NextPawn )
		{
			// check for visibility here as we need a LocalPlayer and don't want to just pass it in to then do the same check
			if( (WorldInfo->TimeSeconds - TempP->LastRenderTime < 0.1f) && IsValidTargetAdhesionFrictionTarget( TempP, MaxDistance ) )
			{
				//warnf( TEXT("PossibleTarget: %s"), *GamePawn->GetName() );
				// score all potential targets and find best one.
				const FLOAT TmpScore = ScoreTargetAdhesionFrictionTarget( TempP, MaxDistance, CamLoc, CamRot );

				// track best visible target
				if( TmpScore > BestFrictionTargetScore )
				{
					BestFrictionTargetScore = TmpScore;
					BestTarget = TempP;
					//warnf( TEXT("BestAdhesionFrictionTarget: %s at %f"), *BestTarget->GetName(), BestFrictionTargetScore );
				}
			}
		}
	}

	return BestTarget;
}


/** 
 * This will score both Adhesion and Friction targets.  We want the same scoring function as we
 * don't want the two different systems fighting over targets that are close.
 **/
FLOAT AUDKPlayerController::ScoreTargetAdhesionFrictionTarget( const APawn* P, FLOAT MaxDistance, const FVector& CamLoc, const FRotator& CamRot ) const
{
	FLOAT Score = 0.0f;

	if( P != NULL && Pawn != NULL )
	{
		// Initial Score based on how much we're aiming at them
		FVector ToTargetNorm = P->Location - Pawn->Location;
		const FLOAT DistToTarget = ToTargetNorm.Size();
		ToTargetNorm /= DistToTarget;

		Score = ToTargetNorm | CamRot.Vector();

		// If they're in front and within adhesion/friction range
		if( (Score > 0.f) && (DistToTarget < MaxDistance) )
		{
			// Adjust Score based on distance, so that closer targets are slightly favored
			Score += (1.f - (DistToTarget/MaxDistance)) * Score * 0.65f;
		}
	}

	return Score;
}

 
UBOOL AUDKPlayerController::Tick(FLOAT DeltaSeconds, ELevelTick TickType)
{
	if ( Super::Tick(DeltaSeconds,TickType) )
	{
		if ( bPulseTeamColor )
		{
			PulseTimer -= DeltaSeconds;
			if (PulseTimer < 0.f)
			{
				bPulseTeamColor = FALSE;
			}
		}
		if( bUsePhysicsRotation )
		{
			const FVector OldVelocity = Velocity;
			physicsRotation(DeltaSeconds, OldVelocity);
		}
		return 1;
	}

	return 0;
}

/** Will return the BindName based on the BindCommand 
  * Adds check for gamepad bindings which have _Gamepad appended to them  (for the special cases where a bind was modified to work special on the gamepad.)
  */
FString UUDKPlayerInput::GetUDKBindNameFromCommand(const FString& BindCommand)
{
	FString NameSearch = TEXT("");
	FString CommandToFind = BindCommand;
	UBOOL bGamepad = bUsingGamepad;

	// Get the bind command using the Mapped FieldName as the key
	if ( CommandToFind.Len() > 0 )
	{
		// We have a potential 2nd pass check in case we are looking for a gamepad binding
		// and we didn't find one.  The reason is that we may have appended "_Gamepad" to the end for
		// the special cases where a bind was modified to work special on the gamepad.
		INT NumAttempts = bGamepad ? 2 : 1;
		for ( INT AttemptIndex = 0; AttemptIndex < NumAttempts; AttemptIndex++ )
		{
			INT BindIndex = -1;

			// If this is the 2nd attempt it is because we were looking for a gamepad bind and
			// could not find one, so append "_Gamepad" and see if this was an altered command.
			if ( AttemptIndex > 0 )
			{
				CommandToFind += TEXT("_Gamepad");
			}

			// Loop for bind names until we get a match that is dependent on whether a controller or keyboard/mouse are used.
			do 
			{
				// Get bind name
				NameSearch = GetBindNameFromCommand( CommandToFind, &BindIndex );
				// See if it starts with the controller prefix.
				if ( NameSearch.StartsWith(TEXT("XboxTypeS")) )
				{
					// Is a controller prefix so if we are using the gamepad break and return this bind name.
					if ( bGamepad )
					{
						break;
					}
				}
				else
				{
					// Is not a controller prefix so if we are not using the gamepad break and return this bind name.
					if ( !bGamepad )
					{
						break;
					}
				}

				// Decrement the index.
				BindIndex--;

			} while( BindIndex >= 0 );

			// If we found a match break out.
			if ( NameSearch.Len() > 0 )
			{
				break;
			}
		}
	}

	return NameSearch;
}



