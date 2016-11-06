<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangePassword.aspx.vb" Inherits="Web.ChangePassword" MasterPageFile="~/Admin/Admin.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <div id="ChangePasswordContent">
        <div style="width: 100%; margin-bottom: 10px;">
            <asp:Label Text="" ID="lblError" runat="server" CssClass="validators" />
        </div>
        <div style="width: 100%">
            <p>
                <b>Type old password and new password:</b></p>
            <p>
                &nbsp;</p>
        </div>
        <div class="rows" style="width: 100%;">
            <div class="lbl">
                <asp:Label Text="Old Password: " ClientIDMode="Static" ID="lblOldPassword" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtOldPassword" ClientIDMode="Static" runat="server" MaxLength="50" TextMode="Password" />
                <asp:RequiredFieldValidator ID="RVOldPassword" runat="server" ControlToValidate="txtOldPassword"
                    SetFocusOnError="true" ErrorMessage="Required" CssClass="validators" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVMOldPassword" runat="server" ControlToValidate="txtOldPassword"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
                <asp:CustomValidator ID="CVIncorrectPassword" runat="server" ControlToValidate="txtOldPassword"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Old Password is not correct"
                    CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div class="rows" style="width: 100%;">
            <div class="lbl">
                <asp:Label Text="New Password: " ClientIDMode="Static" ID="Label1" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtNewPassword" ClientIDMode="Static" runat="server" MaxLength="50" TextMode="Password" />
                <asp:RequiredFieldValidator ID="RVNewPassword" runat="server" ControlToValidate="txtNewPassword"
                    SetFocusOnError="true" ErrorMessage="Required" CssClass="validators" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVNewPassword" runat="server" ControlToValidate="txtNewPassword"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
                <asp:CompareValidator ID="CV_Oldpassword" ControlToValidate="txtRetypeNewPassword"
                    ControlToCompare="txtNewPassword" runat="server" Display="Dynamic" ErrorMessage="New passwords do not match"
                    SetFocusOnError="true" CssClass="validators"></asp:CompareValidator>
            </div>
        </div>
        <div class="rows" style="width: 100%;">
            <div class="lbl">
                <asp:Label Text="Retype New Password: " ClientIDMode="Static" ID="Label2" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtRetypeNewPassword" ClientIDMode="Static" runat="server" MaxLength="50" TextMode="Password" />
                <asp:RequiredFieldValidator ID="RVRetypeNewPassword" runat="server" ControlToValidate="txtRetypeNewPassword"
                    SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVRetypeNewPassword" runat="server" ControlToValidate="txtRetypeNewPassword"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div style="width: 100%; height: 50px; float: left">
            <div class="btn">
                <asp:Button ID="btnClearBottom" ClientIDMode="Static" Text="Clear" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="false" CausesValidation="false" />
                <asp:Button ID="btnChange" ClientIDMode="Static" Text="Change" runat="server" CssClass="dxbButton_Office2010Blue"
                    UseSubmitBehavior="true" CausesValidation="true" OnClientClick="if(Page_ClientValidate()) { if (!ConfirmAction(msgChangeAction)) { return false } }" />
                <div style="display: inline; vertical-align: middle">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message" />
                </div>
            </div>
        </div>
        <div style="width: 100%; height: 10px;">
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptHolder" runat="server">
    <script type="text/javascript">

        var msgChangeAction = "Are you sure you want to change the password?";

        $(function () {
            $("#txtOldPassword").focus();

            $("#btnChange").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnChange").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnChange").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnChange").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnClearBottom").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnClearBottom").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnClearBottom").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnClearBottom").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });

        });

        function ConfirmAction(msg) {
            return confirm(msg);
        }
    </script>
</asp:Content>
