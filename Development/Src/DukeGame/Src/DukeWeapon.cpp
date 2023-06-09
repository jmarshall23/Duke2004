// DukeWeapon.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(ADukeWeapon)

void ADukeWeapon::BeginFire(BYTE FireModeNum)
{
	if(weaponState != WEAPON_STATE_IDLE)
		return;

	eventStopWeaponAnimation();
	eventPlayWeaponAnimation(WeaponFireAnim.GetData()[0], 0.0, false);

	weaponState = WEAPON_STATE_FIRING;

	PlayWeaponFireSound();
	FireLineTrace();
}

void ADukeWeapon::FireLineTrace()
{
	// Do a trace in the player's facing direction and edit anything that's hit.
	FVector PlayerLocation;
	FRotator PlayerRotation;

	ADukePawn *pawn = Cast<ADukePawn>(Owner);

	pawn->Controller->eventGetPlayerViewPoint(PlayerLocation, PlayerRotation);

	FCheckResult Hit(1.0f);

	GWorld->SingleLineCheck(Hit, pawn, PlayerLocation + PlayerRotation.Vector() * 10000, PlayerLocation, TRACE_SingleResult | TRACE_Actors);
	
	AHumanNPC *humanNPC = Cast<AHumanNPC>(Hit.Actor);
	if(humanNPC)
	{
		humanNPC->Damage(pawn, Damage, Hit.Location);
	}
}

void ADukeWeapon::PlayWeaponFireSound()
{
	int soundId = appRandRange(0, numFireSounds-1);

	switch(soundId)
	{
		case 0:
			PlaySound(fireSound1);
			break;
		case 1:
			PlaySound(fireSound2);
			break;
		case 2:
			PlaySound(fireSound3);
			break;
	}
}

void ADukeWeapon::ResetToIdle()
{
	if(weaponState == WEAPON_STATE_IDLE)
		return;

	eventStopWeaponAnimation();
	eventPlayWeaponAnimation(WeaponIdleAnims.GetData()[0], 0.0, true);
	weaponState = WEAPON_STATE_IDLE;
}