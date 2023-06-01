// DukeMainMenu.uc
//

class DukeMainMenu extends HUD
	native
	config(Game);

native function RenderMainMenu();

event PostRender()
{
	RenderMainMenu();
}

defaultproperties
{
}