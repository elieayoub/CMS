Imports Model
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class RolesPermissionsRepository

    Public Function InsertRolePermission(ByVal SelectedRoleId As Integer, ByVal SelectedPagePermissionId As Integer) As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim NewRolePermisisons As New RolesPermission
            Dim dbModel As New ABC_CMSApplicationEntities

            NewRolePermisisons.RoleId = SelectedRoleId
            NewRolePermisisons.PagePermissionId = SelectedPagePermissionId
            dbModel.AddToRolesPermissions(NewRolePermisisons)
            dbModel.SaveChanges()

            Succeeded = True
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return Succeeded
    End Function

    Public Function DeleteRolePermissionByRoleId(ByVal SelectedRoleId As Integer) As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim NewRolePermisisons As New List(Of RolesPermission)
            Dim dbModel As New ABC_CMSApplicationEntities

            NewRolePermisisons = (From item In dbModel.RolesPermissions
                                  Where item.RoleId = SelectedRoleId
                                  Select item).ToList()

            NewRolePermisisons.ForEach(Sub(_item As RolesPermission) dbModel.RolesPermissions.DeleteObject(_item))

            dbModel.SaveChanges()

            Succeeded = True
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return Succeeded
    End Function

End Class
