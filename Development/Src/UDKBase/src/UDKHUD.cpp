//=============================================================================
// Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
// Confidential.
//=============================================================================
#include "UDKBase.h"

IMPLEMENT_CLASS(AUDKHUD);

void AUDKHUD::DrawGlowText(const FString &Text, FLOAT X, FLOAT Y, FLOAT MaxHeightInPixels, FLOAT PulseTime, UBOOL bRightJustified)
{
	if ( Canvas && GlowFonts[0] && GlowFonts[1])
	{
		INT XL,YL;
		FLOAT Scale = 1.f;

		Canvas->CurX = 0;
		Canvas->CurY = 0;

		// Size the string
		Canvas->WrappedPrint(FALSE, XL, YL, GlowFonts[0], Scale, Scale, FALSE, *Text, TextRenderInfo);
		FLOAT Width = FLOAT(XL);
		FLOAT Height = FLOAT(YL);

		// Calculate the scaling
		Scale = MaxHeightInPixels / YL;
		Width *= Scale;
		Height *= Scale;

		// Render the string
		X = bRightJustified ? X - Width : X;

		if ( WorldInfo->TimeSeconds - PulseTime < PulseDuration )
		{
			FLOAT PulsePct = (WorldInfo->TimeSeconds - PulseTime)/PulseDuration;
			FLOAT PulseChangeAt = 1.f - PulseSplit;
			FLOAT PulseScale = 1.f;

			if (PulsePct >= PulseChangeAt) // Growing
			{
				PulseScale = 1.f + PulseMultiplier * (1.f - (PulsePct - PulseChangeAt)/PulseSplit);
			}
			else
			{
				PulseScale = 1.f + PulseMultiplier * PulsePct/PulseChangeAt;
			}

			// Glow it up
			Canvas->CurX = X - 0.5f*Width*(PulseScale - 1.f);
			Canvas->CurY = Y - 0.5f*Height*(PulseScale - 1.f);
			Scale *= PulseScale;
			DrawStringZ(Canvas->Canvas, Canvas->OrgX+Canvas->CurX, Canvas->OrgY+Canvas->CurY, Canvas->CurZ, *Text, GlowFonts[1], Canvas->DrawColor, Scale, Scale, 0.f, NULL, SE_BLEND_Translucent, TRUE, 0.f, 1.f, TextRenderInfo);
		}
		else
		{
			// non-glowy
			Canvas->CurX = X;
			Canvas->CurY = Y;
			DrawStringZ(Canvas->Canvas, Canvas->OrgX+Canvas->CurX, Canvas->OrgY+Canvas->CurY, Canvas->CurZ, *Text, GlowFonts[0], Canvas->DrawColor, Scale, Scale, 0.f, NULL, SE_BLEND_Translucent, TRUE, 0.f, 1.f, TextRenderInfo);
		}
	}
}

void AUDKHUD::TranslateBindToFont(const FString& InBindStr, UFont*& DrawFont, FString& OutBindStr)
{
	//Initialize the output
	DrawFont = NULL;
	OutBindStr = TEXT("");

	//Get the console iconfont/char sequence from the binding
	if (InBindStr != "")
	{
		//Search from the end for the start of the font </tag>
		INT RightIndex = InBindStr.InStr("<Fonts:", TRUE, TRUE);
		if (RightIndex >= 0)
		{
			//Search from the front for the end of the font <tag>
			INT FontIndex = InBindStr.InStr("<Fonts:", FALSE, TRUE);
			if (FontIndex >= 0)
			{
				INT LeftIndex = InBindStr.InStr(">", FALSE, TRUE, FontIndex + 7);
				if (LeftIndex >= 0)
				{
					OutBindStr = InBindStr.Mid(LeftIndex+1, RightIndex-LeftIndex-1);
					DrawFont = ConsoleIconFont;
				}
			}
		}
		else
		{
			DrawFont = BindTextFont;
			OutBindStr = InBindStr;
		}
	}
}

void AUDKGameObjective::SetHUDLocation(FVector NewHUDLocation)
{
	HUDLocation = NewHUDLocation;
}

void AUDKGameObjective::DrawIcon(UCanvas *Canvas, FVector IconLocation, FLOAT IconWidth, FLOAT IconAlpha, AUDKPlayerController* PlayerOwner, FLinearColor DrawColor)
{
	FLOAT YoverX = IconCoords.VL/IconCoords.UL;
	Canvas->CurX = IconLocation.X - 0.5f*IconWidth;
	Canvas->CurY = IconLocation.Y - 0.5f*IconWidth * YoverX;
	if ( IconHudTexture )
	{
		Canvas->DrawTile(IconHudTexture, Canvas->OrgX+Canvas->CurX, Canvas->OrgY+Canvas->CurY, Canvas->CurZ, IconWidth, IconWidth * YoverX, IconCoords.U, IconCoords.V, IconCoords.UL, IconCoords.VL,DrawColor);
	}
}

