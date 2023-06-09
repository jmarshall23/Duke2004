using System;
using System.Collections.Generic;
using Extensibility;
using EnvDTE;
using EnvDTE80;
using EnvDTE90;
using Microsoft.VisualStudio.CommandBars;
using System.Resources;
using System.Reflection;
using System.Globalization;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;
using Microsoft.VisualStudio.Shell;
using Microsoft.VisualStudio.OLE.Interop;
using Microsoft.VisualStudio.Shell.Interop;

namespace UnrealscriptDevSuite
{
	/// <summary>The object for implementing an Add-in.</summary>
	/// <seealso class='IDTExtensibility2' />
	public class Connect : IDTExtensibility2, IDTCommandTarget
	{
		// Button face ids
		private const int FACE_ID_ClassBrowser = 737;
		private const int FACE_ID_Search = 25;
		private const int FACE_ID_Build = 527;

		// Our Browser tool window needs a GUID and caption
		private const string BROWSERWINDOWGUID = "{A2F441AA-869E-4b59-BA59-F6A710C23AF2}";
		private const string BROWSERWINDOWCAPTION = "Unrealscript - Hierarchy";

		// Cached reference to the DTE2 and AddIn objects.  You'll notice a number of 
		// cached objects both here and in the ClassBrwoser.  This is important in order
		// to keep the COM delegates alive and kicking.
		private DTE2 ApplicationObject;
		private AddIn AddInInstance;

		// We want to make sure we only initialize outselves once
		private bool bAddInIsInitialized;

		// Hold a cached reference to our settings
		private UDSSettings Settings;

		// We need to track several document events so cache the DocumentEvents object here
		private DocumentEvents DocEvents;
		
		// Used for parsing errors.
		private bool bInErrorSummary;

		// Our custom error provider needs a GUID
		private const string ERROR_PROVIDER_GUID = "{C19997BF-2DF2-4d95-9C98-DD57B7944F75}";

		// Cache various com objects required to provide an error handler
		private ServiceProvider MyServiceProvider;
		private ErrorListProvider MyErrorProvider;

		// We need to keep a scoped reference to the output pane for compiling
		private OutputWindowPane BuildOutputPane = null;

		// ====================================================================================
		// ====================================================================================
		// ====================================================================================
		// IDTExtensibility2 Events
		// ====================================================================================
		// ====================================================================================
		// ====================================================================================

		/// <summary>Implements the constructor for the Add-in object. Place your initialization code within this method.</summary>
		public Connect()
		{
			Settings = new UDSSettings();
		}

		/// <summary>Implements the OnConnection method of the IDTExtensibility2 interface. Receives notification that the Add-in is being loaded.</summary>
		/// <param term='application'>Root object of the host application.</param>
		/// <param term='connectMode'>Describes how the Add-in is being loaded.</param>
		/// <param term='addInInst'>Object representing this Add-in.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnConnection(object application, ext_ConnectMode connectMode, object addInInst, ref Array custom)
		{
			ApplicationObject = (DTE2)application;
			AddInInstance = (AddIn)addInInst;

			// UISetup is sent only once, when the Add-in has been run for the first time.
			if ( connectMode == ext_ConnectMode.ext_cm_UISetup )
			{
				//MessageBox.Show("UISetup");
				SetupUI();
			}

			// AfterSetup is called each time the add-in is loaded and started.  
			else if ( connectMode == ext_ConnectMode.ext_cm_AfterStartup )
			{
				//MessageBox.Show("AfterStartup");
				SetupRuntime();
			}

			// Startup is only called when the UI is started from the menus
			else if ( connectMode == ext_ConnectMode.ext_cm_Startup )
			{
				//MessageBox.Show("Startup");
			}
		}

		/// <summary>Implements the OnDisconnection method of the IDTExtensibility2 interface. Receives notification that the Add-in is being unloaded.</summary>
		/// <param term='disconnectMode'>Describes how the Add-in is being unloaded.</param>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnDisconnection(ext_DisconnectMode disconnectMode, ref Array custom)
		{
			//MessageBox.Show("OnDisconnection");
			ClearErrors();
		}

		/// <summary>Implements the OnAddInsUpdate method of the IDTExtensibility2 interface. Receives notification when the collection of Add-ins has changed.</summary>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />		
		public void OnAddInsUpdate(ref Array custom)
		{
		}

