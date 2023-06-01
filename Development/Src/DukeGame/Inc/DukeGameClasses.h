/*===========================================================================
    C++ class definitions exported from UnrealScript.
    This is automatically generated by the tools.
    DO NOT modify this manually! Edit the corresponding .uc files instead!
    Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
===========================================================================*/
#if SUPPORTS_PRAGMA_PACK
#pragma pack (push,4)
#endif

#include "DukeGameNames.h"

// Split enums from the rest of the header so they can be included earlier
// than the rest of the header file by including this file twice with different
// #define wrappers. See Engine.h and look at EngineClasses.h for an example.
#if !NO_ENUMS && !defined(NAMES_ONLY)

#ifndef INCLUDED_DUKEGAME_ENUMS
#define INCLUDED_DUKEGAME_ENUMS 1

enum EWeaponState
{
    WEAPON_STATE_NONE       =0,
    WEAPON_STATE_IDLE       =1,
    WEAPON_STATE_FIRING     =2,
    WEAPON_STATE_RELOAD     =3,
    WEAPON_STATE_MAX        =4,
};
#define FOREACH_ENUM_EWEAPONSTATE(op) \
    op(WEAPON_STATE_NONE) \
    op(WEAPON_STATE_IDLE) \
    op(WEAPON_STATE_FIRING) \
    op(WEAPON_STATE_RELOAD) 
enum EIntelligence
{
    BRAINS_NONE             =0,
    BRAINS_REPTILE          =1,
    BRAINS_MAMMAL           =2,
    BRAINS_HUMAN            =3,
    BRAINS_MAX              =4,
};
#define FOREACH_ENUM_EINTELLIGENCE(op) \
    op(BRAINS_NONE) \
    op(BRAINS_REPTILE) \
    op(BRAINS_MAMMAL) \
    op(BRAINS_HUMAN) 
enum EAttitude
{
    ATTITUDE_Fear           =0,
    ATTITUDE_Hate           =1,
    ATTITUDE_Frenzy         =2,
    ATTITUDE_Threaten       =3,
    ATTITUDE_Ignore         =4,
    ATTITUDE_Friendly       =5,
    ATTITUDE_Follow         =6,
    ATTITUDE_MAX            =7,
};
#define FOREACH_ENUM_EATTITUDE(op) \
    op(ATTITUDE_Fear) \
    op(ATTITUDE_Hate) \
    op(ATTITUDE_Frenzy) \
    op(ATTITUDE_Threaten) \
    op(ATTITUDE_Ignore) \
    op(ATTITUDE_Friendly) \
    op(ATTITUDE_Follow) 

#endif // !INCLUDED_DUKEGAME_ENUMS
#endif // !NO_ENUMS

#if !ENUMS_ONLY

#ifndef NAMES_ONLY
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#endif


#ifndef NAMES_ONLY

#ifndef INCLUDED_DUKEGAME_CLASSES
#define INCLUDED_DUKEGAME_CLASSES 1
#define ENABLE_DECLARECLASS_MACRO 1
#include "UnObjBas.h"
#undef ENABLE_DECLARECLASS_MACRO

class UAnimNotify_SetWeaponState : public UAnimNotify
{
public:
    //## BEGIN PROPS AnimNotify_SetWeaponState
    MS_ALIGN(4) BYTE newWeaponState GCC_ALIGN(4); // Extra alignment flags needed because all properties are bytes
    SCRIPT_ALIGN;
    //## END PROPS AnimNotify_SetWeaponState

    DECLARE_CLASS(UAnimNotify_SetWeaponState,UAnimNotify,0,DukeGame)
	// AnimNotify interface.
	virtual void Notify( class UAnimNodeSequence* NodeSeq );
	virtual FString GetEditorComment() { return TEXT("WeaponState"); }
};

class UCrushed : public UDamageType
{
public:
    //## BEGIN PROPS Crushed
    //## END PROPS Crushed

