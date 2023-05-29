//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// This is where you would extend the editor with game-specific dependencies
// and functionality
//=============================================================================

#if _WINDOWS
#include "Core.h"
//#include "UnrealEd.h"
#include "DukeEditorClasses.h"

#define STATIC_LINKING_MOJO 1

// Register things.
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name) FName DUKEDITOR_##name;
#define AUTOGENERATE_FUNCTION(cls,idx,name) IMPLEMENT_FUNCTION(cls,idx,name)
#include "DukeEditorClasses.h"
#undef AUTOGENERATE_NAME

#undef AUTOGENERATE_FUNCTION
#undef NAMES_ONLY

// Register natives.
#define NATIVES_ONLY
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name)
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#include "DukeEditorClasses.h"
#undef AUTOGENERATE_NAME

#undef AUTOGENERATE_FUNCTION
#undef NATIVES_ONLY
#undef NAMES_ONLY

/**
 * Initialize registrants, basically calling StaticClass() to create the class and also 
 * populating the lookup table.
 *
 * @param	Lookup	current index into lookup table
 */
void AutoInitializeRegistrantsDukeEditor( INT& Lookup )
{
	//AUTO_INITIALIZE_REGISTRANTS_EXAMPLEEDITOR;
}

/**
 * Auto generates names.
 */
void AutoGenerateNamesDukeEditor()
{
	#define NAMES_ONLY
    #define AUTOGENERATE_NAME(name) DUKEDITOR_##name = FName(TEXT(#name));
// 		#include "DukeEditorNames.h"
	#undef AUTOGENERATE_NAME

	#define AUTOGENERATE_FUNCTION(cls,idx,name)
	#include "DukeEditorClasses.h"
	#undef AUTOGENERATE_FUNCTION
	#undef NAMES_ONLY
}

#if CHECK_NATIVE_CLASS_SIZES
#if _MSC_VER
#pragma optimize( "", off )
#endif

void AutoCheckNativeClassSizesDukeEditor( UBOOL& Mismatch )
{
#define NAMES_ONLY
#define AUTOGENERATE_NAME( name )
#define AUTOGENERATE_FUNCTION( cls, idx, name )
#define VERIFY_CLASS_SIZES
#include "DukeEditorClasses.h"
#undef AUTOGENERATE_FUNCTION
#undef AUTOGENERATE_NAME
#undef NAMES_ONLY
#undef VERIFY_CLASS_SIZES
}

#if _MSC_VER
#pragma optimize( "", on )
#endif
#endif

#endif
