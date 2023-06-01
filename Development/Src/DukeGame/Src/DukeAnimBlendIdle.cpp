// DukeAnimBlendIdle.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(UDukeAnimBlendIdle);

/**
 * This blend looks at the velocity of the player and blends depending on if they are moving or not
 */
void UDukeAnimBlendIdle::TickAnim(FLOAT DeltaSeconds)
{
	// Get the Pawn Owner
	if (SkelComponent != NULL && SkelComponent->GetOwner() != NULL)
	{
		AActor* Owner = SkelComponent->GetOwner();
		if ( Owner )
		{
			//debugf(TEXT("Velocity %i"), Owner->Velocity.Size() );

			if ( Owner->Velocity.SizeSquared() < KINDA_SMALL_NUMBER )
			{
				if(ActiveChildIndex != 0)
				{
					SetActiveChild(0,BlendTime);
				}
			}
			else
			{
				if(ActiveChildIndex != 1)
				{
					SetActiveChild(1,BlendTime);
				}
			}
		}
	}
	Super::TickAnim(DeltaSeconds);
}