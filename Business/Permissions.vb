Imports Data
Imports Model
Imports CommonLibrary.Members

Public Class Permissions

    'public function hasusercontrolpermission(byval userid as integer, byval controlid as integer) as boolean
    '    dim haspermission as boolean = false
    '    dim dbmodel as new abc_cmsapplicationentities
    '    dim pagepermission as new list(of pagespermission)

    '    pagepermission = (from p in dbmodel.pagespermissions
    '                      join c in dbmodel.permissionscontrols on c.permissioncontrolpagepermissionid equals p.pagepermissionid
    '                      join r in dbmodel.rolespermissions on r.pagepermissionid equals p.pagepermissionid
    '                      join u in dbmodel.usersroles on u.roleid equals r.roleid
    '                      where u.userid = userid _
    '                      and c.permissioncontrolid = controlid
    '                      select p).tolist()

    '    if pagepermission.count > 0 then
    '        haspermission = true
    '    end if

    '    return haspermission
    'end function

    Public Function hasMenuItemPermission(ByVal MenuPageId As Integer, ByVal MenuPagePermissionTypeId As Integer, ByVal UserId As Integer) As Boolean
        Dim hasPermission As Boolean = False
        Dim dbModel As New ABC_CMSApplicationEntities

        Dim MenuItemPermission = (From PP In dbModel.PagesPermissions
                                  Join RP In dbModel.RolesPermissions On RP.PagePermissionId Equals PP.PagePermissionId
                                  Join UR In dbModel.UsersRoles On UR.RoleId Equals RP.RoleId
                                  Join U In dbModel.Users On U.UserId Equals UR.UserId
                                  Where PP.IsEnabled = True _
                                  And PP.IsActive = True _
                                  And U.IsActive = True _
                                  And PP.PagePermissionPageId = MenuPageId _
                                  And PP.PagePermissionTypeId = MenuPagePermissionTypeId _
                                  And U.UserId = UserId
                                  Select PP).FirstOrDefault()

        If MenuItemPermission IsNot Nothing Then hasPermission = True

        Return hasPermission
    End Function

    Public Function GetUserControlPermissionAction(ByVal UserId As Integer, ByVal ControlId As Integer) As List(Of PermissionsAction)
        Dim hasPermission As Boolean = False
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim UserPermissionAction As List(Of PermissionsAction)

        UserPermissionAction = (From A In dbModel.PermissionsActions
                                Join UR In dbModel.UsersRoles On UR.RoleId Equals A.PermissionActionRoleId
                                Join U In dbModel.Users On U.UserId Equals UR.UserId
                                Where U.UserId = UserId _
                                And U.IsActive = True _
                                And A.PermissionActionPermissionControlId = ControlId
                                Select A).ToList()

        Return UserPermissionAction
    End Function

    Public Function hasUserControlsPermissions(ByVal UserActionId As Integer, ByVal ControlId As Integer, ByVal UserId As Integer) As Boolean
        Dim hasControlPermission As Boolean = False
        Dim UserPermissionAction As List(Of PermissionsAction)

        UserPermissionAction = GetUserControlPermissionAction(UserId, ControlId)

        For Each item As PermissionsAction In UserPermissionAction
            Select Case UserActionId
                Case enumUsersActions.Create
                    If (item.Create = True) Then
                        hasControlPermission = True
                        Exit For
                    End If
                Case enumUsersActions.Read
                    If (item.Read = True) Then
                        hasControlPermission = True
                        Exit For
                    End If
                Case enumUsersActions.Update
                    If (item.Update = True) Then
                        hasControlPermission = True
                        Exit For
                    End If
                Case enumUsersActions.Delete
                    If (item.Delete = True) Then
                        hasControlPermission = True
                        Exit For
                    End If
                Case Else
            End Select
        Next

        Return hasControlPermission
    End Function

    Public Function hasUserControlPermission(ByVal UserActionId As Integer, ByVal ControlId As Integer, ByVal UserId As Integer) As Boolean
        Dim hasPermissions As Boolean = False
        Dim clsPermissions As New Business.Permissions

        hasPermissions = clsPermissions.hasUserControlsPermissions(UserActionId, ControlId, UserId)
        Return hasPermissions
    End Function


End Class
