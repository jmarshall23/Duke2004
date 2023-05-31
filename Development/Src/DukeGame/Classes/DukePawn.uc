class DukePawn extends GamePawn
	native
	config(Game);

/** view bob properties */
var	float			Bob;
var float			LandBob;
var float			AppliedBob;
var float			BobTime;
var					vector	WalkBob;

cpptext
{
	void CheckBob(float DeltaTime, float Speed2D, FVector Y);

	virtual void TickSpecial( FLOAT DeltaSeconds );	
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
	//WBob.Z += JumpDamping *(LandBob - JumpBob);
	return WBob;
}


/* GetPawnViewLocation()
Called by PlayerController to determine camera position in first person view.  Returns
the location at which to place the camera
*/
simulated native function Vector GetPawnViewLocation();
simulated native function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV );

native function AddDefaultInventory();

defaultproperties
{
	BaseEyeHeight=27.0
	EyeHeight=27.0
	Bob=0.028000
	MeleeRange=+00050.000000
    GroundSpeed=+00320.000000
    AirSpeed=+00320.000000
    AccelRate=+02048.000000
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