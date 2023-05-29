//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// Confidential.
//=============================================================================

#include "UDKBase.h"
#include "UnPath.h"
#include "DebugRenderSceneProxy.h"

IMPLEMENT_CLASS(AUDKJumpPad);
IMPLEMENT_CLASS(UUDKTrajectoryReachSpec);
IMPLEMENT_CLASS(UUDKJumpPadReachSpec);
IMPLEMENT_CLASS(AUDKScout);
IMPLEMENT_CLASS(AUDKTeamPlayerStart);
IMPLEMENT_CLASS(AUDKScriptedNavigationPoint);

FVector UUDKJumpPadReachSpec::GetInitialVelocity()
{
	AUDKJumpPad* JumpStart = Cast<AUDKJumpPad>(Start);
	return JumpStart ? JumpStart->JumpVelocity : FVector(0.f,0.f,0.f);
}

INT UUDKJumpPadReachSpec::CostFor(APawn* P)
{
	// vehicles can't use jump pads
	return P->IsA(AVehicle::StaticClass()) ? UCONST_BLOCKEDPATHCOST : Super::CostFor(P);
}

// FIXMESTEVE - should be if not ifdef
#if WITH_EDITOR
void AUDKJumpPad::addReachSpecs(AScout *Scout, UBOOL bOnlyChanged)
{
	Super::addReachSpecs(Scout,bOnlyChanged);

	if ( GetGravityZ() >= 0.f )
	{
		GWarn->MapCheck_Add( MCTYPE_ERROR, this, *FString::Printf( LocalizeSecure( LocalizeUnrealEd( "MapCheck_Message_JumpPads" ), *GetName() ) ), TEXT( "JumpPads" ) );
		return;
	}

	// check that there are no other overlapping navigationpoints
	for (ANavigationPoint *Nav = GWorld->GetFirstNavigationPoint(); Nav != NULL; Nav = Nav->nextNavigationPoint)
	{
		if (Nav != NULL &&
			!Nav->bDeleteMe &&
			Nav != this &&
			(!bOnlyChanged || bPathsChanged || Nav->bPathsChanged) ) 
		{
			FVector XYDir = Nav->Location - Location;
			FLOAT ZDiff = Abs(XYDir.Z);
			if ( ZDiff < CylinderComponent->CollisionHeight + Nav->CylinderComponent->CollisionHeight )
			{
				XYDir.Z = 0.f;
				FLOAT MinDist = CylinderComponent->CollisionRadius + Nav->CylinderComponent->CollisionRadius;
				if ( XYDir.SizeSquared() < MinDist*MinDist )
				{
					GWarn->MapCheck_Add( MCTYPE_ERROR, Nav, *FString::Printf( LocalizeSecure( LocalizeUnrealEd( "MapCheck_Message_NavPointTouchesJumpPad" ), *GetName() ) ), TEXT( "NavPointTouchesJumpPad" ) );
				}
			}
		}
	}

	if ( !JumpTarget )
	{
		GWarn->MapCheck_Add( MCTYPE_ERROR, this, *FString::Printf( LocalizeSecure( LocalizeUnrealEd( "MapCheck_Message_NoJumpTarget" ), *GetName() ) ), TEXT( "NoJumpTarget" ) );
		return;
	}

	if ( CalculateJumpVelocity(Scout) )
	{
		UReachSpec *newSpec = ConstructObject<UReachSpec>(UUDKJumpPadReachSpec::StaticClass(),GWorld->GetOuter(),NAME_None);

		// debugf(TEXT("Add Jump Reachspec for JumpPad at (%f, %f, %f)"), Location.X,Location.Y,Location.Z);
		FVector HumanSize = Scout->GetSize(((AUDKScout*)(AUDKScout::StaticClass()->GetDefaultActor()))->SizePersonFindName);
		newSpec->CollisionRadius = appTrunc(HumanSize.X);
		newSpec->CollisionHeight = appTrunc(HumanSize.Y);
		newSpec->Start = this;
		newSpec->End = JumpTarget;
		newSpec->reachFlags = R_JUMP + R_WALK;

		FVector JumpXY = JumpVelocity;
		JumpXY.Z = 0.f;
		// scale distance based on speed
		newSpec->Distance = (INT)((Location - JumpTarget->Location).Size() * ::Min(1.f, 1.5f*Scout->TestGroundSpeed/JumpXY.Size()));
		PathList.AddItem(newSpec);
	}
	else
	{
		GWarn->MapCheck_Add( MCTYPE_ERROR, this, *FString::Printf( LocalizeSecure( LocalizeUnrealEd( "MapCheck_Message_JumpCannotBeMade" ), *JumpTarget->GetName() ) ), TEXT( "JumpCannotBeMade" ) );
	}
}
#endif

