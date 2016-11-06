Imports Model
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class ErrorLogs
    Inherits System.Web.UI.Page

#Region "Page Events"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim hasPermission As Boolean = True
        Try
            ClearMessageFields()
            If Not Page.IsPostBack Then
                Dim clsPermissions As New Business.Permissions
                hasPermission = clsPermissions.hasUserControlsPermissions(enumUsersActions.Read, enumPermissionsControls.Admin_ErrorLogsPage, pUserId)
                If hasPermission Then
                    txtErrorLogDateTo.Attributes.Add("readonly", "readonly")
                    txtErrorLogDateFrom.Attributes.Add("readonly", "readonly")
                    BindDDL()
                    ClearFields()
                    SearchGrid()
                End If
            End If
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ErrorLogsPage, enumUsersActions.Read)
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
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ErrorLogsPage, enumUsersActions.Read)
        End Try
    End Sub
    Protected Sub gvSearch_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvSearch.SelectedIndexChanged
        Dim SelectedErrorLogId As Integer
        Dim clsErrorLogs As New Business.ErrorLogs
        Dim dbModel As New ABC_CMSApplicationEntities

        Try
            SelectedErrorLogId = gvSearch.SelectedDataKey.Value
            hfErrorLogId.Value = SelectedErrorLogId

            Dim itemErrorLog As New v_GetErrorLogsInformation

            itemErrorLog = clsErrorLogs.GetErrorLogDataById(SelectedErrorLogId)
            If itemErrorLog IsNot Nothing Then
                lblErrorLogDate.Text = itemErrorLog.ErrorLogDate
                lblErrorLogMessage.Text = itemErrorLog.Message.Trim
                lblErrorLogStackTrace.Text = itemErrorLog.StackTrace.Trim
                lblErrorLogInnerException.Text = itemErrorLog.InnerException.Trim
                lblErrorLogSource.Text = itemErrorLog.Source.Trim
                lblErrorLogUsername.Text = itemErrorLog.Username.Trim
                lblErrorLogControlName.Text = itemErrorLog.PermissionControlName.Trim
                lblErrorLogActionName.Text = itemErrorLog.UserActionName.Trim
            End If

            InsertActionLog(pUserId, enumPagesPermissions.Admin_ErrorLogs, enumPermissionsControls.Admin_ErrorLogsPage, enumUsersActions.Read)
        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ErrorLogsPage, enumUsersActions.Read)
        End Try
    End Sub
#End Region

#Region "Methods"


    Sub SearchGrid()
        gvSearch.PageIndex = 0
        gvSearch.SelectedIndex = -1
        BindSearchUsersInformations()
    End Sub

    Protected Sub ClearFieldsForSearch()
        gvSearch.SelectedIndex = -1
        gvSearch.Visible = False

        lblErrorLogActionName.Text = ""
        lblErrorLogControlName.Text = ""
        lblErrorLogDate.Text = ""
        lblErrorLogInnerException.Text = ""
        lblErrorLogMessage.Text = ""
        lblErrorLogControlName.Text = ""
        lblErrorLogSource.Text = ""
        lblErrorLogStackTrace.Text = ""
        lblErrorLogUsername.Text = ""

        hfErrorLogId.Value = ""
    End Sub

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
        txtErrorLogDateFrom.Text = ""
        txtErrorLogDateTo.Text = ""
        ddlUsername.SelectedIndex = 0

        lblErrorLogActionName.Text = ""
        lblErrorLogControlName.Text = ""
        lblErrorLogDate.Text = ""
        lblErrorLogInnerException.Text = ""
        lblErrorLogMessage.Text = ""
        lblErrorLogControlName.Text = ""
        lblErrorLogSource.Text = ""
        lblErrorLogStackTrace.Text = ""
        lblErrorLogUsername.Text = ""

        hfErrorLogId.Value = ""
    End Sub

    Protected Sub BindSearchUsersInformations()
        Try
            Dim ErrorLogDateFromMMS As Integer = 0
            If Not String.IsNullOrEmpty(txtErrorLogDateFrom.Text.Trim) Then
                ErrorLogDateFromMMS = Val(ConvertDateToMMS(Convert.ToDateTime(txtErrorLogDateFrom.Text.Trim)))
            End If
            Dim ErrorLogDateToMMS As Integer = 0
            If Not String.IsNullOrEmpty(txtErrorLogDateTo.Text.Trim) Then
                ErrorLogDateToMMS = Val(ConvertDateToMMS(Convert.ToDateTime(txtErrorLogDateTo.Text.Trim)))
            End If

            ESSearchErrorLogs.WhereParameters("ErrorLogDateFromMMS").DefaultValue = ErrorLogDateFromMMS
            ESSearchErrorLogs.WhereParameters("ErrorLogDateToMMS").DefaultValue = ErrorLogDateToMMS

            gvSearch.DataSourceID = "ESSearchErrorLogs"
            gvSearch.Visible = True

        Catch ex As Exception
            lblError.Text = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, enumPermissionsControls.Admin_ErrorLogsPage, enumUsersActions.Read)
        End Try
    End Sub

#End Region

End Class