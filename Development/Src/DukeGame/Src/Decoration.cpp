// Decoration.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(ADecoration)

UBOOL ADecoration::CanSplash()
{
	if ( (WorldInfo->TimeSeconds - SplashTime > 0.25) && (Physics == PHYS_Falling) && (Abs(Velocity.Z) > 100) )
	{
		SplashTime = WorldInfo->TimeSeconds;
		return true;
	}
	return false;
}

void ADecoration::Landed(FVector HitNormal,class AActor* FloorActor)
{
	FRotator NewRot;
	APawn *localOwner;

	localOwner = Cast<APawn>(Owner);

	if(!localOwner)
		return;

	if (Velocity.Z<-500) 
		TakeDamage(100,localOwner->Controller,FloorActor->Location,HitNormal, UCrushed::StaticClass());	
	Velocity = FVector::ZeroVector;
	NewRot = Rotation;
	NewRot.Pitch = 0;
	NewRot.Roll = 0;
	SetRotation(NewRot);
}

void ADecoration::TakeDamage(INT DamageAmount,class AController* EventInstigator,FVector HitLocation,FVector Momentum,class UClass* DamageType,struct FTraceHitInfo HitInfo,class AActor* DamageCauser)
{
	APlayerController *eventController;

	eventController = Cast<APlayerController>(EventInstigator);
	if(eventController == NULL)
		return;

	Instigator = eventController->Pawn;
	if (!bDamageable || (Health<0) ) 
		return;

	if ( Instigator != NULL )
		MakeNoise(1.0);
	Health -= DamageAmount;
	FragMomentum = Momentum;
	if (Health <0) 	
	{
		GWorld->DestroyActor( this );
	}
	else 
	{
		setPhysics(PHYS_Falling);
		Momentum.Z = 1000;
		Velocity=Momentum/Mass;
	}
}

void ADecoration::Trigger(class AActor* Other,class APawn* EventInstigator)
{
	Instigator = EventInstigator;
	TakeDamage( 1000, Instigator->Controller, Location, FVector::GetZAxisVector()*900, UCrushed::StaticClass());
}

void ADecoration::PhysicsVolumeChange(class APhysicsVolume* NewVolume)
{
	if( NewVolume->bWaterVolume )
	{
		if( bSplash && !PhysicsVolume->bWaterVolume && Mass<=Buoyancy 
			&& ((Abs(Velocity.Z) < 100) || (Mass == 0)) && (appFrand() < 0.05) && !PlayerCanSeeMe() )
		{
			bSplash = false;
			setPhysics(PHYS_None);
		}
	}
	if( PhysicsVolume->bWaterVolume && (Buoyancy > Mass) )
	{
		if( Buoyancy > 1.1 * Mass )
			Buoyancy = 0.95 * Buoyancy; // waterlog
		else if( Buoyancy > 1.03 * Mass )
			Buoyancy = 0.99 * Buoyancy;
	}
}

void ADecoration::BaseChangeImp()
{
	if( Velocity.Z < -500 )
		TakeDamage( (1-Velocity.Z/30),Instigator->Controller,Location, FVector::ZeroVector, UCrushed::StaticClass());

	if( Base == NULL )
	{ 
		if ( /*!bInterpolating &&*/ bPushable && (Physics == PHYS_None) )
			setPhysics(PHYS_Falling);
	}
	else if( Cast<APawn>(Base) != NULL )
	{
		APawn *_base = Cast<APawn>(Base);

		_base->eventTakeDamage( (1-Velocity.Z/400)* Mass/_base->Mass,Instigator->Controller,Location,0.5 * Velocity, UCrushed::StaticClass());
		Velocity.Z = 100;
		if (appFrand() < 0.5)
			Velocity.X += 70;
		else
			Velocity.Y += 70;
		setPhysics(PHYS_Falling);
	}
	else if( Cast<ADecoration>(Base) != NULL && Velocity.Z<-500 )
	{
		ADecoration *_base = Cast<ADecoration>(Base);

		_base->eventTakeDamage((1 - Mass/_base->Mass * Velocity.Z/30), Instigator->Controller, Location, 0.2 * Velocity, UCrushed::StaticClass());
		Velocity.Z = 100;
		if (appFrand() < 0.5)
			Velocity.X += 70;
		else
			Velocity.Y += 70;
		setPhysics(PHYS_Falling);
	}
	else
		Instigator = NULL;
}