UBOOL AUDKJumpPad::CalculateJumpVelocity(AScout *Scout)
{
	if ( !JumpTarget )
	{
		JumpVelocity = FVector(0.f, 0.f, 0.f);
		return FALSE;
	}

	FVector HumanSize = Scout->GetSize( ((AUDKScout*)(AUDKScout::StaticClass()->GetDefaultActor()))->SizePersonFindName);

	FVector Flight = JumpTarget->Location - Location;
	FLOAT FlightZ = Flight.Z;
	Flight.Z = 0.f;
	FLOAT FlightSize = Flight.Size();

	if ( FlightSize == 0.f )
	{
		JumpVelocity = FVector(0.f, 0.f, 0.f);
		return FALSE;
	}

	FLOAT Gravity = GetGravityZ(); 

	FLOAT XYSpeed = FlightSize/JumpTime;
	FLOAT ZSpeed = FlightZ/JumpTime - Gravity * JumpTime;

	// trace check trajectory
	UBOOL bFailed = TRUE;
	FVector FlightDir = Flight/FlightSize;
	FCheckResult Hit(1.f);

	// look for unobstructed trajectory, by increasing or decreasing flighttime
	UBOOL bDecreasing = TRUE;
	FLOAT AdjustedJumpTime = JumpTime;

	while ( bFailed )
	{
		FVector StartVel = XYSpeed*FlightDir + FVector(0.f,0.f,ZSpeed);
		FLOAT StepSize = 0.0625f;
		FVector TraceStart = Location;
		bFailed = FALSE;

		// trace trajectory to make sure it isn't obstructed
		for ( FLOAT Step=0.f; Step<1.f; Step+=StepSize )
		{
			FLOAT FlightTime = (Step+StepSize) * AdjustedJumpTime;
			FVector TraceEnd = Location + StartVel*FlightTime + FVector(0.f, 0.f, Gravity * FlightTime * FlightTime);
			if ( !GWorld->SingleLineCheck( Hit, this, TraceEnd, TraceStart, TRACE_World|TRACE_StopAtAnyHit, HumanSize ) )
			{
				bFailed = TRUE;
				break;
			}
			TraceStart = TraceEnd;
		}

		if ( bFailed )
		{
			if ( bDecreasing )
			{
				AdjustedJumpTime -= 0.1f*JumpTime;
				if ( AdjustedJumpTime < 0.5f*JumpTime )
				{
					bDecreasing = FALSE;
					AdjustedJumpTime = JumpTime + 0.2f*JumpTime;
				}
			}
			else
			{
				AdjustedJumpTime += 0.2f*JumpTime;
				if ( AdjustedJumpTime > 2.f*JumpTime )
				{
					// no valid jump possible
					JumpVelocity = FVector(0.f, 0.f, 0.f);
					return FALSE;
				}

				XYSpeed = FlightSize/AdjustedJumpTime;
				ZSpeed = FlightZ/AdjustedJumpTime - Gravity * AdjustedJumpTime;
			}
		}
	}
	JumpVelocity = XYSpeed*FlightDir + FVector(0.f,0.f,ZSpeed);
	return TRUE;
}

