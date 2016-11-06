Imports Model
Imports CommonLibrary.Members
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class WebService
    Inherits System.Web.Services.WebService

    <WebMethod(EnableSession:=True)> _
    Public Function KeepSessionAlive() As String
        Return ""
    End Function

    <WebMethod(EnableSession:=True)> _
    Public Sub InsertWSErrorLog(ByVal ErrorText As String, ByVal ControlId As Integer)
        Dim dbModel As New ABC_CMSApplicationEntities
        Dim InnerExceptionValue As String = ""
        Dim log As New ErrorLog
        ErrorText = System.Web.HttpContext.Current.Server.UrlDecode(ErrorText)

        log.ErrorLogDate = DateTime.Now
        log.ErrorLogDateMMS = Format(DateTime.Now, "yyMMdd")
        log.Message = ErrorText
        log.UserId = pUserId
        log.ErrorLogControlId = ControlId
        dbModel.AddToErrorLogs(log)
        dbModel.SaveChanges()
    End Sub
End Class