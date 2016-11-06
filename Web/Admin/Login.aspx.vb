Imports Model
Imports CommonLibrary.Globals
Imports CommonLibrary.Members
Imports CommonLibrary

Public Class Login
    Inherits System.Web.UI.Page

#Region "Members"
    Private UserId As Integer
    Private UserFullName As String
    Private UserGroupId As Integer
    Private AlertMessage As String
    Private msgUserDenied As String = "User is not an Administrator"
    Private msgWrongUserPassword As String = "Wrong Username or Password"
    Private msgInvalidUsername As String = "Username does not exist"
    Private msgInvalidUsernameEmail As String = "Username email should not be empty"
#End Region


#Region "Page Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            ClearMessageFields()
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
    End Sub
#End Region

#Region "Control Events"
    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        If ValidateData(False) AndAlso LoginUser() Then
            pUserId = UserId
            pUserFullName = UserFullName
            Response.Redirect("Default.aspx")
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "TriggerShowAlertMessage", "$(function () { ShowAlertMessage('" + AlertMessage + "') }); ", True)
        End If
    End Sub

    Protected Sub btnResetPassword_Click(sender As Object, e As EventArgs) Handles btnResetPassword.Click
        Dim Redirect As Boolean = False
        Dim UserToEdit As New User
        Try
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))
            Dim Username As String = txtUsername.Text

            UserToEdit = (From item In dbModel.Users Where item.Username = Username Select item).FirstOrDefault()
            If UserToEdit IsNot Nothing AndAlso UserToEdit.Email IsNot Nothing AndAlso Not String.IsNullOrEmpty(UserToEdit.Email) Then
                Redirect = True
            ElseIf (UserToEdit IsNot Nothing AndAlso UserToEdit.Email IsNot Nothing AndAlso String.IsNullOrEmpty(UserToEdit.Email)) Or (UserToEdit IsNot Nothing AndAlso UserToEdit.Email Is Nothing) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgInvalidUsernameEmail & "') }); ", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgInvalidUsername & "') }); ", True)
            End If

        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try

        If Redirect Then Response.Redirect("~/ResetPassword.aspx?UserId=" & UserToEdit.UserId)
    End Sub
#End Region

#Region "Methods"
    Protected Sub ClearMessageFields()
        lblError.Text = ""
    End Sub

    Protected Function LoginUser() As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim clsUsers As New Business.Users
            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))

            Dim Username As String = txtUsername.Text
            Dim Password As String = wrapper.EncryptData(txtPassword.Text)

            Dim User As New v_GetUsersInformations
            User = (From item In dbModel.v_GetUsersInformations
                    Where item.Username = Username _
                    And item.Password = Password _
                    And item.IsActive = True
                    Select item).FirstOrDefault()

            If User IsNot Nothing AndAlso clsUsers.IsUserAdmin(User.UserId) Then
                UserId = User.UserId
                UserFullName = User.FirstName & " " & User.LastName
                Succeeded = True
            ElseIf User IsNot Nothing AndAlso Not clsUsers.IsUserAdmin(User.UserId) Then
                Succeeded = False
                AlertMessage = msgUserDenied
            ElseIf User Is Nothing Then
                Succeeded = False
                AlertMessage = msgWrongUserPassword
            End If
            Return Succeeded
        Catch ex As Exception
            Succeeded = False
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
            Return Succeeded
        End Try
    End Function

    Protected Function ValidateData(ByVal ForgotPasswordClicked As Boolean) As Boolean
        Dim valid As Boolean = True

        If String.IsNullOrEmpty(Trim(txtUsername.Text)) Then
            RFV_Username.IsValid = False
            valid = False
        ElseIf txtUsername.Text.Length > 50 Then
            CVUsername.IsValid = False
            valid = False
        End If

        If Not ForgotPasswordClicked AndAlso String.IsNullOrEmpty(Trim(txtPassword.Text)) Then
            RFV_Password.IsValid = False
            valid = False
        ElseIf Not ForgotPasswordClicked AndAlso txtPassword.Text.Length > 50 Then
            CVPassword.IsValid = False
            valid = False
        End If

        Return valid
    End Function
#End Region


End Class