    DECLARE_ABSTRACT_CLASS(UCrushed,UDamageType,0,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(UCrushed)
};

struct Decoration_eventNotReachableBy_Parms
{
    class APawn* P;
    Decoration_eventNotReachableBy_Parms(EEventParm)
    {
    }
};
class ADecoration : public APawn
{
public:
    //## BEGIN PROPS Decoration
    class UClass* EffectWhenDestroyed;
    BITFIELD bPushable:1;
    BITFIELD bDamageable:1;
    BITFIELD bPushSoundPlaying:1;
    BITFIELD bSplash:1;
    class USoundCue* PushSound;
    class USoundCue* EndPushSound;
    INT numLandings;
    class UClass* Contents;
    INT NumFrags;
    class UTexture* FragSkin;
    FVector FragMomentum;
    INT Health;
    FLOAT SplashTime;
    FLOAT LastValidAnchorTime;
    //## END PROPS Decoration

    virtual UBOOL CanSplash();
    virtual void Landed(FVector HitNormal,class AActor* FloorActor);
    virtual void TakeDamage(INT DamageAmount,class AController* EventInstigator,FVector HitLocation,FVector Momentum,class UClass* DamageType,struct FTraceHitInfo HitInfo=FTraceHitInfo(EC_EventParm),class AActor* DamageCauser=NULL);
    virtual void PhysicsVolumeChange(class APhysicsVolume* NewVolume);
    virtual void Trigger(class AActor* Other,class APawn* EventInstigator);
    virtual void BaseChangeImp();
    DECLARE_FUNCTION(execCanSplash)
    {
        P_FINISH;
        *(UBOOL*)Result=this->CanSplash();
    }
    DECLARE_FUNCTION(execLanded)
    {
        P_GET_STRUCT(FVector,HitNormal);
        P_GET_OBJECT(AActor,FloorActor);
        P_FINISH;
        this->Landed(HitNormal,FloorActor);
    }
    DECLARE_FUNCTION(execTakeDamage)
    {
        P_GET_INT(DamageAmount);
        P_GET_OBJECT(AController,EventInstigator);
        P_GET_STRUCT(FVector,HitLocation);
        P_GET_STRUCT(FVector,Momentum);
        P_GET_OBJECT(UClass,DamageType);
        P_GET_STRUCT_OPTX(struct FTraceHitInfo,HitInfo,FTraceHitInfo(EC_EventParm));
        P_GET_OBJECT_OPTX(AActor,DamageCauser,NULL);
        P_FINISH;
        this->TakeDamage(DamageAmount,EventInstigator,HitLocation,Momentum,DamageType,HitInfo,DamageCauser);
    }
    DECLARE_FUNCTION(execPhysicsVolumeChange)
    {
        P_GET_OBJECT(APhysicsVolume,NewVolume);
        P_FINISH;
        this->PhysicsVolumeChange(NewVolume);
    }
    DECLARE_FUNCTION(execTrigger)
    {
        P_GET_OBJECT(AActor,Other);
        P_GET_OBJECT(APawn,EventInstigator);
        P_FINISH;
        this->Trigger(Other,EventInstigator);
    }
    DECLARE_FUNCTION(execBaseChangeImp)
    {
        P_FINISH;
        this->BaseChangeImp();
    }
    void eventNotReachableBy(class APawn* P)
    {
        Decoration_eventNotReachableBy_Parms Parms(EC_EventParm);
        Parms.P=P;
        ProcessEvent(FindFunctionChecked(DUKEGAME_NotReachableBy),&Parms);
    }
    DECLARE_ABSTRACT_CLASS(ADecoration,APawn,0|CLASS_Config,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(ADecoration)
};

class ADukeGameInfo : public AFrameworkGame
{
public:
    //## BEGIN PROPS DukeGameInfo
    //## END PROPS DukeGameInfo

