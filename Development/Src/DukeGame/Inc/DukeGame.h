// DukeGame.h
//

#pragma once

#include "Engine.h"
#include "EngineAnimClasses.h"
#include "GameFramework.h"
#include "DukeGameClasses.h"
#include "DukeGameAnimationClasses.h"

class DukeMath
{
public:
	static void GetAxes(FRotator A, FVector &X, FVector &Y, FVector &Z)
	{
		FRotationMatrix R(A);
		X = R.GetAxis(0);
		Y = R.GetAxis(1);
		Z = R.GetAxis(2);
	}
};

/** 
 * CalcDist - Takes 2 yaw values A & B and calculates the distance between them. 
 *
 *	@param	YawA	- First Yaw
 *  @param	YawB	- Second Yaw
 *  @param	Dist	- The distance between them is returned here
 *  
 *	@return			- Returns the sign needed to move from A to B
 */
FORCEINLINE INT CalcDist(INT YawA, INT YawB, INT& Dist)
{
	INT Sign = 1;

	Dist = YawA - YawB;
	if ( Abs(Dist) > 32767 )
	{
		if (Dist > 0)
		{
			Sign = -1;
		}
		Dist = Abs( Abs(Dist) - 65536 );
	}
	else
	{
		if (Dist < 0)
		{
			Sign = -1;
		}
	}
	return Sign;
}