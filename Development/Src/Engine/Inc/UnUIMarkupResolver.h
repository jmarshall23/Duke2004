/*=============================================================================
	UnUIMarkupResolver.h: Data store markup resolver classes.
	Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
=============================================================================*/

#ifndef __UNUIMARKUPRESOLVER_H__
#define __UNUIMARKUPRESOLVER_H__

#ifndef	MARKUP_BEGIN_CHAR
	// the character that begins standard markup blocks; these blocks will not be processed if the string
	// is configured to ignore markup
	#define	MARKUP_BEGIN_CHAR	TCHAR('<')
#endif
#ifndef MARKUP_END_CHAR
	// the character that marks the end of a markup block; these blocks will not be processed if the string
	// is configured to ignore markup
	#define	MARKUP_END_CHAR		TCHAR('>')
#endif

#ifndef SYSTEM_MARKUP_BEGIN_CHAR
	// represents the start of a markup block generated by the system; these markup blocks will always be processed
	// resolved, regardless of whether the string is configured to process markup or not
	#define SYSTEM_MARKUP_BEGIN_CHAR	TCHAR('')	// STX (ANSI 002 - Start of Text)
#endif
#ifndef SYSTEM_MARKUP_END_CHAR
	// represents the start of a markup block generated by the system; these markup blocks will always be processed
	// resolved, regardless of whether the string is configured to process markup or not
	#define SYSTEM_MARKUP_END_CHAR		TCHAR('')	// ETX (ANSI 003 - End of Text)
#endif

/**
 * Represents a single chunk of text, either normal text or a markup value
 */
struct FTextChunk
{
	/** Virtual destructor */
	virtual ~FTextChunk() {}

	/** the text that this text chunk processed...filled by calling ProcessChunk */
	FString ChunkValue;

	/**
	 * Searches for the character specified in the text, respecting escaped characters
	 *
	 * @param	SearchText			the text to search
	 * @param	CharToSearchFor		the character to look for
	 *
	 * @return	a pointer to the first occurrence in SearchText of the specified character
	 */
	static const TCHAR* FindCharacterPos( const TCHAR* SearchText, const TCHAR CharToSearchFor )
	{
		if ( SearchText )
		{
			UBOOL bEscaped = FALSE;
			while ( *SearchText )
			{
				if ( bEscaped )
				{
					bEscaped = FALSE;
				}
				else if ( *SearchText == TCHAR('\\') )
				{
					bEscaped = TRUE;
				}
				else if ( *SearchText == CharToSearchFor )
				{
					return SearchText;
				}

				SearchText++;
			}
		}

		return NULL;
	}

	/**
	 * Finds the first markup character within InputText.
	 *
	 * @param	InputText			the text to search
	 * @param	bSystemMarkupOnly	if TRUE, only normal markup characters will be ignored
	 *
	 * @return	a pointer to the location of the first markup character in InputString, or NULL if InputString doesn't contain any markup characters
	 */
	static const TCHAR* FindFirstMarkupCharacter( const TCHAR* InputText, UBOOL bSystemMarkupOnly=FALSE )
	{
		const TCHAR* Result = NULL;

		const TCHAR* StandardMarkupStartPos = (bSystemMarkupOnly == TRUE) ? NULL : FindCharacterPos(InputText,MARKUP_BEGIN_CHAR);
		const TCHAR* SystemMarkupStartPos = FindCharacterPos(InputText,SYSTEM_MARKUP_BEGIN_CHAR);
		if ( StandardMarkupStartPos == NULL )
		{
			Result = SystemMarkupStartPos;
		}
		else if ( SystemMarkupStartPos == NULL )
		{
			Result = StandardMarkupStartPos;
		}
		else
		{
			Result = Min(StandardMarkupStartPos, SystemMarkupStartPos);
		}

		return Result;
	}

	/**
	 * Determines how much of InputText belongs to this text chunk and copies that part into internal storage.
	 *
	 * @param	InputText			A pointer to the location in the input string where this text chunk will begin.  After
	 *								this function returns, InputText will be pointing to the first character following the
	 *								text that this chunk contains.
	 * @param	bSystemMarkupOnly	if TRUE, only system markup blocks will be processed
	 *
	 * @return	TRUE if the input text was successfully parsed and processed
	 */
	virtual UBOOL ProcessChunk( const TCHAR*& InputText, UBOOL bSystemMarkupOnly )
	{
		UBOOL bResult = FALSE;

		const TCHAR* MarkupStartPos = NULL;
		if ( bSystemMarkupOnly )
		{
			MarkupStartPos = FindCharacterPos(InputText, SYSTEM_MARKUP_BEGIN_CHAR);
		}
		else
		{
			MarkupStartPos = FindFirstMarkupCharacter(InputText);
		}

		if ( MarkupStartPos != NULL )
		{
			// get access to the underlying TCHAR array
			TArray<TCHAR>& Value = ChunkValue.GetCharArray();

			// manually move all characters up to the markup over to the internal string...
			// this is to avoid the multiple copies of FString created by using its Left/Mid methods
			INT Count = (MarkupStartPos - InputText) + 1;
			Value.Add( Count );

			appStrncpy( &Value(0), InputText, Count );
			InputText = MarkupStartPos;
			bResult = TRUE;
		}
		else
		{
			// no markup characters in the string...eat the whole string
			ChunkValue = InputText;
			InputText += appStrlen(InputText);
			bResult = TRUE;
		}

		return bResult;
	}

	/**
	 * Returns whether this chunk contains UI datastore markup.
	 */
	virtual UBOOL IsMarkup() const
	{ return FALSE; }

