Imports Model
Imports CommonLibrary.Members
Imports CommonLibrary.Globals

Public Class PermissionsActionsRepository

    Public Function DeletePermissionsActionsByRoleId(ByVal SelectedRoleId As Integer) As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim lstPermissionsActions As New List(Of PermissionsAction)
            Dim dbModel As New ABC_CMSApplicationEntities



            lstPermissionsActions = (From item In dbModel.PermissionsActions
                                     Where item.PermissionActionRoleId = SelectedRoleId
                                     Select item).ToList()

            lstPermissionsActions.ForEach(Sub(_item As PermissionsAction) dbModel.PermissionsActions.DeleteObject(_item))
            dbModel.SaveChanges()

            Succeeded = True
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return Succeeded
    End Function

End Class
