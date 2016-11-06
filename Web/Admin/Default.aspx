<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Web._Default1" MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="Content" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptHolder" runat="server">
<script type="text/javascript">
    $(function () {
        $("#menuItem_Home").addClass("pressed");
    });
</script>
</asp:Content>