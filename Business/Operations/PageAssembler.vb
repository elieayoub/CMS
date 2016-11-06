Imports System.Web
Imports System.Web.UI
Imports CommonLibrary.Globals
Imports System.Web.UI.WebControls

Namespace Operations
    Public Class PageAssembler

        Private ReadOnly _page As Page
        Private _Control As PlaceHolder

        Public Sub New(ByVal page As Page)
            _page = page
        End Sub

        Public Sub LoadBuckets(ByVal BucketName As String, ByVal PageControlName As String)
            _Control = CType(_page.FindControl(PageControlName), PlaceHolder)
            Dim bucket As Control = _page.LoadControl("core/buckets/" + BucketName + ".ascx")

            bucket.ID = String.Concat(GetFromConfig("UIPrefix"), BucketName)
            If _Control IsNot Nothing Then
                _Control.Controls.Add(bucket)
            End If
        End Sub

        Public Sub LoadMasterPageBuckets(ByVal Master As MasterPage, ByVal BucketName As String, ByVal PageControlName As String)
            _Control = CType(Master.FindControl(PageControlName), PlaceHolder)
            Dim bucket As Control = Master.LoadControl("core/buckets/" + BucketName + ".ascx")

            bucket.ID = String.Concat(GetFromConfig("UIPrefix"), BucketName)
            If _Control IsNot Nothing Then
                _Control.Controls.Add(bucket)
            End If
        End Sub

    End Class
End Namespace