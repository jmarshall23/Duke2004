/**
 * Implementation file for all UDK datastore classes.
 * Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 */
#include "UDKBase.h"

IMPLEMENT_CLASS(UUDKUIDataProvider_MapInfo);

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataProvider_MenuOption
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataProvider_MenuOption);

/** @return 	TRUE if this menu option's configuration isn't compatible with the desired game settings  */
/*
UBOOL UUDKUIDataProvider_MenuOption::IsFiltered()
{
	UBOOL bFiltered = Super::IsFiltered();

	if ( !bFiltered )
	{
		UDataStoreClient* DataStoreClient = UUIInteraction::GetDataStoreClient();
		if (DataStoreClient != NULL)
		{
			UUIDataStore_Registry* Registry = Cast<UUIDataStore_Registry>(DataStoreClient->FindDataStore(TEXT("Registry")));
			if(Registry)
			{
				FString Value;

				if ( Registry->eventGetData(TEXT("SelectedGameMode"), Value ))
				{
					bFiltered = (RequiredGameMode != NAME_None && RequiredGameMode != FName(*Value));
				}

				if ( !bFiltered && Registry->eventGetData(TEXT("StandaloneGame"), Value) )
				{
								// bOnlineOnly option
					bFiltered = (bOnlineOnly && Value == TEXT("1"))
								// bOfflineOnly option
							||	(bOfflineOnly && Value == TEXT("0"));
				}
			}
		}

		// If we are the german version, remove gore option
		if( (GForceLowGore) && (GetName()==TEXT("GoreLevel")) )
		{
			bFiltered=TRUE;
		}

#if PS3
		// If this menu option corresponds to something that is only relevant for keyboard/mouse (i.e. mouse sensitivity, etc.),
		// filter it out if we don't have a keyboard or mouse
		if ( bKeyboardOrMouseOption )
		{
			if(GEngine && GEngine->GamePlayers.Num() && GEngine->GamePlayers(0))
			{
				AUDKPlayerController* PC = Cast<AUDKPlayerController>(GEngine->GamePlayers(0)->Actor);

				if(PC != NULL)
				{
					if(PC->IsKeyboardAvailable()==FALSE && PC->IsMouseAvailable()==FALSE)
					{
						bFiltered=TRUE;
					}
				}
			}
		}
#endif
	}

	return bFiltered || Super::IsFiltered();
}
*/

//////////////////////////////////////////////////////////////////////////
// UUDKUIResourceDataProvider
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIResourceDataProvider);

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataStore_StringAliasMap
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataStore_StringAliasMap);

/**
 * Set MappedString to be the localized string using the FieldName as a key
 * Returns the index into the mapped string array of where it was found.
 */
INT UUDKUIDataStore_StringAliasMap::GetStringWithFieldName( const FString& FieldName, FString& MappedString )
{
	INT FieldIdx = INDEX_NONE;
	FString FinalFieldName = FieldName;

#if PS3
	// Swap accept and cancel on PS3 if we need to, this is a TRC requirement.
	if(appPS3UseCircleToAccept())
	{
		if(FinalFieldName==TEXT("Accept"))
		{
			FinalFieldName=TEXT("Cancel");
		}
		else if(FinalFieldName==TEXT("Cancel"))
		{
			FinalFieldName=TEXT("Accept");
		}
	}
#endif

	// Try to find platform specific versions first
	FString SetName;
#if XBOX
	SetName = TEXT("360");
#elif PS3
	SetName = TEXT("PS3");
#else
	switch ( FakePlatform )
	{
		case 1: SetName = TEXT("360"); break;
		case 2: SetName = TEXT("PS3"); break;
		default: SetName = TEXT("PC"); break;
	}
#endif
	FieldIdx = FindMappingWithFieldName(FinalFieldName, SetName);

	if(FieldIdx == INDEX_NONE)
	{
		FieldIdx = FindMappingWithFieldName(FinalFieldName);
	}

	if(FieldIdx == INDEX_NONE)
	{
		FieldIdx = FindMappingWithFieldName();
	}

	if(FieldIdx != INDEX_NONE)
	{
		MappedString = MenuInputMapArray(FieldIdx).MappedText;
	}

	return FieldIdx;
}

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataStore_StringAliasBindingMap
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataStore_StringAliasBindingMap);

//Clear the command to input keybinding cache
void UUDKUIDataStore_StringAliasBindingMap::ClearBoundKeyCache()
{
	CommandToBindNames.Empty();
}

// Given an input command of the form GBA_ return the mapped keybinding string 
// Returns TRUE if it exists, FALSE otherwise
UBOOL UUDKUIDataStore_StringAliasBindingMap::FindMappingInBoundKeyCache(const FString& Command, FString& MappingStr, INT& FieldIndex)
{
	const FName Key(*Command);
	// Does the data already exist
	const FBindCacheElement* CacheElement = CommandToBindNames.Find(Key);
	if (CacheElement != NULL)
	{
		MappingStr = CacheElement->MappingString;
		FieldIndex = CacheElement->FieldIndex;
	}

	return (CacheElement != NULL);
}

