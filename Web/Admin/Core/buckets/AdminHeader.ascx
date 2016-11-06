<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AdminHeader.ascx.vb"
    Inherits="Web.AdminHeader" %>
<div id="Header" class="hideOnPrint">
    <div id="Logo">
        <img id="Img1" src="~/Images/ABC_Logo.png" style="padding-left: 5px; padding-top: 3px;
            width: 71px; height: 79px;" alt="Home" runat="server" />
    </div>
    <div id="HeaderCenterContent">
        <h1>
            ABC CMS APPLICATION - ADMIN</h1>
    </div>
    <div id="HeaderRightContent">
        <div id="HeaderWelcomeMessage">
            Welcome,
            <asp:Label ID="lblLoggedinUserFullName" Text="" runat="server" />
        </div>
        <div id="HomeTopMenuContent">
            <ul class="Menu" id="ulTopMenu" runat="server">
                <li><a href="ChangePassword.aspx">Change Password</a></li>
                <li class="sep">|</li>
                <li>
                    <asp:LinkButton runat="server" ID="btnLogout" Text="Log Out" CausesValidation="false"></asp:LinkButton></li>
            </ul>
        </div>
    </div>
</div>
<div id="HomeMenuContent" class="hideOnPrint">
    <ul class="Menu">
        <li id="liHome" runat="server"><a id="menuItem_Home" href="Default.aspx" style='cursor: pointer;'
            class='top'>Home</a></li>
        <li id="liSep" runat="server" class='sep'>|</li>
        <asp:Repeater runat="server" ID="rptMenu">
            <ItemTemplate>
                <%# IIf((CType(Eval("MenuParentId"), Integer) = 0 AndAlso CType(Eval("MenuPageId"), Integer) = 0), "<li class='HasSub'><a id='menuParentItem_" & RemoveSpaces(Eval("MenuName")) & "' href='javascript:void(0)' class='top'>" & Eval("MenuName") & "</a>", "<li><a id='menuItem_" & RemoveSpaces(Eval("MenuName")) & "' href='" & Eval("MenuPath") & "' class='top' style='cursor: pointer'>" & Eval("MenuName") & "</a>")%>
                <asp:Repeater ID="rpt_SubMenu" runat="server">
                    <HeaderTemplate>
                        <ul class="submenu">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li><a href='<%# Eval("MenuPath") %>'>
                            <%# Eval("MenuName") %></a></li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul></FooterTemplate>
                </asp:Repeater>
                </li>
            </ItemTemplate>
            <SeparatorTemplate>
                <li class="sep">|</li>
            </SeparatorTemplate>
        </asp:Repeater>
    </ul>
</div>
