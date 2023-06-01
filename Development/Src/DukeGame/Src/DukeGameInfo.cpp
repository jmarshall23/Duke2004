// DukeGameInfo.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(ADukeMenuGameInfo)
IMPLEMENT_CLASS(ADukeGameInfo)

class UClass* ADukeGameInfo::GetGameType(const FString& MapName,const FString& Options,const FString& Portal)
{
	if(appStrstr(*MapName, TEXT("MainMenu")))
	{
		return ADukeMenuGameInfo::StaticClass();
	}
	return ADukeGameInfo::StaticClass();
}