Imports Model

Public Class MenusRepository

    Public Function GetParentMenu(ByVal PermissionTypeId As Integer) As List(Of Menu)
        Dim lstMenu As New List(Of Menu)
        Dim dbModel As New ABC_CMSApplicationEntities

        lstMenu = (From item In dbModel.Menus
                   Where item.MenuPermissionTypeId = PermissionTypeId _
                   And item.MenuParentId = 0
                   Select item).ToList()

        Return lstMenu
    End Function

    Public Function GetSubMenu(ByVal PermissionTypeId As Integer) As List(Of Menu)
        Dim lstMenu As New List(Of Menu)
        Dim dbModel As New ABC_CMSApplicationEntities

        lstMenu = (From item In dbModel.Menus
                   Where item.MenuPermissionTypeId = PermissionTypeId _
                   And item.MenuParentId <> 0
                   Select item).ToList()

        Return lstMenu
    End Function

    Public Function GetMenuByType(ByVal PermissionTypeId As Integer) As List(Of Menu)
        Dim lstMenu As New List(Of Menu)
        Dim dbModel As New ABC_CMSApplicationEntities

        lstMenu = (From item In dbModel.Menus
                   Where item.MenuPermissionTypeId = PermissionTypeId
                   Select item).ToList()

        Return lstMenu
    End Function

    Public Function GetSubMenusByType(ByVal PermissionTypeId As Integer, ByVal ParentMenuId As Integer) As List(Of Menu)
        Dim lstMenu As New List(Of Menu)
        Dim dbModel As New ABC_CMSApplicationEntities

        lstMenu = (From item In dbModel.Menus
                   Where item.MenuPermissionTypeId = PermissionTypeId _
                   And item.MenuParentId = ParentMenuId
                   Select item).ToList()

        Return lstMenu
    End Function

End Class
