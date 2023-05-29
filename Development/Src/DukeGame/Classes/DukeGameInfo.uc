class DukeGameInfo extends FrameworkGame;

auto State PendingMatch
{
Begin:
	StartMatch();
}

defaultproperties
{
	HUDType=class'DukeGame.DukeHud'
	PlayerControllerClass=class'DukeGame.DukePlayerController'
	DefaultPawnClass=class'DukeGame.DukePawn'
	bDelayedStart=false
}


