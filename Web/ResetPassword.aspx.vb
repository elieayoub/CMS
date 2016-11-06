Imports Model
Imports CommonLibrary
Imports CommonLibrary.Globals
Imports CommonLibrary.Members

Public Class ResetPassword
    Inherits System.Web.UI.Page


#Region "Members"
    Private msgResetPassword As String = "Password reset successfully and sent by email"
    Private msgInvalidUsernameEmail As String = "Username email should not be empty"
    Private msgInvalidUsername As String = "Username does not exist"
#End Region


#Region "Page Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ClearMessageFields()
        If Not IsPostBack Then
            BindLabels()
        End If
    End Sub
#End Region

#Region "Control Events"
    Protected Sub btnResetPassword_Click(sender As Object, e As EventArgs) Handles btnResetPassword.Click
        Try
            Dim clsUsers As New Business.Users
            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))

            Dim UserId As Integer = qUserId(Request)
            Dim ResetPasswordUser As New User
            Dim rnd As Random = New Random
            Dim password As String = rnd.Next(1, 1000000)
            Dim newPassword As String = wrapper.EncryptData(password)
            ResetPasswordUser = clsUsers.ResetUserPassword(UserId, newPassword)
            If ResetPasswordUser IsNot Nothing AndAlso ResetPasswordUser.Email IsNot Nothing AndAlso Not String.IsNullOrEmpty(ResetPasswordUser.Email) Then
                Dim Email As String = ResetPasswordUser.Email.Trim
                If (SendResetPasswordEmail(Email, password)) Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgResetPassword & "') }); ", True)
                End If
            ElseIf (ResetPasswordUser IsNot Nothing AndAlso ResetPasswordUser.Email IsNot Nothing AndAlso String.IsNullOrEmpty(ResetPasswordUser.Email)) Or (ResetPasswordUser IsNot Nothing AndAlso ResetPasswordUser.Email Is Nothing) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgInvalidUsernameEmail & "') }); ", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgInvalidUsername & "') }); ", True)
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, enumUsersActions.Update)
        End Try
    End Sub
#End Region

#Region "Methods"
    Protected Sub ClearMessageFields()
        lblMessage.Text = ""
        lblError.Text = ""
    End Sub

    Protected Sub BindLabels()
        Try
            Dim clsUsers As New Business.Users
            Dim dbModel As New ABC_CMSApplicationEntities

            Dim UserId As Integer = qUserId(Request)
            Dim UserToEdit As New v_GetUsersInformations
            UserToEdit = clsUsers.GetUserInformationDataById(UserId, dbModel)
            If UserToEdit IsNot Nothing AndAlso UserToEdit.Email IsNot Nothing AndAlso Not String.IsNullOrEmpty(UserToEdit.Email) Then
            lblFirstName.Text = UserToEdit.FirstName.Trim
            lblLastName.Text = UserToEdit.LastName.Trim
            lblLastName.Text = UserToEdit.LastName.Trim
            lblUsername.Text = UserToEdit.Username.Trim
            lblActive.Text = UserToEdit.IsActive
            lblEmail.Text = UserToEdit.Email.Trim

            ElseIf (UserToEdit IsNot Nothing AndAlso UserToEdit.Email IsNot Nothing AndAlso String.IsNullOrEmpty(UserToEdit.Email)) Or (UserToEdit IsNot Nothing AndAlso UserToEdit.Email Is Nothing) Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgInvalidUsernameEmail & "') }); ", True)
            Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerAlertMesasge", "$(function () { ShowAlertMessage('" & msgInvalidUsername & "') }); ", True)
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, enumUsersActions.Read)
        End Try
    End Sub

    Private Function SendResetPasswordEmail(ByVal ToEmail As String, ByVal Password As String) As Boolean
        Dim Succeeded As Boolean = False
        Dim SendEmailReturnMsg As String = String.Empty
        Try
            Dim FromEmail, Subject, Body As String
            Dim CcEmail As String = String.Empty, BccEmail As String = String.Empty
            FromEmail = GetFromConfig("FromEmailAddress")
            Subject = GetFromConfig("ResetPasswordEmailSubject")
            Body = String.Concat(GetFromConfig("ResetPasswordEmailBody"), " ", Password)

            SendEmailReturnMsg = SendMail(Body, {}, FromEmail, ToEmail, CcEmail, BccEmail, Subject)
            If (Not String.IsNullOrEmpty(SendEmailReturnMsg)) Then
                Succeeded = False
                lblError.Visible = True
                lblError.Text = "Error: " & SendEmailReturnMsg
            Else
                Succeeded = True
            End If
        Catch ex As Exception
            Succeeded = False
            lblError.Visible = True
            lblError.Text = "Error: " & ex.Message
        End Try
        Return Succeeded
    End Function
#End Region

End Class