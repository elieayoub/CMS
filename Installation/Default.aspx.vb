Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Microsoft.SqlServer.Management.Smo
Imports Microsoft.SqlServer.Management.Common
Imports System.IO
Imports System.IO.Compression
Imports System.Data.SqlClient
Imports Ionic.Zip

Public Class _Default
    Inherits System.Web.UI.Page

#Region "Members"
    Private ProjectPath As String
    Private NewProjectFileName As String
    Private ABCCMSFolderName As String = "ABC CMS"
    Private msgInvalidInput As String = "All fields are required."
    Private SQLScriptFilePath As String = "~/SQLScripts/sqlScript.sql"
    Private msgDownloadProject As String = "Use this <a href='{0}'>link</a> to download the created project."
    Private msgProjectCreated As String = "Project created successfully. <br />Make sure to modify the web.config connection string."
#End Region

#Region "Page Events"
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        ClearMessageFields()
    End Sub
#End Region

#Region "Control Events"
    Protected Sub btnFinish_Click(sender As Object, e As System.EventArgs) Handles btnFinish.Click
        Try
            If Not IsValidInput() Then
                lblError.Text = msgInvalidInput
                Exit Sub
            End If

            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))
            Dim DatabaseServerName As String = txtDatabaseServerName.Text.Trim
            Dim DatabaseName As String = txtDatabaseName.Text.Trim
            Dim DatabaseOwnerUsername As String = txtDatabaseOwnerUsername.Text.Trim
            Dim DatabaseOwnerPassword As String = txtDatabaseOwnerPassword.Text.Trim
            Dim AdministratorUsername As String = txtAdministratorUsername.Text.Trim
            Dim AdministratorPassword As String = wrapper.EncryptData(txtAdministratorPassword.Text.Trim)
            Dim AdministratorRoleName As String = txtAdministratorRoleName.Text.Trim
            Dim AdministratorFirstname As String = txtAdministratorFirstname.Text.Trim
            Dim AdministratorLastname As String = txtAdministratorLastname.Text.Trim
            Dim AdministratorEmail As String = txtAdministratorEmail.Text.Trim
            Dim today As DateTime = DateTime.Now
            Dim todayMMS As Integer = ConvertDateToMMS(DateTime.Now)

            Dim SQLConnectionString = String.Format(ConfigurationManager.ConnectionStrings.Item("con").ConnectionString, DatabaseServerName, DatabaseName, DatabaseOwnerUsername, DatabaseOwnerPassword)

            Dim file As FileInfo = New FileInfo(HttpContext.Current.Server.MapPath(SQLScriptFilePath))
            Dim SQLScript As String = file.OpenText().ReadToEnd()

            'Replace with users input
            SQLScript = SQLScript.Replace("<today>", "'" & today & "'")
            SQLScript = SQLScript.Replace("<todayMMS>", todayMMS)

            'Replace with users input for Entities table
            SQLScript = SQLScript.Replace("<AdministratorFirstname>", "'" & AdministratorFirstname & "'")
            SQLScript = SQLScript.Replace("<AdministratorLastname>", "'" & AdministratorLastname & "'")

            'Replace with users input for Users table
            SQLScript = SQLScript.Replace("<AdministratorUsername>", "'" & AdministratorUsername & "'")
            SQLScript = SQLScript.Replace("<AdministratorPassword>", "'" & AdministratorPassword & "'")
            SQLScript = SQLScript.Replace("<AdministratorEmail>", "'" & AdministratorEmail & "'")

            'Replace with users input for Roles table
            SQLScript = SQLScript.Replace("<AdministratorRoleName>", "'" & AdministratorRoleName & "'")

            Dim conn As New SqlConnection(SQLConnectionString)
            Dim server As Microsoft.SqlServer.Management.Smo.Server = New Microsoft.SqlServer.Management.Smo.Server(New ServerConnection(conn))

            server.ConnectionContext.ExecuteNonQuery(SQLScript)
            file.OpenText().Close()

            Dim ProjectPath As String = CreateNewProject()
            If Not String.IsNullOrEmpty(ProjectPath) Then
                lblMessage.Text = msgProjectCreated
                lblDownloadProject.Text = String.Format(msgDownloadProject, "Projects/" & NewProjectFileName)
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowFinishStep", "$(function () {GoToStep3();});", True)
            End If

        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message & ex.StackTrace
        End Try

    End Sub
