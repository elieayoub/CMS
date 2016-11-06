Imports Business.Operations
Imports CommonLibrary.Globals
Imports CommonLibrary.Members

Public Class Admin
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If pUserId = 0 Then
                Response.Redirect("Login.aspx")
            Else
                Dim pa As New PageAssembler(Nothing)
                pa.LoadMasterPageBuckets(Me, "AdminHeader", "AdminHeader")
                pa.LoadMasterPageBuckets(Me, "AdminFooter", "AdminFooter")
            End If
        Catch ex As Exception
            Dim msg As String = "Error: " & ex.Message
            InsertErrorLog(ex, pUserId, 0, 0)
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "TriggerShowAlertMessageFromSiteMaster", "$(function () { ShowAlertMessage('" + msg + "') }); ", True)
        End Try
    End Sub


End Class