void AUDKJumpPad::PostEditChangeProperty(FPropertyChangedEvent& PropertyChangedEvent)
{
	AScout*	Scout = FPathBuilder::GetScout();
	CalculateJumpVelocity(Scout);
	FPathBuilder::DestroyScout();

	Super::PostEditChangeProperty(PropertyChangedEvent);
}

void AUDKJumpPad::PostEditMove(UBOOL bFinished)
{
	if ( bFinished )
	{
		AScout*	Scout = FPathBuilder::GetScout();
		CalculateJumpVelocity(Scout);
	}

	Super::PostEditMove( bFinished );
}

void UUDKTrajectoryReachSpec::AddToDebugRenderProxy(FDebugRenderSceneProxy* DRSP)
{
	if ( Start && End.Nav() )
	{
		FVector InitialVelocity = GetInitialVelocity();
		if ( InitialVelocity.IsZero() )
		{
			Super::AddToDebugRenderProxy(DRSP);
			return;
		}
		FPlane PathColorPlane = PathColor();
		FLinearColor PathColorValue = FLinearColor(PathColorPlane.X, PathColorPlane.Y, PathColorPlane.Z, PathColorPlane.W);
		FLOAT TotalFlightTime = (End->Location - Start->Location).Size2D()/InitialVelocity.Size2D();
		FLOAT Gravity = Start->GetGravityZ(); 
		FLOAT StepSize = 0.0625f;
		FVector TraceStart = Start->Location;

		for ( FLOAT Step=StepSize; Step<=1.f; Step+=StepSize )
		{
			FLOAT FlightTime = Step * TotalFlightTime;
			FVector TraceEnd = Start->Location + InitialVelocity*FlightTime + FVector(0.f, 0.f, Gravity * FlightTime * FlightTime);
			if (Step + StepSize > 1.f)
			{
				new(DRSP->ArrowLines) FDebugRenderSceneProxy::FArrowLine(TraceStart, TraceEnd, PathColorValue);
			}
			else
			{
				new(DRSP->Lines) FDebugRenderSceneProxy::FDebugLine(TraceStart, TraceEnd, PathColorValue);
			}
			TraceStart = TraceEnd;
		}
	}
}


UBOOL AUDKPawn::SuggestJumpVelocity(FVector& JumpVelocity, FVector End, FVector Start, UBOOL bRequireFallLanding)
{
	bRequiresDoubleJump = FALSE;
	if ( Super::SuggestJumpVelocity(JumpVelocity, End, Start) )
		return TRUE;

	if ( !bCanDoubleJump )
		return FALSE;

 	bRequiresDoubleJump = TRUE;
 
 	// calculate using effective JumpZ with doublejump
 	FLOAT RealJumpZ = JumpZ;
 	JumpZ += JumpZ * 0.3f + MultiJumpBoost;
 	UBOOL bResult = Super::SuggestJumpVelocity(JumpVelocity, End, Start);
 
 	// set start jumpvelocity so double jump can be full
 	if ( JumpVelocity.Z <= RealJumpZ )
 	{
 		JumpVelocity.Z = RealJumpZ;
 		bRequiresDoubleJump = FALSE;
 	}
 	else
 	{
		JumpVelocity.Z -= JumpZ - RealJumpZ;
 	}
 	JumpZ = RealJumpZ;
 	return bResult;
}

