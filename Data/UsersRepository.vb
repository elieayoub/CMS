Imports Model

Public Class UsersRepository

    Public Function GetLastUserEntityId() As Integer
        Dim LastUserEntityId As Integer = 0
        Dim dbModel As New ABC_CMSApplicationEntities
        LastUserEntityId = (From item In dbModel.Entities Order By item.EntityId Descending Select item.EntityId).FirstOrDefault()
        Return LastUserEntityId
    End Function

    Public Function GetLastUserId() As Integer
        Dim LastUserId As Integer = 0
        Dim dbModel As New ABC_CMSApplicationEntities
        LastUserId = (From item In dbModel.Users Order By item.UserId Descending Select item.UserId).FirstOrDefault()
        Return LastUserId
    End Function

    Public Function GetUserDataById(ByVal SelectedUserId As Integer, ByVal dbModel As ABC_CMSApplicationEntities) As User
        Dim GetUser As User

        GetUser = (From item In dbModel.Users
                    Where item.UserId = SelectedUserId
                    Select item).FirstOrDefault()

        Return GetUser
    End Function

    Public Function GetUserEntityDataById(ByVal SelectedUserEntityId As Integer, ByVal dbModel As ABC_CMSApplicationEntities) As Entity
        Dim GetUserEntity As Entity

        GetUserEntity = (From item In dbModel.Entities
                          Where item.EntityId = SelectedUserEntityId
                          Select item).FirstOrDefault()

        Return GetUserEntity
    End Function

    Public Function GetUserInformationDataById(ByVal SelectedUserId As Integer, ByVal dbModel As ABC_CMSApplicationEntities) As v_GetUsersInformations
        Dim GetUser As v_GetUsersInformations

        GetUser = (From item In dbModel.v_GetUsersInformations
                    Where item.UserId = SelectedUserId
                    Select item).FirstOrDefault()

        Return GetUser
    End Function

    Public Function GetUsers()
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim lstUsers As New List(Of User)

        lstUsers = (From item In dbModel.Users
                    Select item).ToList()

        Return lstUsers
    End Function

End Class
