Imports System
Imports EnvDTE
Imports EnvDTE80
Imports EnvDTE90
Imports System.Diagnostics

Public Module TextEditor
    'Typically bound to "Ctrl-Alt-F"
    Sub FindInSolution()
	' Source : http://dvanderboom.wordpress.com/2008/03/21/visual-studio-macro-track-item-in-solution-explorer-on-demand/	
        Dim solution As Solution2 = DTE.Solution
        If Not solution.IsOpen OrElse DTE.ActiveDocument Is Nothing Then Return

        solution.FindProjectItem(DTE.ActiveDocument.FullName).ExpandView()

        Dim FileName As String = DTE.ActiveDocument.FullName

        Dim SolutionExplorerPath As String
        Dim items As EnvDTE.UIHierarchyItems = DTE.ToolWindows.SolutionExplorer.UIHierarchyItems
        Dim item As Object = FindItem(items, FileName, SolutionExplorerPath)

        If item Is Nothing Then
            MsgBox("Couldn't find the item in Solution Explorer.")
            Return
        End If

        DTE.Windows.Item(Constants.vsWindowKindSolutionExplorer).Activate()
        DTE.ActiveWindow.Object.GetItem(SolutionExplorerPath).Select(vsUISelectionType.vsUISelectionTypeSelect)
    End Sub

    Public Function FindItem(ByVal Children As UIHierarchyItems, ByVal FileName As String, ByRef SolutionExplorerPath As String) As Object
        For Each CurrentItem As UIHierarchyItem In Children
            Dim TypeName As String = Microsoft.VisualBasic.Information.TypeName(CurrentItem.Object)
            If TypeName = "ProjectItem" Then
                Dim projectitem As EnvDTE.ProjectItem = CType(CurrentItem.Object, EnvDTE.ProjectItem)
                Dim i As Integer = 1
                While i <= projectitem.FileCount
                    If projectitem.FileNames(i) = FileName Then
                        SolutionExplorerPath = CurrentItem.Name
                        Return CurrentItem
                    End If
                    i = i + 1
                End While
            End If

            Dim ChildItem As UIHierarchyItem = FindItem(CurrentItem.UIHierarchyItems, FileName, SolutionExplorerPath)
            If Not ChildItem Is Nothing Then
                SolutionExplorerPath = CurrentItem.Name + "\" + SolutionExplorerPath
                Return ChildItem
            End If
        Next
    End Function

    ' Builds a helper-struct with constructor from the highlighted variable declarations
    Sub MakeStruct()
        Dim TS As TextSelection = DTE.ActiveDocument.Selection
        Dim SelectionLines() As String = TS.Text.Split(vbNewLine)

        Dim ConstructorDecl As String
        Dim ConstructorInit As String

        Dim StructName As String = InputBox("Enter a name for the struct")
        If StructName <> "" Then
            TS.Delete()
            TS.Indent()
            TS.Insert("struct " + StructName)
            TS.NewLine()
            TS.Unindent()
            TS.Insert("{")
            TS.NewLine()

            For Each Line In SelectionLines
                Line = Line.Trim()
                Dim i = Line.IndexOf(";")
                If i <> -1 Then
                    Dim ExprText As String = Line.Substring(0, i)

                    If ExprText <> "" Then
                        i = ExprText.LastIndexOf(" ")
                        Dim VarType As String = ExprText.Substring(0, i)
                        Dim VarName As String = ExprText.Substring(i + 1)

                        If ConstructorDecl <> "" Then
                            ConstructorDecl = ConstructorDecl + ", "
                        End If
                        ConstructorDecl = ConstructorDecl + VarType + " In" + VarName

                        If ConstructorInit <> "" Then
                            ConstructorInit = ConstructorInit + "," + vbTab + VarName + "(In" + VarName + ")" + vbNewLine
                        Else
                            ConstructorInit = ConstructorInit + ":" + vbTab + VarName + "(In" + VarName + ")" + vbNewLine
                        End If
                    End If
                End If

                TS.Insert(Line)
                TS.NewLine()
            Next

            ConstructorInit = ConstructorInit + "{}"

            TS.Insert(StructName + "(" + ConstructorDecl + ")")
            TS.NewLine()
            TS.Unindent()
            For Each Line In ConstructorInit.Split(vbNewLine)
                TS.Insert(Line.Trim())
                TS.NewLine()
            Next
            TS.Unindent()
            TS.Insert("};")
            TS.NewLine()
        End If
    End Sub

End Module