ETestMoveResult AUDKPawn::FindJumpUp(FVector Direction, FVector &CurrentPosition)
{
	bRequiresDoubleJump = FALSE;

	ETestMoveResult success = Super::FindJumpUp(Direction, CurrentPosition);
	if ( (success != TESTMOVE_Stopped) || !bCanDoubleJump )
		return success;

	bRequiresDoubleJump = TRUE;
	FCheckResult Hit(1.f);
	FVector StartLocation = CurrentPosition;
	FVector CollisionExtent = GetDefaultCollisionSize();

	TestMove(FVector(0,0,MaxDoubleJumpHeight - MaxStepHeight), CurrentPosition, Hit, CollisionExtent);
	success = walkMove(Direction, CurrentPosition, CollisionExtent, Hit, NULL, MINMOVETHRESHOLD);

	StartLocation.Z = CurrentPosition.Z;
	if ( success != TESTMOVE_Stopped )
	{
		TestMove(-1.f*FVector(0,0,MaxDoubleJumpHeight), CurrentPosition, Hit, CollisionExtent);
		// verify walkmove didn't just step down
		StartLocation.Z = CurrentPosition.Z;
		if ((StartLocation - CurrentPosition).SizeSquared() < MINMOVETHRESHOLD * MINMOVETHRESHOLD)
			return TESTMOVE_Stopped;
	}
	else
		CurrentPosition = StartLocation;

	return success;
}

/* TryJumpUp()
Check if could jump up over obstruction
*/
UBOOL AUDKPawn::TryJumpUp(FVector Dir, FVector Destination, DWORD TraceFlags, UBOOL bNoVisibility)
{
	FVector Out = 14.f * Dir;
	FCheckResult Hit(1.f);
	FVector Up = FVector(0.f,0.f,MaxJumpHeight);

	if ( bNoVisibility )
	{
		// do quick trace check first
		FVector Start = Location + FVector(0.f, 0.f, CylinderComponent->CollisionHeight);
		FVector End = Start + Up;
		GWorld->SingleLineCheck(Hit, this, End, Start, TRACE_World);
		UBOOL bLowCeiling = Hit.Time < 1.f;
		if ( bLowCeiling )
		{
			End = Hit.Location;
		}
		GWorld->SingleLineCheck(Hit, this, Destination, End, TraceFlags);
		if ( (Hit.Time < 1.f) && (Hit.Actor != Controller->MoveTarget) )
		{
			if ( !bCanDoubleJump || bLowCeiling )
			{
				return FALSE;
			}

			// try double jump LOS
			Start = End;
			End += FVector(0.f, 0.f, MaxDoubleJumpHeight - MaxJumpHeight);
			GWorld->SingleLineCheck(Hit, this, End, Start, TRACE_World);
			if ( Hit.Time < 1.f )
				End = Hit.Location;
			GWorld->SingleLineCheck(Hit, this, Destination, End, TraceFlags);
			if ( (Hit.Time < 1.f) && (Hit.Actor != Controller->MoveTarget) )
			{
				return FALSE;
			}
		}
	}

	GWorld->SingleLineCheck(Hit, this, Location + Up, Location, TRACE_World, GetCylinderExtent());
	FLOAT FirstHit = Hit.Time;
	if ( FirstHit > 0.5f )
	{
		GWorld->SingleLineCheck(Hit, this, Location + Up * Hit.Time + Out, Location + Up * Hit.Time, TraceFlags, GetCylinderExtent());
		if ( (Hit.Time < 1.f) && bCanDoubleJump && (FirstHit == 1.f) )
		{
			// try double jump
			Up = FVector(0.f,0.f,MaxJumpHeight);
			FVector doubleUp(0.f,0.f,MaxDoubleJumpHeight);
			GWorld->SingleLineCheck(Hit, this, Location + doubleUp, Location + Up, TRACE_World, GetCylinderExtent());
			if ( Hit.Time > 0.25f )
			{
				if ( Hit.Time == 1.f )
					Hit.Location = Location + doubleUp;
				GWorld->SingleLineCheck(Hit, this, Hit.Location + Out, Hit.Location, TraceFlags, GetCylinderExtent());
			}
		}
		return (Hit.Time == 1.f);
	}
	return FALSE;
}

INT AUDKPawn::calcMoveFlags()
{
	return ( bCanWalk * R_WALK + bCanFly * R_FLY + bCanSwim * R_SWIM + bJumpCapable * R_JUMP + bCanDoubleJump * R_HIGHJUMP ); 
}


