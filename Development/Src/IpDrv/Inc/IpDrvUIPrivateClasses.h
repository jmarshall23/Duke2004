/*===========================================================================
    C++ class definitions exported from UnrealScript.
    This is automatically generated by the tools.
    DO NOT modify this manually! Edit the corresponding .uc files instead!
    Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
===========================================================================*/
#if SUPPORTS_PRAGMA_PACK
#pragma pack (push,4)
#endif

#include "IpDrvNames.h"

// Split enums from the rest of the header so they can be included earlier
// than the rest of the header file by including this file twice with different
// #define wrappers. See Engine.h and look at EngineClasses.h for an example.
#if !NO_ENUMS && !defined(NAMES_ONLY)

#ifndef INCLUDED_IPDRV_UIPRIVATE_ENUMS
#define INCLUDED_IPDRV_UIPRIVATE_ENUMS 1


#endif // !INCLUDED_IPDRV_UIPRIVATE_ENUMS
#endif // !NO_ENUMS

#if !ENUMS_ONLY

#ifndef NAMES_ONLY
#define AUTOGENERATE_FUNCTION(cls,idx,name)
#endif


#ifndef NAMES_ONLY

#ifndef INCLUDED_IPDRV_UIPRIVATE_CLASSES
#define INCLUDED_IPDRV_UIPRIVATE_CLASSES 1
#define ENABLE_DECLARECLASS_MACRO 1
#include "UnObjBas.h"
#undef ENABLE_DECLARECLASS_MACRO

class UOnlinePlaylistProvider : public UUIResourceDataProvider
{
public:
    //## BEGIN PROPS OnlinePlaylistProvider
    INT PlaylistId;
    TArrayNoInit<FName> PlaylistGameTypeNames;
    FStringNoInit DisplayName;
    INT Priority;
    //## END PROPS OnlinePlaylistProvider

    DECLARE_CLASS(UOnlinePlaylistProvider,UUIResourceDataProvider,0|CLASS_Transient|CLASS_Config,IpDrv)
    static const TCHAR* StaticConfigName() {return TEXT("Playlist");}

    NO_DEFAULT_CONSTRUCTOR(UOnlinePlaylistProvider)
};

#define UCONST_PRIVATEPROVIDERTAG TEXT("PlaylistsPrivate")
#define UCONST_RECMODEPROVIDERTAG TEXT("PlaylistsRecMode")
#define UCONST_UNRANKEDPROVIDERTAG TEXT("PlaylistsUnranked")
#define UCONST_RANKEDPROVIDERTAG TEXT("PlaylistsRanked")

struct UIDataStore_OnlinePlaylists_eventGetMatchTypeForPlaylistId_Parms
{
    INT PlaylistId;
    INT ReturnValue;
    UIDataStore_OnlinePlaylists_eventGetMatchTypeForPlaylistId_Parms(EEventParm)
    {
    }
};
struct UIDataStore_OnlinePlaylists_eventInit_Parms
{
    UIDataStore_OnlinePlaylists_eventInit_Parms(EEventParm)
    {
    }
};
class UUIDataStore_OnlinePlaylists : public UUIDataStore
{
public:
    //## BEGIN PROPS UIDataStore_OnlinePlaylists
    FStringNoInit ProviderClassName;
    class UClass* ProviderClass;
    TArrayNoInit<class UUIResourceDataProvider*> RankedDataProviders;
    TArrayNoInit<class UUIResourceDataProvider*> UnrankedDataProviders;
    TArrayNoInit<class UUIResourceDataProvider*> RecModeDataProviders;
    TArrayNoInit<class UUIResourceDataProvider*> PrivateDataProviders;
    class UOnlinePlaylistManager* PlaylistMan;
    //## END PROPS UIDataStore_OnlinePlaylists

    UBOOL GetResourceProviders(FName ProviderTag,TArray<class UUIResourceDataProvider*>& out_Providers) const;
    UBOOL GetPlaylistProvider(FName ProviderTag,INT ProviderIndex,class UUIResourceDataProvider*& out_Provider);
    DECLARE_FUNCTION(execGetResourceProviders)
    {
        P_GET_NAME(ProviderTag);
        P_GET_TARRAY_REF(class UUIResourceDataProvider*,out_Providers);
        P_FINISH;
        *(UBOOL*)Result=this->GetResourceProviders(ProviderTag,out_Providers);
    }
    DECLARE_FUNCTION(execGetPlaylistProvider)
    {
        P_GET_NAME(ProviderTag);
        P_GET_INT(ProviderIndex);
        P_GET_OBJECT_REF(UUIResourceDataProvider,out_Provider);
        P_FINISH;
        *(UBOOL*)Result=this->GetPlaylistProvider(ProviderTag,ProviderIndex,out_Provider);
    }
    INT eventGetMatchTypeForPlaylistId(INT PlaylistId)
    {
        UIDataStore_OnlinePlaylists_eventGetMatchTypeForPlaylistId_Parms Parms(EC_EventParm);
        Parms.ReturnValue=0;
        Parms.PlaylistId=PlaylistId;
        ProcessEvent(FindFunctionChecked(IPDRV_GetMatchTypeForPlaylistId),&Parms);
        return Parms.ReturnValue;
    }
    void eventInit()
    {
        ProcessEvent(FindFunctionChecked(IPDRV_Init),NULL);
    }
    DECLARE_CLASS(UUIDataStore_OnlinePlaylists,UUIDataStore,0|CLASS_Transient|CLASS_Config,IpDrv)
    static const TCHAR* StaticConfigName() {return TEXT("Game");}

