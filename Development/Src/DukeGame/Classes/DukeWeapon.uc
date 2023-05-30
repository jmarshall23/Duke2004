// DukeWeapon.uc
//

class DukeWeapon extends Weapon
	native;

/** Current ammo count */
var repnotify int AmmoCount;

/** Max ammo count */
var int MaxAmmoCount;

/** The final inventory weight.  It's calculated in PostBeginPlay() */
var float InventoryWeight;

var bool bForceHidden;

/** Offset from view center */
var(FirstPerson) vector	PlayerViewOffset;

/** additional offset applied when using small weapons */
var(FirstPerson) vector SmallWeaponsOffset;

/** additional offset applied when using small weapons */
var(FirstPerson) float WideScreenOffsetScaling;

/** rotational offset only applied when in widescreen */
var rotator WidescreenRotationOffset;

/** special offset when using hidden weapons, as we need to still place the weapon for e.g. attached beams */
var vector HiddenWeaponsOffset;

var float ProjectileSpawnOffset;

var bool bPendingShow;

var float BobDamping;
var float JumpDamping;

var(Animations) array<name> WeaponIdleAnims;
var(Animations)	array<name>	WeaponFireAnim;

var EWeaponState weaponState;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
}

simulated function bool AllowSwitchTo(Weapon NewWeapon)
{
	return true;
}

simulated function bool ShouldSwitchTo(DukeWeapon InWeapon)
{
	if (IsFiring())
	{
		return false;
	}
	else
	{
		return true;
	}
}

/**
 * @returns false if the weapon isn't ready to be fired.  For example, if it's in the Inactive/WeaponPuttingDown states.
 */
simulated function bool bReadyToFire()
{
	return weaponState == WEAPON_STATE_IDLE;
}

native simulated function BeginFire(Byte FireModeNum);

simulated function Loaded(optional bool bUseWeaponMax)
{
	if (bUseWeaponMax)
		AmmoCount = MaxAmmoCount;
	else
		AmmoCount = 999;
}

simulated function PreloadTextures(bool bForcePreload)
{

}

reliable server function ServerReselectWeapon();

/**
 * Returns the current Weapon Hand
 */
simulated function EWeaponHand GetHand()
{
	local DukePlayerController PC;

	// Get the Weapon Hand from the controller or default to HAND_Right
	if (Instigator != None)
	{
		PC = DukePlayerController(Instigator.Controller);
		if (PC != None)
		{
			return PC.WeaponHand;
		}
	}
	return HAND_Right;
}

/**
 * This function aligns the gun model in the world
 */
simulated event SetPosition(DukePawn Holder)
{
	local vector DrawOffset, ViewOffset, FinalSmallWeaponsOffset, FinalLocation;
	local EWeaponHand CurrentHand;
	local rotator NewRotation, FinalRotation, SpecRotation;
	local PlayerController PC;
	local vector2D ViewportSize;
	local bool bIsWideScreen;
	local vector SpecViewLoc;

	if ( !Holder.IsFirstPerson() )
		return;

	// Hide the weapon if hidden
	CurrentHand = GetHand();
	if ( bForceHidden || CurrentHand == HAND_Hidden)
	{
		Mesh.SetHidden(True);
		NewRotation = Holder.GetViewRotation();
		SetLocation(Instigator.GetPawnViewLocation() + (HiddenWeaponsOffset >> NewRotation));
		SetRotation(NewRotation);
		SetBase(Instigator);
		return;
	}

	if(bPendingShow)
	{
		SetHidden(False);
		bPendingShow = FALSE;
	}

	Mesh.SetHidden(False);

	foreach LocalPlayerControllers(class'PlayerController', PC)
	{
		LocalPlayer(PC.Player).ViewportClient.GetViewportSize(ViewportSize);
		break;
	}
	bIsWideScreen = (ViewportSize.Y > 0.f) && (ViewportSize.X/ViewportSize.Y > 1.7);

	// Adjust for the current hand
	ViewOffset = PlayerViewOffset;
	FinalSmallWeaponsOffset = SmallWeaponsOffset;

	switch ( CurrentHand )
	{
		case HAND_Left:
			Mesh.SetScale3D(default.Mesh.Scale3D * vect(1,-1,1));
			Mesh.SetRotation(rot(0,0,0) - default.Mesh.Rotation);
			ViewOffset.Y *= -1.0;
			FinalSmallWeaponsOffset.Y *= -1.0;
			break;

		case HAND_Centered:
			ViewOffset.Y = 0.0;
			FinalSmallWeaponsOffset.Y = 0.0;
			break;

		case HAND_Right:
			Mesh.SetScale3D(default.Mesh.Scale3D);
			Mesh.SetRotation(default.Mesh.Rotation);
			break;
		default:
			break;
	}

	if ( bIsWideScreen )
	{
		ViewOffset += WideScreenOffsetScaling * FinalSmallWeaponsOffset;
	}

	// Calculate the draw offset
	DrawOffset.Z = Holder.GetEyeHeight();
	DrawOffset += Holder.WeaponBob(BobDamping, JumpDamping);

	if ( DukePlayerController(Holder.Controller) != None )
	{
		DrawOffset += DukePlayerController(Holder.Controller).ShakeOffset >> Holder.Controller.Rotation;
	}

	DrawOffset = DrawOffset + ( ViewOffset >> Holder.Controller.Rotation );

	// Adjust it in the world
	FinalLocation = Holder.Location + DrawOffset;
	SetLocation(FinalLocation);
	SetBase(Holder);

	NewRotation = (Holder.Controller == None) ? Holder.GetBaseAimRotation() : Holder.Controller.Rotation;

	// Add some rotation leading
	FinalRotation = NewRotation;
	//LastRotUpdate = WorldInfo.TimeSeconds;
	//LastRotation = NewRotation;

	if ( bIsWideScreen )
	{
		FinalRotation += WidescreenRotationOffset;
	}
	SetRotation(FinalRotation);	
}


 /**
 * Attach Weapon Mesh, Weapon MuzzleFlash and Muzzle Flash Dynamic Light to a SkeletalMesh
 *
 * @param	who is the pawn to attach to
 */
