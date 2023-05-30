// DukeWeapon.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(ADukeWeapon)

void ADukeWeapon::BeginFire(BYTE FireModeNum)
{
	if(weaponState != WEAPON_STATE_IDLE)
		return;

	eventPlayWeaponAnimation(WeaponFireAnim.GetData()[0], 0.0, false);

	weaponState = WEAPON_STATE_FIRING;
}