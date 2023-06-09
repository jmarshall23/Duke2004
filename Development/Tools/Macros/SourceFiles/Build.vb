Imports System
Imports EnvDTE
Imports EnvDTE80
Imports EnvDTE90
Imports System.Diagnostics
Imports System.Windows.Forms
Imports System.Collections
Imports System.IO


Public Module Build
    'Typically bound to "F7"
    Sub BuildStartupProject()
        DTE.ExecuteCommand("View.Output")
        Dim sb As SolutionBuild = DTE.Solution.SolutionBuild
        Dim projName As String = sb.StartupProjects(0)
        sb.BuildProject(sb.ActiveConfiguration.Name + "|" + sb.ActiveConfiguration.PlatformName, projName, False)
    End Sub

    'COMPILING SCRIPT
    'To set this up first create a custom external tool entry:
    'Visual Studio -> Tools -> ExternalCommands
    'Title: Build Script Release
    'Command: <full path>\UnrealEngine3\Binaries\Win32\<your game>.com
    'Arguments: make
    'Initial Directory: $(TargetDir)..\..\
    'Use Output Window: checked

    'Typically bound to "Shift-F7"
    Sub MakeScriptRelease()
        DTE.ExecuteCommand("View.Output")
        DTE.ExecuteCommand("File.SaveAll")
        ' Note: assumes script make release is properly set up as ExternalCommand1
        DTE.ExecuteCommand("Tools.ExternalCommand1")
    End Sub

    Sub MakeScriptDebug()
        DTE.ExecuteCommand("View.Output")
        DTE.ExecuteCommand("File.SaveAll")
        ' Note: assumes make release is properly set up as ExternalCommand2
        DTE.ExecuteCommand("Tools.ExternalCommand2")
    End Sub


    'COMPILE SCRIPT WITH THE CURRENT STARTUP PROJECT AND CONFIGURATION

    'To use this, first create a custom external tool entry:
    'Visual Studio -> Tools -> ExternalCommands
    'Title: UnrealScript Compiler
    'Command: C:\Utils\UCCMake.bat
    '   ==> The macro will create this batch file each time, but you may need to make a temporary batch file with this name the first time you setup this external command.
    'Use Output Window: checked
    'This entry MUST be the first entry in the External Commands list.

    'This uses the freeware KillProcess.exe from http://orangelampsoftware.com/products_killprocess.php to stop a make in progress, stored in C:\Utils.

    'Typically bound to "Shift-F7"

    Sub BuildStartupProjectScript()
        Dim FSO = CreateObject("Scripting.FileSystemObject")
        Dim project_name As String = CType(DTE.Solution.SolutionBuild.StartupProjects(0), String)
        Dim project As EnvDTE.Project = FindProjects(DTE.Solution.Projects, project_name)
        Dim config As Configuration = project.ConfigurationManager.ActiveConfiguration

        ' remove file:///
        Dim target_path_exe As String = config.OutputGroups.Item(1).FileURLs(0).ToString().Remove(0, 8)
        ' Remove "exe"
        Dim target_path = target_path_exe.Remove(target_path_exe.Length - 3, 3)

        Dim batchfile = FSO.CreateTextFile("c:\utils\UCCMake.bat", True)

        If (FSO.FileExists("c:\utils\uccmakerunning.bat")) Then
            ' Kill any process already running
            System.Diagnostics.Process.Start("c:\utils\uccmakerunning.bat")
            batchfile.WriteLine("@echo Terminated: " + target_path + "com make")
            batchfile.WriteLine("@del c:\utils\uccmake.bat")
        Else
            batchfile.WriteLine("@echo @c:\utils\killprocess " + target_path_exe + " > c:\utils\uccmakerunning.bat")
            batchfile.WriteLine("@echo @del c:\utils\uccmakerunning.bat >> c:\utils\uccmakerunning.bat")
            batchfile.WriteLine(target_path + "com make")
            batchfile.WriteLine("@del c:\utils\uccmakerunning.bat")
            batchfile.WriteLine("@del c:\utils\uccmake.bat")
        End If

        batchfile.Close()

        DTE.ExecuteCommand("File.SaveAll")

        ' The first external tool should be set to call the above batch file, using the Output window for stdout.
        DTE.ExecuteCommand("Tools.ExternalCommand1")

    End Sub

    'FindProject / FindProjectItems / FindProjects are thanks to this post: http://code.google.com/p/chromium/wiki/WindowsVisualStudioMacros
    Function FindProjectItems(ByVal project_items As EnvDTE.ProjectItems, ByVal project_name As String) As EnvDTE.Project
        FindProjectItems = Nothing
        For Each project_item As EnvDTE.ProjectItem In project_items
            If Not project_item.SubProject Is Nothing Then
                FindProjectItems = FindProject(project_item.SubProject, project_name)
                If Not FindProjectItems Is Nothing Then Exit Function
            End If
        Next
    End Function

    Function FindProject(ByVal project As EnvDTE.Project, ByVal project_name As String) As EnvDTE.Project
        If project.UniqueName = project_name Then
            FindProject = project
            Exit Function
        End If
        If Not project.ProjectItems Is Nothing Then
            FindProject = FindProjectItems(project.ProjectItems, project_name)
            If Not FindProject Is Nothing Then Exit Function
        End If
    End Function

    Function FindProjects(ByVal projects As EnvDTE.Projects, ByVal project_name As String) As EnvDTE.Project
        ' You never thought it'd be so complex to find a project. The VS extensibility team
        ' stole me an hour of my life I will never get back.
        FindProjects = Nothing
        For Each project As EnvDTE.Project In projects
            FindProjects = FindProject(project, project_name)
            If Not FindProjects Is Nothing Then Exit Function
        Next
    End Function


    Function LoadArray(ByVal filename As String) As ArrayList
        If Not File.Exists(filename) Then
            Return New ArrayList
        End If
        Dim reader As New StreamReader(filename, True)
        Dim result As New ArrayList
        Do
            Dim line As String = reader.ReadLine
            If line = vbNullString Then
                Exit Do
            End If
            result.Add(line)
        Loop
        reader.Close()
        Return result
    End Function


    Sub SaveArray(ByVal filename As String, ByVal arraylist As ArrayList)
        Dim writer As New StreamWriter(filename, False)
        For Each line As String In arraylist
            writer.WriteLine(line)
        Next
        writer.Close()
    End Sub



    Sub CommandArguments()
        Dim project_name As String = CType(DTE.Solution.SolutionBuild.StartupProjects(0), String)
        Dim project As EnvDTE.Project = FindProjects(DTE.Solution.Projects, project_name)
        Dim props As Properties = project.ConfigurationManager.ActiveConfiguration.Properties
        Dim cmdline As String = props.Item("CommandArguments").Value
        Dim mrufilename As String = Replace(project.FullName, ".vcproj", "_mrulist.txt")

        Dim combo As New ComboBox
        Dim form As New Form
        Dim button As New Button

        'load history, moving current command line to MRU
        Dim CommandHistory As ArrayList = LoadArray(mrufilename)
        CommandHistory.Remove(cmdline)
        CommandHistory.Insert(0, cmdline)

        For Each s As String In CommandHistory
            combo.Items.Add(s)
        Next
        combo.SelectedIndex = 0

        button.Text = "OK"
        button.DialogResult = DialogResult.OK
        form.Controls.Add(button)
        button.Dock = DockStyle.Bottom

        form.Text = "Command Arguments"
        form.Controls.Add(combo)
        form.AcceptButton = button

        combo.Dock = DockStyle.Top
        combo.TabIndex = 0
        combo.SelectAll()

        If form.ShowDialog() = DialogResult.OK Then
            ' update
            cmdline = combo.Text
            props.Item("CommandArguments").Value = cmdline

            ' save history
            CommandHistory.Remove(cmdline)
            CommandHistory.Insert(0, cmdline)
            SaveArray(mrufilename, CommandHistory)
        End If
    End Sub

End Module
