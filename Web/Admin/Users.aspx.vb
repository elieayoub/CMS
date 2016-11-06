Imports Model
Imports System.Web.Services
Imports CommonLibrary
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class Users
    Inherits System.Web.UI.Page


#Region "Members"
    Private IsInsert As Boolean
    Private msgInsertedSuccessfully As String = "User inserted successfully"
    Private msgUpdatedSuccessfully As String = "User updated successfully"
    Private msgPleaseSelectAUser As String = "Please select a user from the top table to update it"
    Private msgNoUserPermissionUpdate As String = "You do not have access to Update"
    Private msgNoUserPermissionInsert As String = "You do not have access to Insert"
#End Region

#Region "Page Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim hasPermission As Boolean = True
        Try
            ClearMessageFields()
            If Not Page.IsPostBack Then
                Dim clsPermissions As New Business.Permissions
                hasPermission = clsPermissions.hasUserControlsPermissions(enumUsersActions.Read, enumPermissionsControls.Admin_UsersPage, pUserId)
                If hasPermission Then
                    ClearFields()
                    txtPassword.Attributes("type") = "password"
                    BindRoles()
                    SearchGrid(0)
                End If
            End If

            CheckUserControlsPermissionsOnLoad()
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Read)
        Finally
            If Not hasPermission Then
                Response.Redirect("Default.aspx")
            End If
        End Try
    End Sub
#End Region

#Region "Control Events"
    Protected Sub gvSearch_PageIndexChanged(sender As Object, e As EventArgs) Handles gvSearch.PageIndexChanged
        gvSearch.SelectedIndex = -1
    End Sub

    Protected Sub btnInsert_Click(sender As Object, e As EventArgs) Handles btnInsert.Click
        Try
            Dim InsertSucceeded As Boolean
            Dim NewItemId As Integer = 0
            NewItemId = InsertUser()
            If InsertSucceeded Then
                lblMessage.Text = msgInsertedSuccessfully
                SendEmail(True, txtEmail.Text)
                ClearFields()
                SearchGrid(NewItemId)
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Users, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Create)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Create)
        End Try

    End Sub

    Protected Sub btnInsertAndNew_Click(sender As Object, e As EventArgs) Handles btnInsertAndNew.Click
        Try
            ClearMessageFields()
            Dim NewItemId As Integer = 0
            NewItemId = InsertUser()
            If NewItemId <> 0 Then
                lblMessage.Text = msgInsertedSuccessfully
                SendEmail(True, txtEmail.Text)
                ClearFields()
                SearchGrid(0)
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Users, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Create)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Create)
        End Try
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Try
            Dim UpdateSucceeded As Boolean
            Dim UserIdToUpdate As Integer = Val(hfSelectedUserId.Value)
            Dim UserEntityIdToUpdate As Integer = Val(hfSelectedUserEntityId.Value)

            If UserIdToUpdate = 0 AndAlso UserEntityIdToUpdate = 0 Then
                lblMessage.Text = msgPleaseSelectAUser
            Else
                UpdateSucceeded = UpdateUser(UserIdToUpdate, UserEntityIdToUpdate)
                If UpdateSucceeded Then
                    lblMessage.Text = msgUpdatedSuccessfully
                    SendEmail(False, txtEmail.Text)
                    ClearFields()
                    SearchGrid(UserIdToUpdate)
                End If
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Users, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Update)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Update)
        End Try
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Try
            ClearFieldsForSearch()
            ClearMessageFields()
            SearchGrid(0)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Read)
        End Try
    End Sub

    Protected Sub gvSearch_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvSearch.SelectedIndexChanged
        Dim EditedUserEntityId As Integer
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim clsPermissions As New Business.Permissions
        Dim clsUsersRepository As New Data.UsersRepository
        Dim clsRolesRepository As New Data.RolesRepository
        Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))

        Try
            Dim SelectedUserId As Integer = gvSearch.SelectedDataKey.Item("UserId")
            hfSelectedUserId.Value = SelectedUserId
            hfSelectedUserEntityId.Value = gvSearch.SelectedDataKey.Item("EntityId")
            Dim UserId As Integer = gvSearch.SelectedDataKey.Value
            Dim User As New User
            Dim UserEntity As New Entity
            Dim lstUserRoles As New List(Of UsersRole)

            User = clsUsersRepository.GetUserDataById(UserId, dbModel)
            If User IsNot Nothing Then
                txtUsername.Text = User.Username.Trim
                txtPassword.Text = wrapper.DecryptData(User.Password.Trim)
                txtEmail.Text = User.Email.Trim
                cbxActive.Checked = User.IsActive
                btnCheckUserAvailability.Disabled = True
            End If

            EditedUserEntityId = User.EntityId
            UserEntity = clsUsersRepository.GetUserEntityDataById(EditedUserEntityId, dbModel)
            If UserEntity IsNot Nothing Then
                txtFirstName.Text = UserEntity.FirstName.Trim
                txtLastName.Text = UserEntity.LastName.Trim

                btnUpdate.Enabled = True
            End If

            lstUserRoles = clsRolesRepository.GetUserRoles(SelectedUserId)
            Dim cbxRoleId As Integer = 0
            Dim hasRole As Boolean = False
            If cblRoles IsNot Nothing AndAlso lstUserRoles IsNot Nothing Then
                For Each cbxRole As ListItem In cblRoles.Items
                    cbxRoleId = Val(cbxRole.Value)
                    hasRole = IIf((From item In lstUserRoles Where item.RoleId = cbxRoleId Select item).Count() > 0, True, False)
                    cbxRole.Selected = hasRole
                Next
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Users, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Read)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, enumUsersActions.Read)
        End Try
    End Sub

    Protected Sub btnClearBottom_Click(sender As Object, e As EventArgs) Handles btnClearBottom.Click, btnClearTop.Click
        ClearMessageFields()
        ClearFields()
        SearchGrid(0)
    End Sub
