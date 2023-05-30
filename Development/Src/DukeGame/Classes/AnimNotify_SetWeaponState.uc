// AnimNotify_SetWeaponState.uc

class AnimNotify_SetWeaponState extends AnimNotify
	native;

enum EWeaponState
{
	WEAPON_STATE_NONE,
	WEAPON_STATE_IDLE,
	WEAPON_STATE_FIRING,
	WEAPON_STATE_RELOAD
};

var EWeaponState newWeaponState;

cpptext
{
	// AnimNotify interface.
	virtual void Notify( class UAnimNodeSequence* NodeSeq );
	virtual FString GetEditorComment() { return TEXT("WeaponState"); }
}

defaultproperties
{
	newWeaponState=WEAPON_STATE_NONE
}