	/**
	 * Retrieves the data store tag and property value referenced by the text stored in ChunkValue.
	 *
	 * @param	out_DataStoreTag	will be filled with the name of the data store referenced by this chunk of text
	 * @param	out_DataStoreValue	will be filled with the remainder stored in this text (after removing the data store tag)
	 *
	 * @return	TRUE if this text chunk is a markup chunk, and the parameters were filled with values.
	 */
	virtual UBOOL GetDataStoreMarkup( FString& out_DataStoreTag, FString& out_DataStoreValue ) const
	{ return FALSE; }
};

/**
 * Represents a single chunk of text which contains a UI data store reference using markup.
 */
struct FMarkupTextChunk : public FTextChunk
{
private:

public:

	/**
	 * Returns whether this chunk contains UI datastore markup.
	 */
	virtual UBOOL IsMarkup() const
	{ return TRUE; }

	/**
	 * Retrieves the data store tag and property value referenced by the text stored in ChunkValue.
	 *
	 * @param	out_DataStoreTag	will be filled with the name of the data store referenced by this chunk of text
	 * @param	out_DataStoreValue	will be filled with the remainder stored in this text (after removing the data store tag)
	 *
	 * @return	TRUE if this text chunk is a markup chunk, and the parameters were filled with values.
	 */
	virtual UBOOL GetDataStoreMarkup( FString& out_DataStoreTag, FString& out_DataStoreValue ) const
	{
		if ( DataStoreTag.Len() > 0 && DataStoreProperty.Len() > 0 )
		{
			out_DataStoreTag = DataStoreTag;
			out_DataStoreValue = DataStoreProperty;
			return TRUE;
		}

		return FALSE;
	}

private:
	FString DataStoreTag, DataStoreProperty;
};

/**
 * Reads an input string and separates the markup chunks from the normal text chunks.
 */
struct FUIStringParser
{
private:
	const TCHAR* CurrentPosition;
	TIndirectArray<FTextChunk> Chunks;

	/** Determines whether standard markup blocks (delimited by <>) are processed */
	UBOOL bSystemMarkupOnly;

	/**
	 * Creates the appropriate type of text chunk according to the next character in the input string.
	 *
	 * @param	a pointer to a text chunk of the appropriate type
	 */
	FTextChunk* GetNextToken()
	{
		FTextChunk* Chunk = NULL;
		if ( CurrentPosition && *CurrentPosition )
		{
			if ( *CurrentPosition == SYSTEM_MARKUP_BEGIN_CHAR ||
				(!bSystemMarkupOnly && *CurrentPosition == MARKUP_BEGIN_CHAR) )
			{
				// create a text chunk to contain the markup value - it will eat all the characters that belong to that markup chunk, then return
				// a TCHAR* to the next character in the string following the end of the markup chunk
				Chunk = new FMarkupTextChunk;
			}
			else
			{
				// this is normal text
				Chunk = new FTextChunk;
			}
		}

		return Chunk;
	}

public:

	/**
	 * Reads an input string, separating the string into chunks containing either normal text or markup.  The results of this function
	 * can be retrieved using the GetTextChunks() method.
	 *
	 * @param	InputString			the string to parse
	 * @param	bSystemMarkupOnly	if TRUE, only system generated markup will be processed (such as markup for rendering carets, etc.)
	 */
	void ScanString( const FString& InputString, UBOOL bInSystemMarkupOnly=FALSE )
	{
		bSystemMarkupOnly = bInSystemMarkupOnly;

		CurrentPosition = *InputString;
		for ( FTextChunk* NextChunk=GetNextToken(); NextChunk != NULL; NextChunk = GetNextToken() )
		{
			//@todo - error handling
			if ( NextChunk->ProcessChunk(CurrentPosition,bSystemMarkupOnly) )
			{
				Chunks.AddRawItem(NextChunk);
			}
			else
			{
				//@fixme - should we stop here?
				delete NextChunk;
				NextChunk = NULL;

				break;
			}
		}
	}

	/**
	 * Determine whether the specified input string contains markup.
	 *
	 * @param	InputString			the string to parse
	 * @param	bSystemMarkupOnly	if TRUE, only system generated markup will be processed (such as markup for rendering carets, etc.)
	 *
	 * @return	TRUE if InputString contains markup characters
	 */
	static UBOOL StringContainsMarkup( const FString& InputString, UBOOL bInSystemMarkupOnly=FALSE )
	{
		UBOOL bResult = FALSE;

		TCHAR MarkupBeginChar = bInSystemMarkupOnly ? SYSTEM_MARKUP_BEGIN_CHAR : MARKUP_BEGIN_CHAR;
		TCHAR MarkupEndChar = bInSystemMarkupOnly ? SYSTEM_MARKUP_END_CHAR : MARKUP_END_CHAR;

		const TCHAR* MarkupStartPos = FTextChunk::FindFirstMarkupCharacter(*InputString,bInSystemMarkupOnly);
		if ( MarkupStartPos != NULL )
		{
			const TCHAR* MarkupEndPos = FTextChunk::FindCharacterPos(MarkupStartPos, MarkupEndChar);
			bResult = (MarkupEndPos != NULL);
		}

		return bResult;
	}

	/**
	 * Retrieves the chunks of text that were processed by ScanString.
	 */
	const TIndirectArray<FTextChunk>* GetTextChunks() const
	{
		return &Chunks;
	}
};

#endif	// __UNUIMARKUPRESOLVER_H__