	/* === UUIDataStore_GameResource interface === */
	/**
	 * Finds or creates the UIResourceDataProvider instances used by online playlists, and stores the result by ranked or unranked provider types
	 */
	virtual void InitializeListElementProviders();

	/* === UIDataStore interface === */
	/**
	 * Calls the script event so that it can access the playlist manager
	 */
	virtual void InitializeDataStore()
	{
		Super::InitializeDataStore();
		eventInit();
	}

	/**
	 * Loads the classes referenced by the ElementProviderTypes array.
	 */
	virtual void LoadDependentClasses();

	/**
	 * Called when this data store is added to the data store manager's list of active data stores.
	 *
	 * @param	PlayerOwner		the player that will be associated with this DataStore.  Only relevant if this data store is
	 *							associated with a particular player; NULL if this is a global data store.
	 */
	virtual void OnRegister( ULocalPlayer* PlayerOwner );

	/* === UObject interface === */
	/** Required since maps are not yet supported by script serialization */
	virtual void AddReferencedObjects( TArray<UObject*>& ObjectArray );
	virtual void Serialize( FArchive& Ar );

	/**
	 * Called from ReloadConfig after the object has reloaded its configuration data.  Reinitializes the collection of list element providers.
	 */
	virtual void PostReloadConfig( UProperty* PropertyThatWasLoaded );

	/**
	 * Callback for retrieving a textual representation of natively serialized properties.  Child classes should implement this method if they wish
	 * to have natively serialized property values included in things like diffcommandlet output.
	 *
	 * @param	out_PropertyValues	receives the property names and values which should be reported for this object.  The map's key should be the name of
	 *								the property and the map's value should be the textual representation of the property's value.  The property value should
	 *								be formatted the same way that UProperty::ExportText formats property values (i.e. for arrays, wrap in quotes and use a comma
	 *								as the delimiter between elements, etc.)
	 * @param	ExportFlags			bitmask of EPropertyPortFlags used for modifying the format of the property values
	 *
	 * @return	return TRUE if property values were added to the map.
	 */
	virtual UBOOL GetNativePropertyValues( TMap<FString,FString>& out_PropertyValues, DWORD ExportFlags=0 ) const;
};

#undef DECLARE_CLASS
#undef DECLARE_CASTED_CLASS
#undef DECLARE_ABSTRACT_CLASS
#undef DECLARE_ABSTRACT_CASTED_CLASS
#endif // !INCLUDED_IPDRV_UIPRIVATE_CLASSES
#endif // !NAMES_ONLY

AUTOGENERATE_FUNCTION(UUIDataStore_OnlinePlaylists,-1,execGetPlaylistProvider);
AUTOGENERATE_FUNCTION(UUIDataStore_OnlinePlaylists,-1,execGetResourceProviders);

#ifndef NAMES_ONLY
#undef AUTOGENERATE_FUNCTION
#endif

#ifdef STATIC_LINKING_MOJO
#ifndef IPDRV_UIPRIVATE_NATIVE_DEFS
#define IPDRV_UIPRIVATE_NATIVE_DEFS

#define AUTO_INITIALIZE_REGISTRANTS_IPDRV_UIPRIVATE \
	UOnlinePlaylistProvider::StaticClass(); \
	UUIDataStore_OnlinePlaylists::StaticClass(); \
	GNativeLookupFuncs.Set(FName("UIDataStore_OnlinePlaylists"), GIpDrvUUIDataStore_OnlinePlaylistsNatives); \

#endif // IPDRV_UIPRIVATE_NATIVE_DEFS

#ifdef NATIVES_ONLY
FNativeFunctionLookup GIpDrvUUIDataStore_OnlinePlaylistsNatives[] = 
{ 
	MAP_NATIVE(UUIDataStore_OnlinePlaylists, execGetPlaylistProvider)
	MAP_NATIVE(UUIDataStore_OnlinePlaylists, execGetResourceProviders)
	{NULL, NULL}
};

#endif // NATIVES_ONLY
#endif // STATIC_LINKING_MOJO

#ifdef VERIFY_CLASS_SIZES
VERIFY_CLASS_OFFSET_NODIE(UOnlinePlaylistProvider,OnlinePlaylistProvider,PlaylistId)
VERIFY_CLASS_OFFSET_NODIE(UOnlinePlaylistProvider,OnlinePlaylistProvider,Priority)
VERIFY_CLASS_SIZE_NODIE(UOnlinePlaylistProvider)
VERIFY_CLASS_OFFSET_NODIE(UUIDataStore_OnlinePlaylists,UIDataStore_OnlinePlaylists,ProviderClassName)
VERIFY_CLASS_OFFSET_NODIE(UUIDataStore_OnlinePlaylists,UIDataStore_OnlinePlaylists,PlaylistMan)
VERIFY_CLASS_SIZE_NODIE(UUIDataStore_OnlinePlaylists)
#endif // VERIFY_CLASS_SIZES
#endif // !ENUMS_ONLY

#if SUPPORTS_PRAGMA_PACK
#pragma pack (pop)
#endif
