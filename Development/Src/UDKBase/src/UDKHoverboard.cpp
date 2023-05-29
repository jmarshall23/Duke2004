/**
 * Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 */
#include "UDKBase.h"
#include "EngineAnimClasses.h"
#include "EngineMaterialClasses.h"
#include "UDKBaseAnimationClasses.h"

IMPLEMENT_CLASS(UUDKVehicleSimHoverboard);


void AUDKVehicle::VehicleUnpackRBState()
{
	if( (VState.RBState.bNewData & UCONST_RB_NeedsUpdate) == UCONST_RB_NeedsUpdate )
	{
		FVector OutDeltaPos;
		ApplyNewRBState(VState.RBState, &AngErrorAccumulator, OutDeltaPos);
		VState.RBState.bNewData = UCONST_RB_None;

		// If we are moving fairly quickly and have a physics rider...
		AUDKPawn* UTP = Cast<AUDKPawn>(Driver);
		if( UTP && 
			UTP->bIsHoverboardAnimPawn && 
			UTP->Mesh && 
			UTP->Mesh->PhysicsAssetInstance &&
			OutDeltaPos.SizeSquared() > (0.5f  * 0.5f) )
		{
			// Apply same delta to rider bodies. Need to work out where root body should be
			URB_BodyInstance* RootBodyInst = UTP->Mesh->PhysicsAssetInstance->Bodies(UTP->Mesh->PhysicsAssetInstance->RootBodyIndex);
			if(RootBodyInst->IsValidBodyInstance())
			{
				FMatrix RootBodyMatrix = RootBodyInst->GetUnrealWorldTM();
				FVector NewLoc = RootBodyMatrix.GetOrigin() + OutDeltaPos;

				// This will move all bodies.
				UTP->Mesh->SetRBPosition(NewLoc);
			}
		}
	}
}


#if WITH_NOVODEX
void AUDKVehicle::PostInitRigidBody(NxActor* nActor, NxActorDesc& ActorDesc, UPrimitiveComponent* PrimComp)
{
	Super::PostInitRigidBody(nActor, ActorDesc, PrimComp);

	eventPostInitRigidBody(PrimComp);
}
#endif // WITH_NOVODEX

void UUDKVehicleSimHoverboard::InitWheels(AUDKVehicle* Vehicle)
{
#if WITH_NOVODEX
	if ( Vehicle )
	{
		for( INT i=0; i<Vehicle->Wheels.Num(); i++ )
		{
			USVehicleWheel* vw = Vehicle->Wheels(i);
			NxWheelShape* WheelShape = vw->GetNxWheelShape();

			// Set the various tire params on the new WheelShape.
			SetNxWheelShapeTireForceFunctions(WheelShape, vw);
		}
	}
#endif // WITH_NOVODEX
}

// HACK TJAMES HACK (For Gamers Day), we should get a real RPM system
FLOAT UUDKVehicleSimHoverboard::GetEngineOutput(ASVehicle* Vehicle)
{
	if(bIsOverDeepWater)
	{
		return 0.f;
	}
	else
	{
		return Clamp(((Vehicle->Velocity.Size())/(Vehicle->MaxSpeed)), 0.1f, 1.0f) * 19000.f;
	}
}
void UUDKVehicleSimHoverboard::ProcessCarInput(ASVehicle* Vehicle)
{
	if( Vehicle->Driver == NULL )
	{
		Vehicle->OutputBrake = 1.0f;
		Vehicle->OutputGas = 0.0f;
		Vehicle->bOutputHandbrake = FALSE;
	}
	else
	{
		Vehicle->OutputGas = Vehicle->Throttle;
		Vehicle->OutputSteering = Vehicle->Steering;
		Vehicle->OutputRise = Vehicle->Rise;

		// Keep awake physics of any driven vehicle.
		check(Vehicle->CollisionComponent);
		Vehicle->CollisionComponent->WakeRigidBody();
	}

	if ( Vehicle->Controller)
	{
		if ( Vehicle->IsHumanControlled() )
		{			
			Vehicle->DriverViewPitch = Vehicle->Controller->Rotation.Pitch;
			Vehicle->DriverViewYaw = Vehicle->Controller->Rotation.Yaw;
		}
		else
		{
			// if we can't strafe, and vehicle is off course, look away from target in opposite direction to correct faster
			FVector Direction = Vehicle->Controller->GetFocalPoint() - Vehicle->Location;
			if (Vehicle->bFollowLookDir && !Vehicle->bCanStrafe && Vehicle->VehicleMovingTime == Vehicle->WorldInfo->TimeSeconds)
			{
				const FLOAT OldZ = Direction.Z;
				Direction.Z = 0.f;
				FVector DirCross = Direction ^ FVector(0.f,0.f,1.f);
				DirCross = DirCross.SafeNormal();
				const FVector& VelDir = (Vehicle->Velocity | DirCross) * DirCross;
				if ( (VelDir.SizeSquared() > 160000.f) && (VelDir.SizeSquared() < Direction.SizeSquared()) )
				{
					const FLOAT Distance = Direction.Size();
					Direction = Direction - Distance * VelDir.SafeNormal(); 
				}
				else if ( VelDir.SizeSquared() > 10000.f )
				{
					Direction = Direction - VelDir;	
				}
				Direction.Z = OldZ;
			}

			const FRotator& ViewRot = Direction.Rotation();
			Vehicle->DriverViewPitch = ViewRot.Pitch;
			Vehicle->DriverViewYaw = ViewRot.Yaw;
		}
	}
	else
	{
		Vehicle->DriverViewPitch = Vehicle->Rotation.Pitch;
		Vehicle->DriverViewYaw = Vehicle->Rotation.Yaw;
	}
}

