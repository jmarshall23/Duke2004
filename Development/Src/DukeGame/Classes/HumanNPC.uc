// HumanNPC.uc
//

class HumanNPC extends GamePawn
	native;


/*-----------------------------------------------------------------------------
	AI
-----------------------------------------------------------------------------*/

// Combat
var(AI)		float		Skill;					// Skill, scaled by game difficulty (add difficulty to this value)	
var(AI)		bool		bSnatched;				
var			Actor		Enemy;
var			bool		bFixedEnemy;
var			bool		bRotateToEnemy;			// Update rotation to face Enemy actor *while* moving.
var 		bool 		bFromWall;
var			bool		bHunting;				// Tells navigation code that pawn is hunting another pawn, so fall back to
var			bool		bJumpOffPawn;		
var			bool		bShootSpecial;
var			bool		bAdvancedTactics;		// Used during movement between pathnodes. Finding a path to a visible pathnode if none are reachable.
var(Combat) float		MeleeRange;				// Max range for melee attack (not including collision radii)
var			vector		LastSeenPos;			// Enemy position when I last saw enemy (auto updated if EnemyNotVisible() enabled)
var			vector		LastSeeingPos;			// Position where I last saw enemy (auto updated if EnemyNotVisible enabled)
var			float		LastSeenTime;
var(Combat) float		CombatStyle;			// -1 to 1 = low means tends to stay off and snipe, high means tends to charge and melee.
var			bool		bPlayerCanSeeMe;		// Flag for AI, on if the player can see it.
// States & Stock AI
var			float		Alertness;				// -1 to 1, used within specific states for varying reaction to stimuli
var			name		NextState;				// For queueing states
var			name		NextLabel;				// For queueing states
//var			EControlState PlayerRestartState;
var()		bool		bMuffledHearing;		// This pawn can hear through walls.
var()		float		HearThroughWallDist;	// Max distance at which this pawn can hear through walls.
var()		bool		bNoHeightMod;

var(AI) enum EAttitude					// Important - order in decreasing importance.
{
	ATTITUDE_Fear,								// Will try to run away.
	ATTITUDE_Hate,								// Will attack enemy.
	ATTITUDE_Frenzy,							// Will attack anything, indiscriminately.
	ATTITUDE_Threaten,							// Animations, but no attack.
	ATTITUDE_Ignore,
	ATTITUDE_Friendly,
	ATTITUDE_Follow								// Accepts player as leader.
} AttitudeToPlayer;								// Determines how creature will react on seeing player (if in human form).
var(AI) enum EIntelligence				// Important - order in increasing intelligence.
{
	BRAINS_NONE,								// Only reacts to immediate stimulus.
	BRAINS_REPTILE,								// Follows to last seen position.
	BRAINS_MAMMAL,								// Simple navigation (limited path length).
	BRAINS_HUMAN								// Complex navigation, team coordination, use environment stuff (triggers, etc.)
} Intelligence;
												
// Hearing & Sound
var(AI)		float		HearingThreshold;		// Minimum noise loudness for hearing
var const 	vector 		noise1spot;				// internal use
var const 	float 		noise1time;				// internal use
var const	float		noise1loudness;			// internal use
var const 	vector 		noise2spot;				// internal use
var const 	float 		noise2time;				// internal use
var const	float		noise2loudness;			// internal use

// Sight & Visibility
var()		byte		Visibility;				// How visible is the pawn? 0=invisible, 128=normal, 255=highly visible
var(AI)		float		SightRadius;			// Maximum seeing distance.
var(AI)		float		PeripheralVision;		// Cosine of limits of peripheral vision.
var			float		SightCounter;			// Used to keep track of when to check player visibility
var			bool		bNoRotConstraint;
// Movement
var(Combat) bool		bCanStrafe;
var			bool		bCanJump;
var			bool 		bCanWalk;
var			bool		bCanSwim;
var			bool		bCanFly;
var			bool		bCanOpenDoors;
var			bool		bCanDoSpecial;
var(AI)		bool		bPanicking;
// Kill value
var(AI)     int			EgoKillValue;
var			bool		bWeaponNoAnimSound;

// Misc
var(AI)		bool		bFlyingVehicle;
var()       string	CharacterName;