    class UClass* GetGameType(const FString& MapName,const FString& Options,const FString& Portal);
    DECLARE_FUNCTION(execGetGameType)
    {
        P_GET_STR(MapName);
        P_GET_STR(Options);
        P_GET_STR(Portal);
        P_FINISH;
        *(class UClass**)Result=this->GetGameType(MapName,Options,Portal);
    }
    DECLARE_CLASS(ADukeGameInfo,AFrameworkGame,0|CLASS_Config,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(ADukeGameInfo)
};

class ADukeHUD : public AHUD
{
public:
    //## BEGIN PROPS DukeHUD
    FLOAT Opacity;
    FColor CrosshairColor;
    FColor TextColor;
    FColor HUDColor;
    INT CrosshairCount;
    class UTexture* CrosshairTextures[20];
    FLOAT DesiredIndexTop;
    FLOAT RootIndexTop;
    FLOAT IndexTop;
    FLOAT IndexBottom;
    FLOAT IndexAdjust;
    FLOAT BarOffset;
    FLOAT HUDScale;
    FLOAT HUDScaleX;
    FLOAT HUDScaleY;
    INT MaxIndexItems;
    INT ItemSpace;
    FLOAT TextRightAdjust;
    FLOAT BarPos;
    FLOAT BarLeft;
    FLOAT TitleLeft;
    FLOAT TitleOffset;
    FLOAT SlideRate;
    FLOAT IndexTopOffset;
    FStringNoInit IndexName;
    class UTexture* GradientTexture;
    class UTexture* IndexBarLeftTexture;
    class UTexture* IndexBarRightTexture;
    class UTexture* IndexBarBottomTexture;
    class UTexture* InventoryBarTopTexture;
    class UTexture* InventoryBarBotTexture;
    class UTexture* InventoryCatHLTexture;
    class UTexture* InventoryCatHLTexture2;
    class UTexture* MiscBarTabTexture;
    class UTexture* MiscBarHLTexture;
    class UTexture* HUDTemplateTexture;
    class UTexture* ItemSlantTexture;
    class UTexture* ItemSlantHLTexture;
    class UTexture* MiscBarTexture;
    class UTexture* MiscBarTexture2;
    class UTexture* NumberCircleTexture;
    //## END PROPS DukeHUD

    virtual void HudStartup();
    virtual void RenderHud();
    virtual void DrawScaledTexture(class UTexture* Icon,FLOAT X,FLOAT Y,FVector Scale);
    DECLARE_FUNCTION(execHudStartup)
    {
        P_FINISH;
        this->HudStartup();
    }
    DECLARE_FUNCTION(execRenderHud)
    {
        P_FINISH;
        this->RenderHud();
    }
    DECLARE_FUNCTION(execDrawScaledTexture)
    {
        P_GET_OBJECT(UTexture,Icon);
        P_GET_FLOAT(X);
        P_GET_FLOAT(Y);
        P_GET_STRUCT(FVector,Scale);
        P_FINISH;
        this->DrawScaledTexture(Icon,X,Y,Scale);
    }
    DECLARE_CLASS(ADukeHUD,AHUD,0|CLASS_Transient|CLASS_Config,DukeGame)
	void DrawStatusIndex();
	void DrawCrosshair();
};

class ADukeMainMenu : public AHUD
{
public:
    //## BEGIN PROPS DukeMainMenu
    //## END PROPS DukeMainMenu

    virtual void RenderMainMenu();
    DECLARE_FUNCTION(execRenderMainMenu)
    {
        P_FINISH;
        this->RenderMainMenu();
    }
    DECLARE_CLASS(ADukeMainMenu,AHUD,0|CLASS_Transient|CLASS_Config,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(ADukeMainMenu)
};

class ADukeMenuGameInfo : public AFrameworkGame
{
public:
    //## BEGIN PROPS DukeMenuGameInfo
    //## END PROPS DukeMenuGameInfo

    DECLARE_CLASS(ADukeMenuGameInfo,AFrameworkGame,0|CLASS_Config,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(ADukeMenuGameInfo)
};

class ADukePawn : public AGamePawn
{
public:
    //## BEGIN PROPS DukePawn
    FLOAT Bob;
    FLOAT LandBob;
    FLOAT AppliedBob;
    FLOAT BobTime;
    FVector WalkBob;
    //## END PROPS DukePawn

    virtual FVector GetPawnViewLocation();
    virtual UBOOL CalcCamera(FLOAT fDeltaTime,FVector& out_CamLoc,FRotator& out_CamRot,FLOAT& out_FOV);
    virtual void AddDefaultInventory();
    DECLARE_FUNCTION(execCalcCamera)
    {
        P_GET_FLOAT(fDeltaTime);
        P_GET_STRUCT_REF(FVector,out_CamLoc);
        P_GET_STRUCT_REF(FRotator,out_CamRot);
        P_GET_FLOAT_REF(out_FOV);
        P_FINISH;
        *(UBOOL*)Result=this->CalcCamera(fDeltaTime,out_CamLoc,out_CamRot,out_FOV);
    }
    DECLARE_FUNCTION(execAddDefaultInventory)
    {
        P_FINISH;
        this->AddDefaultInventory();
    }
    DECLARE_CLASS(ADukePawn,AGamePawn,0|CLASS_Config,DukeGame)
	void CheckBob(float DeltaTime, float Speed2D, FVector Y);

