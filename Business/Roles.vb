Imports Model
Imports System.Transactions
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class Roles

    Public Function GetActiveRolesData() As List(Of Role)
        Dim AvailableRoles As New List(Of Role)
        Try
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim clsRolesRepository As New Data.RolesRepository

            AvailableRoles = clsRolesRepository.GetRolesData()

            AvailableRoles = (From item In AvailableRoles
                              Where item.IsActive = True
                              Select item).ToList()
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return AvailableRoles
    End Function

    Public Function InsertRole(ByVal NewRoleName As String, ByVal NewRoleDescription As String, ByVal NewRoleIsActive As Boolean,
                               ByVal NewRolePermissionsActions As List(Of PermissionsAction)) As Integer
        Dim NewRole As New Role
        Dim Succeeded As Boolean = False
        Dim Scope As New TransactionScope
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim NewItemId As Integer = 0

        Try
            Using Scope
                NewRole.RoleName = NewRoleName
                NewRole.RoleDescription = NewRoleDescription
                NewRole.IsActive = NewRoleIsActive
                dbModel.AddToRoles(NewRole)

                NewRolePermissionsActions.ForEach(Sub(_item As PermissionsAction) dbModel.AddToPermissionsActions(_item))

                dbModel.SaveChanges()
                Scope.Complete()
                Succeeded = True
                NewItemId = NewRole.RoleId
            End Using
        Catch ex As Exception
            Scope.Dispose()
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try

        Return NewItemId
    End Function

    Public Function UpdateRole(ByVal RoleIdToUpdate As Integer, ByVal EditRoleName As String, ByVal EditRoleDescription As String,
                               ByVal EditRoleIsActive As Boolean, ByVal EditRolePermissionsActions As List(Of PermissionsAction)) As Boolean
        Dim EditRole As New Role
        Dim Succeeded As Boolean = False
        Dim Scope As New TransactionScope
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim clsRolesRepository As New Data.RolesRepository

        Try
            Using Scope

                EditRole = clsRolesRepository.GetRoleDataById(RoleIdToUpdate, dbModel)

                EditRole.RoleName = EditRoleName
                EditRole.RoleDescription = EditRoleDescription
                EditRole.IsActive = EditRoleIsActive

                EditRolePermissionsActions.ForEach(Sub(_item As PermissionsAction) dbModel.AddToPermissionsActions(_item))

                dbModel.SaveChanges()
                Scope.Complete()
                Succeeded = True
            End Using
        Catch ex As Exception
            Scope.Dispose()
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try

        Return Succeeded
    End Function

End Class
