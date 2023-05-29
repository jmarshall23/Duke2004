//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// Confidential.
//=============================================================================

#include "UDKBase.h"
#include "UnNet.h"

static inline UBOOL NEQ(const FUTTakeHitInfo& A, const FUTTakeHitInfo& B, UPackageMap* Map, UActorChannel* Channel)
{
	return (A.HitLocation != B.HitLocation);
}

static inline UBOOL NEQ(const FDrivenWeaponPawnInfo& A, const FDrivenWeaponPawnInfo& B, UPackageMap* Map, UActorChannel* Channel)
{
	// it's important that we always check both objects so that Channel->ActorMustStayDirty will be set to true if either is not serializable
	UBOOL bResult = NEQ(A.BaseVehicle, B.BaseVehicle, Map, Channel);
	bResult = (NEQ(A.PRI, B.PRI, Map, Channel) || bResult);
	return (bResult || A.SeatIndex != B.SeatIndex);
}

static inline UBOOL NEQ(const FPlayEmoteInfo& A, const FPlayEmoteInfo& B, UPackageMap* Map, UActorChannel* Channel)
{
	return( (A.EmoteTag != B.EmoteTag) ||
			(A.EmoteID != B.EmoteID) ||
			(A.bNewData != B.bNewData) );
}

INT* AUDKPawn::GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel )
{
	Ptr = Super::GetOptimizedRepList(Recent,Retire,Ptr,Map,Channel);
	
	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);	
	if ( bNetDirty )
	{
		if ( bNetOwner )
		{
			DOREP(UDKPawn,FireRateMultiplier);
		}
		else
		{
			DOREP(UDKPawn,DrivenWeaponPawn);
			DOREP(UDKPawn,bPuttingDownWeapon);
		}
		DOREP(UDKPawn,bFeigningDeath);
		DOREP(UDKPawn,CompressedBodyMatColor);
		DOREP(UDKPawn,ClientBodyMatDuration);
		DOREP(UDKPawn,HeadScale);
		DOREP(UDKPawn,PawnAmbientSoundCue);
		DOREP(UDKPawn,WeaponAmbientSoundCue);
		DOREP(UDKPawn,ReplicatedBodyMaterial);
		DOREP(UDKPawn,OverlayMaterialInstance);
		DOREP(UDKPawn,WeaponOverlayFlags);
		DOREP(UDKPawn,CustomGravityScaling);
		DOREP(UDKPawn,bIsInvisible);
		DOREP(UDKPawn,BigTeleportCount);

		if (WorldInfo->TimeSeconds - LastEmoteTime <= MinTimeBetweenEmotes)
		{
			DOREP(UDKPawn,EmoteRepInfo);
		}
		if (WorldInfo->TimeSeconds < LastTakeHitTimeout)
		{
			DOREP(UDKPawn,LastTakeHitInfo);
		}
		if( bTearOff )
		{
			DOREP(UDKPawn,bTearOffGibs);
		}
	}

	return Ptr;
}

INT* AUDKPickupFactory::GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel )
{
	Ptr = Super::GetOptimizedRepList(Recent,Retire,Ptr,Map,Channel);
	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);	

	if ( bNetDirty )
	{
		DOREP(UDKPickupFactory,bPulseBase);
		DOREP(UDKPickupFactory,bIsRespawning);
	}

	return Ptr;
}

INT* AUDKGameObjective::GetOptimizedRepList(BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel)
{
	Ptr = Super::GetOptimizedRepList(Recent, Retire, Ptr, Map, Channel);

	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);
	if (bNetDirty)
	{
		DOREP(UDKGameObjective,DefenderTeamIndex);
		DOREP(UDKGameObjective,bUnderAttack);
	}

	return Ptr;
}


