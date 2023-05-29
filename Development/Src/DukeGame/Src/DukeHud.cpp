// DukeHud.cpp
//


#include "DukeGame.h"

IMPLEMENT_CLASS(ADukeHUD)

void ADukeHUD::HudStartup() 
{

}

void ADukeHUD::DrawScaledTexture(class UTexture* Icon,FLOAT X,FLOAT Y,FVector Scale)
{
	if (Icon != NULL)
	{
		float UL = Icon->GetSurfaceWidth();
		float VL = Icon->GetSurfaceHeight();

		// verify properties are valid
		if (Scale.X == 0 || Scale.Y == 0)
		{
			Scale.X = 1.f;
			Scale.Y = 1.f;
		}

		// set the canvas position
		Canvas->SetPos(X, Y);

		// and draw the texture
		Canvas->DrawTile(Icon, X, Y, 1, Abs(UL) * Scale.X, Abs(VL) * Scale.Y, 0, 0, UL, VL, Canvas->DrawColor, BLEND_Additive);
	}
}

void ADukeHUD::DrawCrosshair()
{
	float XScale;
	float XLength;
	UTexture *T;

	T = CrosshairTextures[11];

	XScale = ::Max( 1, int(0.1 + Canvas->ClipX/640.0) );
	XLength = XScale * T->GetSurfaceWidth();

	Canvas->SetPos(0.5 * (Canvas->ClipX - XLength), 0.5 * (Canvas->ClipY - XLength));

	// UTexture* Tex, FLOAT X, FLOAT Y, FLOAT Z, FLOAT XL, FLOAT YL, FLOAT U, FLOAT V, FLOAT UL, FLOAT VL, const FLinearColor& Color,EBlendMode BlendMode=BLEND_Translucent
	Canvas->DrawTile( T, 0.5 * (Canvas->ClipX - XLength), 0.5 * (Canvas->ClipY - XLength), 1, T->GetSurfaceWidth(), T->GetSurfaceHeight(), 0, 0, 32, 32, FColor(255,255,255), BLEND_Additive );
}

void ADukeHUD::DrawStatusIndex()
{
	// Draw the index background bar.
	Canvas->DrawColor = HUDColor;
	DrawScaledTexture(IndexBarLeftTexture, 0, IndexTop, FVector(HUDScaleX, HUDScaleY, 1));
	DrawScaledTexture(IndexBarRightTexture, 256*HUDScaleX, IndexTop, FVector(HUDScaleX, HUDScaleY, 1));
	Canvas->DrawTile( IndexBarBottomTexture, 0, IndexTop + 128*HUDScaleY, 1, IndexBarBottomTexture->GetSurfaceWidth()*HUDScaleX, 64*HUDScaleY, 0, 0, IndexBarBottomTexture->GetSurfaceWidth(), 64*HUDScaleY, HUDColor, BLEND_Additive );
/*
	C.Style = ERenderStyle.STY_Translucent;
	C.SetPos( 0, IndexTop );
	C.DrawScaledIcon( IndexBarLeftTexture, HUDScaleX, HUDScaleY );
	C.SetPos( 256*HUDScaleX, IndexTop );
	C.DrawScaledIcon( IndexBarRightTexture, HUDScaleX, HUDScaleY );
	C.SetPos( 0, IndexTop + 128*HUDScaleY );
	C.DrawTile( IndexBarBottomTexture, IndexBarBottomTexture.USize*HUDScaleX, 64*HUDScaleY, 0, 0, IndexBarBottomTexture.USize*HUDScaleX, IndexBarBottomTexture.VSize*HUDScaleY );
*/
}

void ADukeHUD::RenderHud()
{	
	// Draw status index.
	DrawStatusIndex();

	// Draw crosshair.
	Canvas->DrawColor = WhiteColor;
	DrawCrosshair();
}