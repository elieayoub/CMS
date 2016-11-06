Imports Data
Imports Model
Imports CommonLibrary.Members

Public Class NavigationMenus


    Public Function GetNavigationParentMenu(ByVal PermissionTypeId As Integer) As List(Of Menu)
        Dim MR As New MenusRepository

        Dim AdminMenu As List(Of Menu) = MR.GetParentMenu(enumPermissionsType.BackEnd)

        Return AdminMenu
    End Function

    Public Function GetNavigationSubMenu(ByVal PermissionTypeId As Integer) As List(Of Menu)
        Dim MR As New MenusRepository

        Dim AdminMenu As List(Of Menu) = MR.GetSubMenu(enumPermissionsType.BackEnd)
        AdminMenu = (From item In AdminMenu
                     Order By item.MenuOrder Ascending, item.MenuParentId Ascending
                     Select item).ToList()


        Return AdminMenu
    End Function

    Public Function GetActiveMenuByType(ByVal PermissionTypeId As Integer) As List(Of Menu)
        Dim MR As New MenusRepository
        Dim lstMenu As New List(Of Menu)
        lstMenu = MR.GetMenuByType(PermissionTypeId)

        lstMenu = (From item In lstMenu
                   Where item.IsActive = True
                   Select item).ToList()

        Return lstMenu
    End Function

    Public Function GetActiveSubMenusByType(ByVal PermissionTypeId As Integer, ByVal ParentMenuId As Integer) As List(Of Menu)
        Dim MR As New MenusRepository
        Dim lstMenu As New List(Of Menu)
        lstMenu = MR.GetSubMenusByType(PermissionTypeId, ParentMenuId)

        lstMenu = (From item In lstMenu
                   Where item.IsActive = True
                   Select item).ToList()

        Return lstMenu
    End Function

End Class
