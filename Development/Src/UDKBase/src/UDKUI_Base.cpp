//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// Confidential.
//
// This holds all of the base UI Objects
//=============================================================================

#include "UDKBase.h"

#include "EngineAudioDeviceClasses.h"

IMPLEMENT_CLASS(UUDKGameInteraction);

/*=========================================================================================
	UUDKGameInteraction - Supports globally blocking UI input.
========================================================================================= */

/**
 * @return Whether or not we should process input.
 */
UBOOL UUDKGameInteraction::ShouldProcessUIInput() const
{
	return BlockUIInputSemaphore == 0;
}

/**
 * Check a key event received by the viewport.
 *
 * @param	Viewport - The viewport which the key event is from.
 * @param	ControllerId - The controller which the key event is from.
 * @param	Key - The name of the key which an event occured for.
 * @param	Event - The type of event which occured.
 * @param	AmountDepressed - For analog keys, the depression percent.
 * @param	bGamepad - input came from gamepad (ie xbox controller)
 *
 * @return	True to consume the key event, FALSE to pass it on.
 */
UBOOL UUDKGameInteraction::InputKey(INT ControllerId,FName Key,EInputEvent Event,FLOAT AmountDepressed/*=1.f*/,UBOOL bGamepad/*=FALSE*/)
{
	UBOOL bResult = FALSE;

	if ( ShouldProcessUIInput() )
	{
#if PS3
		// if we are supposed to swap the accept and cancel keys, do that now
		static UBOOL bUseCircleToAccept = appPS3UseCircleToAccept();
		if ( bUseCircleToAccept )
		{
			if ( Key == KEY_XboxTypeS_A )
			{
				Key = KEY_XboxTypeS_B;
			}
			else if ( Key == KEY_XboxTypeS_B )
			{
				Key = KEY_XboxTypeS_A;
			}
		}
#endif
		bResult = Super::InputKey(ControllerId, Key, Event, AmountDepressed,bGamepad);
	}
	else
	{
		// Always swallow input.
		bResult = TRUE;
	}

	return bResult;
}

/**
 * Check an axis movement received by the viewport.
 *
 * @param	Viewport - The viewport which the axis movement is from.
 * @param	ControllerId - The controller which the axis movement is from.
 * @param	Key - The name of the axis which moved.
 * @param	Delta - The axis movement delta.
 * @param	DeltaTime - The time since the last axis update.
 *
 * @return	True to consume the axis movement, FALSE to pass it on.
 */
UBOOL UUDKGameInteraction::InputAxis(INT ControllerId,FName Key,FLOAT Delta,FLOAT DeltaTime, UBOOL bGamepad)
{
	UBOOL bResult = FALSE;

	if ( ShouldProcessUIInput() )
	{
		bResult = Super::InputAxis(ControllerId, Key, Delta, DeltaTime, bGamepad);
	}
	else
	{
		// Always swallow input.
		bResult = TRUE;
	}

	return bResult;
}

/**
 * Check a character input received by the viewport.
 *
 * @param	Viewport - The viewport which the axis movement is from.
 * @param	ControllerId - The controller which the axis movement is from.
 * @param	Character - The character.
 *
 * @return	True to consume the character, FALSE to pass it on.
 */
UBOOL UUDKGameInteraction::InputChar(INT ControllerId,TCHAR Character)
{
	UBOOL bResult = FALSE;

	if ( ShouldProcessUIInput() )
	{
		bResult = Super::InputChar(ControllerId, Character);
	}
	else
	{
		// Always swallow input.
		bResult = TRUE;
	}

	return bResult;
}

IMPLEMENT_CLASS(UUDKGameSettingsCommon);

/*=========================================================================================
UUDKGameSettingsCommon - Stores common game settings for online games.
========================================================================================= */

/**
 * Converts a string to a hexified blob.
 *
 * @param InString	String to convert.
 * @param OutBlob	Resulting blob.
 *
 * @return	Returns the hexified string.
 */
UBOOL UUDKGameSettingsCommon::StringToBlob(const FString& InString, FString& OutBlob)
{
	BYTE BlobbedString[1024];
	UBOOL bResult = appStringToBlob(InString,BlobbedString,1024);

	INT ExpectedLength = InString.Len() / 3;
	if(bResult)
	{
		// Zero the buffer and treat as if its unicode
		BlobbedString[ExpectedLength] = 0;
		BlobbedString[ExpectedLength + 1] = 0;
		OutBlob = (const TCHAR*)BlobbedString;
	}

	return bResult;
}

/**
 * Converts a hexified blob to a normal string.
 *
 * @param InBlob	String to convert back.
 * @return	Returns the normal string.
 */
FString UUDKGameSettingsCommon::BlobToString(const FString& InBlob)
{
	return appBlobToString((const BYTE*)(*InBlob),sizeof(TCHAR)*InBlob.Len());
}