// Similar to SimChopper only without mouse steering
void UUDKVehicleSimHoverboard::UpdateVehicle(ASVehicle* Vehicle, FLOAT DeltaTime)
{
	if (!Vehicle->bDriving && Vehicle->bChassisTouchingGround)
		return;

	AUDKVehicle* Hoverboard = Cast<AUDKVehicle>(Vehicle);
	if (!Hoverboard)
		return;

	FLOAT OutputSteer = Vehicle->OutputSteering;
	FLOAT OutputThrust = Vehicle->OutputGas;
	//FLOAT OutputRise = Vehicle->OutputRise;

	// Zero force/torque accumulation.
	FVector Up(0.0f, 0.0f, 1.0f);
	FVector Force(0.0f, 0.0f, 0.0f);
	FVector Torque(0.0f, 0.0f, 0.0f);

	if( Vehicle->bDriving )
	{
		// Calc up (z), right(y) and forward (x) vectors
		FRotationMatrix R(Vehicle->Rotation);
		const FVector& DirX = R.GetAxis(0);
		const FVector& DirY = R.GetAxis(1);
		const FVector& DirZ = R.GetAxis(2);

		// 'World plane' forward & right vectors ie. no z component.
		FVector Forward = DirX;
		Forward.Normalize();

		FVector Right = DirY;
		Right.Normalize();

		FVector LocalUp = DirZ;
		LocalUp.Normalize();

		// Get body angular velocity
		FRigidBodyState rbState(0);
		Vehicle->GetCurrentRBState(rbState);
		FVector AngVel(rbState.AngVel.X, rbState.AngVel.Y, rbState.AngVel.Z);
		const FLOAT TurnAngVel = AngVel | LocalUp;
		//FLOAT RollAngVel = AngVel | DirX;
		//FLOAT PitchAngVel = AngVel | DirY;

		const FLOAT ForwardVelMag = Vehicle->Velocity | Forward;
		const FLOAT RightVelMag = Vehicle->Velocity | Right;
		//FLOAT UpVelMag = Vehicle->Velocity | Up;

		const UBOOL bWheelsOnGround = Vehicle->HasWheelsOnGround();

		FCheckResult Hit(1.0f);
		const UBOOL bHit = !GWorld->SingleLineCheck(Hit, Vehicle, Vehicle->Location - FVector(0.0f, 0.0f, WaterCheckLevel), Vehicle->Location, TRACE_AllBlocking | TRACE_SingleResult);

		const UBOOL bOldOverDeepWater = bIsOverDeepWater;
		bIsOverDeepWater = (Vehicle->bVehicleOnWater && (Hit.Time == 1.f));

		// If this is the first frame over deep water - play sound
		if(!bOldOverDeepWater && bIsOverDeepWater)
		{
			Hoverboard->PlaySound(OverWaterSound, TRUE, TRUE, TRUE, &Hoverboard->Location);
		}

		// Save the normal of the surface we are over.
		GroundNormal = bHit ? Hit.Normal : FVector(0.f,0.f,1.f);

		// Thrust and Strafe
		Vehicle->bOutputHandbrake = false;
		// Apply thrust when on ground or doing trick,
		// and we are not over deep water, or going slower than waterspeed.
		if ( (bWheelsOnGround || Hoverboard->bTrickJumping) && (!bIsOverDeepWater || (ForwardVelMag < Vehicle->WaterSpeed)) )
		{
			FVector UseForward = Forward;
			// When trick jumping - keep thrusting in the direction
			if(Hoverboard->bTrickJumping)
			{
				const FRotator& TakeoffRot = FRotator(0, appTrunc(TakeoffYaw), 0);
				UseForward = TakeoffRot.Vector();
			}

			if ( Vehicle->Driver && (GroundNormal.Z > Vehicle->WalkableFloorZ) )
			{
				if ( (OutputThrust < 0.f) && ((Vehicle->Velocity | UseForward) < 0.f) )
				{
					if ( (Vehicle->Velocity | Forward) > -1.f * MaxReverseVelocity ) 
					{
						Force += OutputThrust * MaxReverseForce * UseForward;
					}
				}
				else
				{
					// When holding crouch to warm up for a jump, or actually executing that jump, keep thrusting.
					if ( TrickJumpWarmup > 0.f || Hoverboard->bTrickJumping )
					{
						OutputThrust = 1.f;
					}
					Force += OutputThrust * MaxThrustForce * UseForward;
				}
			}
			if ( OutputSteer != 0.f && Vehicle->Rise >= 0.0f )
			{
				//Force -= OutputSteer * 2.f * ::Max(OutputThrust * MaxThrustForce, MaxStrafeForce) * Right;
				Vehicle->bOutputHandbrake = TRUE;
			}
		}

		check(!Force.ContainsNaN());

		// Damp velocity on water regardless of throttle
		if (bIsOverDeepWater)
		{
			Force -= LongDamping * ForwardVelMag * Forward;
			Force -= LatDamping * RightVelMag * Right;
		}
		else
		{
			Force -= (1.0f - Abs(OutputThrust)) * LongDamping * ForwardVelMag * Forward;
		}

		check(!Force.ContainsNaN());

		//// STEERING ////

		// When in air and spinning - update the yaw as we hold the stick.
		FLOAT SpinAmount = OutputSteer;
		if(Abs(SpinHeadingOffset) < 2.f*(FLOAT)PI)
		{
			SpinAmount = AutoSpin;
		}

		if ( Hoverboard->bDriving && bInAJump && Hoverboard->bTrickJumping )
		{
			SpinHeadingOffset += (SpinSpeed * -SpinAmount * DeltaTime);
		}

		// When not jumping, holding alt-fire lets you look around without steering.
		const UBOOL bLookAroundMode = (Hoverboard->bGrab2 && !bInAJump);
		if (!bLookAroundMode)
		{
			FVector LookDir(0,0,0);
			FLOAT DesiredSteerOffset = 0.f;
			FLOAT TurnDampingScale = 1.f;
			FLOAT TurnTorqueScale = 1.f;

			if(Hoverboard->bTrickJumping && bInAJump && bLeftGround)
			{
				// Steer towards takeoff yaw plus whatever spin offset we have built up.
				const FRotator& LookRot = FRotator(Vehicle->DriverViewPitch, appTrunc(TakeoffYaw), 0);
				LookDir = LookRot.Vector();
				CurrentSteerOffset = DesiredSteerOffset = SpinHeadingOffset;

				// While actively trying to spin - reduce damping and increase torque
				if(Abs(SpinAmount) > 0.f)
				{
					TurnDampingScale = (1.f - Abs(SpinAmount));
					TurnTorqueScale = SpinTurnTorqueScale;
				}
			}
			else
			{
				const FRotator& LookRot = FRotator(Vehicle->DriverViewPitch, Vehicle->DriverViewYaw, 0);
				LookDir = LookRot.Vector();

				if(Vehicle->OutputRise >= 0.f)
				{
					// Steering applies offset from that steering angle to some control
					DesiredSteerOffset = -OutputSteer * HoverboardSlalomMaxAngle * (PI/180.f);

					// Invert if reversing
					if(ForwardVelMag < 0.f)
					{
						DesiredSteerOffset *= -1.f;
					}
				}
				else
				{
					CurrentSteerOffset = 0.f;
				}

				FLOAT MaxSteerOffsetChange = SlalomSpeed * DeltaTime;
				CurrentSteerOffset += ::Clamp((DesiredSteerOffset - CurrentSteerOffset), -MaxSteerOffsetChange, MaxSteerOffsetChange);
			}

			// Find current and desired heading
			const FLOAT CurrentHeading = HeadingAngle(Forward);
			const FLOAT DesiredHeading = UnwindHeading(HeadingAngle(LookDir) + CurrentSteerOffset);

			// Calc and store angle between 'looking' and 'pointing'
			CurrentLookYaw = FindDeltaAngle(CurrentHeading, DesiredHeading);

			// Then put a 'spring' on the copter to target heading.
			FLOAT TurnTorqueMag = (CurrentLookYaw / PI) * TurnTorqueFactor * TurnTorqueScale;

			TurnTorqueMag = Clamp<FLOAT>( TurnTorqueMag, -MaxTurnTorque, MaxTurnTorque );
			Torque += TurnTorqueMag * LocalUp;

			Torque -= TurnAngVel * TurnDampingSpeedFunc.Eval(Abs(ForwardVelMag), 0.f) * LocalUp * TurnDampingScale;
		}

		// velocity damping to limit airspeed
		check(!Force.ContainsNaN());
		Force -= Vehicle->GetDampingForce(Force);
	}

	// Apply force/torque to body.
	Vehicle->AddForce( Force );
	Vehicle->AddTorque( Torque );
}

void UUDKVehicleSimHoverboard::UpdateLeanConstraint( URB_ConstraintInstance* LeanUprightConstraintInstance, FVector LeanY, FVector LeanZ)
{
	FMatrix NewUprightTM = USkelControlBase::BuildMatrixFromVectors(AXIS_Z, LeanZ, AXIS_Y, LeanY);
	LeanUprightConstraintInstance->MoveKinActorTransform(NewUprightTM);
}

