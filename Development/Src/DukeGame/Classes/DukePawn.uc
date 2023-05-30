class DukePawn extends GamePawn
	native
	config(Game);

/** view bob properties */
var	globalconfig	float	Bob;
var					float	LandBob;
var					float	JumpBob;
var					float	AppliedBob;
var					float	bobtime;
var					vector	WalkBob;

cpptext
{
	virtual void TickSpecial( FLOAT DeltaSeconds );
	virtual void UpdateEyeHeight(FLOAT DeltaSeconds);
}

simulated function float GetEyeHeight()
{
	if ( !IsLocallyControlled() )
		return BaseEyeHeight;
	else
		return EyeHeight;
}

simulated function SetPuttingDownWeapon(bool bNowPuttingDownWeapon)
{

}

simulated function vector WeaponBob(float BobDamping, float JumpDamping)
{
	Local Vector WBob;

	WBob = BobDamping * WalkBob;
	WBob.Z = (0.45 + 0.55 * BobDamping)*WalkBob.Z;	
	WBob.Z += JumpDamping *(LandBob - JumpBob);
	return WBob;
}

/* UpdateEyeHeight()
* Update player eye position, based on smoothing view while moving up and down stairs, and adding view bobs for landing and taking steps.
* Called every tick only if bUpdateEyeHeight==true.
*/
event UpdateEyeHeight( float DeltaTime )
{
	local float smooth, MaxEyeHeight, OldEyeHeight, Speed2D, OldBobTime;
	local Actor HitActor;
	local vector HitLocation,HitNormal, X, Y, Z;
	local int m,n;
	local float OldZ;

	OldZ = Location.Z; // hack

	if ( bTearOff )
	{
		// no eyeheight updates if dead
		EyeHeight = Default.BaseEyeheight;
		return;
	}

	// normal walking around
	// smooth eye position changes while going up/down stairs
	smooth = FMin(0.9, 10.0 * DeltaTime/CustomTimeDilation);
	LandBob *= (1 - smooth);
	if( Physics == PHYS_Walking || Physics==PHYS_Spider || Controller.IsInState('PlayerSwimming') )
	{
		OldEyeHeight = EyeHeight;
		EyeHeight = FMax((EyeHeight - Location.Z + OldZ) * (1 - smooth) + BaseEyeHeight * smooth,
							-0.5 * CylinderComponent.CollisionHeight);
	}
	else
	{
		EyeHeight = EyeHeight * ( 1 - smooth) + BaseEyeHeight * smooth;
	}
	

	// don't bob if disabled, or just landed
/*
	if( bJustLanded )
	{
		BobTime = 0;
		WalkBob = Vect(0,0,0);
	}
	else
*/
	// add some weapon bob based on jumping
	if ( Velocity.Z > 0 )
	{
		JumpBob = FMax(-1.5, JumpBob - 0.03 * DeltaTime * FMin(Velocity.Z,300));
	}
	else
	{
		JumpBob *= (1 -  FMin(1.0, 8.0 * DeltaTime));
	}

	// Add walk bob to movement
	OldBobTime = BobTime;
	Bob = FClamp(Bob, -0.05, 0.05);

	if (Physics == PHYS_Walking )
	{
		GetAxes(Rotation,X,Y,Z);
		Speed2D = VSize(Velocity);
		if ( Speed2D < 10 )
			BobTime += 0.2 * DeltaTime;
		else
			BobTime += DeltaTime * (0.3 + 0.7 * Speed2D/GroundSpeed);
		WalkBob = Y * Bob * Speed2D * sin(8 * BobTime);
		AppliedBob = AppliedBob * (1 - FMin(1, 16 * deltatime));
		WalkBob.Z = AppliedBob;
		if ( Speed2D > 10 )
			WalkBob.Z = WalkBob.Z + 0.75 * Bob * Speed2D * sin(16 * BobTime);
	}
	else if ( Physics == PHYS_Swimming )
	{
		GetAxes(Rotation,X,Y,Z);
		BobTime += DeltaTime;
		Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);
		WalkBob = Y * Bob *  0.5 * Speed2D * sin(4.0 * BobTime);
		WalkBob.Z = Bob * 1.5 * Speed2D * sin(8.0 * BobTime);
	}
	else
	{
		BobTime = 0;
		WalkBob = WalkBob * (1 - FMin(1, 8 * deltatime));
	}

	if ( (Physics == PHYS_Walking) && (VSizeSq(Velocity) > 100) && IsFirstPerson() )
	{
		m = int(0.5 * Pi + 9.0 * OldBobTime/Pi);
		n = int(0.5 * Pi + 9.0 * BobTime/Pi);

		if ( (m != n) && !bIsWalking && !bIsCrouched )
		{
		//	ActuallyPlayFootStepSound(0);
		}
	}
	if ( (CylinderComponent.CollisionHeight - Eyeheight < 12) && IsFirstPerson() )
	{
	  // desired eye position is above collision box
	  // check to make sure that viewpoint doesn't penetrate another actor
		// min clip distance 12
		if (bCollideWorld)
		{
			HitActor = trace(HitLocation,HitNormal, Location + WalkBob + (MaxStepHeight + CylinderComponent.CollisionHeight) * vect(0,0,1),
						  Location + WalkBob, true, vect(12,12,12),, TRACEFLAG_Blocking);
			MaxEyeHeight = (HitActor == None) ? CylinderComponent.CollisionHeight + MaxStepHeight : HitLocation.Z - Location.Z;
			Eyeheight = FMin(Eyeheight, MaxEyeHeight);
		}
	}
}