//Given a input command of the form GBA_ and its mapping store that in a lookup for future use
void UUDKUIDataStore_StringAliasBindingMap::AddMappingToBoundKeyCache(const FString& Command, const FString& MappingStr, const INT FieldIndex)
{
	const FName Key(*Command);

	// Does the data already exist
	const FBindCacheElement* CacheElement = CommandToBindNames.Find(Key);

	if (CacheElement == NULL)
	{
		// Initialize a new FBindCacheElement.  It contains a FStringNoInit, so it needs to be initialized to zero.
		FBindCacheElement NewElement;
		appMemzero(&NewElement,sizeof(NewElement));

		NewElement.KeyName = Key;
		NewElement.MappingString = MappingStr;
		NewElement.FieldIndex = FieldIndex;
		CommandToBindNames.Set(Key, NewElement);
	}
}

/**
* Set MappedString to be the localized string using the FieldName as a key
* Returns the index into the mapped string array of where it was found.
*/
INT UUDKUIDataStore_StringAliasBindingMap::GetStringWithFieldName( const FString& FieldName, FString& MappedString )
{
	INT StartIndex = UCONST_SABM_FIND_FIRST_BIND;
	INT FieldIndex = INDEX_NONE;

	if (FindMappingInBoundKeyCache(FieldName, MappedString, FieldIndex) == FALSE)
	{
		FieldIndex = GetBoundStringWithFieldName( FieldName, MappedString, &StartIndex );
		AddMappingToBoundKeyCache(FieldName, MappedString, FieldIndex);
	}

	return FieldIndex;
}

/**
 * Called by GetStringWithFieldName() to retrieve the string using the input binding system.
 */
INT UUDKUIDataStore_StringAliasBindingMap::GetBoundStringWithFieldName( const FString& FieldName, FString& MappedString, INT* StartIndex/*=NULL*/, FString* BindString/*=NULL*/ )
{
	// String to set MappedString to
	FString LocalizedString = TEXT(" ");

	// Get the index in the MenuInputMapArray using FieldName as the key.
	INT FieldIdx = INDEX_NONE;
	FName KeyName = FName(*FieldName);
	for ( INT Idx = 0; Idx < MenuInputMapArray.Num(); Idx++ )
	{
		if ( KeyName == MenuInputMapArray(Idx).FieldName )
		{
			// Found it
			FieldIdx = Idx;
			break;
		}
	}

	// If we found the entry in our array find the binding and map it to a localized string.
	if ( FieldIdx != INDEX_NONE )
	{
		// Determine how the localized string will need to be mapped.
		// 0 = PC
		// 1 = XBox360
		// 2 = PS3
		INT Platform;

		// FIXME TEMP - for PC development of 360 controls
		Platform = 1;

#if XBOX
		Platform = 1;
#elif PS3
		Platform = 2;
#else
		switch ( FakePlatform )
		{
			case 1: Platform = 1; break;
			case 2: Platform = 2; break;
			default: Platform = 0; break;
		}
#endif

		// Get the player controller.
		ULocalPlayer* LP = GetPlayerOwner();
		AUDKPlayerController* UTPC = LP ? Cast<AUDKPlayerController>(LP->Actor) : NULL;

		FString NameSearch = TEXT("");
		INT BindIndex = -1;

		if ( UTPC )
		{
			// Get the bind using the mapped FieldName as the key
			FString KeyCommand = MenuInputMapArray(FieldIdx).FieldName.ToString();
			if ( KeyCommand.Len() > 0 )
			{
				UUDKPlayerInput* UTInput = Cast<UUDKPlayerInput>(UTPC->PlayerInput);
				if ( UTInput )
				{
					if ( StartIndex && *StartIndex == UCONST_SABM_FIND_FIRST_BIND )
					{
						// Get the game logic specific bind based from the command.
						KeyCommand = UTInput->GetUDKBindNameFromCommand( *KeyCommand );
					}
					else
					{
						// Get the bind starting from the back at index StartIndex.
						KeyCommand = UTInput->GetBindNameFromCommand( *KeyCommand, StartIndex );

						// Don't allow controller binds to be shown on PC.
						if ( Platform == 0 )
						{
							while( KeyCommand.StartsWith(TEXT("XBoxTypeS")) && (StartIndex && *StartIndex > -1) )
							{
								(*StartIndex)--;
								KeyCommand = UTInput->GetBindNameFromCommand( *KeyCommand, StartIndex );
							}
						}
					}

					// Set the bind string to the string we found.
					if ( BindString )
					{
						*BindString = KeyCommand;
					}

					// If this is a controller string we have to check the ControllerMapArray for the localized text.
					if ( KeyCommand.StartsWith(TEXT("XBoxTypeS")) )
					{
						// Prefix the mapping with the localized string variable prefix.
						FString SubString = FString::Printf(TEXT("GMS_%s"),*KeyCommand);

						// If this is the Xbox360 or PS3 map it to the localized button strings.
						if ( Platform > 0 )
						{
							FName CommandName = FName(*SubString);
							for ( INT Idx = 0; Idx < ControllerMapArray.Num(); Idx++ )
							{
								if ( CommandName == ControllerMapArray(Idx).KeyName )
								{
									// Found it, now set the correct mapping.
									if ( Platform == 1 )
									{
										SubString = ControllerMapArray(Idx).XBoxMapping;
									}
									else
									{
										SubString = ControllerMapArray(Idx).PS3Mapping;
									}

									// Try and localize it using the ButtonFont section.
									LocalizedString = Localize( TEXT("ButtonFont"), *SubString, TEXT("UDKGameUI") );
									break;
								}
							}
						}
						else
						{
							// Try and localize it using the GameMappedStrings section.
							LocalizedString = Localize( TEXT("GameMappedStrings"), *SubString, TEXT("UDKGameUI") );
						}
					}
					else
					{
						// Could not find a mapping... if this happens the game is trying to draw the string for a bind that
						// it didn't ensure would exist.
						if ( KeyCommand.Len() <= 0 )
						{
							LocalizedString = TEXT("");
						}
						// Found a bind.
						else
						{
							// Prefix the mapping with the localized string variable prefix.
							FString SubString = FString::Printf(TEXT("GMS_%s"),*KeyCommand);
							// Try and localize it using the GameMappedStrings section.
							LocalizedString = Localize( TEXT("GameMappedStrings"), *SubString, TEXT("UDKGameUI") );
						}
					}
				}
			}
		}
	}

	// Set the localized string and return the index.
	MappedString = LocalizedString;
	return FieldIdx;
}

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataProvider_SearchResult
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataProvider_SearchResult);

