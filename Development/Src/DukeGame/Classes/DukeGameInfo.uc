class DukeGameInfo extends FrameworkGame
	native;

auto State PendingMatch
{
Begin:
	StartMatch();
}

static native function class<GameInfo> GetGameType(string MapName, string Options, string Portal);

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return GetGameType(MapName, Options, Portal);
}

defaultproperties
{
	HUDType=class'DukeGame.DukeHud'
	PlayerControllerClass=class'DukeGame.DukePlayerController'
	DefaultPawnClass=class'DukeGame.DukePawn'
	bDelayedStart=false
}


