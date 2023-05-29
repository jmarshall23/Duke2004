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

	// Position the 1st person weapon
	ADukeWeapon* Weap = Cast<ADukeWeapon>(Weapon);
	if (Weap != NULL)
	{
		Weap->eventSetPosition(this);
	}
}