/**
 * @return	TRUE if server corresponding to this search result is password protected.
 */
UBOOL UUDKUIDataProvider_SearchResult::IsPrivateServer()
{
	INT SettingValueIndex = 0;
	if ( Settings != NULL )
	{
		static FName PrivateServerSettingName = FName(TEXT("LockedServer"));
		verify(Settings->GetStringSettingValueByName(PrivateServerSettingName, SettingValueIndex));
	}
	return SettingValueIndex == 1;
}

/**
 * @return	TRUE if server corresponding to this search result allows players to use keyboard & mouse.
 */
UBOOL UUDKUIDataProvider_SearchResult::AllowsKeyboardMouse()
{
	INT SettingValueIndex = 0;
	if ( Settings != NULL )
	{
		static FName KMAllowedSettingName = FName(TEXT("AllowKeyboard"));
		verify(Settings->GetStringSettingValueByName(KMAllowedSettingName, SettingValueIndex));
	}
	return SettingValueIndex == 1;
}

/**
 * Resolves the value of the data field specified and stores it in the output parameter.
 *
 * @param	FieldName		the data field to resolve the value for;  guaranteed to correspond to a property that this provider
 *							can resolve the value for (i.e. not a tag corresponding to an internal provider, etc.)
 * @param	out_FieldValue	receives the resolved value for the property specified.
 *							@see GetDataStoreValue for additional notes
 * @param	ArrayIndex		optional array index for use with data collections
 */
