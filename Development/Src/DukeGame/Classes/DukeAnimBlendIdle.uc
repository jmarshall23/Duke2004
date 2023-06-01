// DukeAnimBlendIdle.uc
//

class DukeAnimBlendIdle extends DukeAnimBlendBase
	native(Animation);

cpptext
{
	// AnimNode interface
	virtual	void TickAnim(FLOAT DeltaSeconds);
}

defaultproperties
{
	Children(0)=(Name="Idle",Weight=1.0)
	Children(1)=(Name="Moving")
	bFixNumChildren=true
}