#End Region

#Region "Methods"
    Public Sub ClearMessageFields()
        lblError.Text = ""
        lblMessage.Text = ""
        lblDownloadProject.Text = ""
    End Sub

    Public Function GetFromConfig(ByVal key As String) As String
        Return ConfigurationManager.AppSettings.Item(key)
    End Function

    Public Function ConvertDateToMMS(ByVal d As Date) As Integer
        Dim returnVal As Integer
        Try
            returnVal = Val(Format(d, "yyMMdd"))
        Catch ex As Exception
        End Try
        Return returnVal
    End Function

    Protected Function CreateNewProject() As String
        Try
            Dim lstFilesToCompress As New List(Of FileInfo)
            Dim CMSInstallationFolderPath As String = HttpContext.Current.Server.MapPath(".")
            Dim CMSApplicationFolderPath As String = CMSInstallationFolderPath.Substring(0, CMSInstallationFolderPath.LastIndexOf("\") + 1) '& ABCCMSFolderName
            Dim CMSInstallationProjectsPath As String = CMSInstallationFolderPath & "\Projects\"

            'Empty projects folder
            EmptyFolder(CMSInstallationProjectsPath)

            NewProjectFileName = "CMSProject.zip"
            ProjectPath = CMSInstallationProjectsPath & NewProjectFileName
            Using zip As ZipFile = New ZipFile
                zip.AddDirectory(CMSApplicationFolderPath)
                zip.Save(ProjectPath)
            End Using
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
        End Try
        Return ProjectPath
    End Function

    Public Sub EmptyFolder(ByVal directoryPath As String)
        For Each f In New DirectoryInfo(directoryPath).GetFiles
            f.Delete()
        Next
    End Sub

    Public Function IsValidInput() As Boolean
        Dim valid As Boolean = True
        If String.IsNullOrEmpty(txtDatabaseServerName.Text.Trim) Then
            valid = False
            RVDatabaseServerName.IsValid = False
        End If
        If String.IsNullOrEmpty(txtDatabaseName.Text.Trim) Then
            valid = False
            RVDatabaseName.IsValid = False
        End If
        If String.IsNullOrEmpty(txtDatabaseOwnerUsername.Text.Trim) Then
            valid = False
            RVDatabaseOwnerUsername.IsValid = False
        End If
        If String.IsNullOrEmpty(txtDatabaseOwnerPassword.Text.Trim) Then
            valid = False
            RVDatabaseOwnerPassword.IsValid = False
        End If
        If String.IsNullOrEmpty(txtAdministratorUsername.Text.Trim) Then
            valid = False
            RVAdministratorUsername.IsValid = False
        End If
        If String.IsNullOrEmpty(txtAdministratorPassword.Text.Trim) Then
            valid = False
            RVAdministratorPassword.IsValid = False
        End If
        If String.IsNullOrEmpty(txtAdministratorRoleName.Text.Trim) Then
            valid = False
            RVAdministratorRoleName.IsValid = False
        End If
        If String.IsNullOrEmpty(txtAdministratorFirstname.Text.Trim) Then
            valid = False
            RVAdministratorFirstname.IsValid = False
        End If
        If String.IsNullOrEmpty(txtAdministratorLastname.Text.Trim) Then
            valid = False
            RVAdministratorLastname.IsValid = False
        End If
        If String.IsNullOrEmpty(txtAdministratorEmail.Text.Trim) Then
            valid = False
            RVAdministratorEmail.IsValid = False
        End If
        Return valid
    End Function

#End Region
End Class