	virtual void TickSpecial( FLOAT DeltaSeconds );	
};

struct DukeWeapon_eventSetPosition_Parms
{
    class ADukePawn* Holder;
    DukeWeapon_eventSetPosition_Parms(EEventParm)
    {
    }
};
class ADukeWeapon : public AWeapon
{
public:
    //## BEGIN PROPS DukeWeapon
    INT AmmoCount;
    INT MaxAmmoCount;
    FLOAT InventoryWeight;
    BITFIELD bForceHidden:1;
    BITFIELD bPendingShow:1;
    SCRIPT_ALIGN;
    FVector PlayerViewOffset;
    FVector SmallWeaponsOffset;
    FLOAT WideScreenOffsetScaling;
    FRotator WidescreenRotationOffset;
    FVector HiddenWeaponsOffset;
    FLOAT ProjectileSpawnOffset;
    FLOAT BobDamping;
    FLOAT JumpDamping;
    TArrayNoInit<FName> WeaponIdleAnims;
    TArrayNoInit<FName> WeaponFireAnim;
    BYTE weaponState;
    SCRIPT_ALIGN;
    //## END PROPS DukeWeapon

    virtual void ResetToIdle();
    virtual void BeginFire(BYTE FireModeNum);
    DECLARE_FUNCTION(execResetToIdle)
    {
        P_FINISH;
        this->ResetToIdle();
    }
    DECLARE_FUNCTION(execBeginFire)
    {
        P_GET_BYTE(FireModeNum);
        P_FINISH;
        this->BeginFire(FireModeNum);
    }
    void eventSetPosition(class ADukePawn* Holder)
    {
        DukeWeapon_eventSetPosition_Parms Parms(EC_EventParm);
        Parms.Holder=Holder;
        ProcessEvent(FindFunctionChecked(DUKEGAME_SetPosition),&Parms);
    }
    DECLARE_CLASS(ADukeWeapon,AWeapon,0|CLASS_Config,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(ADukeWeapon)
};

class AWeaponPistol : public ADukeWeapon
{
public:
    //## BEGIN PROPS WeaponPistol
    //## END PROPS WeaponPistol

    DECLARE_CLASS(AWeaponPistol,ADukeWeapon,0|CLASS_Config,DukeGame)
    NO_DEFAULT_CONSTRUCTOR(AWeaponPistol)
};

struct FSNPCAnimEvent
{
    BITFIELD bEnabled:1;
    FName TriggerEvent;
    FLOAT SoundVolume;

