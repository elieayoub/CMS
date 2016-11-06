Imports Model
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class ActionLogs
    Inherits System.Web.UI.Page

#Region "Page Events"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim hasPermission As Boolean = True
        Try
            ClearMessageFields()
            If Not Page.IsPostBack Then
                Dim clsPermissions As New Business.Permissions
                hasPermission = clsPermissions.hasUserControlsPermissions(enumUsersActions.Read, enumPermissionsControls.Admin_ActionsLogsPage, pUserId)
                If hasPermission Then
                    txtActionLogDateFrom.Attributes.Add("readonly", "readonly")
                    txtActionLogDateTo.Attributes.Add("readonly", "readonly")
                    BindDDL()
                    ClearFields()
                    SearchGrid()
                End If
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ActionsLogsPage, enumUsersActions.Read)
        Finally
            If Not hasPermission Then
                Response.Redirect("Default.aspx")
            End If
        End Try
    End Sub

#End Region

#Region "Controls Events"
    Protected Sub gvSearch_PageIndexChanged(sender As Object, e As EventArgs) Handles gvSearch.PageIndexChanged
        gvSearch.SelectedIndex = -1
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Try
            ClearFieldsForSearch()
            ClearMessageFields()
            SearchGrid()
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ActionsLogsPage, enumUsersActions.Read)
        End Try
    End Sub

    Sub SearchGrid()
        gvSearch.PageIndex = 0
        gvSearch.SelectedIndex = -1
        BindSearchUsersInformations()
    End Sub


    Protected Sub gvSearch_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvSearch.SelectedIndexChanged
        Dim SelectedErrorLogId As Integer
        Dim clsActionLogs As New Business.ActionLogs
        Dim dbModel As New ABC_CMSApplicationEntities

        Try
            SelectedErrorLogId = gvSearch.SelectedDataKey.Value
            hfActionLogId.Value = SelectedErrorLogId

            Dim itemActionLog As New v_GetActionLogsInformation

            itemActionLog = clsActionLogs.GetActionLogDataById(SelectedErrorLogId)
            If itemActionLog IsNot Nothing Then
                lblActionLogDate.Text = itemActionLog.ActionLogDate
                lblActionLogUsername.Text = itemActionLog.Username.Trim
                lblActionLogPageName.Text = itemActionLog.PageName.Trim
                lblActionLogPagePermissionName.Text = itemActionLog.PagePermissionName.Trim
                lblActionLogControlName.Text = itemActionLog.PermissionControlName.Trim
                lblActionLogActionName.Text = itemActionLog.UserActionName.Trim
                lblActionDescription.Text = itemActionLog.Description
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_ActionLogs, enumPermissionsControls.Admin_ActionsLogsPage, enumUsersActions.Read)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ActionsLogsPage, enumUsersActions.Read)
        End Try
    End Sub
#End Region

#Region "Methods"

    Protected Sub BindDDL()
        Dim lstUsers As New List(Of User)
        Dim clsUsers As New Business.Users

        lstUsers = clsUsers.GetActiveUsers()

        If lstUsers.Count > 0 Then
            ddlUsername.DataSource = lstUsers
            ddlUsername.DataTextField = "Username"
            ddlUsername.DataValueField = "UserId"
            ddlUsername.DataBind()
            ddlUsername.Items.Insert(0, New ListItem(DDLSelectText, "0"))
        End If

    End Sub

    Protected Sub btnClearTop_Click(sender As Object, e As EventArgs) Handles btnClearTop.Click
        ClearMessageFields()
        ClearFields()
        SearchGrid()
    End Sub

    Protected Sub ClearMessageFields()
        lblError.Text = ""
    End Sub

    Protected Sub ClearFields()
        gvSearch.SelectedIndex = -1
        gvSearch.Visible = False
        txtSearchFor.Text = ""
        txtActionLogDateFrom.Text = ""
        txtActionLogDateTo.Text = ""
        ddlUsername.SelectedIndex = 0

        lblActionLogDate.Text = ""
        lblActionLogUsername.Text = ""
        lblActionLogPageName.Text = ""
        lblActionLogPagePermissionName.Text = ""
        lblActionLogControlName.Text = ""
        lblActionLogActionName.Text = ""

        hfActionLogId.Value = ""
    End Sub

    Protected Sub ClearFieldsForSearch()
        gvSearch.SelectedIndex = -1
        gvSearch.Visible = False

        lblActionLogDate.Text = ""
        lblActionLogUsername.Text = ""
        lblActionLogPageName.Text = ""
        lblActionLogPagePermissionName.Text = ""
        lblActionLogControlName.Text = ""
        lblActionLogActionName.Text = ""

        hfActionLogId.Value = ""
    End Sub

    Protected Sub BindSearchUsersInformations()
        Try
            Dim ErrorLogDateFromMMS As Integer = 0
            If Not String.IsNullOrEmpty(txtActionLogDateFrom.Text.Trim) Then
                ErrorLogDateFromMMS = Val(ConvertDateToMMS(Convert.ToDateTime(txtActionLogDateFrom.Text.Trim)))
            End If
            Dim ErrorLogDateToMMS As Integer = 0
            If Not String.IsNullOrEmpty(txtActionLogDateTo.Text.Trim) Then
                ErrorLogDateToMMS = Val(ConvertDateToMMS(Convert.ToDateTime(txtActionLogDateTo.Text.Trim)))
            End If

            ESSearchActionLogs.WhereParameters("ActionLogDateFromMMS").DefaultValue = ErrorLogDateFromMMS
            ESSearchActionLogs.WhereParameters("ActionLogDateToMMS").DefaultValue = ErrorLogDateToMMS

            gvSearch.DataSourceID = "ESSearchActionLogs"
            gvSearch.Visible = True

        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ErrorLogsPage, enumUsersActions.Read)
        End Try
    End Sub

#End Region

End Class