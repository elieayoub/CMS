Imports Model

Public Class ErrorLogs

    Public Function GetErrorLogDataById(ByVal SelectedErrorLogId As Integer) As v_GetErrorLogsInformation
        Dim itemErrorLog As New v_GetErrorLogsInformation
        Dim dbModel As New ABC_CMSApplicationEntities

        itemErrorLog = (From item In dbModel.v_GetErrorLogsInformation
                        Where item.ErrorLogId = SelectedErrorLogId
                        Select item).FirstOrDefault()

        Return itemErrorLog
    End Function

End Class
