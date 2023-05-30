// DukePawn.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(ADukePawn)

void ADukePawn::AddDefaultInventory()
{
	this->eventCreateInventory(AWeaponPistol::StaticClass(), false);
}

void ADukePawn::TickSpecial( FLOAT DeltaSeconds )
{
	Super::TickSpecial(DeltaSeconds);

	UpdateEyeHeight(DeltaSeconds);

	// Position the 1st person weapon
	ADukeWeapon* Weap = Cast<ADukeWeapon>(Weapon);
	if (Weap != NULL)
	{
		Weap->eventSetPosition(this);
	}
}

void ADukePawn::UpdateEyeHeight(FLOAT DeltaSeconds)
{
	eventUpdateEyeHeight(DeltaSeconds);
}