/**
 * Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 */
class ExampleGameInfo extends FrameworkGame;

auto State PendingMatch
{
Begin:
	StartMatch();
}

defaultproperties
{
	HUDType=class'GameFramework.MobileHUD'
	PlayerControllerClass=class'ExampleGame.ExamplePlayerController'
	DefaultPawnClass=class'ExampleGame.ExamplePawn'
	bDelayedStart=false
}


