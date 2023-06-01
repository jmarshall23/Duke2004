class DukeMenuGameInfo extends FrameworkGame
	native;

auto State PendingMatch
{
Begin:
	StartMatch();
}

defaultproperties
{
	HUDType=class'DukeGame.DukeMainMenu'
	PlayerControllerClass=class'DukeGame.DukeMenuController'
	ConsolePlayerControllerClass=class'DukeGame.DukeMenuController'
	bDelayedStart=false
}


