Imports Model
Imports CommonLibrary
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class Roles
    Inherits System.Web.UI.Page

#Region "Members"
    Private IsInsert As Boolean
    Private lstUsersActions As List(Of UsersAction)
    Private lstPermissionsControls As List(Of PermissionsControl)
    Private msgUpdatedSuccessfully As String = "Role updated successfully"
    Private msgInsertedSuccessfully As String = "Role inserted successfully"
    Private msgNoUserPermissionUpdate As String = "You do not have access to Update"
    Private msgNoUserPermissionInsert As String = "You do not have access to Insert"
    Private msgPleaseSelectItem As String = "Please select a role from the top table to update it"
#End Region

#Region "Page Events"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim hasPermission As Boolean = True
        Try
            ClearMessageFields()
            If Not Page.IsPostBack Then
                Dim clsPermissions As New Business.Permissions
                hasPermission = clsPermissions.hasUserControlsPermissions(enumUsersActions.Read, enumPermissionsControls.Admin_RolesPage, pUserId)
                ClearFields()
                SearchGrid(0)
            End If

            CheckUserControlsPermissionsOnLoad()
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Read)
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
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Try
            ClearFieldsForSearch()
            ClearMessageFields()
            SearchGrid(0)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Read)
        End Try
    End Sub

    Sub SearchGrid(ByVal ItemId As Integer)
        gvSearch.PageIndex = 0
        If ItemId = 0 Then
            ESSearchRole.WhereParameters("NewItemId").DefaultValue = 0
        Else
            ESSearchRole.WhereParameters("NewItemId").DefaultValue = ItemId
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "TriggerGvSelect", "$(function () { SelectGridViewFirstRow(); }); ", True)
        End If

        gvSearch.PageIndex = 0
        gvSearch.SelectedIndex = -1
        gvSearch.DataSourceID = "ESSearchRole"
        gvSearch.Visible = True
    End Sub

    Protected Sub btnClearBottom_Click(sender As Object, e As EventArgs) Handles btnClearBottom.Click, btnClearTop.Click
        ClearMessageFields()
        ClearFields()
        SearchGrid(0)
    End Sub

    Protected Sub btnInsert_Click(sender As Object, e As EventArgs) Handles btnInsert.Click
        Try
            Dim InsertSucceeded As Boolean
            Dim NewItemId As Integer = 0
            NewItemId = InsertRole()
            If InsertSucceeded Then
                lblMessage.Text = msgInsertedSuccessfully
                ClearFields()
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Roles, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Create, "Inserted a role blablabla")
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Create)
        End Try

    End Sub

    Protected Sub btnInsertAndNew_Click(sender As Object, e As EventArgs) Handles btnInsertAndNew.Click
        Try
            ClearMessageFields()
            Dim NewItemId As Integer = 0
            NewItemId = InsertRole()
            If NewItemId <> 0 Then
                lblMessage.Text = msgInsertedSuccessfully
                ClearFields()
                SearchGrid(0)
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Roles, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Create, "Inserted a role blablabla")
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Create)
        End Try
    End Sub


    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Try
            Dim UpdateSucceeded As Boolean
            Dim RoleIdToUpdate As Integer = Val(hfSelectedRoleId.Value)

            If RoleIdToUpdate = 0 Then
                lblMessage.Text = msgPleaseSelectItem
            Else
                UpdateSucceeded = UpdateRole(RoleIdToUpdate)
                If UpdateSucceeded Then
                    lblMessage.Text = msgUpdatedSuccessfully
                    ClearFields()
                    SearchGrid(RoleIdToUpdate)
                End If
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Roles, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Update, "Updated a role blablabla")
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Update)
        End Try
    End Sub

    Protected Sub gvSearch_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvSearch.SelectedIndexChanged
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim clsRolesRepository As New Data.RolesRepository
        Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))
        Dim lstRolePermissionsActions As New List(Of PermissionsAction)

        Try
            Dim SelectedRoleId As Integer = gvSearch.SelectedDataKey.Item("RoleId")
            hfSelectedRoleId.Value = SelectedRoleId
            Dim SelectedRole As Role

            BindPermissions()

            SelectedRole = clsRolesRepository.GetRoleDataById(SelectedRoleId, dbModel)
            If SelectedRole IsNot Nothing Then
                txtRoleName.Text = SelectedRole.RoleName.Trim
                If SelectedRole.RoleDescription IsNot Nothing Then
                    txtRoleDescription.Text = SelectedRole.RoleDescription.Trim
                Else
                    txtRoleDescription.Text = ""
                End If
                cbxActive.Checked = SelectedRole.IsActive
            End If

            lstRolePermissionsActions = clsRolesRepository.GetRolePermissionsActionsData(SelectedRoleId)

            Dim cbxItemUserActionId As Integer
            Dim cblPageControlActions As New CheckBoxList
            Dim rptPagesControlsPermissions As Repeater
            Dim cbxPermissionActionPagePermissionId As Integer
            Dim itemPermissionAction As New PermissionsAction
            Dim cbxPermissionActionPermissionControlId As Integer
            For Each item As RepeaterItem In rptFrontEndMenu.Items
                rptPagesControlsPermissions = CType(item.FindControl("rptPagesControlsPermissions"), Repeater)
                For Each childItem As RepeaterItem In rptPagesControlsPermissions.Items
                    itemPermissionAction = New PermissionsAction
                    cblPageControlActions = CType(childItem.FindControl("cblPageControlActions"), CheckBoxList)
                    cbxPermissionActionPagePermissionId = Val(cblPageControlActions.Attributes("data-PermissionControlPagePermissionId"))
                    cbxPermissionActionPermissionControlId = Val(cblPageControlActions.Attributes("data-PermissionControlId"))

                    itemPermissionAction = (From PA In lstRolePermissionsActions
                                            Where PA.PermissionActionPagePermissionId = cbxPermissionActionPagePermissionId _
                                            And PA.PermissionActionPermissionControlId = cbxPermissionActionPermissionControlId
                                            Select PA).FirstOrDefault()

                    If itemPermissionAction IsNot Nothing Then
                        For Each cbxItem As ListItem In cblPageControlActions.Items
                            cbxItemUserActionId = Val(cbxItem.Value)
                            Select Case cbxItemUserActionId
                                Case enumUsersActions.Create
                                    cbxItem.Selected = IIf(itemPermissionAction.Create Is Nothing, False, itemPermissionAction.Create)
                                Case enumUsersActions.Read
                                    cbxItem.Selected = IIf(itemPermissionAction.Read Is Nothing, False, itemPermissionAction.Read)
                                Case enumUsersActions.Update
                                    cbxItem.Selected = IIf(itemPermissionAction.Update Is Nothing, False, itemPermissionAction.Update)
                                Case enumUsersActions.Delete
                                    cbxItem.Selected = IIf(itemPermissionAction.Delete Is Nothing, False, itemPermissionAction.Delete)
                                Case Else
                            End Select
                        Next
                    End If

                Next
            Next

            btnUpdate.Enabled = True

            InsertActionLog(pUserId, enumPagesPermissions.Admin_Roles, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Read)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Read)
        End Try
    End Sub

    Protected Sub rptFrontEndMenu_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptFrontEndMenu.ItemDataBound
        Try
            Dim itemMenuPageId As Integer
            Dim item As RepeaterItem = e.Item
            Dim itemMenuPermissionTypeId As Integer
            Dim rptPagesControlsPermissions As New Repeater
            Dim clsNavigationMenus As New Business.NavigationMenus
            Dim clsPermissionsControls As New Business.PermissionsControls
            Dim lstLocalPermissionsControls As New List(Of PermissionsControl)
            If item.ItemType = ListItemType.Item Or item.ItemType = ListItemType.AlternatingItem Then
                itemMenuPageId = CType(item.DataItem.MenuPageId, Integer)
                itemMenuPermissionTypeId = CType(item.DataItem.MenuPermissionTypeId, Integer)

                If lstPermissionsControls IsNot Nothing AndAlso lstPermissionsControls.Count > 0 Then
                    lstLocalPermissionsControls = (From Pitem In lstPermissionsControls
                       Where Pitem.PermissionControlTypeId = itemMenuPermissionTypeId _
                       And Pitem.PermissionControlPageId = itemMenuPageId
                       Select Pitem).ToList()
                End If

                If lstLocalPermissionsControls IsNot Nothing AndAlso lstLocalPermissionsControls.Count > 0 Then
                    rptPagesControlsPermissions = item.FindControl("rptPagesControlsPermissions")
                    If rptPagesControlsPermissions IsNot Nothing Then
                        rptPagesControlsPermissions.DataSource = lstLocalPermissionsControls
                        rptPagesControlsPermissions.DataBind()
                    End If
                End If
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Read)
        End Try
    End Sub

    Protected Sub rptPagesControlsPermissions_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        Try
            Dim item As RepeaterItem = e.Item
            Dim itemPermissionControlId As Integer
            Dim itemPermissionControlPageId As Integer
            Dim cblPageControlActions As New CheckBoxList
            Dim itemPermissionControlPagePermissionId As Integer
            Dim clsUsersActionsRepository As New Data.UsersActionsRepository
            If item.ItemType = ListItemType.Item Or item.ItemType = ListItemType.AlternatingItem Then
                cblPageControlActions = item.FindControl("cblPageControlActions")
                If cblPageControlActions IsNot Nothing Then
                    If lstUsersActions IsNot Nothing AndAlso lstUsersActions.Count > 0 Then
                        itemPermissionControlId = item.DataItem.PermissionControlId
                        itemPermissionControlPageId = item.DataItem.PermissionControlPageId
                        itemPermissionControlPagePermissionId = item.DataItem.PermissionControlPagePermissionId

                        cblPageControlActions.DataSource = lstUsersActions
                        cblPageControlActions.DataTextField = "UserActionName"
                        cblPageControlActions.DataValueField = "UserActionId"
                        cblPageControlActions.Attributes.Add("data-PermissionControlId", itemPermissionControlId)
                        cblPageControlActions.Attributes.Add("data-PermissionControlPageId", itemPermissionControlPageId)
                        cblPageControlActions.Attributes.Add("data-PermissionControlPagePermissionId", itemPermissionControlPagePermissionId)
                        cblPageControlActions.DataBind()
                    End If
                End If
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Read)
        End Try
    End Sub