/* GetPawnViewLocation()
Called by PlayerController to determine camera position in first person view.  Returns
the location at which to place the camera
*/
simulated function Vector GetPawnViewLocation()
{
	return Location + EyeHeight * vect(0,0,1) + WalkBob;
}

native function AddDefaultInventory();

defaultproperties
{
	BaseEyeHeight=27.0
	EyeHeight=27.0
	InventoryManagerClass=class'DukeInventoryManager'

	Begin Object Class=DynamicLightEnvironmentComponent Name=DukeLightEnvironment
		bEnabled=TRUE
		TickGroup=TG_DuringAsyncWork
		// Using a skylight for secondary lighting by default to be cheap
		// Characters and other important skeletal meshes should set bSynthesizeSHLight=true
	End Object
	Components.Add(DukeLightEnvironment)
	LightEnvironment=DukeLightEnvironment

	Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent
		bCacheAnimSequenceNodes=FALSE
		AlwaysLoadOnClient=true
		AlwaysLoadOnServer=true
		bOwnerNoSee=true
		CastShadow=true
		BlockRigidBody=TRUE
		bUpdateSkelWhenNotRendered=false
		bIgnoreControllersWhenNotRendered=TRUE
		bUpdateKinematicBonesFromAnimation=true
		bCastDynamicShadow=true
		Translation=(Z=8.0)
		RBChannel=RBCC_Untitled3
		RBCollideWithChannels=(Untitled3=true)
		LightEnvironment=DukeLightEnvironment
		bOverrideAttachmentOwnerVisibility=true
		bAcceptsDynamicDecals=FALSE
		SkeletalMesh=SkeletalMesh'Duke.DukeMesh'
		AnimSets(0)=AnimSet'Duke.DukeMesh_Anims'
		bHasPhysicsAssetInstance=true
		TickGroup=TG_PreAsyncWork
		MinDistFactorForKinematicUpdate=0.2
		bChartDistanceFactor=true
		//bSkipAllUpdateWhenPhysicsAsleep=TRUE
		RBDominanceGroup=20
		Scale=1.075
		// Nice lighting for hair
		bUseOnePassLightingOnTranslucency=TRUE
		bPerBoneMotionBlur=true
	End Object
	Mesh=WPawnSkeletalMeshComponent
	Components.Add(WPawnSkeletalMeshComponent)
}