/** Check that game objectives are not non-uniformly scaled. */
#if WITH_EDITOR
void AUDKGameObjective::CheckForErrors()
{
	Super::CheckForErrors();

	// Then iterate over components
	UBOOL bUniformScaling = TRUE;
	for(INT i=0; i<Components.Num(); i++)
	{
		if(Components(i) && Components(i)->IsAttached())
		{
			// Only care about primitive components
			USkeletalMeshComponent* SkelComp = Cast<USkeletalMeshComponent>(Components(i));
			if(SkelComp && SkelComp->ShouldCollide())
			{
				FVector TotalScale = SkelComp->Scale3D;
				if(SkelComp->GetOwner())
				{
					TotalScale *= SkelComp->GetOwner()->DrawScale3D;
				}

				if(!TotalScale.IsUniform())
				{
					bUniformScaling = FALSE;
					break;				
				}
			}
		}
	}

	// If something is non-uniformly scaled, add warning.
	if(!bUniformScaling)
	{
		GWarn->MapCheck_Add( MCTYPE_WARNING, this, *FString::Printf( LocalizeSecure( LocalizeUnrealEd( "MapCheck_Message_ObjectiveCollidingComponentWithNonUniformScaling" ), *GetName() ) ), TEXT( "ObjectiveCollidingComponentWithNonUniformScaling" ) );
	}
}
#endif


UBOOL AUDKScout::SetHighJumpFlag()
{
	if ( bRequiresDoubleJump )
	{
		bRequiresDoubleJump = FALSE;
		return TRUE;
	}
	return FALSE;
}


/** flag used by FindBestJump() to prevent SuggestJumpVelocity() considering double jump */
static UBOOL GForceNoDoubleJump = FALSE;

UBOOL AUDKScout::SuggestJumpVelocity(FVector& JumpVelocity, FVector End, FVector Start, UBOOL bRequireFallLanding)
{
	bRequiresDoubleJump = FALSE;
	if ( Super::SuggestJumpVelocity(JumpVelocity, End, Start) )
		return TRUE;

	if (GForceNoDoubleJump || PrototypePawnClass == NULL)
	{
		return FALSE;
	}

 	bRequiresDoubleJump = TRUE;
 
 	// calculate using effective JumpZ with doublejump
 	FLOAT RealJumpZ = JumpZ;
	AUDKPawn* DefaultPawn = PrototypePawnClass->GetDefaultObject<AUDKPawn>();
	JumpZ += DefaultPawn->JumpZ * 0.3 + DefaultPawn->MultiJumpBoost;

 	UBOOL bResult = Super::SuggestJumpVelocity(JumpVelocity, End, Start);
 	JumpZ = RealJumpZ;
 	return bResult;
}

ETestMoveResult AUDKScout::FindBestJump(FVector Dest, FVector &CurrentPosition)
{
	// test both with and without double jump
	// if non-double jump check reached same Z, then don't require it
	GForceNoDoubleJump = TRUE;
	FVector SingleJumpPosition = CurrentPosition;
	ETestMoveResult SingleJumpResult = Super::FindBestJump(Dest, SingleJumpPosition);

	GForceNoDoubleJump = FALSE;
	FVector DoubleJumpPosition = CurrentPosition;
	ETestMoveResult DoubleJumpResult = Super::FindBestJump(Dest, DoubleJumpPosition);

	if (SingleJumpResult != TESTMOVE_Moved && DoubleJumpResult != TESTMOVE_Moved)
	{
		// both failed
		return SingleJumpResult;
	}
	else
	{
		if (SingleJumpResult != DoubleJumpResult)
		{
			bRequiresDoubleJump = (SingleJumpResult != TESTMOVE_Moved);
		}
		else
		{
			bRequiresDoubleJump = (SingleJumpPosition.Z <= DoubleJumpPosition.Z - MaxStepHeight);
		}
		
		CurrentPosition = bRequiresDoubleJump ? SingleJumpPosition : DoubleJumpPosition;
		return TESTMOVE_Moved;
	}
}

