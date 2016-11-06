<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Web.Login" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>ABC CMS Application - Admin</title>
    <meta http-equiv="content-type" content="text/html; charset=windows-1250">
    <meta http-equiv="x-ua-compatible" content="IE=8">
    <link href="Styles/Admin.css" rel="Stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.10.1.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="Form1" runat="server">
    <div id="LoginWrapper">

        <div style="display: inline-block; vertical-align: middle; height: 100%">
        </div>
        <div id="Login">
            <div style="display: inline-block">
                <img id="Img2" src="~/Images/ABC_Logo.png" style="padding-left: 5px; padding-top: 3px;
                    width: 71px; height: 79px;" alt="Home" runat="server" />
            </div>
            <div style="display: inline-block; vertical-align: top;">
                <h1>
                    ABC CMS APPLICATION - ADMIN</h1>
            </div>
            <div style="display: inline-block; height: 30px; width:100%;">
            </div>
            <div class="LoginTitle">
                Login Information</div>
            <div style="height: 10px; width: 100%">
            </div>
            <div class="LoginContent">
                <div style="width: 100%">
                    <asp:RequiredFieldValidator ID="RFV_Username" runat="server" ControlToValidate="txtUsername"
                        ErrorMessage="Field is required" CssClass="validators" ValidationGroup="valLogin"
                        SetFocusOnError="true" ClientIDMode="Static"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVUsername" runat="server" ControlToValidate="txtUsername"
                        Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
                    <%--<asp:RegularExpressionValidator ID="RE_UserId" ValidationExpression="^[0-9]+$" Display="Dynamic"
                        ControlToValidate="txtUsername" ValidationGroup="valForgotPassword" runat="server"
                        ErrorMessage="Field is numeric" Font-Bold="True" ForeColor="Red"></asp:RegularExpressionValidator>--%>
                </div>
                <div style="width: 100%; height: 20px;">
                    <div style="width: 75px; float: left;">
                        <label for="txtUsername">
                            Username:</label>
                    </div>
                    <div style="width: auto; float: left;">
                        <asp:TextBox runat="server" ID="txtUsername" ClientIDMode="Static" MaxLength="50" />
                    </div>
                </div>
                <div style="height: 2px; width: 100%">
                </div>
                <div style="width: 100%">
                    <asp:RequiredFieldValidator ID="RFV_Password" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="Field is required" CssClass="validators" ValidationGroup="valLogin"
                        ClientIDMode="Static" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVPassword" runat="server" ControlToValidate="txtPassword"
                        Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
                </div>
                <div style="width: 100%; height: 20px;">
                    <div style="width: 75px; float: left;">
                        <label for="txtPassword">
                            Password:</label>
                    </div>
                    <div style="width: auto; float: left;">
                        <asp:TextBox runat="server" ID="txtPassword" ClientIDMode="Static" MaxLength="50"
                            TextMode="Password" />
                    </div>
                </div>
                <div style="height: 20px; width: 100%">
                </div>
                <div style="text-align: right">
                    <asp:Button ID="btnResetPassword" ClientIDMode="Static" Text="Reset Password" runat="server"
                        CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="false" ValidationGroup="valForgotPassword"
                        OnClientClick="if(!UsernameIsValid(event)) { return false; }" />
                    <asp:Button ID="btnLogin" ClientIDMode="Static" Text="Login" runat="server" CssClass="dxbButton_Office2010Blue"
                        UseSubmitBehavior="true" CausesValidation="true" ValidationGroup="valLogin" />
                </div>
                <div style="text-align: left; padding-top: 10px;">
                    <asp:Label Text="" ID="lblError" runat="server" CssClass="validators" Style="padding-left: 0" />
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
<script type="text/javascript">
    String.prototype.RemoveSpaces = function () { return this.replace(/^\s+|\s+$/gm, ''); };
    var msgResetPassword = "Are you sure you want to reset your password?"

    function UsernameIsValid(e) {
        var returnVal = true;
        var usernameVal = $("#txtUsername").val();
        if (usernameVal.RemoveSpaces() == "") {
            $("#RFV_Username").css("visibility", "visible");
            returnVal = false;
        }
        if (returnVal) {
            returnVal = ConfirmAction(msgResetPassword);
        }
        return returnVal;
    }

    $(function () {

        $("#btnLogin").hover(function () {
            $(this).addClass("dxbButtonHover_Office2010Blue");
        });
        $("#btnLogin").mousedown(function () {
            $(this).addClass("dxbButtonPressed_Office2010Blue");
        });
        $("#btnLogin").mouseup(function () {
            $(this).removeClass("dxbButtonHover_Office2010Blue");
            $(this).removeClass("dxbButtonPressed_Office2010Blue");
        });
        $("#btnLogin").mouseout(function () {
            $(this).removeClass("dxbButtonHover_Office2010Blue");
            $(this).removeClass("dxbButtonPressed_Office2010Blue");
        });
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

        $("#txtUsername").focus();
    });

    function ShowAlertMessage(msg) {
        alert(msg);
    }

    function ConfirmAction(msg) {
        return confirm(msg);
    }

</script>
</html>