#End Region

#Region "Methods"

    Protected Sub CheckUserControlsPermissionsOnLoad()
        Dim hasPermission As Boolean = False
        Dim clsPermissions As New Business.Permissions
        hasPermission = clsPermissions.hasUserControlsPermissions(enumUsersActions.Read, enumPermissionsControls.Admin_UsersPage_RolesModule, pUserId)

        If Not hasPermission Then
            cblRoles.Visible = False
            cblRoles_NoAccess.Visible = True
        End If
    End Sub

    Protected Sub SearchGrid(ByVal ItemId As Integer)
        gvSearch.PageIndex = 0
        If ItemId = 0 Then
            ESSearchUser.WhereParameters("NewItemId").DefaultValue = 0
        Else
            ESSearchUser.WhereParameters("NewItemId").DefaultValue = ItemId
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "TriggerGvSelect", "$(function () { SelectGridViewFirstRow(); }); ", True)
        End If

        gvSearch.SelectedIndex = -1
        gvSearch.DataSourceID = "ESSearchUser"
        gvSearch.Visible = True
    End Sub

    Protected Function hasUserControlPermission(ByVal UserActionId As Integer, ByVal ControlId As Integer) As Boolean
        Dim hasPermission As Boolean = False
        Dim clsPermissions As New Business.Permissions
        hasPermission = clsPermissions.hasUserControlsPermissions(UserActionId, ControlId, pUserId)
        Return hasPermission
    End Function

    Protected Sub ClearMessageFields()
        lblMessage.Text = ""
        lblError.Text = ""
    End Sub

    Protected Sub ClearFields()
        txtFirstName.Text = ""
        txtLastName.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        txtEmail.Text = ""
        cbxActive.Checked = True
        btnCheckUserAvailability.Disabled = False

        gvSearch.SelectedIndex = -1
        gvSearch.Visible = False
        cbxActiveSearch.Checked = True
        txtSearchFor.Text = ""

        hfSelectedUserId.Value = ""
        btnUpdate.Enabled = False

        cblRoles.SelectedIndex = -1
        lblUsernameStatus.Text = ""
    End Sub

    Protected Sub ClearFieldsForSearch()
        txtFirstName.Text = ""
        txtLastName.Text = ""
        txtUsername.Text = ""
        txtPassword.Text = ""
        txtEmail.Text = ""
        cbxActive.Checked = True
        btnCheckUserAvailability.Disabled = False

        gvSearch.SelectedIndex = -1
        'gvSearch.Visible = False

        hfSelectedUserId.Value = ""
        btnUpdate.Enabled = False

        cblRoles.SelectedIndex = -1
        lblUsernameStatus.Text = ""
    End Sub

    Protected Function InsertUser() As Integer
        Dim Succeeded As Boolean = False
        Dim NewItemId As Integer = 0

        If ValidateData() Then

            Dim clsPermissions As New Business.Permissions
            Dim clsUsers As Business.Users = New Business.Users

            If clsPermissions.hasUserControlPermission(enumUsersActions.Create, enumPermissionsControls.Admin_UsersPage, pUserId) Then
                NewItemId = clsUsers.InsertUser(txtFirstName.Text.Trim, txtLastName.Text.Trim, txtUsername.Text.Trim, txtEmail.Text.Trim, txtPassword.Text.Trim, cbxActive.Checked, cblRoles)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessage2", "$(function () { ShowAlertMessage('" + msgNoUserPermissionInsert + "') }); ", True)
            End If

        End If

        Return NewItemId
    End Function

    Protected Function UpdateUser(ByVal SelectedUserId As Integer, ByVal SelectedUserEntityIdToUpdate As Integer) As Boolean

        Dim Succeeded As Boolean = False

        If ValidateData() Then

            Dim clsPermissions As New Business.Permissions
            Dim clsUsers As Business.Users = New Business.Users

            If clsPermissions.hasUserControlPermission(enumUsersActions.Update, enumPermissionsControls.Admin_UsersPage, pUserId) Then
                Succeeded = clsUsers.UpdateUser(SelectedUserId, SelectedUserEntityIdToUpdate, txtFirstName.Text.Trim, txtLastName.Text.Trim, txtUsername.Text.Trim, txtPassword.Text.Trim, txtEmail.Text.Trim, cbxActive.Checked, cblRoles)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessage1", "$(function () { ShowAlertMessage('" + msgNoUserPermissionUpdate + "') }); ", True)
            End If
        End If

        Return Succeeded
    End Function

    Protected Sub BindRoles()
        Dim AvailableRoles As New List(Of Role)

        Dim clsRoles As Business.Roles = New Business.Roles
        AvailableRoles = clsRoles.GetActiveRolesData()

        cblRoles.DataSource = AvailableRoles
        cblRoles.DataBind()
    End Sub

    Protected Function ValidateData()
        Dim valid As Boolean = True

        If String.IsNullOrEmpty(Trim(txtFirstName.Text)) Then
            RVFirstName.IsValid = False
            valid = False
        ElseIf txtFirstName.Text.Length > 50 Then
            CVFirstName.IsValid = False
            valid = False
        End If

        If String.IsNullOrEmpty(Trim(txtLastName.Text)) Then
            RVLastName.IsValid = False
            valid = False
        ElseIf txtLastName.Text.Length > 50 Then
            CVLastName.IsValid = False
            valid = False
        End If

        If String.IsNullOrEmpty(Trim(txtUsername.Text)) Then
            RVUsername.IsValid = False
            valid = False
        ElseIf txtUsername.Text.Length > 50 Then
            CVUsername.IsValid = False
            valid = False
        ElseIf IsUsernameDuplicate(Trim(txtUsername.Text)) AndAlso String.IsNullOrEmpty(hfSelectedUserId.Value) Then
            valid = False
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessage", "$(function () { $('#lblUsernameStatus').css('color','red'); $('#lblUsernameStatus').text(msgUsernameAlreadyExist); }); ", True)
        End If

        If String.IsNullOrEmpty(Trim(txtPassword.Text)) Then
            RVPassword.IsValid = False
            valid = False
        ElseIf txtPassword.Text.Length > 50 Then
            CVPassword.IsValid = False
            valid = False
        End If

        If String.IsNullOrEmpty(Trim(txtEmail.Text)) Then
            RVEmail.IsValid = False
            valid = False
        ElseIf txtEmail.Text.Length > 50 Then
            CVEmail.IsValid = False
            valid = False
        ElseIf Not Regex.IsMatch(txtEmail.Text, "\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*") Then
            REEmail.IsValid = False
            valid = False
        End If

        Return valid
    End Function

    Protected Sub SendEmail(ByVal IsInsert As Boolean, ByVal ToEmail As String)
        Dim SendEmailReturnMsg As String = String.Empty
        Try
            Dim FromEmail, Subject, Body As String
            Dim CcEmail As String = String.Empty, BccEmail As String = String.Empty
            FromEmail = GetFromConfig("FromEmailAddress")
            Subject = GetFromConfig("UsersManagementEmailSubject")

            If IsInsert Then
                Body = String.Format(GetFromConfig("InsertUserEmailBody"), "<br />", txtUsername.Text, "<br />", txtPassword.Text, "<br />", txtFirstName.Text, "<br />", txtLastName.Text, "<br />", txtEmail.Text, "<br />", cbxActive.Checked)
            Else
                Body = String.Format(GetFromConfig("UpdateUserEmailBody"), "<br />", txtUsername.Text, "<br />", txtPassword.Text, "<br />", txtFirstName.Text, "<br />", txtLastName.Text, "<br />", txtEmail.Text, "<br />", cbxActive.Checked)
            End If

            SendEmailReturnMsg = SendMail(Body, {}, FromEmail, ToEmail, CcEmail, BccEmail, Subject)
            If (Not String.IsNullOrEmpty(SendEmailReturnMsg)) Then
                lblError.Text = "Error: " & SendEmailReturnMsg
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_UsersPage, 0)
        End Try
    End Sub

    <WebMethod(EnableSession:=True)> _
    Public Shared Function IsUsernameDuplicate(ByVal Username As String) As Boolean
        Username = System.Web.HttpContext.Current.Server.UrlDecode(Username)
        Dim UserExist As Boolean = False

        Dim clsUsers As Business.Users = New Business.Users
        UserExist = clsUsers.IsUsernameDuplicate(Username)

        Return UserExist
    End Function

#End Region

End Class