INT* AUDKProjectile::GetOptimizedRepList(BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel)
{
	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);

	if (bNetDirty)
	{
		if (bReplicateInstigator)
		{
			if (!bNetTemporary || (InstigatorBaseVehicle != NULL && Map->CanSerializeObject(InstigatorBaseVehicle)))
			{
				DOREP(UDKProjectile,InstigatorBaseVehicle);
			}
		
			// don't ever stay dirty for unserializable Instigator if we have InstigatorBaseVehicle
			if (Instigator == NULL || (!bNetTemporary && InstigatorBaseVehicle == NULL && ((AUDKProjectile*)Recent)->InstigatorBaseVehicle == NULL) || Map->CanSerializeObject(Instigator))
			{
				DOREP(Actor,Instigator);
			}
		}

		if (bNetInitial)
		{
			DOREP(UDKProjectile,bWideCheck);
			DOREP(UDKProjectile,SeekTarget);
			DOREP(UDKProjectile,InitialDir);
		}
	}

	// we already handled Instigator replication, so temporarily disable bReplicateInstigator for AActor version
	UBOOL bOldReplicateInstigator = bReplicateInstigator;
	bReplicateInstigator = FALSE;
	Ptr = Super::GetOptimizedRepList(Recent, Retire, Ptr, Map, Channel);
	bReplicateInstigator = bOldReplicateInstigator;

	return Ptr;
}


INT* AUDKVehicleFactory::GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel )
{
	Ptr = Super::GetOptimizedRepList(Recent,Retire,Ptr,Map,Channel);

	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);	
	if (bNetDirty)
	{
		DOREP(UDKVehicleFactory,bHasLockedVehicle);
		if (bReplicateChildVehicle)
		{
			DOREP(UDKVehicleFactory,ChildVehicle);
		}
	}

	return Ptr;
}

INT* AUDKWeaponPawn::GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel )
{
	Ptr = Super::GetOptimizedRepList(Recent,Retire,Ptr,Map,Channel);

	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);	
	if (bNetDirty)
	{
		DOREP(UDKWeaponPawn,MySeatIndex);
		DOREP(UDKWeaponPawn,MyVehicle);
		DOREP(UDKWeaponPawn,MyVehicleWeapon);
	}
	
	return Ptr;
}

INT* AUDKWeapon::GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel )
{
	Ptr = Super::GetOptimizedRepList(Recent,Retire,Ptr,Map,Channel);
	
	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);	
	if ( bNetDirty && bNetOwner )
	{
		DOREP(UDKWeapon,AmmoCount);
		DOREP(UDKWeapon,HitEnemy);
	}

	return Ptr;
}


INT* AUDKVehicle::GetOptimizedRepList( BYTE* Recent, FPropertyRetirement* Retire, INT* Ptr, UPackageMap* Map, UActorChannel* Channel )
{
	Ptr = Super::GetOptimizedRepList(Recent,Retire,Ptr,Map,Channel);

	checkSlow(StaticClass()->ClassFlags & CLASS_NativeReplication);	
	if (bNetDirty)
	{
		if (!bNetOwner || bDemoRecording)
		{
			DOREP(UDKVehicle,WeaponRotation);
			DOREP(UDKVehicle,bTrickJumping);
			DOREP(UDKVehicle,bForceSpinWarmup);
		}
		DOREP(UDKVehicle,bDeadVehicle);
		DOREP(UDKVehicle,Team);
		DOREP(UDKVehicle,SeatMask);
		DOREP(UDKVehicle,CustomGravityScaling);
		DOREP(UDKVehicle,bIsDisabled);
		DOREP(UDKVehicle,bTeamLocked);
		DOREP(UDKVehicle,bGrab1);
		DOREP(UDKVehicle,bGrab2);
		
		if (WorldInfo->TimeSeconds < LastTakeHitTimeout)
		{
			DOREP(UDKVehicle,LastTakeHitInfo);
		}
		if (KillerController == NULL || Map->CanSerializeObject(KillerController))
		{
			DOREP(UDKVehicle,KillerController);
		}
	}
	return Ptr;
}


