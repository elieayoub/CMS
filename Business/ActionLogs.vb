Imports Model

Public Class ActionLogs

    Public Function GetActionLogDataById(ByVal SelectedActionLogId As Integer) As v_GetActionLogsInformation
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim itemErrorLog As New v_GetActionLogsInformation

        itemErrorLog = (From item In dbModel.v_GetActionLogsInformation
                        Where item.ActionLogId = SelectedActionLogId
                        Select item).FirstOrDefault()

        Return itemErrorLog
    End Function

End Class
