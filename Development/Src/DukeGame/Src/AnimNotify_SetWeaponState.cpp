// AnimNotify_SetWeaponState.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(UAnimNotify_SetWeaponState)

void UAnimNotify_SetWeaponState::Notify( class UAnimNodeSequence* NodeSeq )
{
	ADukeWeapon* weapon = Cast<ADukeWeapon>(NodeSeq->SkelComponent->GetOwner());
	if( weapon )
	{
		if( !GWorld->HasBegunPlay() )
		{
			debugf( NAME_Log, TEXT("Editor: skipping AnimNotify_CameraEffect %s"), *GetName() );
			return;
		}

		weapon->weaponState = WEAPON_STATE_IDLE;
	}
}