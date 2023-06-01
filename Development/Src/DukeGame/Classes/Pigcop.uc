// Pigcop.uc
//

class Pigcop extends HumanNPC
	placeable
	native;

native function State_Idle();

// SkeletalMesh'a_characters.pigcopc.pigcopc'
// AnimSet'a_characters.pigcopc.pigcopc_Anims'

defaultproperties
{
	Begin Object Class=DynamicLightEnvironmentComponent Name=DukeLightEnvironment
		bEnabled=TRUE
		TickGroup=TG_DuringAsyncWork
		// Using a skylight for secondary lighting by default to be cheap
		// Characters and other important skeletal meshes should set bSynthesizeSHLight=true
	End Object
	Components.Add(DukeLightEnvironment)
	LightEnvironment=DukeLightEnvironment

	DrawScale3D=(X=1.4,Y=1.4,Z=1.4)

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
		SkeletalMesh=SkeletalMesh'a_characters.pigcopc.pigcopc'
		AnimSets(0)=AnimSet'a_characters.pigcopc.pigcopc_Anims'
		AnimTreeTemplate=AnimTree'a_characters.pigcopc.pigcopc_animtree'
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