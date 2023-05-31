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
}

void ADukeWeapon::ResetToIdle()
{
	if(weaponState == WEAPON_STATE_IDLE)
		return;

	eventStopWeaponAnimation();
	eventPlayWeaponAnimation(WeaponIdleAnims.GetData()[0], 0.0, true);
	weaponState = WEAPON_STATE_IDLE;
}