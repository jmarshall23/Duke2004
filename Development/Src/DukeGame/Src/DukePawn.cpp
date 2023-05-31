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
	float Speed2D;
	FVector X,Y,Z;

	DukeMath::GetAxes(Rotation, X, Y, Z);

	//Rotation.

	Super::TickSpecial(DeltaSeconds);

	Speed2D = appSqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);
	CheckBob(DeltaSeconds, Speed2D, Y);

	// Position the 1st person weapon
	ADukeWeapon* Weap = Cast<ADukeWeapon>(Weapon);
	if (Weap != NULL)
	{
		Weap->eventSetPosition(this);
	}
}

void ADukePawn::CheckBob(float DeltaTime, float Speed2D, FVector Y)
{
	float OldBobTime;
	float GroundSpeed = 600;

	//GroundSpeed = GetMovementComponent(

	OldBobTime = BobTime;
	if (Speed2D < 10)
		BobTime += 0.2 * DeltaTime;
	else
		BobTime += DeltaTime * (0.3 + 0.7 * Speed2D / GroundSpeed);
	WalkBob = Y * 0.4 * Bob * Speed2D * sin(8 * BobTime);
	AppliedBob = Min<float>(1, 16 * DeltaTime) * LandBob + AppliedBob * (1 - Min<float>(1, 16 * DeltaTime));
	if (Speed2D < 10)
		WalkBob.Z = AppliedBob;
	else
		WalkBob.Z = AppliedBob + 0.3 * Bob * Speed2D * sin(16 * BobTime);
	LandBob *= (1 - 8 * DeltaTime);
}

FVector ADukePawn::GetPawnViewLocation()
{
	return Location + EyeHeight * FVector::GetZAxisVector() + WalkBob;
}

UBOOL ADukePawn::CalcCamera(FLOAT fDeltaTime,FVector& out_CamLoc,FRotator& out_CamRot,FLOAT& out_FOV)
{
	if(WalkBob.X > 0)
		WalkBob = WalkBob;

	out_CamLoc = GetPawnViewLocation();
	out_CamRot = GetViewRotation();

	return TRUE;
}