/*
UBOOL UUDKUIDataProvider_SearchResult::GetFieldValue(const FString& FieldName,FUIProviderFieldValue& out_FieldValue,INT ArrayIndex)
{
	UBOOL bResult=FALSE;

	const FName FieldFName(*FieldName);
	if ( FieldFName == ServerFlagsTag )
	{
		out_FieldValue.PropertyTag = PlayerRatioTag;
		out_FieldValue.PropertyType = DATATYPE_Property;

		// since we always want this field value to be displayed using a certain font, use markup to ensure that font is used
		// this way we can just use the same style as the rest of the list or string
		out_FieldValue.StringValue = US + TEXT("<Fonts:") + IconFontPathName + TEXT(">");

		if ( !GIsGame )
		{
			out_FieldValue.StringValue += TEXT("0");
		}

		if ( IsPrivateServer() || !GIsGame )
		{
			out_FieldValue.StringValue += TEXT("7");
		}

		if ( AllowsKeyboardMouse() || !GIsGame )
		{
			out_FieldValue.StringValue += TEXT("6");
		}

		// closing data store markup
		out_FieldValue.StringValue += TEXT("<Fonts:/>");

		bResult = TRUE;
	}
	else if ( FieldFName == PlayerRatioTag )
	{
		FUIProviderFieldValue TotalValue(EC_EventParm);
		FUIProviderFieldValue OpenValue(EC_EventParm);
		if (Super::GetFieldValue(TEXT("NumPublicConnections"), TotalValue, ArrayIndex)
		&&	Super::GetFieldValue(TEXT("NumOpenPublicConnections"), OpenValue, ArrayIndex))
		{
			INT OpenNum = appAtoi(*OpenValue.StringValue);
			INT TotalNum = appAtoi(*TotalValue.StringValue);

			out_FieldValue.PropertyTag = PlayerRatioTag;
			out_FieldValue.StringValue = FString::Printf(TEXT("%i/%i"), TotalNum-OpenNum, TotalNum);
			bResult = TRUE;
		}
	}
	else if ( FieldFName == GameModeFriendlyNameTag || FieldFName == TEXT("CustomGameMode") )
	{
		FUIProviderFieldValue GameClassName(EC_EventParm);

		if ( Super::GetFieldValue(TEXT("CustomGameMode"), GameClassName, ArrayIndex) )
		{
			// Try to get the localized game name out of the localization file.
			FString LocalizedGameName;
			LocalizedGameName = GameClassName.StringValue;
			
			// Replace _Content class name with normal class name.
			if(LocalizedGameName.ReplaceInline(TEXT("UTGameContent."),TEXT("UTGame.")))
			{
				LocalizedGameName.ReplaceInline(TEXT("_Content"),TEXT(""));
			}

			INT PeriodPos = LocalizedGameName.InStr(TEXT("."));
			if(PeriodPos > 0 && PeriodPos < LocalizedGameName.Len())
			{	
				FString GamePackageName = LocalizedGameName.Left(PeriodPos);
				FString GameModeName = LocalizedGameName.Mid(PeriodPos + 1);
				FString LocalizedResult = Localize(*GameModeName, TEXT("GameName"), *GamePackageName, NULL, TRUE);
				if ( LocalizedResult.Len() > 0 )
				{
					LocalizedGameName = LocalizedResult;
				}
				else
				{
					LocalizedGameName = GameModeName;
				}
			}

			// Return the string field value.
			out_FieldValue.PropertyTag = GameModeFriendlyNameTag;
			out_FieldValue.StringValue = LocalizedGameName;
			bResult = TRUE;
		}
	}
	else if ( FieldFName == MapNameTag )
	{
		FUIProviderFieldValue ActualMapName(EC_EventParm);
		if ( Super::GetFieldValue(FieldName, ActualMapName, ArrayIndex) )
		{
			const FName MapTag(TEXT("Maps"));

			// same thing for the map
			// for maps however, we'll need to look up this map in the menu items (game resource) data store
			// for the friendly name because there isn't any loc section to look in for a map (no class)
			UDataStoreClient* DSClient = UUIInteraction::GetDataStoreClient();
			if ( DSClient != NULL )
			{
				UUDKUIDataStore_MenuItems* ResourceDataStore = Cast<UUDKUIDataStore_MenuItems>(DSClient->FindDataStore(TEXT("UTMenuItems")));
				if ( ResourceDataStore != NULL )
				{
					INT ProviderIndex = ResourceDataStore->FindValueInProviderSet(MapTag, TEXT("MapName"), ActualMapName.StringValue);
					if ( ProviderIndex != INDEX_NONE )
					{
						if ( ResourceDataStore->GetValueFromProviderSet(MapTag, TEXT("FriendlyName"), ProviderIndex, out_FieldValue.StringValue) )
						{
							out_FieldValue.PropertyTag = MapNameTag;
							out_FieldValue.PropertyType = DATATYPE_Property;
							bResult = TRUE;
						}
					}
				}
			}

			if ( !bResult && ActualMapName.StringValue.Len() > 0 )
			{
				out_FieldValue = ActualMapName;
				out_FieldValue.PropertyTag = MapNameTag;
				bResult = TRUE;
			}
		}
	}
	else if ( FieldName == TEXT("OwningPlayerName") )
	{
		FUIProviderFieldValue PlayerName(EC_EventParm);
		FString FinalName;

		// Get the player's name first
		if(Super::GetFieldValue(TEXT("OwningPlayerName"), PlayerName, ArrayIndex))
		{
			FinalName = PlayerName.StringValue;

			// See if we should append a server description.
			FUIProviderFieldValue ServerDescription(EC_EventParm);
			if(Super::GetFieldValue(TEXT("ServerDescription"), ServerDescription, ArrayIndex))
			{
				FString DescStr = ServerDescription.StringValue.Trim().TrimTrailing();
				if(DescStr.Len())
				{
					FinalName += TEXT(": ");
					FinalName += DescStr;
				}
			}

			out_FieldValue.PropertyTag = *FieldName;
			out_FieldValue.StringValue = FinalName;
			bResult = TRUE;
		}
	}
	else
	{
		bResult = Super::GetFieldValue(FieldName, out_FieldValue, ArrayIndex);
	}

	return bResult;
}
*/

//////////////////////////////////////////////////////////////////////////
// UUDKDataStore_GameSearchBase
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKDataStore_GameSearchBase);

/**
 * Loads and creates an instance of the registered filter object
 */
void UUDKDataStore_GameSearchBase::InitializeDataStore(void)
{
	Super::InitializeDataStore();

	// Create server details object
	ServerDetailsProvider = ConstructObject<UUDKUIDataProvider_ServerDetails>(UUDKUIDataProvider_ServerDetails::StaticClass(), this);
}

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataProvider_ServerDetails
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataProvider_ServerDetails);

/**
 * Determines whether the specified field should be included when the user requests to see a list of this server's details.
 */