    /** Constructors */
    FSNPCAnimEvent() {}
    FSNPCAnimEvent(EEventParm)
    {
        appMemzero(this, sizeof(FSNPCAnimEvent));
    }
};

struct HumanNPC_eventPlayAnim_Parms
{
    FName AnimName;
    FLOAT Duration;
    UBOOL bLoop;
    UBOOL bRestartIfAlreadyPlaying;
    FLOAT StartTime;
    UBOOL bPlayBackwards;
    HumanNPC_eventPlayAnim_Parms(EEventParm)
    {
    }
};
struct HumanNPC_eventSeeFocalPoint_Parms
{
    class AActor* PointSeen;
    HumanNPC_eventSeeFocalPoint_Parms(EEventParm)
    {
    }
};
class AHumanNPC : public AGamePawn
{
public:
    //## BEGIN PROPS HumanNPC
    FLOAT Skill;
    BITFIELD bSnatched:1;
    BITFIELD bFixedEnemy:1;
    BITFIELD bRotateToEnemy:1;
    BITFIELD bFromWall:1;
    BITFIELD bHunting:1;
    BITFIELD bJumpOffPawn:1;
    BITFIELD bShootSpecial:1;
    BITFIELD bAdvancedTactics:1;
    BITFIELD bPlayerCanSeeMe:1;
    BITFIELD bMuffledHearing:1;
    BITFIELD bNoHeightMod:1;
    BITFIELD bNoRotConstraint:1;
    BITFIELD bCanStrafe:1;
    BITFIELD bCanJump:1;
    BITFIELD bCanWalk:1;
    BITFIELD bCanSwim:1;
    BITFIELD bCanFly:1;
    BITFIELD bCanOpenDoors:1;
    BITFIELD bCanDoSpecial:1;
    BITFIELD bPanicking:1;
    BITFIELD bWeaponNoAnimSound:1;
    BITFIELD bFlyingVehicle:1;
    BITFIELD bAlwaysUseTentacles:1;
    BITFIELD bCanHaveCash:1;
    BITFIELD bAggressiveToPlayer:1;
    BITFIELD bVisiblySnatched:1;
    BITFIELD bPatrolled:1;
    BITFIELD bFollowEventOnceOnly:1;
    BITFIELD bHateWhenSnatched:1;
    BITFIELD bFire:1;
    BITFIELD bForcedAttack:1;
    BITFIELD bShielded:1;
    BITFIELD bCamping:1;
    BITFIELD bFocusOnPlayer:1;
    BITFIELD bCanBeUsed:1;
    BITFIELD bDisableUseTrigEvent:1;
    BITFIELD bFollowEventDisabled:1;
    BITFIELD bSnatchedAtStartup:1;
    BITFIELD bSleeping:1;
    BITFIELD bEyeless:1;
    BITFIELD bLegless:1;
    BITFIELD bCanHeadTrack:1;
    BITFIELD bCanTorsoTrack:1;
    BITFIELD bReadyToAttack:1;
    BITFIELD bSawEnemy:1;
    BITFIELD bEMPed:1;
    class AActor* Enemy;
    FLOAT MeleeRange;
    FVector LastSeenPos;
    FVector LastSeeingPos;
    FLOAT LastSeenTime;
    FLOAT CombatStyle;
    FLOAT Alertness;
    FName NextState;
    FName NextLabel;
    FLOAT HearThroughWallDist;
    BYTE AttitudeToPlayer;
    BYTE Intelligence;
    BYTE Visibility;
    FLOAT HearingThreshold;
    FVector noise1spot;
    FLOAT noise1time;
    FLOAT noise1loudness;
    FVector noise2spot;
    FLOAT noise2time;
    FLOAT noise2loudness;
    FLOAT SightRadius;
    FLOAT PeripheralVision;
    FLOAT SightCounter;
    INT EgoKillValue;
    FStringNoInit CharacterName;
    FName InitialIdlingAnim;
    FName InitialTopIdlingAnim;
    FLOAT RunSpeed;
    FName HateTag;
    FLOAT AggroSnatchDistance;
    FName PatrolTag;
    FName FollowEvent;
    FLOAT AIMeleeRange;
    FName ControlTag;
    FName CoverTag;
    FName PendingTopAnimation;
    FName PendingBottomAnimation;
    FName PendingAllAnimation;
    FName PendingFocusTag;
    class AActor* MyGiveItem;
    class AActor* AEDestination;
    class AActor* PendingTriggerActor;
    class AActor* Obstruction;
    FLOAT WalkingSpeed;
    class AActor* PendingDoor;
    class AActor* OrderObject;
    struct FSNPCAnimEvent NPCAnimEvent[15];
    class AActor* SuspiciousActor;
    FVector WanderDir;
    //## END PROPS HumanNPC

