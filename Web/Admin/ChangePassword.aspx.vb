Imports Model
Imports CommonLibrary
Imports CommonLibrary.Globals
Imports CommonLibrary.Members

Public Class ChangePassword
    Inherits System.Web.UI.Page


#Region "Members"
    Dim msgChangedSuccessfully As String = "Password changed successfully."
#End Region

#Region "Page Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            ClearMessages()
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, enumUsersActions.Read)
        End Try
    End Sub
#End Region

#Region "Control Events"
    Protected Sub btnClearBottom_Click(sender As Object, e As EventArgs) Handles btnClearBottom.Click
        Clear()
    End Sub

    Protected Sub btnChange_Click(sender As Object, e As EventArgs) Handles btnChange.Click
        Try
            If ValidateData() Then
                ChangeUserPassword()
                lblMessage.Text = msgChangedSuccessfully
                Clear()
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, enumUsersActions.Update)
        End Try
    End Sub
#End Region


#Region "Methods"
    Protected Sub Clear()
        txtOldPassword.Text = ""
        txtNewPassword.Text = ""
        txtRetypeNewPassword.Text = ""
    End Sub

    Protected Sub ClearMessages()
        lblMessage.Text = ""
        lblError.Text = ""
    End Sub

    Protected Function ValidateData() As Boolean
        Dim valid As Boolean = True

        If String.IsNullOrEmpty(Trim(txtOldPassword.Text)) Then
            RVOldPassword.IsValid = False
            valid = False
        ElseIf txtOldPassword.Text.Length > 50 Then
            CVMOldPassword.IsValid = False
            valid = False
        ElseIf Not CorrectPassword() Then
            CVIncorrectPassword.IsValid = False
            valid = False
        End If

        If String.IsNullOrEmpty(Trim(txtNewPassword.Text)) Then
            RVNewPassword.IsValid = False
            valid = False
        ElseIf txtNewPassword.Text.Length > 50 Then
            CVNewPassword.IsValid = False
            valid = False
        End If

        If String.IsNullOrEmpty(Trim(txtRetypeNewPassword.Text)) Then
            RVRetypeNewPassword.IsValid = False
            valid = False
        ElseIf txtRetypeNewPassword.Text.Length > 50 Then
            CVRetypeNewPassword.IsValid = False
            valid = False
        ElseIf Not (txtNewPassword.Text = txtRetypeNewPassword.Text) Then
            CV_Oldpassword.IsValid = False
            valid = False
        End If

        Return valid
    End Function

    Protected Function CorrectPassword() As Boolean
        Dim Correct As Boolean = False
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))
        Dim UserPassword As String = wrapper.EncryptData(txtOldPassword.Text)
        Dim clsUsers As New Business.Users

        Correct = clsUsers.IsUserPasswordCorrect(pUserId, dbModel, UserPassword)
        
        Return Correct
    End Function

    Protected Function ChangeUserPassword() As Boolean
        Dim Succeeded As Boolean = False
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))
        Dim NewPassword As String = wrapper.EncryptData(txtNewPassword.Text)
        Dim clsUsers As New Business.Users

        Succeeded = clsUsers.ChangeUserPassword(pUserId, dbModel, NewPassword)

        Return Succeeded
    End Function

#End Region


End Class