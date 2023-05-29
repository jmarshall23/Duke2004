/*=============================================================================
	UnDebuggerInterface.h: Debugger Interface interface
	Copyright 1998-2013 Epic Games, Inc. All Rights Reserved.
=============================================================================*/

#ifndef __UNDEBUGGERINTERFACE_H__
#define __UNDEBUGGERINTERFACE_H__

/**
 * The types of user commands that the debugger engine responds to
 */
enum EUserAction
{
	UA_None,

	/** end the current game session */
	UA_Exit,

	/** step into the current line; if the current line is a function call, steps into that function */
	UA_StepInto,

	/** step over the next instruction (i.e. for stepping into different parts of a for loop); not yet implemented */
	UA_StepOver,

	/** step over the next line of code, skipping all instructions on the current line */
	UA_StepOverStack,

	/** step out of the current function */
	UA_StepOut, 

	/** continue execution until the code reaches the specified line/instruction; not yet implemented */
	UA_RunToCursor,

	/** continue execution and return control to the debugger engine */
	UA_Go,

	UA_MAX,
};

/**
 * Abstract base for classes which handle user input and data presentation for the debugger engine.
 */
class UDebuggerInterface
{
public:
	/** @name Internal methods */
	//@{

	/** Constructor */
	UDebuggerInterface() 
		: GLOBAL_WATCH(1), LOCAL_WATCH(0), WATCH_WATCH(2)
	{}

	/**
	 * Initialize the debugger interface.  Called when the debugger engine is created.
	 *
	 * Subclasses should use this method to bind to any external .dlls, create any required forms, etc.
	 *
	 * @param	DebuggerOwner	the debugger engine instance that will handle commands for this interface
	 *
	 * @return	TRUE if the interface was initialized successfully.
	 */
	virtual UBOOL Initialize( class UDebuggerCore* DebuggerOwner )=0;

	/**
	 * Close the debugger window and detach from the engine.  Called when the debugger engine is being torn down.
	 *
	 * Subclasses should use this method to unload any external .dlls and close any forms created.
	 */
	virtual void Close()=0;

	/**
	 * Indicates whether the debugger interface is active. (i.e. if external .dlls are used, whether those .dlls are currenly loaded)
	 *
	 * @return	TRUE if the debugger interface is active
	 */
	virtual UBOOL IsLoaded() const = 0;
	//@}

	/**
	 * @name Engine => Interface communication: methods called by the engine to the interface
	 */
	//@{

	/**
	 * Present the debugger interface.  Called when the debugger engine wishes to give control to the interface (such as when a breakpoint is hit), AFTER
	 * all watch data has been sent to the interface.
	 *
	 * Subclasses should use this method to bring the debugger window to the foreground, start capturing input, etc.
	 */
	virtual void Show()=0;

	/**
	 * Release focus.  Called when the debugger engine is resuming control from the interface (such as when the user chooses "Run" or "Step Over").
	 *
	 * Subclasses should use this method to bring the game's window back to the foreground, stop capturing input, etc.
	 */
	virtual void Hide()=0;

	/**
	 * Outputs a message generated by the debugger engine.
	 *
	 * Subclasses should use this method to forward debug output to the appropriate window/control.
	 *
	 * @param	Line	the message to output
	 */
	virtual void AddToLog( const TCHAR* Line )=0;


	/**
	 * Notifies the debugger interface that the debugger engine has moved to a new location in the code.
	 *
	 * Subclasses should use this method to reposition the source code window to the appropriate position and update any status info accordingly.
	 *
	 * @param	ClassName	the name of the unrealscript class containing the code currently being executed (i.e. the name of the .uc file)
	 * @param	PackageName	the name of the Unreal package which contains the class (i.e. the directory containing the .uc file)
	 * @param	LineNumber	the line number for the current code position
	 * @param	OpCodeName	the name of the bytecode currently about to be executed (corresponds to a value in OpCodes.h)
	 * @param	ObjectName	the name of the object instance executing the code (for C++, would be the value of 'this')
	 */
	virtual void Update( const TCHAR* ClassName, const TCHAR* PackageName, INT LineNumber, const TCHAR* OpcodeName, const TCHAR* objectName )=0;


	/**
	 * Update the contents of the callstack window with the specified list of stack nodes.
	 *
	 * Subclasses should use this method to populate the contents of the callstack window.
	 *
	 * @param	StackNames	array of strings containing all stack nodes in the callstack.  Each element contains the full path name for the stack node; for example,
	 *						if the topmost stack node is the BeginState function of the PlayerWaiting state in the PlayerController class from the Engine package, the
	 *						value of the last element in the array would be: Engine.PlayerController.PlayerWaiting.BeginState
	 *
	 */
	virtual void UpdateCallStack( TArray<FString>& StackNames )=0;

