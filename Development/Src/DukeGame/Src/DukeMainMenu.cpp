// DukeMainMenu.cpp
//

#include "DukeGame.h"

IMPLEMENT_CLASS(ADukeMainMenu)
void ADukeMainMenu::RenderMainMenu()
{
	Canvas->SetPos(0, 0);
	Canvas->SetDrawColor(255, 255, 255);
	Canvas->DrawText(TEXT("The main menu is not implemented yet, please use the console to warp to a level."));
}