UBOOL UUDKUIDataProvider_ServerDetails::ShouldDisplayField( FName FieldName )
{
	static TLookupMap<FName> FieldsToHide;
	if ( FieldsToHide.Num() == 0 )
	{
		FieldsToHide.AddItem(FName(TEXT("MaxPlayers"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("MinNetPlayers"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bShouldAdvertise"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bIsLanMatch"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bAllowJoinInProgress"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bAllowInvites"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bUsesPresence"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bUsesStats"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bAllowJoinViaPresence"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bUsesArbitration"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bAntiCheatProtected"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("bIsListPlay"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("Campaign"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("CustomMapName"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("CustomGameMode"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("CustomMutators"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("GameMode"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("ServerDescription"),FNAME_Find));

		// these are the fields that are shown in the main server browser list
		FieldsToHide.AddItem(FName(TEXT("ServerFlags")));
		FieldsToHide.AddItem(FName(TEXT("OwningPlayerName"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("PingInMs"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("OfficialMutators"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("PlayerRatio"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("NumOpenPrivateConnections"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("NumOpenPublicConnections"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("NumPublicConnections"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("NumPrivateConnections"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("MapName"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("PureServer"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("LockedServer"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("IsFullServer"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("IsEmptyServer"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("AllowKeyboard"),FNAME_Find));
		FieldsToHide.AddItem(FName(TEXT("IsDedicated"),FNAME_Find));
	}

	return !FieldsToHide.HasKey(FieldName);
}

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataStore_MenuItems
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataStore_MenuItems);

void UUDKUIDataStore_MenuItems::GetAllResourceDataProviders(UClass* ProviderClass, TArray<UUDKUIResourceDataProvider*>& Providers)
{
	checkSlow(ProviderClass->IsChildOf(UUDKUIResourceDataProvider::StaticClass()));

	// Get a list of ini files from disk.
	TArray<FString> ConfigFileNamesFromDisk;
	GFileManager->FindFiles(ConfigFileNamesFromDisk, *(appGameConfigDir() + TEXT("*.ini")), TRUE, FALSE);

	// Get a list of ini files in memory.  Things like e.g. DLC that were merged at startup
	// will be in memory but not in the config dir.
	TArray<FFilename> ConfigFileNamesInMemory;
	GConfig->GetConfigFilenames( ConfigFileNamesInMemory );

	// Merge the two lists so that providers declared in inis in both lists don't get double-added to the menus.
	TArray<FString> ConfigFileNames;
	for (INT i = 0; i < ConfigFileNamesFromDisk.Num(); i++)	
	{
		ConfigFileNames.AddUniqueItem(ConfigFileNamesFromDisk(i));
	}
	for (INT i = 0; i < ConfigFileNamesInMemory.Num(); i++)	
	{
		// There may be loc files in memory -- we don't want these.
		if ( ConfigFileNamesInMemory(i).GetExtension() == TEXT("ini") )
		{
			ConfigFileNames.AddUniqueItem(ConfigFileNamesInMemory(i).GetCleanFilename());
		}
	}

	for (INT i = 0; i < ConfigFileNames.Num(); i++)
	{
		UBOOL bSimmobileConfig = ConfigFileNames(i).InStr(SIMMOBILE_INI_PREFIX) != INDEX_NONE;
		// ignore default .inis
		if ((appStricmp(*ConfigFileNames(i).Left(7), TEXT("Default")) != 0) && (!bSimmobileConfig))
		{
			FString FullConfigPath = appGameConfigDir() + ConfigFileNames(i);
			TArray<FString> GameTypeResourceSectionNames;
			if (GConfig->GetPerObjectConfigSections(*FullConfigPath, *ProviderClass->GetName(), GameTypeResourceSectionNames) )
			{
				for (INT SectionIndex = 0; SectionIndex < GameTypeResourceSectionNames.Num(); SectionIndex++)
				{
					INT POCDelimiterPosition = GameTypeResourceSectionNames(SectionIndex).InStr(TEXT(" "));
					// we shouldn't be here if the name was included in the list
					checkSlow(POCDelimiterPosition != INDEX_NONE);

					FName ObjectName = *GameTypeResourceSectionNames(SectionIndex).Left(POCDelimiterPosition);
					if (ObjectName != NAME_None)
					{
						UBOOL bLoadDataProvider = TRUE;

						// if map, make sure it exists
						if ( ProviderClass == MapInfoDataProviderClass )
						{
							FString PackageFileName;
							bLoadDataProvider = GPackageFileCache->FindPackageFile(*ObjectName.ToString(), NULL, PackageFileName);
						}
						
						if ( bLoadDataProvider )
						{
							//@note: names must be unique across all .ini files
							UUDKUIResourceDataProvider* NewProvider = Cast<UUDKUIResourceDataProvider>(StaticFindObject(ProviderClass, ANY_PACKAGE, *ObjectName.ToString(), TRUE));
							if (NewProvider == NULL)
							{
								NewProvider = ConstructObject<UUDKUIResourceDataProvider>(ProviderClass, IsTemplate() ? (UObject*)GetTransientPackage() : this, ObjectName);
								if (NewProvider != NULL)
								{
									// load the config and localized values from the current .ini name
									NewProvider->IniName = *FFilename(ConfigFileNames(i)).GetBaseFilename();
									NewProvider->LoadConfig(NULL, *FullConfigPath);
									LoadLocalizedStruct( ProviderClass, *NewProvider->IniName,
														*(ObjectName.ToString() + TEXT(" ") + ProviderClass->GetName()), NULL, NewProvider, (BYTE*)NewProvider );
								}
							}

							if (NewProvider != NULL)
							{
								Providers.AddItem(NewProvider);
							}
						}
					}
				}
			}
		}
	}

	if ( ProviderClass == MapInfoDataProviderClass )
	{
		// also look for packages with UDK extensions, and add them if not already
		const TArray<FString> FilesInPath( GPackageFileCache->GetPackageFileList() );
		if( FilesInPath.Num() > 0 )
		{
			// Iterate over all files looking for maps.
			for( INT FileIndex = 0 ; FileIndex < FilesInPath.Num() ; ++FileIndex )
			{
				const FFilename& FileName = FilesInPath(FileIndex);
				if ( FileName.GetExtension() == TEXT("UDK") )
				{
					const FString MapName = FileName.GetBaseFilename();

					if ( MapName != TEXT("EnvyEntry") && MapName != TEXT("UDKFrontEndMap"))
					{
				        // The 'FriendlyName' is the name that will be displayed in the menus.
				        // Strip the gametype from the front (e.g. 'DM-Blah' becomes 'Blah').
				        FString FriendlyName = MapName;
				        FString MapPrefix;
				        const INT DashPos = FriendlyName.InStr( TEXT("-") );
				        if (DashPos != -1)
				        {
					        MapPrefix = FriendlyName.Left( DashPos );
					        FriendlyName = FriendlyName.Right( (FriendlyName.Len() - DashPos) - 1);
				        }

						INT ProviderIndex;

						// Now add the map to the data provider
						UUDKUIResourceDataProvider* ExistingProvider = Cast<UUDKUIResourceDataProvider>(StaticFindObject(ProviderClass, ANY_PACKAGE, *MapName, TRUE));
						if (ExistingProvider == NULL)
						{
							UUDKUIDataProvider_MapInfo* NewProvider = Cast<UUDKUIDataProvider_MapInfo>(StaticFindObject(ProviderClass, ANY_PACKAGE, *MapName, TRUE));
							if ( NewProvider == NULL )
							{
								NewProvider = ConstructObject<UUDKUIDataProvider_MapInfo>(ProviderClass, IsTemplate() ? (UObject*)GetTransientPackage() : this, FName(*MapName));
								if (NewProvider != NULL)
								{
									// load the config and localized values from the current .ini name
									NewProvider->MapName = MapName;
									NewProvider->FriendlyName = FriendlyName;
									Providers.AddItem(NewProvider);
								}
							}
						}
						else if( !Providers.FindItem(ExistingProvider, ProviderIndex) )
						{
							Providers.AddItem(ExistingProvider);
						}
					}
				}	
			}
		}
	}
}



/**
 * Finds or creates the UIResourceDataProvider instances referenced by ElementProviderTypes, and stores the result
 * into the ListElementProvider map.
 */
void UUDKUIDataStore_MenuItems::InitializeListElementProviders()
{
	ListElementProviders.Empty();

	// for each configured provider type, retrieve the list of ini sections that contain data for that provider class
	for ( INT ProviderTypeIndex = 0; ProviderTypeIndex < ElementProviderTypes.Num(); ProviderTypeIndex++ )
	{
		FGameResourceDataProvider& ProviderType = ElementProviderTypes(ProviderTypeIndex);

		UClass* ProviderClass = ProviderType.ProviderClass;

#if !CONSOLE
		if (ProviderClass->IsChildOf(UUDKUIResourceDataProvider::StaticClass()) && ProviderClass->GetDefaultObject<UUDKUIResourceDataProvider>()->bSearchAllInis)
		{
			// search all .ini files for instances to create
			TArray<UUDKUIResourceDataProvider*> Providers;
			GetAllResourceDataProviders(ProviderClass, Providers);
			for (INT i = 0; i < Providers.Num(); i++)
			{
				ListElementProviders.Add(ProviderType.ProviderTag, Providers(i));
			}
		}
		else
#endif
		{
			// use default method of only searching the class's .ini file
			TArray<FString> GameTypeResourceSectionNames;
			if ( GConfig->GetPerObjectConfigSections(*ProviderClass->GetConfigName(), *ProviderClass->GetName(), GameTypeResourceSectionNames) )
			{
				for ( INT SectionIndex = 0; SectionIndex < GameTypeResourceSectionNames.Num(); SectionIndex++ )
				{
					INT POCDelimiterPosition = GameTypeResourceSectionNames(SectionIndex).InStr(TEXT(" "));
					// we shouldn't be here if the name was included in the list
					check(POCDelimiterPosition!=INDEX_NONE);

					FName ObjectName = *GameTypeResourceSectionNames(SectionIndex).Left(POCDelimiterPosition);
					if ( ObjectName != NAME_None )
					{
						UUIResourceDataProvider* Provider = Cast<UUIResourceDataProvider>( StaticFindObject(ProviderClass, ANY_PACKAGE, *ObjectName.ToString(), TRUE) );
						if ( Provider == NULL )
						{
							Provider = ConstructObject<UUIResourceDataProvider>(
								ProviderClass,
								this,
								ObjectName
							);
						}

						if ( Provider != NULL )
						{
							ListElementProviders.Add(ProviderType.ProviderTag, Provider);
						}
					}
				}
			}
		}
	}

	eventInitializeListElementProviders();

	SortRelevantProviders();
}

/**
  * Remove key from ListElementProviders multimap
  */
void UUDKUIDataStore_MenuItems::RemoveListElementProvidersKey(FName KeyName)
{
	ListElementProviders.RemoveKey(KeyName);
}

/**
  * Add to ListElementProviders multimap
  */
void UUDKUIDataStore_MenuItems::AddListElementProvidersKey(FName KeyName, UUDKUIResourceDataProvider* Provider)
{
	ListElementProviders.Add(KeyName, Provider);
}


IMPLEMENT_COMPARE_CONSTPOINTER(UUDKUIResourceDataProvider,UI_DataStores, {
	INT Result = 0;
	if ( A && B )
	{
		Result = appStricmp(*A->FriendlyName, *B->FriendlyName);
	}

	return Result;
})

/**
 * Sorts the list of map and mutator data providers according to whether they're official or not, then alphabetically.
 */
void UUDKUIDataStore_MenuItems::SortRelevantProviders()
{
	FName MapsName(TEXT("Maps"));
	// sort the maps
	TArray<UUDKUIResourceDataProvider*> MapProviders;
	ListElementProviders.MultiFind(MapsName, (TArray<UUIResourceDataProvider*>&)MapProviders);
	for ( INT ProviderIndex = 0; ProviderIndex < MapProviders.Num(); ProviderIndex++ )
	{
		UUDKUIResourceDataProvider* Provider = MapProviders(ProviderIndex);
	}

	Sort<USE_COMPARE_CONSTPOINTER(UUDKUIResourceDataProvider,UI_DataStores)>( &MapProviders(0), MapProviders.Num() );

	// now re-add the maps in reverse order so that calls to MultiFind will return them in the right order
	ListElementProviders.RemoveKey(MapsName);
	for ( INT ProviderIndex = MapProviders.Num() - 1; ProviderIndex >= 0; ProviderIndex-- )
	{
		ListElementProviders.Add(MapsName, MapProviders(ProviderIndex));
	}

	// now sort the mutator providers
	FName MutatorsName(TEXT("Mutators"));
	TArray<UUDKUIResourceDataProvider*> MutatorProviders;
	ListElementProviders.MultiFind(MutatorsName, (TArray<UUIResourceDataProvider*>&)MutatorProviders);

	Sort<USE_COMPARE_CONSTPOINTER(UUDKUIResourceDataProvider,UI_DataStores)>( &MutatorProviders(0), MutatorProviders.Num() );

	// now re-add the mutators in reverse order so that calls to MultiFind will return them in the right order
	ListElementProviders.RemoveKey(MutatorsName);
	for ( INT ProviderIndex = MutatorProviders.Num() - 1; ProviderIndex >= 0; ProviderIndex-- )
	{
		ListElementProviders.Add(MutatorsName, MutatorProviders(ProviderIndex));
	}
}

/** 
 * Attempts to retrieve all providers with the specified provider field name.
 *
 * @param ProviderFieldName		Name of the provider set to search for
 * @param OutProviders			A set of providers with the given name
 * 
 * @return	TRUE if the set was found, FALSE otherwise.
 */
UBOOL UUDKUIDataStore_MenuItems::GetProviderSet(FName ProviderFieldName,TArray<class UUDKUIResourceDataProvider*>& OutProviders)
{
	OutProviders.Empty();
	
	TArray<UUIResourceDataProvider*> Providers;
	ListElementProviders.MultiFind(ProviderFieldName, Providers);
	for ( INT ProviderIndex = 0; ProviderIndex < Providers.Num(); ProviderIndex++ )
	{
		UUDKUIResourceDataProvider* DataProvider = Cast<UUDKUIResourceDataProvider>(Providers(ProviderIndex));

		if(DataProvider!=NULL)
		{
			OutProviders.AddUniqueItem(DataProvider);
		}
	}

	return (OutProviders.Num()>0);
}

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataStore_Options
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataStore_Options);


/**
 * Called when this data store is added to the data store manager's list of active data stores.
 *
 * Initializes the ListElementProviders map
 *
 * @param	PlayerOwner		the player that will be associated with this DataStore.  Only relevant if this data store is
 *							associated with a particular player; NULL if this is a global data store.
 */
void UUDKUIDataStore_Options::OnRegister( ULocalPlayer* PlayerOwner )
{
	Super::OnRegister(PlayerOwner);

	// Initialize all of the option providers, go backwards because of the way MultiMap appends items.
	TArray<UUIResourceDataProvider*> Providers;
	ListElementProviders.MultiFind(TEXT("OptionSets"), Providers);

	for ( INT ProviderIndex = Providers.Num()-1; ProviderIndex >= 0; ProviderIndex-- )
	{
		UUDKUIDataProvider_MenuOption* DataProvider = Cast<UUDKUIDataProvider_MenuOption>(Providers(ProviderIndex));
		if(DataProvider)
		{
			for (INT OptionIndex=0;OptionIndex<DataProvider->OptionSet.Num();OptionIndex++)
			{
				OptionProviders.Add(DataProvider->OptionSet(OptionIndex), DataProvider);
			}
		}
	}
}

//////////////////////////////////////////////////////////////////////////
// UUDKDataStore_StringList
//////////////////////////////////////////////////////////////////////////

IMPLEMENT_CLASS(UUDKUIDataStore_StringList);

/**
 * @param FieldName		Name of the String List to find
 * @return the index of a string list
 */

INT UUDKUIDataStore_StringList::GetFieldIndex(FName FieldName)
{
	INT Result = INDEX_NONE;
	for (INT i=0;i<StringData.Num();i++)
	{
		if (StringData(i).Tag == FieldName)
		{
			Result = i;
			break;
		}
	}
	return Result;
}


/**
 * Remove a string from the list
 *
 * @Param FieldName		The string list to work on
 * @Param StringToRemove 	The string to remove
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */

void UUDKUIDataStore_StringList::RemoveStr(FName FieldName, const FString &StringToRemove, UBOOL bBatchOp/*=FALSE*/)
{
	INT FieldIndex = GetFieldIndex(FieldName);
	if ( StringData.IsValidIndex(FieldIndex) )
	{
		StringData(FieldIndex).Strings.RemoveItem(StringToRemove);
	}

	if ( !bBatchOp )
	{
		eventRefreshSubscribers(FieldName);
	}
}

/**
 * Remove a string (or multiple strings) by the index.
 *
 * @Param FieldName		The string list to work on
 * @Param Index			The index to remove
 * @Param Count			<Optional> # of strings to remove
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */

void UUDKUIDataStore_StringList::RemoveStrByIndex(FName FieldName, INT Index, INT Count, UBOOL bBatchOp/*=FALSE*/)
{
	INT FieldIndex = GetFieldIndex(FieldName);
	if (StringData.IsValidIndex(FieldIndex)
	&&	StringData(FieldIndex).Strings.IsValidIndex(Index))
	{
		StringData(FieldIndex).Strings.Remove(Index, Count);
	}
	if ( !bBatchOp )
	{
		eventRefreshSubscribers(FieldName);
	}
}

/**
 * Empty a string List
 *
 * @Param FieldName		The string list to work on
 * @param bBatchOp		if TRUE, doesn't call RefreshSubscribers()
 */

void UUDKUIDataStore_StringList::Empty(FName FieldName, UBOOL bBatchOp/*=FALSE*/)
{
	INT FieldIndex = GetFieldIndex(FieldName);
	if ( StringData.IsValidIndex(FieldIndex) )
	{
		StringData(FieldIndex).Strings.Empty();
	}

	if ( !bBatchOp )
	{
		eventRefreshSubscribers(FieldName);
	}
}

/**
 * Finds a string in the list
 *
 * @Param FieldName		The string list to add the new string to
 * @Param SearchStr		The string to find
 *
 * @returns the index in the list or INVALIDFIELD
 */

INT UUDKUIDataStore_StringList::FindStr(FName FieldName, const FString &SearchString)
{
	INT Result = UCONST_INVALIDFIELD;

	const INT FieldIndex = GetFieldIndex(FieldName);
	if ( StringData.IsValidIndex(FieldIndex) )
	{	
		Result = StringData(FieldIndex).Strings.FindItemIndex(SearchString);
	}

	return Result;
}

/**
 * Returns the a string by the index
 *
 * @Param FieldName		The string list to add the new string to
 * @Param StrIndex		The index of the string to get
 *
 * @returns the string.
 */

FString UUDKUIDataStore_StringList::GetStr(FName FieldName, INT StrIndex)
{
	FString Result;

	const INT FieldIndex = GetFieldIndex(FieldName);
	if (StringData.IsValidIndex(FieldIndex)
	&&	StringData(FieldIndex).Strings.IsValidIndex(StrIndex))
	{	
		Result = StringData(FieldIndex).Strings(StrIndex);
	}

	return Result;
}
//////////////////////////////////////////////////////////////////////////
// UUDKUIDataProvider_StringArray
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataProvider_StringArray)

//////////////////////////////////////////////////////////////////////////
// UUDKUIDataProvider_SimpleElementProvider
//////////////////////////////////////////////////////////////////////////
IMPLEMENT_CLASS(UUDKUIDataProvider_SimpleElementProvider)

/* 
 * Given a string containing some amount of time in seconds, 
 * convert to a string of the form HHHH:MM:SS 
 */
FString ConvertSecondsToFormattedString(const FString& SecondsString)
{
	INT Hours = 0;
	INT Minutes = 0;
	INT SecondsToConvert = Clamp(appAtoi(*SecondsString), 0, 9999 * 3600 + 59 * 60 + 59); //Clamp to 9999:59:59

	if (SecondsToConvert > 0)
	{
		//Slice up the seconds
		Hours = SecondsToConvert / 3600;
		SecondsToConvert = SecondsToConvert % 3600;
		if (SecondsToConvert > 0)
		{
			Minutes = SecondsToConvert / 60;
			SecondsToConvert = SecondsToConvert % 60;
		}
	}
	   
	//debugf(TEXT("Converted %s to %s"), *SecondsString, *FString::Printf(TEXT("%02d:%02d:%02d"), Hours, Minutes, SecondsToConvert));
	return FString::Printf(TEXT("%02d:%02d:%02d"), Hours, Minutes, SecondsToConvert);
}