/*-----------------------------------------------------------------------------
	Control State related variables
-----------------------------------------------------------------------------*/
var( AIStartup )	bool			bAlwaysUseTentacles;//		?("If true, this AIPawn will always use tentacle attacks instead\nof punches and kicks.");
var( AIStartup )	name			InitialIdlingAnim;//		?("Optional override for waiting animation in the Idling state.");		// Optional override for waiting anim in Idle state.
var( AIStartup )	name			InitialTopIdlingAnim;//	?("Optional top override for waiting animation in the Idling state.");
var( AIStartup )	bool			bCanHaveCash;//			?("This pawn can carry cash.");			
var( AIStartup )	bool			bAggressiveToPlayer;//		?("Set to true if this Pawn should attack the player on sight.");	// NPC is aggressive to playerpawns.
var( AIStartup )	float			RunSpeed;
var( AIStartup )	name			HateTag;
//var( AIStartup )	class<Carcass>	CarcassType;//				?("Type of carcass for this AIPawn. Robots and other creatures have\ndifferent carcasses.");
var( AIStartup )	bool			bVisiblySnatched;//		?("Determines whether or not this pawn is visibly snatched at startup." );
var( AIStartup )	float			AggroSnatchDistance;//		?("Maximum distance snatch victim should be before going aggressive.");
//var( AIStartup )	PatrolControl	CurrentPatrolControl;
var( AIStartup )	Name			PatrolTag;
var bool bPatrolled;
var( AIFollow )		name			FollowEvent;
var( AIFollow )		bool			bFollowEventOnceOnly;
var( AI ) float		AIMeleeRange;
var( AI ) bool		bHateWhenSnatched;//						?("This NPC will immediately hate the player if snatched in-game."); 
var( AI ) name		ControlTag;
var( AI ) name		CoverTag;
//var( AI ) bool		bPanicking;
var( AI ) bool		bFire;
var bool bForcedAttack;

var( AI ) bool		bShielded;
var bool				bCamping;
var	name				PendingTopAnimation;
var	name				PendingBottomAnimation;
var	name				PendingAllAnimation;
//var	sound				PendingSound;
var	name				PendingFocusTag;
var	bool				bFocusOnPlayer;
var	bool				bCanBeUsed;
var	actor				MyGiveItem;
//var	NPCActivityEvent	MyAE;
var	actor				AEDestination;
var	actor				PendingTriggerActor;
var	bool				bDisableUseTrigEvent;
var	actor				Obstruction;
var	float				WalkingSpeed;
var	actor				PendingDoor;
var	bool				bFollowEventDisabled;
var bool				bSnatchedAtStartup;
var bool				bSleeping;
var bool				bEyeless;
var bool				bLegless;
var bool				bCanHeadTrack;
var bool				bCanTorsoTrack;
var	bool				bReadyToAttack;	
var bool				bSawEnemy;
var actor				OrderObject;	

/*
var NavigationPoint		CurrentPatrolPoint;
var PatrolEvent			CurrentPatrolEvent;
var NPCActivityEvent	CurrentActivityEvent;
var CreatureFactory		MyFactory;
*/

// Handling of frame based animation events
struct native SNPCAnimEvent
{
//	var()	sound	EventSound;
	var()	bool	bEnabled;
	var()	name	TriggerEvent;
	var()   float   SoundVolume;
};
var( AI ) SNPCAnimEvent NPCAnimEvent[ 15 ];

//var Effects				Shield;
var	Actor				SuspiciousActor;
//var SnatchActor			MySnatcher;
var bool				bEMPed;
//var AIFocusController 	MyFocusController;
//var AICombatController	MyCombatController;
var vector				WanderDir;

var ParticleSystem		bloodCloud1;

cpptext
{
	virtual void PostBeginPlay();
}

event PlayNPCAnimation(Name Sequence, float fDesiredDuration, optional bool bLoop)
{
	Mesh.PlayAnim(Sequence, fDesiredDuration, bLoop);
}

native function State_Idle();

function Activate( optional actor NewTarget );

final function SetAlertness(float NewAlertness)
{
	if ( Alertness != NewAlertness )
	{
		PeripheralVision += 0.707 * (Alertness - NewAlertness); //Used by engine for SeePlayer()
		HearingThreshold += 0.5 * (Alertness - NewAlertness); //Used by engine for HearNoise()
		Alertness = NewAlertness;
	}
}

