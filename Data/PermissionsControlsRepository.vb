Imports Model

Public Class PermissionsControlsRepository

    Public Function GetPagesPermissionsControlsData() As List(Of PermissionsControl)
        Dim lstControls As New List(Of PermissionsControl)
        Dim dbModel As New ABC_CMSApplicationEntities

        lstControls = (From item In dbModel.PermissionsControls
                       Select item).ToList()

        Return lstControls
    End Function

End Class
