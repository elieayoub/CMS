Imports Model
Imports Data
Imports CommonLibrary
Imports CommonLibrary.Globals
Imports CommonLibrary.Members
Imports System.Web.UI.WebControls


Public Class Users

    Public Function InsertUser(ByVal NewUserFirstName As String, ByVal NewUserLastName As String,
                                  ByVal NewUserUsername As String, ByVal NewUserEmail As String,
                                  ByVal NewUserPassword As String, ByVal NewUserIsActive As Boolean,
                                  ByVal cblRoles As CheckBoxList) As Integer

        Dim Succeeded As Boolean = False
        Dim NewItemId As Integer = 0
        Try
            Dim LastUserId As Integer = 1
            Dim UserEntityId As Integer = 1
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim clsPermissions As New Business.Permissions
            Dim clsUsersRepository As New Data.UsersRepository
            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))

            Dim CheckLastUserEntityId = clsUsersRepository.GetLastUserEntityId()
            If CheckLastUserEntityId <> 0 Then
                UserEntityId = CheckLastUserEntityId + 1
            End If

            Dim NewUserEntity As New Entity
            With NewUserEntity
                .FirstName = NewUserFirstName
                .LastName = NewUserLastName
                .CreationDate = DateTime.Now
                .CreationDateMMS = ConvertDateToMMS(Date.Now)
                .IsActive = NewUserIsActive
            End With
            dbModel.AddToEntities(NewUserEntity)

            Dim NewUser As New User
            With NewUser
                .Username = NewUserUsername
                .Password = wrapper.EncryptData(NewUserPassword)
                .Email = NewUserEmail
                .EntityId = UserEntityId
                .IsActive = NewUserIsActive
            End With
            dbModel.AddToUsers(NewUser)

            Dim CheckLastUserId = clsUsersRepository.GetLastUserId()
            If CheckLastUserId <> 0 Then
                LastUserId = CheckLastUserId + 1
            End If

            Dim cbxRoleId As Integer = 0
            Dim EditUserRole As New UsersRole
            If cblRoles IsNot Nothing AndAlso clsPermissions.hasUserControlPermission(enumUsersActions.Create, enumPermissionsControls.Admin_UsersPage_RolesModule, pUserId) Then
                For Each cbxRole As ListItem In cblRoles.Items
                    If cbxRole.Selected Then
                        EditUserRole = New UsersRole
                        cbxRoleId = Val(cbxRole.Value)
                        EditUserRole.RoleId = cbxRoleId
                        EditUserRole.UserId = LastUserId
                        dbModel.AddToUsersRoles(EditUserRole)
                    End If
                Next
            End If

            dbModel.SaveChanges()

            NewItemId = NewUser.UserId
            Succeeded = True
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return NewItemId
    End Function

    Public Function UpdateUser(ByVal SelectedUserId As Integer, ByVal SelectedUserEntityIdToUpdate As Integer,
                               ByVal EditUserFirstName As String, ByVal EditUserLastName As String,
                               ByVal EditUserUsername As String, ByVal EditUserPassword As String,
                               ByVal EditUserEmail As String, ByVal EditUserIsActive As Boolean, ByVal cblRoles As CheckBoxList) As Boolean
        Dim Succeeded As Boolean = False
        Try
            Dim DeleteUserRolesSucceeded As Boolean
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim clsPermissions As New Business.Permissions
            Dim clsUsersRepository As New Data.UsersRepository
            Dim clsRolesRepository As New Data.RolesRepository
            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))

            Dim EditUser As New User
            EditUser = clsUsersRepository.GetUserDataById(SelectedUserId, dbModel)
            With EditUser
                .Username = EditUserUsername
                .Password = wrapper.EncryptData(EditUserPassword)
                .Email = EditUserEmail
                .IsActive = EditUserIsActive
            End With

            Dim EditUserEntity As New Entity
            EditUserEntity = clsUsersRepository.GetUserEntityDataById(SelectedUserEntityIdToUpdate, dbModel)
            With EditUserEntity
                .FirstName = EditUserFirstName
                .LastName = EditUserLastName
                .CreationDate = DateTime.Now
                .CreationDateMMS = ConvertDateToMMS(Date.Now)
                .IsActive = EditUserIsActive
            End With

            Dim cbxRoleId As Integer = 0
            Dim EditUserRole As New UsersRole
            If cblRoles IsNot Nothing AndAlso clsPermissions.hasUserControlPermission(enumUsersActions.Update, enumPermissionsControls.Admin_UsersPage_RolesModule, pUserId) Then
                DeleteUserRolesSucceeded = clsRolesRepository.DeleteUserRolesData(SelectedUserId)
                If DeleteUserRolesSucceeded Then
                    For Each cbxRole As ListItem In cblRoles.Items
                        If cbxRole.Selected Then
                            EditUserRole = New UsersRole
                            cbxRoleId = Val(cbxRole.Value)
                            EditUserRole.RoleId = cbxRoleId
                            EditUserRole.UserId = SelectedUserId
                            dbModel.AddToUsersRoles(EditUserRole)
                        End If
                    Next
                End If
            End If

            dbModel.SaveChanges()

            Succeeded = True
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return Succeeded
    End Function

    Public Function IsUsernameDuplicate(ByVal Username As String) As Boolean
        Dim UserToCheck As New User
        Dim UserExist As Boolean = False
        Dim dbModel As New ABC_CMSApplicationEntities
        UserToCheck = (From item In dbModel.Users Where item.Username = Username And item.IsActive = True Select item).FirstOrDefault()
        If UserToCheck IsNot Nothing Then
            UserExist = True
        End If
        Return UserExist
    End Function

    Public Function GetActiveUsers() As List(Of User)
        Dim lstUsers As New List(Of User)
        Dim clsUsersRepository As New UsersRepository

        lstUsers = clsUsersRepository.GetUsers()
        lstUsers = (From item In lstUsers Where item.IsActive = True Select item).ToList()

        Return lstUsers
    End Function

    Public Function IsUserAdmin(ByVal UserId As Integer) As Boolean
        Dim IsAdmin As Boolean = False
        Dim dbModel As New ABC_CMSApplicationEntities

        Dim Role As Role = (From R In dbModel.Roles
                            Join RP In dbModel.RolesPermissions On RP.RoleId Equals R.RoleId
                            Join PP In dbModel.PagesPermissions On PP.PagePermissionId Equals RP.PagePermissionId
                            Join UR In dbModel.UsersRoles On UR.RoleId Equals R.RoleId
                            Join U In dbModel.Users On U.UserId Equals UR.UserId
                            Where PP.PagePermissionTypeId = enumPermissionsType.BackEnd _
                            And U.UserId = UserId
                            Select R).FirstOrDefault()

        Return IIf(Role IsNot Nothing, True, False)
    End Function

    Public Function ResetUserPassword(ByVal UserId As Integer, ByVal newPassword As String) As User
        Dim UserToEdit As New User
        Try
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim wrapper As New Simple3Des(GetFromConfig("EncryptionKey"))

            UserToEdit = (From item In dbModel.Users Where item.UserId = UserId Select item).FirstOrDefault()
            If UserToEdit IsNot Nothing AndAlso UserToEdit.Email IsNot Nothing AndAlso Not String.IsNullOrEmpty(UserToEdit.Email) Then
                Dim Email As String = UserToEdit.Email.Trim
                UserToEdit.Password = newPassword
                dbModel.SaveChanges()
            End If
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return UserToEdit
    End Function

    Public Function GetUserInformationDataById(ByVal SelectedUserId As Integer, ByVal dbModel As ABC_CMSApplicationEntities) As v_GetUsersInformations
        Dim GetUser As v_GetUsersInformations
        Dim clsUsersRepository As New Data.UsersRepository

        GetUser = clsUsersRepository.GetUserInformationDataById(SelectedUserId, dbModel)

        Return GetUser
    End Function

    Public Function ChangeUserPassword(ByVal SelectedUserId As Integer, ByVal dbModel As ABC_CMSApplicationEntities, ByVal NewPassword As String) As Boolean
        Dim Succeeded As Boolean = False
        Dim clsUsersRepository As New Data.UsersRepository
        Dim LoggedInUser As User
        Try
            LoggedInUser = clsUsersRepository.GetUserDataById(SelectedUserId, dbModel)

            If LoggedInUser IsNot Nothing Then
                LoggedInUser.Password = NewPassword
                LoggedInUser.ModificationDate = DateTime.Now
                LoggedInUser.ModificationDateMMS = ConvertDateToMMS(Date.Now)

                dbModel.SaveChanges()
                Succeeded = True
            End If
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return Succeeded
    End Function

    Public Function IsUserPasswordCorrect(ByVal SelectedUserId As Integer, ByVal dbModel As ABC_CMSApplicationEntities, ByVal UserPassword As String) As Boolean
        Dim LoggedInUser As User
        Dim Correct As Boolean = False
        Dim clsUsersRepository As New Data.UsersRepository

        LoggedInUser = clsUsersRepository.GetUserDataById(SelectedUserId, dbModel)
        If LoggedInUser IsNot Nothing Then
            If LoggedInUser.Password = UserPassword Then
                Correct = True
            End If
        End If
        Return Correct
    End Function

End Class
