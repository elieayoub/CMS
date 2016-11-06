Imports Data
Imports System
Imports System.Web

Public Class Members

#Region "Variables"
    Public Shared DDLSelectText As String = "--Select--"
#End Region

#Region "Enums"
    Public Enum enumPermissionsType As Integer
        BackEnd = 1
        FrontEnd = 2
    End Enum

    Public Enum enumPermissionsControls As Integer
        Admin_UsersPage = 1
        Admin_UsersPage_RolesModule = 2
        Admin_RolesPage = 3
        Admin_RolesPage_PermissionsModule = 4
        Admin_ErrorLogsPage = 5
        Admin_ActionsLogsPage = 6
    End Enum

    Public Enum enumPagesPermissions As Integer
        Admin_Users = 1
        Admin_Roles = 2
        Admin_Home = 3
        Admin_ErrorLogs = 4
        Admin_ActionLogs = 5
    End Enum

    Public Enum enumUsersActions As Integer
        Create = 1
        Read = 2
        Update = 3
        Delete = 4
    End Enum
#End Region

#Region "Properties"
    Public Shared Property pUserId() As Integer
        Get
            Return Val(HttpContext.Current.Session("UserId"))
        End Get
        Set(ByVal value As Integer)
            HttpContext.Current.Session("UserId") = value
        End Set
    End Property

    Public Shared Property pUserFullName() As String
        Get
            Return HttpContext.Current.Session("UserFullName")
        End Get
        Set(ByVal value As String)
            HttpContext.Current.Session("UserFullName") = value
        End Set
    End Property

    Public Shared Property qUserId(ByVal PageHttpRequest As HttpRequest) As Integer
        Get
            Return Val(PageHttpRequest.QueryString("UserId"))
        End Get
        Set(ByVal value As Integer)
        End Set
    End Property
#End Region

End Class

