class DukePawn extends GamePawn
	native
	config(Game);

simulated function float GetEyeHeight()
{
	if ( !IsLocallyControlled() )
		return BaseEyeHeight;
	else
		return EyeHeight;
}

defaultproperties
{
	BaseEyeHeight=38.0
	EyeHeight=38.0
}