    void eventPlayAnim(FName AnimName,FLOAT Duration=0,UBOOL bLoop=FALSE,UBOOL bRestartIfAlreadyPlaying=TRUE,FLOAT StartTime=0.000000,UBOOL bPlayBackwards=FALSE)
    {
        HumanNPC_eventPlayAnim_Parms Parms(EC_EventParm);
        Parms.AnimName=AnimName;
        Parms.Duration=Duration;
        Parms.bLoop=bLoop ? FIRST_BITFIELD : FALSE;
        Parms.bRestartIfAlreadyPlaying=bRestartIfAlreadyPlaying ? FIRST_BITFIELD : FALSE;
        Parms.StartTime=StartTime;
        Parms.bPlayBackwards=bPlayBackwards ? FIRST_BITFIELD : FALSE;
        ProcessEvent(FindFunctionChecked(DUKEGAME_PlayAnim),&Parms);
    }
    void eventSeeFocalPoint(class AActor* PointSeen)
    {
        HumanNPC_eventSeeFocalPoint_Parms Parms(EC_EventParm);
        Parms.PointSeen=PointSeen;
        ProcessEvent(FindFunctionChecked(DUKEGAME_SeeFocalPoint),&Parms);
    }
    DECLARE_CLASS(AHumanNPC,AGamePawn,0|CLASS_Config,DukeGame)
	virtual void PostBeginPlay();
};

#undef DECLARE_CLASS
#undef DECLARE_CASTED_CLASS
#undef DECLARE_ABSTRACT_CLASS
#undef DECLARE_ABSTRACT_CASTED_CLASS
#endif // !INCLUDED_DUKEGAME_CLASSES
#endif // !NAMES_ONLY

AUTOGENERATE_FUNCTION(ADecoration,-1,execBaseChangeImp);
AUTOGENERATE_FUNCTION(ADecoration,-1,execTrigger);
AUTOGENERATE_FUNCTION(ADecoration,-1,execPhysicsVolumeChange);
AUTOGENERATE_FUNCTION(ADecoration,-1,execTakeDamage);
AUTOGENERATE_FUNCTION(ADecoration,-1,execLanded);
AUTOGENERATE_FUNCTION(ADecoration,-1,execCanSplash);
AUTOGENERATE_FUNCTION(ADukeGameInfo,-1,execGetGameType);
AUTOGENERATE_FUNCTION(ADukeHUD,-1,execDrawScaledTexture);
AUTOGENERATE_FUNCTION(ADukeHUD,-1,execRenderHud);
AUTOGENERATE_FUNCTION(ADukeHUD,-1,execHudStartup);
AUTOGENERATE_FUNCTION(ADukeMainMenu,-1,execRenderMainMenu);
AUTOGENERATE_FUNCTION(ADukePawn,-1,execAddDefaultInventory);
AUTOGENERATE_FUNCTION(ADukePawn,-1,execCalcCamera);
AUTOGENERATE_FUNCTION(ADukePawn,-1,execGetPawnViewLocation);
AUTOGENERATE_FUNCTION(ADukeWeapon,-1,execBeginFire);
AUTOGENERATE_FUNCTION(ADukeWeapon,-1,execResetToIdle);

#ifndef NAMES_ONLY
#undef AUTOGENERATE_FUNCTION
#endif

#ifdef STATIC_LINKING_MOJO
#ifndef DUKEGAME_NATIVE_DEFS
#define DUKEGAME_NATIVE_DEFS

#define AUTO_INITIALIZE_REGISTRANTS_DUKEGAME \
	UAnimNotify_SetWeaponState::StaticClass(); \
	UCrushed::StaticClass(); \
	ADecoration::StaticClass(); \
	GNativeLookupFuncs.Set(FName("Decoration"), GDukeGameADecorationNatives); \
	ADukeGameInfo::StaticClass(); \
	GNativeLookupFuncs.Set(FName("DukeGameInfo"), GDukeGameADukeGameInfoNatives); \
	ADukeHUD::StaticClass(); \
	GNativeLookupFuncs.Set(FName("DukeHUD"), GDukeGameADukeHUDNatives); \
	ADukeMainMenu::StaticClass(); \
	GNativeLookupFuncs.Set(FName("DukeMainMenu"), GDukeGameADukeMainMenuNatives); \
	ADukeMenuGameInfo::StaticClass(); \
	ADukePawn::StaticClass(); \
	GNativeLookupFuncs.Set(FName("DukePawn"), GDukeGameADukePawnNatives); \
	ADukeWeapon::StaticClass(); \
	GNativeLookupFuncs.Set(FName("DukeWeapon"), GDukeGameADukeWeaponNatives); \
	AWeaponPistol::StaticClass(); \
	AHumanNPC::StaticClass(); \

#endif // DUKEGAME_NATIVE_DEFS

#ifdef NATIVES_ONLY
FNativeFunctionLookup GDukeGameADecorationNatives[] = 
{ 
	MAP_NATIVE(ADecoration, execBaseChangeImp)
	MAP_NATIVE(ADecoration, execTrigger)
	MAP_NATIVE(ADecoration, execPhysicsVolumeChange)
	MAP_NATIVE(ADecoration, execTakeDamage)
	MAP_NATIVE(ADecoration, execLanded)
	MAP_NATIVE(ADecoration, execCanSplash)
	{NULL, NULL}
};

FNativeFunctionLookup GDukeGameADukeGameInfoNatives[] = 
{ 
	MAP_NATIVE(ADukeGameInfo, execGetGameType)
	{NULL, NULL}
};

FNativeFunctionLookup GDukeGameADukeHUDNatives[] = 
{ 
	MAP_NATIVE(ADukeHUD, execDrawScaledTexture)
	MAP_NATIVE(ADukeHUD, execRenderHud)
	MAP_NATIVE(ADukeHUD, execHudStartup)
	{NULL, NULL}
};

FNativeFunctionLookup GDukeGameADukeMainMenuNatives[] = 
{ 
	MAP_NATIVE(ADukeMainMenu, execRenderMainMenu)
	{NULL, NULL}
};

FNativeFunctionLookup GDukeGameADukePawnNatives[] = 
{ 
	MAP_NATIVE(ADukePawn, execAddDefaultInventory)
	MAP_NATIVE(ADukePawn, execCalcCamera)
	MAP_NATIVE(ADukePawn, execGetPawnViewLocation)
	{NULL, NULL}
};

FNativeFunctionLookup GDukeGameADukeWeaponNatives[] = 
{ 
	MAP_NATIVE(ADukeWeapon, execBeginFire)
	MAP_NATIVE(ADukeWeapon, execResetToIdle)
	{NULL, NULL}
};

#endif // NATIVES_ONLY
#endif // STATIC_LINKING_MOJO

#ifdef VERIFY_CLASS_SIZES
VERIFY_CLASS_OFFSET_NODIE(UAnimNotify_SetWeaponState,AnimNotify_SetWeaponState,newWeaponState)
VERIFY_CLASS_SIZE_NODIE(UAnimNotify_SetWeaponState)
VERIFY_CLASS_SIZE_NODIE(UCrushed)
VERIFY_CLASS_OFFSET_NODIE(ADecoration,Decoration,EffectWhenDestroyed)
VERIFY_CLASS_OFFSET_NODIE(ADecoration,Decoration,LastValidAnchorTime)
VERIFY_CLASS_SIZE_NODIE(ADecoration)
VERIFY_CLASS_SIZE_NODIE(ADukeGameInfo)
VERIFY_CLASS_OFFSET_NODIE(ADukeHUD,DukeHUD,Opacity)
VERIFY_CLASS_OFFSET_NODIE(ADukeHUD,DukeHUD,NumberCircleTexture)
VERIFY_CLASS_SIZE_NODIE(ADukeHUD)
VERIFY_CLASS_SIZE_NODIE(ADukeMainMenu)
VERIFY_CLASS_SIZE_NODIE(ADukeMenuGameInfo)
VERIFY_CLASS_OFFSET_NODIE(ADukePawn,DukePawn,Bob)
VERIFY_CLASS_OFFSET_NODIE(ADukePawn,DukePawn,WalkBob)
VERIFY_CLASS_SIZE_NODIE(ADukePawn)
VERIFY_CLASS_OFFSET_NODIE(ADukeWeapon,DukeWeapon,AmmoCount)
VERIFY_CLASS_OFFSET_NODIE(ADukeWeapon,DukeWeapon,weaponState)
VERIFY_CLASS_SIZE_NODIE(ADukeWeapon)
VERIFY_CLASS_SIZE_NODIE(AWeaponPistol)
VERIFY_CLASS_OFFSET_NODIE(AHumanNPC,HumanNPC,Skill)
VERIFY_CLASS_OFFSET_NODIE(AHumanNPC,HumanNPC,WanderDir)
VERIFY_CLASS_SIZE_NODIE(AHumanNPC)
#endif // VERIFY_CLASS_SIZES
#endif // !ENUMS_ONLY

#if SUPPORTS_PRAGMA_PACK
#pragma pack (pop)
#endif
