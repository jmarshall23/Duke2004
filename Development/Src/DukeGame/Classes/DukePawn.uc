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

simulated function SetPuttingDownWeapon(bool bNowPuttingDownWeapon)
{

}

native function AddDefaultInventory();

/*
{

	local int i;
	local UTWeaponLocker Locker, BestLocker;
	local float Dist, BestDist;

	// may give the physics gun to non-bots
	if( bGivePhysicsGun && PlayerPawn.IsHumanControlled() )
	{
		PlayerPawn.CreateInventory(class'UTWeap_PhysicsGun',true);
	}
}
*/

defaultproperties
{
	BaseEyeHeight=38.0
	EyeHeight=38.0
	InventoryManagerClass=class'DukeInventoryManager'
}