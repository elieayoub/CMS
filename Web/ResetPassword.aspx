<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResetPassword.aspx.vb" Inherits="Web.ResetPassword" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>ABC CMS Application - Admin</title>
    <meta http-equiv="content-type" content="text/html; charset=windows-1250">
    <meta http-equiv="x-ua-compatible" content="IE=8">
    <link href="Admin/Styles/Admin.css" rel="Stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.10.1.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="ResetPasswordContent">
        <div style="width: 100%; margin-bottom: 10px; float: left">
            <asp:Label Text="" ID="lblError" runat="server" CssClass="validators" />
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="First Name: " ClientIDMode="Static" ID="label1" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label ClientIDMode="Static" ID="lblFirstName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Last Name: " ClientIDMode="Static" ID="label2" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label ClientIDMode="Static" ID="lblLastName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Username: " ClientIDMode="Static" ID="label4" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label ClientIDMode="Static" ID="lblUsername" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Email: " ClientIDMode="Static" ID="label7" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label ClientIDMode="Static" ID="lblEmail" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Active: " ClientIDMode="Static" ID="label5" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label ClientIDMode="Static" ID="lblActive" runat="server"></asp:Label>
            </div>
        </div>
        <div style="width: 100%; height: 50px; float: left">
            <div class="btn">
                <asp:Button ID="btnResetPassword" ClientIDMode="Static" Text="Reset Password" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="false" ValidationGroup="valForgotPassword"
                    OnClientClick="if(!ConfirmAction(msgResetPassword)) { return false; }" />
                <div style="display: inline; vertical-align: middle">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message" />
                </div>
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        var msgResetPassword = "Are you sure you want to reset password?";

        $(function () {
            $("#btnResetPassword").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnResetPassword").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnResetPassword").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnResetPassword").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
        });

        function ConfirmAction(msg) {
            return confirm(msg);
        }

        function ShowAlertMessage(msg) {
            alert(msg);
        }

    </script>
</body>
</html>