ETestMoveResult AUDKScout::FindJumpUp(FVector Direction, FVector &CurrentPosition)
{
	bRequiresDoubleJump = FALSE;

	ETestMoveResult success = Super::FindJumpUp(Direction, CurrentPosition);
	if ( success != TESTMOVE_Stopped )
		return success;

	// only path build double jump up if human sized or smaller
	FVector HumanSize = GetSize(SizePersonFindName);
	if ( (HumanSize.X < CylinderComponent->CollisionRadius) || (HumanSize.Y < CylinderComponent->CollisionHeight) )
	{
		return success;
	}
	bRequiresDoubleJump = TRUE;
	FCheckResult Hit(1.f);
	FVector StartLocation = CurrentPosition;
	FVector CollisionExtent = GetDefaultCollisionSize();

	TestMove(FVector(0,0,MaxDoubleJumpHeight - MaxStepHeight), CurrentPosition, Hit, CollisionExtent);
	success = walkMove(Direction, CurrentPosition, CollisionExtent, Hit, NULL, MINMOVETHRESHOLD);

	StartLocation.Z = CurrentPosition.Z;
	if ( success != TESTMOVE_Stopped )
	{
		TestMove(-1.f*FVector(0,0,MaxDoubleJumpHeight), CurrentPosition, Hit, CollisionExtent);
		// verify walkmove didn't just step down
		StartLocation.Z = CurrentPosition.Z;
		if ((StartLocation - CurrentPosition).SizeSquared() < MINMOVETHRESHOLD * MINMOVETHRESHOLD)
			return TESTMOVE_Stopped;
	}
	else
		CurrentPosition = StartLocation;

	return success;
}




//============================================================
// UDKScout path building

void AUDKScout::SetPrototype()
{
	if ( PrototypePawnClass )
	{
		AUDKPawn* DefaultPawn = Cast<AUDKPawn>(PrototypePawnClass->GetDefaultActor());

		// override UDKScout defaults
		PathSizes(0).Radius = DefaultPawn->CrouchRadius + 1;
		PathSizes(0).Height = DefaultPawn->CrouchHeight;

		PathSizes(1).Radius = DefaultPawn->CylinderComponent->CollisionRadius + 1;
		PathSizes(1).Height = DefaultPawn->CylinderComponent->CollisionHeight;

		TestJumpZ = DefaultPawn->JumpZ;
		TestGroundSpeed = DefaultPawn->GroundSpeed;
		MaxStepHeight = DefaultPawn->MaxStepHeight;
		MaxJumpHeight = DefaultPawn->MaxJumpHeight;
		MaxDoubleJumpHeight = DefaultPawn->MaxDoubleJumpHeight;
	}
}

static AUDKGameObjective* TestObjective = NULL;

IMPLEMENT_COMPARE_POINTER(ANavigationPoint, UTPathing, { return appTrunc(appSqrt((TestObjective->Location - A->Location).SizeSquared() - (TestObjective->Location - B->Location).SizeSquared())); })

void AUDKGameObjective::AddForcedSpecs(AScout* Scout)
{
	// put the five closest visible NavigationPoints in the ShootSpots array

	// create list of all non-blocking non-flying source NavigationPoints
	TArray<ANavigationPoint*> NavList;
	for (ANavigationPoint* N = GWorld->GetFirstNavigationPoint(); N != NULL; N = N->nextNavigationPoint)
	{
		if (N != this && !N->bBlockActors && !N->bDestinationOnly && !N->bFlyingPreferred)
		{
			NavList.AddItem(N);
		}
	}

	// sort by distance
	TestObjective = this;
	Sort<USE_COMPARE_POINTER(ANavigationPoint,UTPathing)>(NavList.GetTypedData(), NavList.Num());
	TestObjective = NULL;

	// put the first five that succeed a visibility trace into the ShootSpots array
	ShootSpots.Empty();
	FCheckResult Hit(1.0f);
	FVector TargetLoc = GetTargetLocation();
	for (INT i = 0; i < NavList.Num(); i++)
	{
		if (GWorld->SingleLineCheck(Hit, Scout, TargetLoc, NavList(i)->Location, TRACE_World | TRACE_StopAtAnyHit))
		{
			ShootSpots.AddItem(NavList(i));
			if (ShootSpots.Num() >= 5)
			{
				break;
			}
		}
	}

	// if bAllowOnlyShootable, we don't need to be reachable if we found any ShootSpots
	if (bAllowOnlyShootable && ShootSpots.Num() > 0)
	{
		bMustBeReachable = FALSE;
	}
	else
	{
		bMustBeReachable = GetArchetype<ANavigationPoint>()->bMustBeReachable;
	}
}

