//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// Confidential.
//=============================================================================
#include "UDKBase.h"

IMPLEMENT_CLASS(AMobileHUDExt);

void AMobileHUDExt::UpdateBenchmarkInformation()
{
#if ANDROID
	extern EAndroidPerformanceLevel GAndroidPerformanceLevel;
	BenchmarkFeatureLevel = (INT) GAndroidPerformanceLevel;
	extern FLOAT GAndroidResolutionScale;
	BenchmarkResolutionScale = GAndroidResolutionScale;
#endif
}