	/**
	 * Indicates that the engine is about to perform some action on the specified watch window, such as adding new watch entries, updating watch data values, etc.  Can be called multiple
	 * times before the corresponding UnlockWatch is called.  UnlockWatch must be called the same number of times as LockWatch for a given watch window.
	 *
	 * Subclasses can use this method to prevent any changes to the specified watch window during the update, if desired (for example, ignoring paint events when e.g. a
	 * number of actions will occur at once, or if the interface uses multiple threads to do its work).  This method is intended to be used for incrementing mutexes, ref counts, etc.
	 *
	 * @param	watch	the watch window that will be updated; valid values are UDebuggerInterface::GLOBAL_WATCH, UDebuggerInterface::LOCAL_WATCH, and UDebuggerInterface::WATCH_WATCH
	 */
	virtual void LockWatch(int watch) = 0;

	/**
	 * Indicates that the engine has completed performing actions to the specified watch window.
	 *
	 * Subclasses can use this method to decrement any counters or ref counts used to prevent modification to the specified watch window.
	 *
	 * @param	watch	the watch window that is no longer being updated; valid values are UDebuggerInterface::GLOBAL_WATCH,
	 *					UDebuggerInterface::LOCAL_WATCH, and UDebuggerInterface::WATCH_WATCH
	 */
	virtual void UnlockWatch(int watch) = 0;

	/**
	 * Add a entry to a specified watch window.
	 *
	 * Subclasses should use this method to add new elements to the specified watch window.
	 *
	 * @param	watch		the watch window to add the new watch entry to; valid values are UDebuggerInterface::GLOBAL_WATCH,
	 *						UDebuggerInterface::LOCAL_WATCH, and UDebuggerInterface::WATCH_WATCH
	 * @param	ParentIndex	the Id for the tree item to add this watch entry under, or -1 if a root-level item
	 * @param	WatchName	the name of the symbol associated with this watch
	 * @param	Data		the resolved value of this watch entry
	 *
	 * @return	the ID corresponding to the list/tree item created for the specified watch.
	 */
	virtual int AddAWatch(int watch, int ParentIndex, const TCHAR* WatchName, const TCHAR* Data) = 0;

	/**
	 * Clears the contents of a watch window.
	 *
	 * Subclasses should use this method to remove all elements from the specified watch window.
	 *
	 * @param	watch	the watch window that should be clered; valid values are UDebuggerInterface::GLOBAL_WATCH,
	 *					UDebuggerInterface::LOCAL_WATCH, and UDebuggerInterface::WATCH_WATCH
	 */
	virtual void ClearAWatch(int watch) = 0;


	//@}

	/**
	 * @name Interface => Engine communication: methods called by the interface to the engine
	 */
	//@{
	/**
	 * Instructs the engine to set a breakpoint at the specified location.
	 *
	 * @param	ClassName	the name of the unrealscript class to set the breakpoint in (i.e. the name of the .uc file)
	 * @param	Line		the line number to set the breakpoint on
	 */
	virtual void SetBreakpoint( const TCHAR* ClassName, INT Line )=0;

	/**
	 * Instructs the engine to remove the specified breakpoint.
	 *
	 * @param	ClassName	the name of the unrealscript class to remove the breakpoint from
	 * @param	Line		the line number to remove the breakpoint from.
	 */
	virtual void RemoveBreakpoint( const TCHAR* ClassName, INT Line )=0;
	//@}

	/**
 	 * Callback from the DebuggerCore on a tick
	 */
	virtual void NotifyBeginTick()
	{
	}

	/**
 	 * Callback from the DebuggerCore on a DebugInfo call
	 * @param bAllowDetach Returns TRUE if the debugger allows detaching
	 * @return TRUE if the debugger is ready
	 */
	virtual UBOOL NotifyDebugInfo( UBOOL* bAllowDetach )
	{
		if ( bAllowDetach )
			*bAllowDetach = TRUE;
		return TRUE;
	}

	/**
	 * The three watch windows. Used as parameters to LockWatch, UnlockWatch, ClearWatch and AddAWatch
	 */
	const int GLOBAL_WATCH;
	const int LOCAL_WATCH;
	const int WATCH_WATCH;

	// DEPRECATED METHODS
	/**
	 * Update the interface's version of the class-hierarchy tree (if applicable).  Deprecated - should not be used.
	 */
	virtual void UpdateClassTree() {}

protected:
	class UDebuggerCore* Debugger;
};

#endif // __UNDEBUGGERINTERFACE_H__