		/// <summary>Implements the OnStartupComplete method of the IDTExtensibility2 interface. Receives notification that the host application has completed loading.</summary>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnStartupComplete(ref Array custom)
		{
			SetupRuntime();
			//MessageBox.Show("OnStartupCompleted");
		}
		/// <summary>Implements the OnBeginShutdown method of the IDTExtensibility2 interface. Receives notification that the host application is being unloaded.</summary>
		/// <param term='custom'>Array of parameters that are host application specific.</param>
		/// <seealso class='IDTExtensibility2' />
		public void OnBeginShutdown(ref Array custom)
		{
			ClassBrowser Browser = GetClassBrowser();
			bool bHierarchyIsVisible = ( Browser != null && Browser.ParentToolWindow != null && Browser.ParentToolWindow.Visible );

			//MessageBox.Show("OnBeginShutdown " + bHierarchyIsVisible.ToString());
			Settings.bBrowserVisible = bHierarchyIsVisible;
		}
		
		/// <summary>Implements the QueryStatus method of the IDTCommandTarget interface. This is called when the command's availability is updated</summary>
		/// <param term='commandName'>The name of the command to determine state for.</param>
		/// <param term='neededText'>Text that is needed for the command.</param>
		/// <param term='status'>The state of the command in the user interface.</param>
		/// <param term='commandText'>Text requested by the neededText parameter.</param>
		/// <seealso class='Exec' />
		public void QueryStatus(string commandName, vsCommandStatusTextWanted neededText, ref vsCommandStatus status, ref object commandText)
		{
			if(neededText == vsCommandStatusTextWanted.vsCommandStatusTextWantedNone)
			{
				if(commandName == "UnrealscriptDevSuite.Connect.UnrealscriptDevSuite")
				{
					status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported|vsCommandStatus.vsCommandStatusEnabled;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.FindClassInHierarchy" )
				{
					status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported | vsCommandStatus.vsCommandStatusEnabled;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.ShowHierarchy" )
				{
					status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported | vsCommandStatus.vsCommandStatusEnabled;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.SearchLineage" )
				{
					status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported | vsCommandStatus.vsCommandStatusEnabled;
					return;
				}

				if ( commandName == "UnrealscriptDevSuite.Connect.BuildScript" )
				{
					status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported | vsCommandStatus.vsCommandStatusEnabled;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.BuildAllScript" )
				{
					status = (vsCommandStatus)vsCommandStatus.vsCommandStatusSupported | vsCommandStatus.vsCommandStatusEnabled;
					return;
				}
			}
		}

		/// <summary>Implements the Exec method of the IDTCommandTarget interface. This is called when the command is invoked.</summary>
		/// <param term='commandName'>The name of the command to execute.</param>
		/// <param term='executeOption'>Describes how the command should be run.</param>
		/// <param term='varIn'>Parameters passed from the caller to the command handler.</param>
		/// <param term='varOut'>Parameters passed from the command handler to the caller.</param>
		/// <param term='handled'>Informs the caller if the command was handled or not.</param>
		/// <seealso class='Exec' />
		public void Exec(string commandName, vsCommandExecOption executeOption, ref object varIn, ref object varOut, ref bool handled)
		{
			handled = false;
			if(executeOption == vsCommandExecOption.vsCommandExecOptionDoDefault)
			{
				if(commandName == "UnrealscriptDevSuite.Connect.UnrealscriptDevSuite")
				{
					handled = true;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.FindClassInHierarchy" )
				{
					FindInHierarchy();
					handled = true;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.ShowHierarchy" )
				{
					DisplayClassBrowser();
					handled = true;
					return;
				}

				if ( commandName == "UnrealscriptDevSuite.Connect.SearchLineage" )
				{
					SearchLineage();
					handled = true;
					return;
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.BuildScript" )
				{
					BuildUC(false);
				}
				if ( commandName == "UnrealscriptDevSuite.Connect.BuildAllScript" )
				{
					BuildUC(true);
				}
			}
		}

		// ====================================================================================
		// ====================================================================================
		// ====================================================================================
		// UDS Main Code
		// ====================================================================================
		// ====================================================================================
		// ====================================================================================


		/**
		 * Find the localized name for a given VS popup menu.  We need this to place our commands correctly
		 * 
		 * @param MenuName The name of the menu we are looking for
		 */
		public string LocalizeMenuName( string MenuName )
		{
			string Result = "";
			try
			{
				string resourceName;
				ResourceManager resourceManager = new ResourceManager("UnrealscriptDevSuite.CommandBar", Assembly.GetExecutingAssembly());
				CultureInfo cultureInfo = new CultureInfo(ApplicationObject.LocaleID);

				if ( cultureInfo.TwoLetterISOLanguageName == "zh" )
				{
					System.Globalization.CultureInfo parentCultureInfo = cultureInfo.Parent;
					resourceName = String.Concat(parentCultureInfo.Name, MenuName);
				}
				else
				{
					resourceName = String.Concat(cultureInfo.TwoLetterISOLanguageName, MenuName);
				}
				Result = resourceManager.GetString(resourceName);
			}
			catch
			{
				Result = MenuName;
			}

			return Result;
		}

		/**
		 * Returns the current callstack as a string.  We use this for error output
		 */
		private string GetCallStack()
		{
			StackTrace T = new StackTrace();
			System.Diagnostics.StackFrame[] F = T.GetFrames();

			string S = "";

			foreach ( System.Diagnostics.StackFrame Frm in F )
			{
				S = S + Frm.GetMethod().Name + " (" + Frm.GetFileLineNumber() + ")\r\n";
			}

			return S;
		}

		/**
		 * Create all of the commands used by UDS and setup the various toolbars, etc.
		 * This is called when the connection mode is UISETUP and that should only be 
		 * once.
		 */
		public void SetupUI()
		{
			object[] contextGUIDS = new object[] { };
			Commands2 commands = (Commands2)ApplicationObject.Commands;
			try
			{
				CommandBar MenuBar = ( (CommandBars)ApplicationObject.CommandBars )["MenuBar"];
				Command Cmd;

				CommandBarPopup EditPopup = (CommandBarPopup)MenuBar.Controls[LocalizeMenuName("Edit")];
				if (EditPopup != null)
				{
					if ( !FindCommand(commands, "FindClassInHierarchy", out Cmd) )
					{
						Cmd = commands.AddNamedCommand2(AddInInstance,
						   "FindClassInHierarchy", "Find in Hierarchy", "Find the currently open .UC class in the class hierarchy.",
						   true, FACE_ID_Search, ref contextGUIDS,
						   (int)vsCommandStatus.vsCommandStatusSupported +
						   (int)vsCommandStatus.vsCommandStatusEnabled,
						   (int)vsCommandStyle.vsCommandStylePictAndText,
						   vsCommandControlType.vsCommandControlTypeButton);
					}

					if ( Cmd != null )
					{
						CommandBarButton B = (CommandBarButton)Cmd.AddControl(EditPopup.CommandBar, EditPopup.Controls.Count + 1);
						if ( B != null )
						{
							B.BeginGroup = true;
						}
					}
				}
				CommandBarPopup BuildPopup = (CommandBarPopup)MenuBar.Controls[LocalizeMenuName("Build")];
				if (BuildPopup != null)
				{
					if ( !FindCommand(commands, "BuildScript", out Cmd) )
					{
						Cmd = commands.AddNamedCommand2(AddInInstance,
							"BuildScript", "Build .UC Script", "Build changed script classes.",
							true, FACE_ID_Build, ref contextGUIDS,
							(int)vsCommandStatus.vsCommandStatusSupported +
							(int)vsCommandStatus.vsCommandStatusEnabled,
							(int)vsCommandStyle.vsCommandStylePictAndText,
							vsCommandControlType.vsCommandControlTypeButton);
					}

					if ( Cmd != null )
					{
						CommandBarButton B = (CommandBarButton)Cmd.AddControl(BuildPopup.CommandBar, BuildPopup.Controls.Count + 1);
						if ( B != null ) B.BeginGroup = true;
					}

					if ( !FindCommand(commands, "BuildAllScript", out Cmd) )
					{
						Cmd = commands.AddNamedCommand2(AddInInstance,
							"BuildAllScript", "Build .UC Script (Full)", "Build all script classes.",
							true, FACE_ID_Build, ref contextGUIDS,
							(int)vsCommandStatus.vsCommandStatusSupported +
							(int)vsCommandStatus.vsCommandStatusEnabled,
							(int)vsCommandStyle.vsCommandStylePictAndText,
							vsCommandControlType.vsCommandControlTypeButton);
					}
					
					if ( Cmd != null )
					{
						Cmd.AddControl(BuildPopup.CommandBar, BuildPopup.Controls.Count + 1);
					}
				}

				CommandBarPopup ViewPopup = (CommandBarPopup)MenuBar.Controls[LocalizeMenuName("View")];
				if (ViewPopup != null)
				{
					CommandBarPopup OtherPopup = (CommandBarPopup)ViewPopup.Controls["Other Windows"];
					if (OtherPopup != null)
					{
						if ( !FindCommand(commands, "ShowHierarchy", out Cmd) )
						{
							Cmd = commands.AddNamedCommand2(AddInInstance,
								"ShowHierarchy", "Unrealscript Class Hierarchy", "Shows the hierarchy window.",
								true, FACE_ID_ClassBrowser, ref contextGUIDS,
								(int)vsCommandStatus.vsCommandStatusSupported +
								(int)vsCommandStatus.vsCommandStatusEnabled,
								(int)vsCommandStyle.vsCommandStylePictAndText,
								vsCommandControlType.vsCommandControlTypeButton);
						}

						if ( Cmd != null )
						{
							CommandBarButton B = (CommandBarButton)Cmd.AddControl(OtherPopup.CommandBar, OtherPopup.Controls.Count + 1);
							if ( B != null ) B.BeginGroup = true;
						}
					}
				}

				if ( !FindCommand(commands, "SearchLineage", out Cmd) )
				{
					Cmd = commands.AddNamedCommand2(AddInInstance,
						"SearchLineage", "Search Lineage", "Search Parents and Children of the selected class.",
						true, FACE_ID_Search, ref contextGUIDS,
						(int)vsCommandStatus.vsCommandStatusSupported +
						(int)vsCommandStatus.vsCommandStatusEnabled,
						(int)vsCommandStyle.vsCommandStylePictAndText,
						vsCommandControlType.vsCommandControlTypeButton);
				}
				
				Settings.bBrowserVisible = false;
			}
			catch (Exception Ex)
			{
				MessageBox.Show("An Error has occurred while initializing the UDS.\r\n" + Ex.ToString());
			}
		}

		/**
		 * This is called when the runtime version of the add-in is loaded.  It can happen from the following
		 * paths.  When an installed add-in that is set to auto-start, this will be called via the 
		 * OnStartupComplete function.  If you disable then re-enable the add-in via the menus, it will be
		 * called from AfterStartup.
		 * 
		 * Also note, SetupRuntime is called in both cases AFTER the VS's GUI is up and running
		 */
		private void SetupRuntime()
		{
			// Saftey check.. only initialize once
			if (bAddInIsInitialized)
			{
				return;
			}

			bAddInIsInitialized = true;

			Object Missing = System.Reflection.Missing.Value;
			DocEvents = ApplicationObject.Events.get_DocumentEvents(Missing as Document);
			DocEvents.DocumentOpened += new _dispDocumentEvents_DocumentOpenedEventHandler(DocumentOpened);

			if ( Settings.bBrowserVisible )
			{
				DisplayClassBrowser();
			}
		}

		/**
		 * If the Command already exists, delete it.
		 * 
		 * @Param Commands Is the array of commands
		 * @Param Name Is the name of the command to delete
		 */

		private bool FindCommand( Commands2 Commands, string Name, out Command Cmd )
		{
			// Look to see if the command already exists.
			foreach ( Command C in Commands )
			{
				string Test = "UnrealscriptDevSuite.Connect." + Name.ToUpper();
				if ( C.Name.ToUpper() == Test.ToUpper() )
				{
					Cmd = C;
					return true;
				}
			}
			Cmd = null;
			return false;
		}

		// ======================== [ Error List Interface ]==============================

		/**
		 * Add an error to the list.
		 * 
		 * @Param bIsWarning will be true if this is a warning, not an error
		 * @Param Text is the type of error
		 * @Param Filename is the path to the source file
		 * @Param Line is the line # where the error occured.
		 */
		public void AddErrorTask(bool bIsWarning, string Text, string Filename, int Line)
		{
			if (MyErrorProvider != null)
			{
				TaskPriority Priority = bIsWarning ? TaskPriority.Normal : TaskPriority.High;
				TaskErrorCategory Category = bIsWarning ? TaskErrorCategory.Warning : TaskErrorCategory.Error;

				bool bAlreadyReported = false;
				foreach (ErrorTask Task in MyErrorProvider.Tasks)
				{
					if ((Task.ErrorCategory == Category) && (Task.Document == Filename) && (Task.Line == Line) && (Task.Text == Text))
					{
						bAlreadyReported = true;
						break;
					}
				}

				if (!bAlreadyReported)
				{
					ErrorTask Task = new ErrorTask();
					Task.Document = Filename;
					Task.Line = Line-1;
					Task.Column = 0;
					Task.Text = Text;
					Task.Priority = Priority;
					Task.ErrorCategory = Category;
					Task.Navigate += new EventHandler(ErrorTaskNavigate);

					MyErrorProvider.Tasks.Add(Task);

				}
			}
		}

		/**
		 * This is the event that will be called when someone double-clicks on an error in the
		 * task window.
		 */
		private void ErrorTaskNavigate(object sender, EventArgs e)
		{
			Microsoft.VisualStudio.Shell.Task Task = sender as Microsoft.VisualStudio.Shell.Task;
			if (Task != null)
			{
				string Filename = Task.Document;
				ProjectItem Item = FindProjectItemFromFilename(Filename);
				if (Item != null)
				{
					Item.Open(EnvDTE.Constants.vsViewKindCode).Activate();
					((TextSelection) ApplicationObject.ActiveDocument.Selection).GotoLine(Task.Line+1,false);
				}
			}
		}

		/**
		 * Clear all errors from the list
		 */
		private void ClearErrors()
		{
			if (MyErrorProvider != null)
			{
				MyErrorProvider.Tasks.Clear();
			}
		}

		/**
		 * Given a filename, find the projectitem that is associated with it
		 * 
		 * @Param Filename the name of the file to find
		 */
		public ProjectItem FindProjectItemFromFilename(string Filename)
		{
			// Iterate over all of the solution objects and add their children
			Solution3 CurrentSolution = ApplicationObject.Solution as Solution3;
			foreach (Project Proj in CurrentSolution.Projects)
			{
				foreach (ProjectItem Item in Proj.ProjectItems)
				{
					ProjectItem Result = SearchForProjectItemWithFilename(Item, Filename);
					if (Result != null)
					{
						return Result;
					}
				}
			}

			return null;
		}

		/**
		 * Recursively search for a given filename
		 * 
		 * @Param Item is the current parent ProjectItem to search
		 * @Param SearchFilename is the name of the file to find
		 */
		private ProjectItem SearchForProjectItemWithFilename(ProjectItem Item, string SearchFilename)
		{
			if (Item.Kind == EnvDTE.Constants.vsProjectItemKindPhysicalFile)
			{
				try
				{
					string ItemFilename = Item.get_FileNames(0);
					if (ItemFilename != null && ItemFilename != "" && ItemFilename.ToLower() == SearchFilename.ToLower())
					{
						return Item;
					}
				}
				catch
				{
				}
			}
			else if (Item.SubProject != null && Item.SubProject.ProjectItems != null)
			{
				foreach (ProjectItem SubItem in Item.SubProject.ProjectItems)
				{
					ProjectItem Result = SearchForProjectItemWithFilename(SubItem,SearchFilename);
					if ( Result != null )
					{
						return Result;
					}
				}
			}
			else if (Item.ProjectItems != null)
			{
				foreach (ProjectItem Child in Item.ProjectItems)
				{
					ProjectItem Result = SearchForProjectItemWithFilename(Child,SearchFilename);
					if ( Result != null )
					{
						return Result;
					}
				}
			}

			return null;
		}

		// ======================== [ Class Browser Support Functions ]==============================

		public ClassBrowser GetClassBrowser()
		{
			for ( int i = 1; i <= ApplicationObject.Windows.Count; i++ )
			{
				Window W = ApplicationObject.Windows.Item(i);
				if (W.Caption == BROWSERWINDOWCAPTION)
				{
					return W.Object as ClassBrowser;
				}
			}
			return null;
		}

		private void DocumentOpened( Document Document )
		{
			ClassBrowser Browser = GetClassBrowser();
			if (Browser != null && Path.GetExtension(Document.FullName).ToUpper() == ".UC" )
			{
				Browser.FindClassInHierarchy(Document.FullName);
			}
		}

		private ClassBrowser CreateClassBrowser()
		{
			if ( GetClassBrowser() == null )
			{
				try
				{
					string ctlProgID;
					EnvDTE80.Windows2 toolWins;
					EnvDTE.Window Wnd;

					object objTemp = null;

					ctlProgID = "UnrealscriptDevSuite.ClassBrowser";
					Assembly Asm = Assembly.GetExecutingAssembly();
					toolWins = (Windows2)ApplicationObject.Windows;
					Wnd = toolWins.CreateToolWindow2(AddInInstance,
					  Asm.Location, ctlProgID, BROWSERWINDOWCAPTION, BROWSERWINDOWGUID,
					  ref objTemp);

					if ( Wnd != null )
					{
						ClassBrowser Browser = ( Wnd.Object as ClassBrowser );
						Browser.ConnectToVS(ApplicationObject, AddInInstance);
						Browser.ParentToolWindow = Wnd;
						return Browser;
					}
				}
				catch ( Exception ex )
				{
					MessageBox.Show("Exception: " + ex.Message);
				}
			}
			return null;
		}

		private ClassBrowser DisplayClassBrowser()
		{
			ClassBrowser Browser = GetClassBrowser();

			// If the Browser doesn't exist, create it.
			if ( Browser == null )
			{
				Browser = CreateClassBrowser();
			}

			if ( Browser != null )
			{
				Browser.ParentToolWindow.Activate();
				Settings.bBrowserVisible = true;
			}			

			return Browser;
		}

		private void HideClassBrowser()
		{
			ClassBrowser Browser = GetClassBrowser();
			if ( Browser != null )
			{
				Browser.ParentToolWindow.Visible = false;
				Settings.bBrowserVisible = false;
			}
		}

		private void FindInHierarchy()
		{
			ClassBrowser Browser = DisplayClassBrowser();
			if (Browser != null)
			{
				// Find the class in the hierarchy
				EnvDTE.Document CurrentDocument = ApplicationObject.ActiveDocument;
				if (Path.GetExtension(CurrentDocument.FullName).ToUpper() == ".UC")
				{
					if ( Browser != null )
					{
						Browser.FindClassInHierarchy(CurrentDocument.FullName);
					}
				}
			}
		}

		private void SearchLineage()
		{
			ClassBrowser Browser = DisplayClassBrowser();
			if ( Browser != null )
			{
				Browser.SearchLineage();
			}
		}

		private void BuildUC(bool bFull)
		{
			ProjectItem StartupProjectItem = GetStartupProject();
			
			string Filename = "";

			// If we aren't forcing the Compile EXE then use the startup project
			if ( !Settings.bForceCompileEXE )
			{
				if ( StartupProjectItem != null && StartupProjectItem.Kind == EnvDTE.Constants.vsProjectItemKindSolutionItems )
				{
					Project StartupProject = StartupProjectItem.SubProject;
					string FilePath = StartupProject.ConfigurationManager.ActiveConfiguration.Properties.Item("OutputPath").Value.ToString();
					foreach ( OutputGroup Group in StartupProject.ConfigurationManager.ActiveConfiguration.OutputGroups )
					{
						if ( Group.CanonicalName == "Built" && Group.FileCount > 0 )
						{
							foreach ( string FN in (Array)Group.FileNames )
							{
								Filename = FN.ToString();
							}
							break;
						}
					}

					Filename = Path.Combine(FilePath, Filename);
				}
			}
			else
			{
				Filename = Settings.CompileExeFilename;
			}

			if (Filename != "" && File.Exists(Filename))
			{
				
				if (Settings.bUseCOMFile)
				{
					Filename = Filename.Replace(".exe", ".com");
				}
				
				ApplicationObject.ExecuteCommand("SaveAll", "");
				bFull = true;

				OutputWindow OW = ApplicationObject.ToolWindows.OutputWindow;
				BuildOutputPane = OW.OutputWindowPanes.Item("Build");

				if (BuildOutputPane != null)
				{
					BuildOutputPane.Activate();
					if (Settings.bClearOutputWindow)
					{
						BuildOutputPane.Clear();
					}
				}

				Window OutputWind = ApplicationObject.Windows.Item(EnvDTE.Constants.vsWindowKindOutput);
				OutputWind.Visible = true;

				System.Diagnostics.Process Proc = new System.Diagnostics.Process();
				Proc.StartInfo.FileName = Filename;
				Proc.StartInfo.Arguments = bFull ? "make -full" : "make";

				if (Settings.AdditionalCompileCmdLine != "")
				{
					Proc.StartInfo.Arguments = Proc.StartInfo.Arguments + " " + Settings.AdditionalCompileCmdLine;
				}

				Proc.StartInfo.UseShellExecute = false;
				Proc.StartInfo.RedirectStandardOutput = true;
				Proc.StartInfo.CreateNoWindow = true;
				Proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;

				bInErrorSummary = false;
			
				Proc.OutputDataReceived += new DataReceivedEventHandler(Proc_OutputDataReceived);
				Proc.Exited += new EventHandler(Proc_Exited);
				Proc.EnableRaisingEvents = true;

				// Initialize the Error List provider so we can add tasks
				if (MyErrorProvider == null)
				{
					if ( MyServiceProvider == null )
					{
						MyServiceProvider = new ServiceProvider((Microsoft.VisualStudio.OLE.Interop.IServiceProvider)ApplicationObject);
					}

					MyErrorProvider = new ErrorListProvider(MyServiceProvider);
					MyErrorProvider.ProviderName = "UDS Error Provider";
					MyErrorProvider.ProviderGuid = new Guid(ERROR_PROVIDER_GUID);
				}
				else
				{
					MyErrorProvider.Tasks.Clear();
				}

				Proc.Start();
				Proc.BeginOutputReadLine();
			}
 		}

		void Proc_Exited(object sender, EventArgs e)
		{
			if (MyErrorProvider.Tasks.Count>0)
			{
				MyErrorProvider.Show();
			}
		}

		void Proc_OutputDataReceived(object sender, DataReceivedEventArgs e)
		{
			string Text = e.Data as string;
			BuildOutputPane.OutputString(Text + "\r\n");
			if (!bInErrorSummary)
			{
				if (Text == "Warning/Error Summary")
				{
					bInErrorSummary = true;
				}
			}
			else if (Text != "" && Text != null)
			{
				string TextLower = Text.ToLower();
				if (TextLower.IndexOf(") : warning,") >= 0 || TextLower.IndexOf(") : error,") >= 0)
				{
					// We have an error or warning.

					bool bWarn = TextLower.IndexOf(") : warning,") >= 0;

					int index = TextLower.IndexOf("(");
					string Filename = Text.Substring(0, index);

					int index2 = TextLower.IndexOf(")", index);
					int Line = Int32.Parse(Text.Substring(index + 1, index2 - index - 1));
					index = TextLower.IndexOf(", ", index2);
					string ErrorText = Text.Substring(index + 2, Text.Length - index - 2);

					AddErrorTask(bWarn, ErrorText, Filename, Line);
				}
			}
		}


		private ProjectItem GetStartupProject()
		{
			string StartupProj = (string)ApplicationObject.Solution.Properties.Item("StartupProject").Value;
			Solution3 CurrentSolution = ApplicationObject.Solution as Solution3;
			foreach ( Project Proj in CurrentSolution.Projects )
			{
				foreach ( ProjectItem Item in Proj.ProjectItems )
				{
					ProjectItem Result = FindStartupProject(Item, StartupProj);
					if (Result != null)
					{
						return Result;
					}
				}
			}

			return null;
		}

		private ProjectItem FindStartupProject(ProjectItem Item, string StartupProj)
		{
			if (Item.Name == StartupProj)
			{
				return Item;
			}

			ProjectItem Result;
			if (Item.SubProject != null && Item.SubProject.ProjectItems != null)
			{
				foreach (ProjectItem SubItem in Item.SubProject.ProjectItems)
				{
					Result = FindStartupProject(SubItem, StartupProj);
					if (Result != null) return Result;
				}
			}
			else if (Item.ProjectItems != null)
			{
				foreach (ProjectItem Child in Item.ProjectItems)
				{
					Result = FindStartupProject(Child,StartupProj);
					if ( Result != null ) return Result;
				}
			}			
			return null;
		}

	}
}