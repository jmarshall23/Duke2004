//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
//=============================================================================

#include "UnrealEd.h"
#include "PropertyWindow.h"
#include "EngineMaterialClasses.h"
#include "UTEditor.h"
#include "UTEditorFactories.h"
#include "SourceControl.h"
#include "FConfigCacheIni.h"
#include "BusyCursor.h"
#include "ScopedTransaction.h"

#define STATIC_LINKING_MOJO 1

// Register things.
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name) FName UTEDITOR_##name;
#define AUTOGENERATE_FUNCTION(cls,idx,name) IMPLEMENT_FUNCTION(cls,idx,name)
#include "UTEditorClasses.h"
#undef AUTOGENERATE_NAME

#undef AUTOGENERATE_FUNCTION
#undef NAMES_ONLY

// Register natives.
#define NATIVES_ONLY
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name)
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#include "UTEditorClasses.h"
#undef AUTOGENERATE_NAME

#undef AUTOGENERATE_FUNCTION
#undef NATIVES_ONLY
#undef NAMES_ONLY

#if CHECK_NATIVE_CLASS_SIZES
#if _MSC_VER
#pragma optimize( "", off )
#endif

void AutoCheckNativeClassSizesUTEditor( UBOOL& Mismatch )
{
#define NAMES_ONLY
#define AUTOGENERATE_NAME( name )
#define AUTOGENERATE_FUNCTION( cls, idx, name )
#define VERIFY_CLASS_SIZES
#include "UTEditorClasses.h"
#undef AUTOGENERATE_FUNCTION
#undef AUTOGENERATE_NAME
#undef NAMES_ONLY
#undef VERIFY_CLASS_SIZES
}

#if _MSC_VER
#pragma optimize( "", on )
#endif
#endif

/**
 * Initialize registrants, basically calling StaticClass() to create the class and also 
 * populating the lookup table.
 *
 * @param	Lookup	current index into lookup table
 */
void AutoInitializeRegistrantsUTEditor( INT& Lookup )
{
	AUTO_INITIALIZE_REGISTRANTS_UTEDITOR;
}

/**
 * Auto generates names.
 */
void AutoGenerateNamesUTEditor()
{
	#define NAMES_ONLY
    #define AUTOGENERATE_NAME(name) UTEDITOR_##name = FName(TEXT(#name));
		#include "UTEditorNames.h"
	#undef AUTOGENERATE_NAME
	#define AUTOGENERATE_FUNCTION(cls,idx,name)
	#include "UTEditorClasses.h"
	#undef AUTOGENERATE_FUNCTION
	#undef NAMES_ONLY
}

IMPLEMENT_CLASS(UUTMapMusicInfoFactoryNew);
IMPLEMENT_CLASS(UGenericBrowserType_UTMapMusicInfo);
IMPLEMENT_CLASS(UUTUnrealEdEngine);

/*------------------------------------------------------------------------------
     UUTMapMusicInfoFactoryNew.
------------------------------------------------------------------------------*/

void UUTMapMusicInfoFactoryNew::StaticConstructor()
{
	new(GetClass()->HideCategories) FName(NAME_Object);
}

/**
 * Initializes property values for intrinsic classes.  It is called immediately after the class default object
 * is initialized against its archetype, but before any objects of this class are created.
 */
void UUTMapMusicInfoFactoryNew::InitializeIntrinsicPropertyValues()
{
	SupportedClass		= UUDKMapMusicInfo::StaticClass();
	bCreateNew			= TRUE;
	bEditAfterNew		= TRUE;
	Description			= SupportedClass->GetName();
}

UObject* UUTMapMusicInfoFactoryNew::FactoryCreateNew(UClass* Class,UObject* InParent,FName Name,EObjectFlags Flags,UObject* Context,FFeedbackContext* Warn)
{
	return StaticConstructObject(Class,InParent,Name,Flags);
}

void UGenericBrowserType_UTMapMusicInfo::Init()
{
	SupportInfo.AddItem(FGenericBrowserTypeInfo(UUDKMapMusicInfo::StaticClass(), FColor(200,128,128), 0, this));
}




