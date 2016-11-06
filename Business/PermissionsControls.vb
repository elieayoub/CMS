Imports Model

Public Class PermissionsControls

    Public Function GetActivePagesPermissionsControlsData() As List(Of PermissionsControl)
        Dim clsPermissionsControlsRepository As New Data.PermissionsControlsRepository
        Dim lstControls As New List(Of PermissionsControl)

        lstControls = clsPermissionsControlsRepository.GetPagesPermissionsControlsData()

        lstControls = (From item In lstControls
                       Where item.IsActive = True
                       Select item).ToList()

        Return lstControls
    End Function

End Class
