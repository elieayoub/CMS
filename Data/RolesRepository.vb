Imports Model
Imports CommonLibrary.Globals
Imports CommonLibrary.Members

Public Class RolesRepository

    Public Function GetUserRoles(ByVal SelectedUserId As Integer) As List(Of UsersRole)
        Dim lstUserRoles As New List(Of UsersRole)
        Dim dbModel As New ABC_CMSApplicationEntities
        lstUserRoles = (From item In dbModel.UsersRoles Where item.UserId = SelectedUserId Select item).ToList()
        Return lstUserRoles
    End Function

    Public Function DeleteUserRolesData(ByVal SelectedUserId As Integer) As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim lstUserRoles As New List(Of UsersRole)
            Dim dbModel As New ABC_CMSApplicationEntities
            lstUserRoles = GetUserRoles(SelectedUserId)
            For Each item As UsersRole In lstUserRoles
                dbModel.ExecuteStoreCommand("Delete From cms.UsersRoles Where UserId = " & item.UserId)
            Next
            Succeeded = True
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return Succeeded
    End Function

    Public Function GetRoleDataById(ByVal SelectedRoleId As Integer, ByVal dbModel As ABC_CMSApplicationEntities) As Role
        Dim SelectedRole As New Role

        SelectedRole = (From item In dbModel.Roles
                        Where item.RoleId = SelectedRoleId
                        Select item).FirstOrDefault()

        Return SelectedRole
    End Function

    Public Function GetRolePermissionsActionsData(ByVal RoleId As Integer) As List(Of PermissionsAction)
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim lstPermissionsActions As New List(Of PermissionsAction)

        lstPermissionsActions = (From item In dbModel.PermissionsActions
                                 Where item.PermissionActionRoleId = RoleId
                                 Select item).ToList()

        Return lstPermissionsActions
    End Function

    Public Function GetLastRoleId() As Integer
        Dim LastRoleId As Integer = 0
        Dim dbModel As New ABC_CMSApplicationEntities
        LastRoleId = (From item In dbModel.Roles Order By item.RoleId Descending Select item.RoleId).FirstOrDefault()
        Return LastRoleId
    End Function

    Public Function GetRolesData() As List(Of Role)
        Dim AllRoles As New List(Of Role)
        Dim dbModel As New ABC_CMSApplicationEntities

        AllRoles = (From item In dbModel.Roles
                          Select item).ToList()

        Return AllRoles
    End Function


End Class
