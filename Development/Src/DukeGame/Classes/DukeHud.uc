// DukeHud.UC
//

class DukeHUD extends HUD
	native;

// Color customization.
var float Opacity;
var color CrosshairColor;
var color TextColor;
var color HUDColor;

// Crosshair.
var int CrosshairCount;
var texture CrosshairTextures[20];

// Index Items.
// 0 reserved for EGO.
// 1 reserved for Energy.
// 2 reserved for Ammo.
// 3 reserved for AltAmmo.
// 4 reserved for Shield.
// 5 reserved for Oxygen.
// 6 reserved for Vehicle Health.
// 7 reserved for Jetpack.
// 8 reserved for Bomb
// 10 reserved for Cash.
// 11 reserved for Frags or Credits.
var float DesiredIndexTop, RootIndexTop;
var float IndexTop, IndexBottom;
var float IndexAdjust;
var float BarOffset;
var float HUDScale;
var float HUDScaleX;
var float HUDScaleY;
//var HUDIndexItem IndexItems[12];
var int MaxIndexItems;								// Max number of index items.
var int ItemSpace;									// How much space to pad between index items.
var float TextRightAdjust;							// How much to the right to draw the index items.
var float BarPos, BarLeft;
var float TitleLeft, TitleOffset;
var float SlideRate;
var float IndexTopOffset;
var localized string IndexName;
var texture GradientTexture;
var texture IndexBarLeftTexture;
var texture IndexBarRightTexture;
var texture IndexBarBottomTexture;
var texture InventoryBarTopTexture;
var texture InventoryBarBotTexture;
var texture InventoryCatHLTexture;
var texture InventoryCatHLTexture2;
var texture MiscBarTabTexture;
var texture MiscBarHLTexture;
var texture HUDTemplateTexture;
var texture ItemSlantTexture;
var texture ItemSlantHLTexture;
var texture MiscBarTexture;
var texture MiscBarTexture2;
var texture NumberCircleTexture;

native function HudStartup();
native function RenderHud();
native function DrawScaledTexture(texture Icon, float X, float Y, Vector Scale);

cpptext
{
	void DrawStatusIndex();
	void DrawCrosshair();
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

	HudStartup();
}

simulated function SetupScale()
{
	/*
	HUDScaleX		= C.ClipX/1024.0;
	HUDScaleY		= C.ClipY/768.0;
	*/

	// TODO: HUD scaling in settings.
	HUDScaleX		= 1.0 * HUDScale;
	HUDScaleY		= 1.0 * HUDScale;
	BarOffset		= Default.BarOffset * HUDScaleY;
	BarLeft			= Default.BarLeft * HUDScaleX;
	TitleOffset		= Default.TitleOffset * HUDScaleY;
	TitleLeft		= Default.TitleLeft * HUDScaleX;
	ItemSpace		= Default.ItemSpace * HUDScaleY;
	TextRightAdjust	= Default.TextRightAdjust * HUDScaleX;
	SlideRate		= Default.SlideRate * HUDScaleY;
	IndexTopOffset	= Default.IndexTopOffset * HUDScaleY;
	//RootIndexTop	= Default.RootIndexTop * HUDScaleY;
	//RootIndexTop	= C.ClipY * (682.0 / 768.0);
	RootIndexTop 	= Canvas.ClipY - (768.0 - 682.0) * HUDScaleY;
	DesiredIndexTop	= RootIndexTop - IndexAdjust*HUDScaleY;
	IndexTop		= RootIndexTop - IndexAdjust*HUDScaleY;
	BarPos			= (Default.TextRightAdjust+4.0) * HUDScaleX;
//	IndexNameX		= 0;
/*
	VerySmallFont	= MyFonts.GetVerySmallFont(C);
	SmallFont		= MyFonts.GetSmallFont(C);
	MediumFont		= MyFonts.GetMediumFont(C);
	LargeFont		= MyFonts.GetBigFont(C);
	HugeFont		= MyFonts.GetHugeFont(C);
*/
}

simulated event PostRender()
{
	super.PostRender();

	SetupScale();

	RenderHud();
}

defaultproperties
{
	Opacity=0.570000
	TextColor=(R=255,G=255,B=255,A=0)
	HUDColor=(R=40,G=106,B=254,A=0)
	CrosshairColor=(R=0,G=16,B=0,A=0)
    RootIndexTop=682.0
	IndexAdjust=20.0
	BarOffset=0.0
    MaxIndexItems=12
    ItemSpace=5.0
	TextRightAdjust=76.0
    BarLeft=0.000000
    TitleLeft=6.000000
    TitleOffset=18.000000
    SlideRate=400.000000
	HUDScaleX=1.0
	HUDScaleY=1.0
	HUDScale=1.3
	IndexTopOffset=27.0
    IndexName="S.O.S v1"
    GradientTexture=Texture'hud_effects.ing_gradient1BC'
	IndexBarLeftTexture=texture'hud_effects.ingame_main1BC'
	IndexBarRightTexture=texture'hud_effects.ingame_main2BC'
	IndexBarBottomTexture=texture'hud_effects.ingame_main_repeat1bc'
	InventoryBarTopTexture=texture'hud_effects.ingame_wepbar1BC'
	InventoryBarBotTexture=texture'hud_effects.ingame_wepbar2BC'
	MiscBarTabTexture=texture'hud_effects.ingame_rightslant1BC'
	MiscBarHLTexture=texture'hud_effects.ingame_miscbar_alert1'
	InventorySmackTop=smackertexture'hud_effects.ingame_wepbar_topext'
	InventorySmackBot=smackertexture'hud_effects.ingame_wepbar_botext'
	InventoryCatHLTexture=texture'hud_effects.ingame_wepbar_highlight1bc'
	InventoryCatHLTexture2=texture'hud_effects.ingame_wepbar_highlight2bc'
	ItemSlantTexture=texture'hud_effects.ingame_itemslant1bc'
	ItemSlantHLTexture=texture'hud_effects.ingame_itemslant_highlightbc'
	MiscBarTexture=texture'hud_effects.ingame_miscbar1bc'
	MiscBarTexture2=texture'hud_effects.ingame_miscbar2bc'
	NumberCircleTexture=texture'hud_effects.ingame_numbercircleBC'

	CrosshairCount=9
    CrosshairTextures(0)=Texture'hud_effects.crosshair1BC'
    CrosshairTextures(1)=Texture'hud_effects.crosshair2BC'
    CrosshairTextures(2)=Texture'hud_effects.crosshair3BC'
    CrosshairTextures(3)=Texture'hud_effects.crosshair4BC'
    CrosshairTextures(4)=Texture'hud_effects.crosshair5BC'
    CrosshairTextures(5)=Texture'hud_effects.crosshair6BC'
    CrosshairTextures(6)=Texture'hud_effects.crosshair7BC'
    CrosshairTextures(7)=Texture'hud_effects.crosshair8BC'
    CrosshairTextures(8)=Texture'hud_effects.crosshair9BC'
    CrosshairTextures(9)=Texture'hud_effects.crosshair10BC'
    CrosshairTextures(10)=Texture'hud_effects.crosshair11BC'
    CrosshairTextures(11)=Texture'hud_effects.crosshair12BC'
    CrosshairTextures(12)=Texture'hud_effects.crosshair13BC'
    CrosshairTextures(13)=Texture'hud_effects.crosshair14BC'
}