function Panic()
{
	bPanicking = true;
	GotoState( 'Wandering' );
}

function PostBeginPlay()
{
	Disable( 'SeeFocalPoint' );
	Disable( 'FocalPointNotVisible' );
	Super.PostBeginPlay();
}

function PlayNPCAnimEvent( int EventNum )
{
	// This handled elsewhere in Unreal3
}

function TriggerHate() {}
function float GetRunSpeed() { return RunSpeed; }
function float GetWalkingSpeed() { return WalkingSpeed; }

function StopMoving()
{
	Acceleration = vect(0,0,0);
	Velocity = vect(0,0,0);
//	MoveTimer = -1.0;
}

// Implement in subclass
event SeeFocalPoint( actor PointSeen );

/*
function InitializeController()
{
	local AICombatController C;
	
	foreach allactors( class'AICombatController', C )
	{
		if( C.Tag == ControlTag )
		{
			if( C.AddPawn( self ) )
				MyCombatController = C;
			else
				log( "AddPawn failed for "$self$"!" );
		}
	}
}
*/

event PlayAnim(name AnimName, optional float Duration, optional bool bLoop, optional bool bRestartIfAlreadyPlaying = true, optional float StartTime=0.0f, optional bool bPlayBackwards=false)
{
	Mesh.PlayAnim(AnimName, Duration, bLoop, bRestartIfAlreadyPlaying, StartTime, bPlayBackwards);
}

function bool StopFiring()
{
	bFire = false;
	//bAltFire = false;

	return true;
}

function NPCAnimEvent0()
{
	PlayNPCAnimEvent( 0 );
}

function NPCAnimEvent1()
{
	PlayNPCAnimEvent( 1 );
}

function NPCAnimEvent2()
{
	PlayNPCAnimEvent( 2 );
}

function NPCAnimEvent3()
{
	PlayNPCAnimEvent( 3 );
}

function NPCAnimEvent4()
{
	PlayNPCAnimEvent( 4 );
}

function NPCAnimEvent5()
{
	PlayNPCAnimEvent( 5 );
}

function NPCAnimEvent6()
{
	PlayNPCAnimEvent( 6 );
}

function NPCAnimEvent7()
{
	PlayNPCAnimEvent( 7 );
}

function NPCAnimEvent8()
{
	PlayNPCAnimEvent( 8 );
}

function NPCAnimEvent9()
{
	PlayNPCAnimEvent( 9 );
}

function NPCAnimEvent10()
{
	PlayNPCAnimEvent( 10 );
}

function NPCAnimEvent11()
{
	PlayNPCAnimEvent( 11 );
}

function NPCAnimEvent12()
{
	PlayNPCAnimEvent( 12 );
}

function NPCAnimEvent13()
{
	PlayNPCAnimEvent( 13 );
}

function NPCAnimEvent14()
{
	PlayNPCAnimEvent( 14 );
}

function NPCAnimEvent15()
{
	PlayNPCAnimEvent( 15 );
}

function bool NeedToTurn(vector targ)
{
/*
	local int YawErr;

	DesiredRotation = Rotator(targ - location);
	DesiredRotation.Pitch = 0;
	DesiredRotation.Yaw = DesiredRotation.Yaw & 65535;
	
	YawErr = (DesiredRotation.Yaw - (Rotation.Yaw & 65535)) & 65535;
	if ( (YawErr < 4000) || (YawErr > 61535) )
		return false;
*/
	return true;
}

function bool CanSeeEnemyFrom( vector aLocation, optional float NewEyeHeight, optional bool bUseNewEyeHeight )
{
	local actor HitActor;
	local vector HitNormal, HitLocation, HeightAdjust;

	if( bUseNewEyeHeight )
	{
		HeightAdjust.Z = NewEyeHeight;
	}
	else
		HeightAdjust.Z = BaseEyeHeight;
	HitActor = Trace( HitLocation, HitNormal, Enemy.Location, aLocation + HeightAdjust, true );
	if( HitActor == Enemy )
	{
		return true;
	}
	return false;
}

native function Damage(Actor instigator, int damage, vector hitlocation);

defaultproperties
{
	bloodCloud1=ParticleSystem'T_FX_UT3.Effects.P_FX_Bloodhit_01_Near'
}