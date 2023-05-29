/*=============================================================================
 	UnAsyncLoadingAndroid.cpp: Unreal async loading code, Android implementation.
 	Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
 =============================================================================*/

#include "CorePrivate.h"

#if ANDROID

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <pwd.h>
#include <errno.h>
#include <fcntl.h>
#include <dirent.h>
#include "FTableOfContents.h"
#include "FFileManagerGeneric.h"
#include "AsyncLoadingAndroid.h"
#include "FFileManagerAndroid.h"

/*-----------------------------------------------------------------------------
 Async loading stats.
 -----------------------------------------------------------------------------*/

DECLARE_FLOAT_ACCUMULATOR_STAT(TEXT("Platform read time"),STAT_AsyncIO_PlatformReadTime,STATGROUP_AsyncIO);


/*-----------------------------------------------------------------------------
 FAsyncIOSystemAndroid implementation.
 -----------------------------------------------------------------------------*/

/** 
 * Reads passed in number of bytes from passed in file handle.
 *
 * @param	FileHandle	Handle of file to read from.
 * @param	Offset		Offset in bytes from start, INDEX_NONE if file pointer shouldn't be changed
 * @param	Size		Size in bytes to read at current position from passed in file handle
 * @param	Dest		Pointer to data to read into
 *
 * @return	TRUE if read was successful, FALSE otherwise
 */
UBOOL FAsyncIOSystemAndroid::PlatformRead( FAsyncIOHandle FileHandle, INT Offset, INT Size, void* Dest )
{
	ssize_t BytesRead = 0;
	UBOOL bSeekFailed = FALSE;
	UBOOL bReadFailed = FALSE;
	{
		SCOPED_FILE_IO_ASYNC_READ_STATS(FileHandle.StatsHandle,Size,Offset);		
		if (FileHandle.Handle != NULL)
		{
			const int Handle = (int) ((PTRINT) FileHandle.Handle);
			if( Offset != INDEX_NONE )
			{
				bSeekFailed = lseek( Handle, Offset + FileHandle.FileOffset, SEEK_SET ) == -1;
			}
			if( !bSeekFailed )
			{
				BytesRead = read( Handle, Dest, Size );
			}
		}
	}
	return BytesRead == ((ssize_t) Size);
}

/** 
 * Creates a file handle for the passed in file name
 *
 * @param	Filename	Pathname to file
 *
 * @return	INVALID_HANDLE if failure, handle on success
 */
FAsyncIOHandle FAsyncIOSystemAndroid::PlatformCreateHandle( const TCHAR* Filename )
{
	FAsyncIOHandle FileHandle;
	int Handle = -1;
	SQWORD FileLength = 0;

	// We know the Android File Manager is being used
	FFileManagerAndroid* AndroidFileManager = static_cast<FFileManagerAndroid*>(GFileManager);

	// make sure the file is cached to the phone
	FFileManagerAndroid::VerifyFileIsLocal(Filename);
	
	// first look in the User Directory (look in FFileManagerUnix.cpp)
	FString AbsPath = GFileManager->ConvertAbsolutePathToUserPath(*GFileManager->ConvertToAbsolutePath( Filename ));
	Handle = AndroidFileManager->GetFileHandle(*AbsPath, FileHandle.FileOffset, FileLength);

	// if that failed, then look in install dir
	if (Handle == -1)
	{
		FString AbsPath = GFileManager->ConvertToAbsolutePath( Filename );
		Handle = AndroidFileManager->GetFileHandle(*AbsPath, FileHandle.FileOffset, FileLength);
	}
	
	// seek to proper offset
	::lseek(Handle, FileHandle.FileOffset, SEEK_SET);

	FileHandle.Handle = (void *) ((PTRINT) Handle);
	FileHandle.StatsHandle	= FILE_IO_STATS_GET_HANDLE( Filename );
	return FileHandle;
}

/**
 * Closes passed in file handle.
 */
void FAsyncIOSystemAndroid::PlatformDestroyHandle( FAsyncIOHandle FileHandle )
{
	FILE_IO_STATS_CLOSE_HANDLE( FileHandle.StatsHandle );
	const int Handle = (int) ((PTRINT) FileHandle.Handle);
	close(Handle);
}

/**
 * Returns whether the passed in handle is valid or not.
 *
 * @param	FileHandle	File hande to check validity
 *
 * @return	TRUE if file handle is valid, FALSE otherwise
 */
UBOOL FAsyncIOSystemAndroid::PlatformIsHandleValid( FAsyncIOHandle FileHandle )
{
	const int Handle = (int) ((PTRINT) FileHandle.Handle);
	return Handle != -1;
}

/** 
 * Reads passed in number of bytes from passed in file handle.
 *
 * @param	FileHandle	Handle of file to read from.
 * @param	Offset		Offset in bytes from start, INDEX_NONE if file pointer shouldn't be changed
 * @param	Size		Size in bytes to read at current position from passed in file handle
 * @param	Dest		Pointer to data to read into
 *
 * @return	TRUE if read was successful, FALSE otherwise
 */
UBOOL FAsyncIOSystemAndroid::PlatformReadDoNotCallDirectly( FAsyncIOHandle FileHandle, INT Offset, INT Size, void* Dest )
{
	ssize_t BytesRead = 0;
	UBOOL bSeekFailed = FALSE;
	UBOOL bReadFailed = FALSE;
	{
		SCOPED_FILE_IO_ASYNC_READ_STATS(FileHandle.StatsHandle,Size,Offset);          
		if (FileHandle.Handle != NULL)
		{
			const int Handle = (int) ((PTRINT) FileHandle.Handle);
			if( Offset != INDEX_NONE )
			{
				bSeekFailed = lseek( Handle, Offset + FileHandle.FileOffset, SEEK_SET ) == -1;
			}
			if( !bSeekFailed )
			{
				BytesRead = read( Handle, Dest, Size );
			}
		}
	}
	return BytesRead == ((ssize_t) Size);
}

#endif

/*----------------------------------------------------------------------------
 End.
 ----------------------------------------------------------------------------*/
