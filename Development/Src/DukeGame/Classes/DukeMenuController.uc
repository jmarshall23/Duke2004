// DukeMenuController.uc
//

class DukeMenuController extends PlayerController;

event bool IsMoveInputIgnored()
{
	return true;
}

event bool IsLookInputIgnored()
{
	return true;
}

defaultproperties
{
	bIgnoreMoveInput=true
	bIgnoreLookInput=true
}