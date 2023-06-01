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

#ifndef INCLUDED_DUKEGAME_ANIMATION_ENUMS
#define INCLUDED_DUKEGAME_ANIMATION_ENUMS 1


#endif // !INCLUDED_DUKEGAME_ANIMATION_ENUMS
#endif // !NO_ENUMS

#if !ENUMS_ONLY

#ifndef NAMES_ONLY
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#endif


#ifndef NAMES_ONLY

#ifndef INCLUDED_DUKEGAME_ANIMATION_CLASSES
#define INCLUDED_DUKEGAME_ANIMATION_CLASSES 1
#define ENABLE_DECLARECLASS_MACRO 1
#include "UnObjBas.h"
#undef ENABLE_DECLARECLASS_MACRO

struct DukeAnimBlendBase_eventTickAnim_Parms
{
    FLOAT DeltaSeconds;
    DukeAnimBlendBase_eventTickAnim_Parms(EEventParm)
    {
    }
};
class UDukeAnimBlendBase : public UAnimNodeBlendList
{
public:
    //## BEGIN PROPS DukeAnimBlendBase
    FLOAT BlendTime;
    TArrayNoInit<FLOAT> ChildBlendTimes;
    BITFIELD bTickAnimInScript:1;
    SCRIPT_ALIGN;
    //## END PROPS DukeAnimBlendBase

    FLOAT GetBlendTime(INT ChildIndex,UBOOL bGetDefault=FALSE);
    FLOAT GetAnimDuration(INT ChildIndex);
    DECLARE_FUNCTION(execGetBlendTime)
    {
        P_GET_INT(ChildIndex);
        P_GET_UBOOL_OPTX(bGetDefault,FALSE);
        P_FINISH;
        *(FLOAT*)Result=this->GetBlendTime(ChildIndex,bGetDefault);
    }
    DECLARE_FUNCTION(execGetAnimDuration)
    {
        P_GET_INT(ChildIndex);
        P_FINISH;
        *(FLOAT*)Result=this->GetAnimDuration(ChildIndex);
    }
    void eventTickAnim(FLOAT DeltaSeconds)
    {
        DukeAnimBlendBase_eventTickAnim_Parms Parms(EC_EventParm);
        Parms.DeltaSeconds=DeltaSeconds;
        ProcessEvent(FindFunctionChecked(DUKEGAME_TickAnim),&Parms);
    }
    DECLARE_CLASS(UDukeAnimBlendBase,UAnimNodeBlendList,0,DukeGame)
	virtual	void TickAnim(FLOAT DeltaSeconds);

	// AnimTree editor interface
	virtual void HandleSliderMove(INT SliderIndex, INT ValueIndex, FLOAT NewSliderValue);
};

class UDukeAnimBlendIdle : public UDukeAnimBlendBase
{
public:
    //## BEGIN PROPS DukeAnimBlendIdle
    //## END PROPS DukeAnimBlendIdle

    DECLARE_CLASS(UDukeAnimBlendIdle,UDukeAnimBlendBase,0,DukeGame)
	// AnimNode interface
	virtual	void TickAnim(FLOAT DeltaSeconds);
};

#undef DECLARE_CLASS
#undef DECLARE_CASTED_CLASS
#undef DECLARE_ABSTRACT_CLASS
#undef DECLARE_ABSTRACT_CASTED_CLASS
#endif // !INCLUDED_DUKEGAME_ANIMATION_CLASSES
#endif // !NAMES_ONLY

AUTOGENERATE_FUNCTION(UDukeAnimBlendBase,-1,execGetAnimDuration);
AUTOGENERATE_FUNCTION(UDukeAnimBlendBase,-1,execGetBlendTime);

#ifndef NAMES_ONLY
#undef AUTOGENERATE_FUNCTION
#endif

#ifdef STATIC_LINKING_MOJO
#ifndef DUKEGAME_ANIMATION_NATIVE_DEFS
#define DUKEGAME_ANIMATION_NATIVE_DEFS

#define AUTO_INITIALIZE_REGISTRANTS_DUKEGAME_ANIMATION \
	UDukeAnimBlendBase::StaticClass(); \
	GNativeLookupFuncs.Set(FName("DukeAnimBlendBase"), GDukeGameUDukeAnimBlendBaseNatives); \
	UDukeAnimBlendIdle::StaticClass(); \

#endif // DUKEGAME_ANIMATION_NATIVE_DEFS

#ifdef NATIVES_ONLY
FNativeFunctionLookup GDukeGameUDukeAnimBlendBaseNatives[] = 
{ 
	MAP_NATIVE(UDukeAnimBlendBase, execGetAnimDuration)
	MAP_NATIVE(UDukeAnimBlendBase, execGetBlendTime)
	{NULL, NULL}
};

#endif // NATIVES_ONLY
#endif // STATIC_LINKING_MOJO

#ifdef VERIFY_CLASS_SIZES
VERIFY_CLASS_OFFSET_NODIE(UDukeAnimBlendBase,DukeAnimBlendBase,BlendTime)
VERIFY_CLASS_OFFSET_NODIE(UDukeAnimBlendBase,DukeAnimBlendBase,ChildBlendTimes)
VERIFY_CLASS_SIZE_NODIE(UDukeAnimBlendBase)
VERIFY_CLASS_SIZE_NODIE(UDukeAnimBlendIdle)
#endif // VERIFY_CLASS_SIZES
#endif // !ENUMS_ONLY

#if SUPPORTS_PRAGMA_PACK
#pragma pack (pop)
#endif
