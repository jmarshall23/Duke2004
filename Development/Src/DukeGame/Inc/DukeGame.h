// DukeGame.h
//

#pragma once

#include "Engine.h"
#include "EngineAnimClasses.h"
#include "GameFramework.h"
#include "DukeGameClasses.h"

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