#End Region

#Region "Methods"

    Protected Sub CheckUserControlsPermissionsOnLoad()
        Dim hasPermission As Boolean = False
        Dim clsPermissions As New Business.Permissions
        hasPermission = clsPermissions.hasUserControlsPermissions(enumUsersActions.Read, enumPermissionsControls.Admin_RolesPage_PermissionsModule, pUserId)

        If Not hasPermission Then
            rptFrontEndMenu.Visible = False
            rptFrontEndMenu_NoAccess.Visible = True
        End If
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
        txtRoleName.Text = ""
        txtRoleDescription.Text = ""
        cbxActive.Checked = True

        gvSearch.SelectedIndex = -1
        gvSearch.Visible = False
        cbxActiveSearch.Checked = True
        txtSearchFor.Text = ""

        hfSelectedRoleId.Value = ""
        btnUpdate.Enabled = False

        BindPermissions()

    End Sub

    Protected Sub ClearFieldsForSearch()
        txtRoleName.Text = ""
        txtRoleDescription.Text = ""
        cbxActive.Checked = True

        gvSearch.SelectedIndex = -1
        gvSearch.Visible = False

        hfSelectedRoleId.Value = ""
        btnUpdate.Enabled = False

        BindPermissions()

    End Sub

    Protected Sub BindPermissions()
        Try
            Dim lstAdminMenu As New List(Of Menu)
            Dim lstFrontendMenu As New List(Of Menu)
            Dim clsNavigationMenus As New Business.NavigationMenus
            Dim clsPermissionsControls As New Business.PermissionsControls
            Dim clsUsersActionsRepository As New Data.UsersActionsRepository

            lstUsersActions = clsUsersActionsRepository.GetUsersActionsData()
            lstPermissionsControls = clsPermissionsControls.GetActivePagesPermissionsControlsData()

            lstAdminMenu = clsNavigationMenus.GetActiveMenuByType(enumPermissionsType.BackEnd)
            lstFrontendMenu = clsNavigationMenus.GetActiveMenuByType(enumPermissionsType.FrontEnd)

            rptFrontEndMenu.DataSource = lstAdminMenu
            rptFrontEndMenu.DataBind()

        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage_PermissionsModule, enumUsersActions.Read)
        End Try
    End Sub

    Protected Function InsertRole() As Integer
        Dim Succeeded As Boolean = False
        Dim NewItemId As Integer = 0
        Try
            Dim clsPermissions As New Business.Permissions
            Dim clsRoles As Business.Roles = New Business.Roles
            Dim lstPermissionsActions As New List(Of PermissionsAction)

            If ValidateData() Then

                If clsPermissions.hasUserControlPermission(enumUsersActions.Create, enumPermissionsControls.Admin_RolesPage, pUserId) Then
                    If clsPermissions.hasUserControlPermission(enumUsersActions.Create, enumPermissionsControls.Admin_RolesPage_PermissionsModule, pUserId) Then
                        lstPermissionsActions = AddControlsPermissionsActions(0)
                    End If

                    NewItemId = clsRoles.InsertRole(txtRoleName.Text.Trim, txtRoleDescription.Text.Trim, cbxActive.Checked, lstPermissionsActions)
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessage1", "$(function () { ShowAlertMessage('" + msgNoUserPermissionInsert + "') }); ", True)
                End If

            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Create)
        End Try
        Return NewItemId
    End Function

    Protected Function AddControlsPermissionsActions(ByVal EditItemRoleId As Integer) As List(Of PermissionsAction)
        Dim ItemRoleId As Integer = 1
        Dim SelectedControlPagePermissionId As Integer
        Dim itemPermissionAction As New PermissionsAction
        Dim clsRolesRepository As New Data.RolesRepository
        Dim clsRolesPermissionsRepository As New Data.RolesPermissionsRepository
        Dim lstPermissionsActions As New List(Of PermissionsAction)

        Try
            Dim UserHasPagePermission As Boolean = False

            If EditItemRoleId = 0 Then
                Dim CheckLastRoleId = clsRolesRepository.GetLastRoleId()
                If CheckLastRoleId <> 0 Then
                    ItemRoleId = CheckLastRoleId + 1
                End If
            Else
                ItemRoleId = EditItemRoleId
            End If

            Dim cbxItemUserActionId As Integer
            Dim cblPageControlActions As New CheckBoxList
            Dim rptPagesControlsPermissions As Repeater
            For Each item As RepeaterItem In rptFrontEndMenu.Items
                rptPagesControlsPermissions = CType(item.FindControl("rptPagesControlsPermissions"), Repeater)
                For Each childItem As RepeaterItem In rptPagesControlsPermissions.Items
                    itemPermissionAction = New PermissionsAction
                    itemPermissionAction.PermissionActionRoleId = ItemRoleId
                    cblPageControlActions = CType(childItem.FindControl("cblPageControlActions"), CheckBoxList)
                    SelectedControlPagePermissionId = Val(cblPageControlActions.Attributes("data-PermissionControlPagePermissionId"))
                    itemPermissionAction.PermissionActionPagePermissionId = SelectedControlPagePermissionId
                    itemPermissionAction.PermissionActionPermissionControlId = Val(cblPageControlActions.Attributes("data-PermissionControlId"))
                    For Each cbxItem As ListItem In cblPageControlActions.Items
                        cbxItemUserActionId = IIf(cbxItem.Selected, Val(cbxItem.Value), 0)
                        Select Case cbxItemUserActionId
                            Case enumUsersActions.Create
                                itemPermissionAction.Create = True
                                UserHasPagePermission = True
                            Case enumUsersActions.Read
                                itemPermissionAction.Read = True
                                UserHasPagePermission = True
                            Case enumUsersActions.Update
                                itemPermissionAction.Update = True
                                UserHasPagePermission = True
                            Case enumUsersActions.Delete
                                itemPermissionAction.Delete = True
                                UserHasPagePermission = True
                            Case Else
                        End Select
                    Next
                    lstPermissionsActions.Add(itemPermissionAction)
                Next

                'Insert Pages Permissions relationship
                If UserHasPagePermission Then
                    clsRolesPermissionsRepository.InsertRolePermission(ItemRoleId, SelectedControlPagePermissionId)
                End If
                UserHasPagePermission = False
            Next
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage_PermissionsModule, enumUsersActions.Create)
        End Try
        Return lstPermissionsActions
    End Function

    Protected Function UpdateRole(ByVal RoleIdToUpdate As Integer) As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim clsPermissions As New Business.Permissions
            Dim clsRoles As Business.Roles = New Business.Roles
            Dim lstPermissionsActions As New List(Of PermissionsAction)
            Dim clsRolesPermissionsRepository As New Data.RolesPermissionsRepository
            Dim clsPermissionsActionsRepository As New Data.PermissionsActionsRepository

            If ValidateData() Then

                If clsPermissions.hasUserControlPermission(enumUsersActions.Update, enumPermissionsControls.Admin_RolesPage, pUserId) Then

                    If clsPermissions.hasUserControlPermission(enumUsersActions.Update, enumPermissionsControls.Admin_RolesPage_PermissionsModule, pUserId) Then
                        clsPermissionsActionsRepository.DeletePermissionsActionsByRoleId(RoleIdToUpdate)
                        clsRolesPermissionsRepository.DeleteRolePermissionByRoleId(RoleIdToUpdate)
                        lstPermissionsActions = AddControlsPermissionsActions(RoleIdToUpdate)
                    End If

                    If lstPermissionsActions IsNot Nothing Then
                        Succeeded = clsRoles.UpdateRole(RoleIdToUpdate, txtRoleName.Text.Trim, txtRoleDescription.Text.Trim, cbxActive.Checked, lstPermissionsActions)
                    End If
                Else
                    ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessage2", "$(function () { ShowAlertMessage('" + msgNoUserPermissionUpdate + "') }); ", True)
                End If

            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_RolesPage, enumUsersActions.Update)
        End Try
        Return Succeeded
    End Function

    Protected Function ValidateData()
        Dim valid As Boolean = True

        If String.IsNullOrEmpty(Trim(txtRoleName.Text)) Then
            RVRoleName.IsValid = False
            valid = False
        ElseIf txtRoleName.Text.Length > 50 Then
            CVRoleName.IsValid = False
            valid = False
        End If

        If txtRoleDescription.Text.Length > 50 Then
            RERoleDescription.IsValid = False
            valid = False
        End If

        Return valid
    End Function

#End Region

End Class