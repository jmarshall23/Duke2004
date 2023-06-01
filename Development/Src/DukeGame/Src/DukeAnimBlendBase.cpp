// dnAnimBlendBase.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(UDukeAnimBlendBase);

void UDukeAnimBlendBase::TickAnim(FLOAT DeltaSeconds)
{
	if ( bTickAnimInScript )
	{
		eventTickAnim(DeltaSeconds);
	}
	Super::TickAnim(DeltaSeconds);	// pass along for now until falls anims are separated			
}

void UDukeAnimBlendBase::HandleSliderMove(INT SliderIndex, INT ValueIndex, FLOAT NewSliderValue)
{
	check(0 == SliderIndex && 0 == ValueIndex);
	SliderPosition = NewSliderValue;

	const INT TargetChannel = appRound(SliderPosition*(Children.Num() - 1));
	if( ActiveChildIndex != TargetChannel )
	{
		FLOAT const BlendInTime = GetBlendTime(TargetChannel);
		SetActiveChild(TargetChannel, BlendInTime);
	}
}

FLOAT UDukeAnimBlendBase::GetBlendTime(INT ChildIndex, UBOOL bGetDefault/*=0*/)
{
	if ( bGetDefault || (ChildBlendTimes.Num() == 0) || (ChildIndex < 0) || (ChildIndex >= ChildBlendTimes.Num()) || (ChildBlendTimes(ChildIndex) == 0.0f) )
	{
		return BlendTime;
	}
	else
	{
		return ChildBlendTimes(ChildIndex);
	}
}

FLOAT UDukeAnimBlendBase::GetAnimDuration(INT ChildIndex)
{
	if((ChildIndex >= 0) && (ChildIndex < Children.Num()) && Children(ChildIndex).Anim)
	{
		UAnimNodeSequence* SeqNode = Cast<UAnimNodeSequence>(Children(ChildIndex).Anim);
		if(SeqNode)
		{
			return SeqNode->GetAnimPlaybackLength();
		}
	}

	return 0.f;
}
