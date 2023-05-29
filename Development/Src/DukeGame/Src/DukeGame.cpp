// DukeGame.cpp

#include "DukeGame.h"

/*-----------------------------------------------------------------------------
	The following must be done once per package.
-----------------------------------------------------------------------------*/

#define STATIC_LINKING_MOJO 1

// Register things.
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name) FName DUKEGAME_##name;
#define AUTOGENERATE_FUNCTION(cls,idx,name) IMPLEMENT_FUNCTION(cls,idx,name)
#include "DukeGameClasses.h"
#undef AUTOGENERATE_NAME

#undef AUTOGENERATE_FUNCTION
#undef NAMES_ONLY

// Register natives.
#define NATIVES_ONLY
#define NAMES_ONLY
#define AUTOGENERATE_NAME(name)
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#include "DukeGameClasses.h"
#undef AUTOGENERATE_NAME

#undef AUTOGENERATE_FUNCTION
#undef NATIVES_ONLY
#undef NAMES_ONLY

#if CHECK_NATIVE_CLASS_SIZES
#if _MSC_VER
#pragma optimize( "", off )
#endif

void AutoCheckNativeClassSizesDukeGame( UBOOL& Mismatch )
{
#define NAMES_ONLY
#define AUTOGENERATE_NAME( name )
#define AUTOGENERATE_FUNCTION( cls, idx, name )
#define VERIFY_CLASS_SIZES
#include "DukeGameClasses.h"
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
void AutoInitializeRegistrantsDukeGame( INT& Lookup )
{
	AUTO_INITIALIZE_REGISTRANTS_DUKEGAME;
}

/**
 * Auto generates names.
 */
void AutoGenerateNamesDukeGame()
{
	#define NAMES_ONLY
    #define AUTOGENERATE_NAME(name) DUKEGAME_##name = FName(TEXT(#name));
	#include "DukeGameNames.h"
	#undef AUTOGENERATE_NAME

	#define AUTOGENERATE_FUNCTION(cls,idx,name)
	#include "DukeGameClasses.h"
	#undef AUTOGENERATE_FUNCTION
	#undef NAMES_ONLY
}

/**
 * Game-specific code to handle DLC being added or removed
 *
 * @param bContentWasInstalled TRUE if DLC was installed, FALSE if it was removed
 */
void appOnDownloadableContentChanged(UBOOL bContentWasInstalled)
{
	
}

FSystemSettings& GetSystemSettings()
{
	static FSystemSettings SystemSettingsSingleton;
	return SystemSettingsSingleton;
}
