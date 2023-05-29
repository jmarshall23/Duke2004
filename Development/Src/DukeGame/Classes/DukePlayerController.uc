class DukePlayerController extends GamePlayerController
	config(Game);

enum EWeaponHand
{
	HAND_Right,
	HAND_Left,
	HAND_Centered,
	HAND_Hidden,
};

var globalconfig EWeaponHand WeaponHandPreference;
var EWeaponHand	WeaponHand;

/** current offsets applied to the camera due to camera anims, etc */
var vector ShakeOffset; // current magnitude to offset camera position from shake
var rotator ShakeRot; // current magnitude to offset camera rotation from shake