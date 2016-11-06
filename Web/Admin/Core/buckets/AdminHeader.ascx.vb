Imports Model
Imports Business
Imports Business.Operations
Imports CommonLibrary.Globals
Imports CommonLibrary.Members

Public Class AdminHeader
    Inherits System.Web.UI.UserControl

#Region "Members"
    Private lstSubMenu As List(Of Menu)
    Private HideSeperator As Boolean
#End Region

#Region "Page Events"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            lblLoggedinUserFullName.Text = pUserFullName
            BuildMenu()
        Catch ex As Exception
            Dim msg As String = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessageFromAdminHeader1", "$(function () { ShowAlertMessage('" + msg + "') }); ", True)
        End Try
    End Sub
#End Region

#Region "Control Events"
    Protected Sub rptMenu_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptMenu.ItemDataBound
        Try
            Dim rpt_SubMenu As Repeater
            Dim subMenu As New List(Of Menu)
            Dim Item As RepeaterItem = e.Item
            Dim subMenuAllowed As New List(Of Menu)
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim clsPermissions As New Business.Permissions

            If (Item.ItemType = ListItemType.Item Or Item.ItemType = ListItemType.AlternatingItem) AndAlso Item.DataItem.MenuParentId = 0 AndAlso Item.DataItem.MenuPageId = 0 Then
                subMenu = (From MenuItem In lstSubMenu
                           Where MenuItem.MenuParentId = Item.DataItem.MenuId _
                           Select MenuItem
                           Order By MenuItem.MenuOrder Ascending).ToList()

                For Each subMenuItem As Menu In subMenu
                    If clsPermissions.hasMenuItemPermission(subMenuItem.MenuPageId, subMenuItem.MenuPermissionTypeId, pUserId) Then
                        subMenuAllowed.Add(subMenuItem)
                    End If
                Next

                If subMenuAllowed.Count > 0 Then
                    rpt_SubMenu = TryCast(Item.FindControl("rpt_SubMenu"), Repeater)
                    rpt_SubMenu.DataSource = subMenuAllowed
                    rpt_SubMenu.DataBind()
                Else
                    Item.Visible = False
                    HideSeperator = True
                End If

            ElseIf (Item.ItemType = ListItemType.Item Or Item.ItemType = ListItemType.AlternatingItem) AndAlso Item.DataItem.MenuParentId = 0 AndAlso Item.DataItem.MenuPageId <> 0 Then
                'Check Menu Item without sub menu permission
                If Not clsPermissions.hasMenuItemPermission(Item.DataItem.MenuPageId, Item.DataItem.MenuPermissionTypeId, pUserId) Then
                    Item.Visible = False
                    HideSeperator = True
                End If
            ElseIf (Item.ItemType = ListItemType.Separator AndAlso HideSeperator) Then
                Item.Controls.Clear()
                HideSeperator = False
            End If
        Catch ex As Exception
            Dim msg As String = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessageFromAdminNavigation2", "$(function () { ShowAlertMessage('" + msg + "') }); ", True)
        End Try
    End Sub


    Protected Sub btnLogout_Click(sender As Object, e As EventArgs) Handles btnLogout.Click
        Session.Clear()
        Response.Redirect("Login.aspx")
    End Sub
#End Region

#Region "Methods"
    Protected Sub BuildMenu()
        Try
            Dim nv As New NavigationMenus

            lstSubMenu = nv.GetNavigationSubMenu(enumPermissionsType.BackEnd)

            Dim lstParentMenu As List(Of Menu) = nv.GetNavigationParentMenu(enumPermissionsType.BackEnd)

            rptMenu.DataSource = lstParentMenu
            rptMenu.DataBind()

        Catch ex As Exception
            Dim msg As String = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessageFromAdminNavigation1", "$(function () { ShowAlertMessage('" + msg + "') }); ", True)
        End Try
    End Sub

    Public Function RemoveSpaces(ByVal value As String) As String
        Return value.Replace(" ", "")
    End Function
#End Region

End Class