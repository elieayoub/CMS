<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Users.aspx.vb" Inherits="Web.Users"
    MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <asp:HiddenField ID="hfSelectedUserId" runat="server" />
    <asp:HiddenField ID="hfSelectedUserEntityId" runat="server" />
    <div id="UsersContent">
        <div class="ContentHeaderTitle">
            Users
        </div>
        <div style="width: 100%; margin-bottom: 10px; float: left">
            <asp:Label Text="" ID="lblError" runat="server" CssClass="validators" />
        </div>
        <div id="SearchContainer">
            <div>
                Search For:
            </div>
            <div>
                <asp:TextBox runat="server" ID="txtSearchFor" ClientIDMode="Static" />
            </div>
            <div>
                <asp:CheckBox runat="server" ID="cbxActiveSearch" Checked="true" Text="Active" />
            </div>
            <div>
                <asp:Button ID="btnClearTop" ClientIDMode="Static" Text="Clear" runat="server" CssClass="dxbButton_Office2010Blue"
                    UseSubmitBehavior="false" CausesValidation="false" />
            </div>
            <div>
                <asp:Button ID="btnSearch" ClientIDMode="Static" Text="Search" runat="server" CssClass="dxbButton_Office2010Blue"
                    UseSubmitBehavior="false" CausesValidation="false" />
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:GridView ID="gvSearch" CssClass="gvSearch" runat="server" AllowPaging="true" AutoGenerateSelectButton="true"
                    CellPadding="5" AutoGenerateColumns="false" DataKeyNames="UserId,EntityId" Style="margin-top: 10px"
                    AllowSorting="true" SelectedRowStyle-BackColor="Gold" HeaderStyle-BackColor="#DDDDDD"
                    HeaderStyle-Height="25" RowStyle-BackColor="#FFFFFF" PagerStyle-BackColor="#DDDDDD"
                    RowStyle-Height="23">
                    <Columns>
                        <asp:BoundField DataField="Username" SortExpression="Username" HeaderText="Username" />
                        <asp:BoundField DataField="FirstName" SortExpression="FirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="LastName" SortExpression="LastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="Email" SortExpression="Email" HeaderText="Email" />
                        <asp:BoundField DataField="IsActive" SortExpression="IsActive" HeaderText="Is Active" />
                    </Columns>
                </asp:GridView>
                <asp:EntityDataSource ContextTypeName="Model.ABC_CMSApplicationEntities" ID="ESSearchUser"
                    runat="server" ConnectionString="name=ABC_CMSApplicationEntities" DefaultContainerName="ABC_CMSApplicationEntities"
                    EnableFlattening="False" EntitySetName="v_GetUsersInformations" Select="it.[UserId],it.[FirstName],it.[LastName],it.[Username],it.[Password],it.[CreationDate],it.[CreationDateMMS],it.[ModificationDate],it.[ModificationDateMMS],it.[IsActive],it.[Email],it.[EntityId]"
                    Where="((it.[FirstName] Like '%' + @SearchText + '%' or it.[LastName] Like '%' + @SearchText + '%' or it.[Username] Like '%' + @SearchText + '%' or it.[Email] Like '%' + @SearchText + '%') and it.[IsActive] = @UserStatus)"
                    OrderBy="it.[Username]">
                    <WhereParameters>
                         <asp:Parameter Name="NewItemId" Type="Int32" />
                        <asp:ControlParameter ControlID="txtSearchFor" Type="String" Name="SearchText" PropertyName="Text"
                            DefaultValue="%" />
                        <asp:ControlParameter ControlID="cbxActiveSearch" Type="Boolean" Name="UserStatus"
                            PropertyName="Checked" />
                    </WhereParameters>
                </asp:EntityDataSource>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="First Name: " ClientIDMode="Static" ID="lblFirstName" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtFirstName" ClientIDMode="Static" runat="server" MaxLength="50" />
                <asp:RequiredFieldValidator ID="RVFirstName" runat="server" ControlToValidate="txtFirstName"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVFirstName" runat="server" ControlToValidate="txtFirstName"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Last Name: " ClientIDMode="Static" ID="lblLastName" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtLastName" ClientIDMode="Static" runat="server" MaxLength="50" />
                <asp:RequiredFieldValidator ID="RVLastName" runat="server" ControlToValidate="txtLastName"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVLastName" runat="server" ControlToValidate="txtLastName"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Username: " ClientIDMode="Static" ID="lblUsername" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtUsername" ClientIDMode="Static" runat="server" MaxLength="50"
                    Style="width: 170px; width: 178px\9;" />
                <input type="button" id="btnCheckUserAvailability" clientidmode="Static" value="Check Username"
                    runat="server" class="dxbButton_Office2010Blue" onclick="IsUsernameDuplicate(true)" />
                <asp:Label ID="lblUsernameStatus" ClientIDMode="Static" runat="server" />
                <asp:RequiredFieldValidator ID="RVUsername" runat="server" ControlToValidate="txtUsername"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVUsername" runat="server" ControlToValidate="txtUsername"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Password: " ClientIDMode="Static" ID="lblPassword" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtPassword" ClientIDMode="Static" runat="server" MaxLength="50" />
                <asp:RequiredFieldValidator ID="RVPassword" runat="server" ControlToValidate="txtPassword"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVPassword" runat="server" ControlToValidate="txtPassword"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Email: " ClientIDMode="Static" ID="lblEmail" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtEmail" ClientIDMode="Static" runat="server" MaxLength="50" />
                <asp:RequiredFieldValidator ID="RVEmail" runat="server" ControlToValidate="txtEmail"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic"
                    SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
                <asp:RegularExpressionValidator ID="REEmail" runat="server" ErrorMessage="Invalid Email"
                    ControlToValidate="txtEmail" CssClass="validators" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                </asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label ID="lblUserActive" Text="Active: " runat="server" ClientIDMode="Static" />
            </div>
            <div class="txt">
                <asp:CheckBox Text="" runat="server" ID="cbxActive" Checked="true" ClientIDMode="Static" />
            </div>
        </div>
        <div class="rows" style="width: 100%; float: left;">
            <div class="lbl">
                <asp:Label Text="Roles: " ClientIDMode="Static" ID="lblRoles" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:CheckBoxList ID="cblRoles" runat="server" DataValueField="RoleId" DataTextField="RoleName"
                    RepeatLayout="OrderedList" RepeatDirection="Vertical" Style="margin-top: 0">
                </asp:CheckBoxList>
                <div id="cblRoles_NoAccess" class="NoAccessBox" runat="server" visible="false">
                </div>
            </div>
        </div>
        <div style="width: 100%; height: 50px; float: left">
            <div class="btn">
                <asp:Button ID="btnClearBottom" ClientIDMode="Static" Text="Clear" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="false" CausesValidation="false" />
                <asp:Button ID="btnUpdate" ClientIDMode="Static" Text="Update User" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="true" CausesValidation="true"
                    OnClientClick="if(Page_ClientValidate()) { if (!ConfirmAction(msgUpdateAction)) { return false } }" />
                <asp:Button ID="btnInsert" ClientIDMode="Static" Text="Insert User" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="true" CausesValidation="true"
                    OnClientClick="var returnVal = false; if(Page_ClientValidate()) { if (ConfirmAction(msgInsertAction)) { if (!IsUsernameDuplicate(false)) { returnVal = true; } } }; return returnVal;" />
                <asp:Button ID="btnInsertAndNew" ClientIDMode="Static" Text="Insert User And New"
                    runat="server" CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="true" CausesValidation="true"
                    OnClientClick="var returnVal = false; if(Page_ClientValidate()) { if (ConfirmAction(msgInsertAction)) { if (!IsUsernameDuplicate(false)) { returnVal = true; } } }; return returnVal;" />
                <div style="display: inline; vertical-align: middle">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message" />
                </div>
            </div>
        </div>
        <div style="width: 100%; height: 10px; float: left">
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptHolder" runat="server">
    <script type="text/javascript">
        String.prototype.RemoveSpaces = function () { return this.replace(/^\s+|\s+$/gm, ''); };
        var msgUpdateAction = "Are you sure you want to update this user?";
        var msgInsertAction = "Are you sure you want to insert this user?";
        var msgUsernameAlreadyExist = "Taken"
        var msgUsernameNotExist = "Available"

        $(function () {
            $("#menuParentItem_UsersManagement").addClass("pressed");
            $("#txtFirstName").focus();

            $("#btnInsert").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnInsert").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnInsert").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnInsert").mouseout(function () {
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
            $("#btnClearTop").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnClearTop").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnClearTop").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnClearTop").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnUpdate").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnUpdate").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnUpdate").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnUpdate").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnSearch").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnSearch").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnSearch").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnSearch").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnCheckUserAvailability").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnCheckUserAvailability").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnCheckUserAvailability").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnCheckUserAvailability").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnInsertAndNew").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $("#btnInsertAndNew").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnInsertAndNew").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $("#btnInsertAndNew").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });

            $("#txtSearchFor").keypress(function (e) {
                if (e.which == 13) {
                    $("#btnSearch").click();
                }
            });

        });

        function IsUsernameDuplicate(alertIfExist) {
            var exist;
            var Username = $("#txtUsername").val();
            Username = Username.RemoveSpaces();
            if (Username != null && Username != "") {
                Username = escape(Username);
                $.ajax({
                    type: "POST",
                    url: "Users.aspx/IsUsernameDuplicate",
                    data: "{'Username':'" + Username + "'}",
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false,
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Request: " + XMLHttpRequest.toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                    },
                    success: function (result) {
                        if (result.d == true) {
                            //alert(msgUsernameAlreadyExist);
                            $("#lblUsernameStatus").css("color", "red")
                            $("#lblUsernameStatus").text(msgUsernameAlreadyExist);
                        } else if (alertIfExist) {
                            //alert(msgUsernameNotExist);
                            $("#lblUsernameStatus").css("color", "green")
                            $("#lblUsernameStatus").text(msgUsernameNotExist);
                        }
                        exist = result.d;
                    }
                });
            }
            return exist;
        }

        function ConfirmAction(msg) {
            var msgData = $("#lblFirstName").text() + $("#txtFirstName").val() + "\n" + $("#lblLastName").text() + $("#txtLastName").val() + "\n" + $("#lblUsername").text() + $("#txtUsername").val() + "\n" + $("#lblEmail").text() + $("#txtEmail").val() + "\n" + $("#lblUserActive").text() + ($("#cbxActive").is(':checked') ? "True" : "False");
            return confirm(msg + "\n\n" + msgData);
        }
    </script>
</asp:Content>