#if WITH_EDITOR
void AUDKGameObjective::SetNetworkID(INT InNetworkID)
{
	if (bAllowOnlyShootable)
	{
		// steal network ID from ShootSpots
		if (NetworkID == INDEX_NONE)
		{
			for (INT i = 0; i < ShootSpots.Num(); i++)
			{
				if (ShootSpots(i)->NetworkID != INDEX_NONE)
				{
					InNetworkID = ShootSpots(i)->NetworkID;
					break;
				}
			}
		}

		Super::SetNetworkID(InNetworkID);

		// also pass ID to ShootSpots
		for (INT i = 0; i < ShootSpots.Num(); i++)
		{
			ShootSpots(i)->SetNetworkID(InNetworkID);
		}
	}
	else
	{
		Super::SetNetworkID(InNetworkID);
	}
}
#endif

void AUDKTeamPlayerStart::PostEditChangeProperty(FPropertyChangedEvent& PropertyChangedEvent)
{
	UTexture2D* NewSprite = NULL;
#if WITH_EDITORONLY_DATA
	if (TeamNumber < TeamSprites.Num())
	{
		NewSprite = TeamSprites(TeamNumber);
	}
	else
#endif // WITH_EDITORONLY_DATA
	{
		// get sprite from defaults
		AUDKTeamPlayerStart* Default = GetArchetype<AUDKTeamPlayerStart>();
		for (INT i = 0; i < Default->Components.Num() && NewSprite == NULL; i++)
		{
			USpriteComponent* SpriteComponent = Cast<USpriteComponent>(Default->Components(i));
			if (SpriteComponent != NULL)
			{
				NewSprite = SpriteComponent->Sprite;
			}
		}
	}

	if (NewSprite != NULL)
	{
		// set the new sprite as the current one
		USpriteComponent* SpriteComponent = NULL;
		for (INT i = 0; i < Components.Num() && SpriteComponent == NULL; i++)
		{
			SpriteComponent = Cast<USpriteComponent>(Components(i));
		}
		if (SpriteComponent != NULL)
		{
			SpriteComponent->Sprite = NewSprite;
		}
	}

	Super::PostEditChangeProperty(PropertyChangedEvent);
}

void AUDKTeamPlayerStart::Spawned()
{
	Super::Spawned();

	PostEditChange();
}

ANavigationPoint* AUDKScriptedNavigationPoint::SpecifyEndAnchor(APawn* RouteFinder)
{
	if ( bScriptSpecifyEndAnchor )
	{
		return eventSpecifyEndAnchor(RouteFinder);
	}
	else
	{
		return Super::SpecifyEndAnchor(RouteFinder);
	}
}

void AUDKScriptedNavigationPoint::NotifyAnchorFindingResult(ANavigationPoint* EndAnchor, APawn* RouteFinder)
{
	if ( bScriptNotifyAnchorFindingResult )
	{
		eventNotifyAnchorFindingResult(EndAnchor, RouteFinder);
	}
	else
	{
		Super::NotifyAnchorFindingResult(EndAnchor, RouteFinder);
	}
}

UBOOL AUDKScriptedNavigationPoint::AnchorNeedNotBeReachable()
{
	return !bAnchorMustBeReachable;
}

