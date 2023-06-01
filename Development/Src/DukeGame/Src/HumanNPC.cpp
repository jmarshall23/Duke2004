// HumanNPC.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(AHumanNPC)

void AHumanNPC::PostBeginPlay()
{
	USkeletalMeshComponent *skelMesh;

	Super::PostBeginPlay();

	skelMesh = Cast<USkeletalMeshComponent>(Mesh);
	if(skelMesh != NULL)
	{
		State_Idle();
	}
}

void AHumanNPC::State_Idle()
{

}