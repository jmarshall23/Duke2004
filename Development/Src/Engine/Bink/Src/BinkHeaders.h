/*=============================================================================
	BinkHeaders.h: Bink specific include headers
	Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
=============================================================================*/

#ifndef HEADERS_BINK_H
#define HEADERS_BINK_H

#if EPIC_INTERNAL && !CONSOLE && !IS_USING_BINK2
#define BINKUDK 1
#endif

#if SUPPORTS_PRAGMA_PACK
#pragma pack (push,8)
#endif
#define RAD_NO_LOWERCASE_TYPES

// When compiling UDK for consoles, don't use special UDK Bink version (we don't have any).
#if CONSOLE && UDK
	#undef UDK
	#define UDK 0
	#define UDK_Prev 1
#else
	#define UDK_Prev 0
#endif

#include "bink.h"

#if CONSOLE && UDK_Prev
	#undef UDK
	#define UDK 1
#endif
#undef UDK_Prev

#include "BinkTextures.h"
#if SUPPORTS_PRAGMA_PACK
#pragma pack (pop)
#endif

#endif //HEADERS_BINK_H




