Imports CommonLibrary.Members
Imports Model

Public Class Globals

#Region "Methods"
    Public Shared Sub InsertErrorLog(ByVal Exception As System.Exception, ByVal UserId As Integer, ByVal ControlId As Integer, ByVal UserActionId As Integer)
        Try
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim InnerExceptionValue As String = ""
            If Exception.InnerException IsNot Nothing Then
                InnerExceptionValue = Exception.InnerException.ToString()
            End If
            Dim log As New ErrorLog
            log.ErrorLogDate = DateTime.Now
            log.ErrorLogDateMMS = Format(DateTime.Now, "yyMMdd")
            log.Message = Exception.Message
            log.StackTrace = Exception.StackTrace
            log.InnerException = InnerExceptionValue
            log.Source = Exception.Source
            log.UserId = UserId
            log.ErrorLogControlId = ControlId
            log.UserActionId = UserActionId
            dbModel.AddToErrorLogs(log)
            dbModel.SaveChanges()
        Catch ex As Exception
            Throw ex.InnerException
        End Try
    End Sub

    Public Shared Sub InsertActionLog(ByVal UserId As Integer, ByVal PagePermissionId As Integer, ByVal ControlId As Integer, ByVal UserActionId As Integer, Optional ByVal ActionDescription As String = "")
        Try
            Dim dbModel As New ABC_CMSApplicationEntities
            Dim action As New ActionLog
            action.UserId = UserId
            action.PagePermissionId = PagePermissionId
            action.ActionLogControlId = ControlId
            action.UserActionId = UserActionId
            action.ActionLogDate = DateTime.Now
            action.ActionLogDateMMS = ConvertDateToMMS(DateTime.Now)
            action.Description = ActionDescription

            dbModel.AddToActionLogs(action)
            dbModel.SaveChanges()
        Catch ex As Exception
            Throw ex.InnerException
        End Try
    End Sub

    Public Shared Function ConvertDateToMMS(ByVal d As Date) As String
        Dim returnVal As String = ""
        Try
            returnVal = Format(d, "yyMMdd")
        Catch ex As Exception
            InsertErrorLog(ex, pUserId, 0, 0)
        End Try
        Return returnVal
    End Function

    Public Shared Function GetFromConfig(ByVal key As String)
        Dim ConfigReader As New Configuration.AppSettingsReader
        Return ConfigReader.GetValue(key, GetType(String))
    End Function

    Public Shared Function SendMail(ByVal HtmlBody As String, ByVal FilesToAttach As String(), FromEmail As String, ToEmail As String, CcEmail As String, BccEmail As String, Subject As String) As String
        Dim ReturnMessage As String = String.Empty
        Try
            Dim Recipients() As String
            Dim Mail As New Net.Mail.MailMessage()
            Dim SmtpServer As New Net.Mail.SmtpClient()

            'SmtpServer.Credentials = New Net.NetworkCredential("username@gmail.com", "password")
            SmtpServer.Port = 25
            SmtpServer.Host = GetFromConfig("STMP")
            Mail = New Net.Mail.MailMessage()
            Mail.From = New Net.Mail.MailAddress(FromEmail)

            'SET TO RECIPIENTS
            Recipients = ToEmail.Split(",")
            For Each Item In Recipients
                Mail.To.Add(Item)
            Next

            'SET CC RECIPIENTS
            If Not String.IsNullOrEmpty(CcEmail) Then
                Recipients = CcEmail.Split(",")
                For Each Item In Recipients
                    Mail.CC.Add(Item)
                Next
            End If

            'SET BCC RECIPIENTS
            If Not String.IsNullOrEmpty(BccEmail) Then
                Recipients = BccEmail.Split(",")
                For Each Item In Recipients
                    Mail.Bcc.Add(Item)
                Next
            End If

            Mail.Subject = Subject & " - " & Format(Now, "dd MMM yyyy hh:mm:ss") & " - " & "(Automatically Generated Email)"

            For Each FileName As String In FilesToAttach
                Mail.Attachments.Add(New System.Net.Mail.Attachment(FileName))
            Next

            Mail.IsBodyHtml = True
            Mail.Body = "Dear,<br/><br/>" & _
                            HtmlBody & _
                            "<br/><br /> Regards,<br/>"

            SmtpServer.Send(Mail)
        Catch ex As Exception
            ReturnMessage = ex.Message
        End Try
        Return ReturnMessage
    End Function
#End Region

End Class
