Imports Model

Public Class UsersActionsRepository

    Public Function GetUsersActionsData() As List(Of UsersAction)
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim lstUsersActions As New List(Of UsersAction)

        lstUsersActions = (From item In dbModel.UsersActions
                           Select item).ToList()

        Return lstUsersActions
    End Function

End Class