simulated function AttachWeaponTo( SkeletalMeshComponent MeshCpnt, optional Name SocketName )
{
	local DukePawn UTP;

	UTP = DukePawn(Instigator);

	// Attach 1st Person Muzzle Flashes, etc,
	if ( Instigator.IsFirstPerson() )
	{
		AttachComponent(Mesh);
		SetHidden(False);
	}
	else
	{
		SetHidden(True);
	}

	SetSkin(None);
}

/**
 * Sets the timing for equipping a weapon.
 * The WeaponEquipped event is trigged when expired
 */
simulated function TimeWeaponEquipping()
{
	// The weapon is equipped, attach it to the mesh.
	AttachWeaponTo( Instigator.Mesh );

	PlayWeaponAnimation(WeaponIdleAnims[0], 0.0, true);

	weaponState = WEAPON_STATE_IDLE;
}

simulated state Active
{
	simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
	{
		local int IdleIndex;

		IdleIndex = Rand(WeaponIdleAnims.Length);
		PlayWeaponAnimation(WeaponIdleAnims[IdleIndex], 0.0, true);
	}
}

/**
 * Material control
 *
 * @Param 	NewMaterial		The new material to apply or none to clear it
 */
simulated function SetSkin(Material NewMaterial)
{
	local int i,Cnt;

	if ( NewMaterial == None )
	{
		// Clear the materials
		if ( default.Mesh.Materials.Length > 0 )
		{
			Cnt = Default.Mesh.Materials.Length;
			for (i=0;i<Cnt;i++)
			{
				Mesh.SetMaterial( i, Default.Mesh.GetMaterial(i) );
			}
		}
		else if (Mesh.Materials.Length > 0)
		{
			Cnt = Mesh.Materials.Length;
			for ( i=0; i < Cnt; i++ )
			{
				Mesh.SetMaterial(i, none);
			}
		}
	}
	else
	{
		// Set new material
		if ( default.Mesh.Materials.Length > 0 || Mesh.GetNumElements() > 0 )
		{
			Cnt = default.Mesh.Materials.Length > 0 ? default.Mesh.Materials.Length : Mesh.GetNumElements();
			for ( i=0; i < Cnt; i++ )
			{
				Mesh.SetMaterial(i, NewMaterial);
			}
		}
	}
}

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

	Begin Object Class=SkeletalMeshComponent Name=FirstPersonMesh
		DepthPriorityGroup=SDPG_Foreground
		bOnlyOwnerSee=true
		LightEnvironment=DukeLightEnvironment
		bOverrideAttachmentOwnerVisibility=true
	End Object
	Mesh=FirstPersonMesh

	bForceHidden=FALSE
	BobDamping=0.85000
	JumpDamping=1.0

	weaponState=WEAPON_STATE_NONE
}