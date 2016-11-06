<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Roles.aspx.vb" Inherits="Web.Roles"
    MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <asp:HiddenField ID="hfSelectedRoleId" runat="server" />
    <div id="RolesContent">
        <div class="ContentHeaderTitle">
            Roles
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
                    CellPadding="5" AutoGenerateColumns="false" DataKeyNames="RoleId" Style="margin-top: 10px"
                    AllowSorting="true" SelectedRowStyle-BackColor="Gold" HeaderStyle-BackColor="#DDDDDD"
                    HeaderStyle-Height="25" RowStyle-BackColor="#FFFFFF" PagerStyle-BackColor="#DDDDDD"
                    RowStyle-Height="23">
                    <Columns>
                        <asp:BoundField DataField="RoleName" SortExpression="RoleName" HeaderText="Role Name" />
                        <asp:BoundField DataField="IsActive" SortExpression="IsActive" HeaderText="Is Active" />
                    </Columns>
                </asp:GridView>
                <asp:EntityDataSource ContextTypeName="Model.ABC_CMSApplicationEntities" ID="ESSearchRole"
                    runat="server" ConnectionString="name=ABC_CMSApplicationEntities" DefaultContainerName="ABC_CMSApplicationEntities"
                    EnableFlattening="False" EntitySetName="Roles" Select="it.[RoleId],it.[RoleName],it.[RoleDescription],it.[IsActive]"
                    Where="(((@NewItemId <> 0 AND it.[RoleId] = @NewItemId) Or (@NewItemId = 0 AND it.[RoleId] Is Not Null)) AND (it.[RoleName] Like '%' + @SearchText + '%') AND ((@NewItemId = 0 And it.[IsActive] = @RoleStatus) Or (@NewItemId <> 0 And it.[IsActive] Is Not Null)))" 
                    OrderBy="it.[RoleName]">
                    <WhereParameters>
                        <asp:Parameter Name="NewItemId" Type="Int32" />
                        <asp:ControlParameter ControlID="txtSearchFor" Type="String" Name="SearchText" PropertyName="Text"
                            DefaultValue="%" />
                        <asp:ControlParameter ControlID="cbxActiveSearch" Type="Boolean" Name="RoleStatus"
                            PropertyName="Checked" />
                    </WhereParameters>
                </asp:EntityDataSource>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Role Name: " ClientIDMode="Static" ID="lblRoleName" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:TextBox ID="txtRoleName" ClientIDMode="Static" runat="server" MaxLength="50" />
                <asp:RequiredFieldValidator ID="RVRoleName" runat="server" ControlToValidate="txtRoleName"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Required" CssClass="validators"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CVRoleName" runat="server" ControlToValidate="txtRoleName"
                    Display="Dynamic" SetFocusOnError="true" ErrorMessage="Maximum: 50 chars." CssClass="validators"></asp:CustomValidator>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label ID="lblRoleActive" Text="Active: " runat="server" ClientIDMode="Static" />
            </div>
            <div class="txt">
                <asp:CheckBox Text="" runat="server" ID="cbxActive" Checked="true" ClientIDMode="Static" />
            </div>
        </div>
        <div class="rows" style="width: 100%">
            <div class="lbl">
                <asp:Label ID="lblRoleDescription" Text="Role Description: " runat="server" ClientIDMode="Static" />
            </div>
            <div class="txt">
                <asp:TextBox ID="txtRoleDescription" ClientIDMode="Static" runat="server" TextMode="MultiLine" />
                <asp:RegularExpressionValidator ControlToValidate="txtRoleDescription" ID="RERoleDescription"
                    Display="Dynamic" ValidationExpression="^[\s\S]{1,250}$" runat="server" ErrorMessage="Maximum: 250 char."
                    CssClass="validators"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="rows" style="width: 100%">
            <div class="lbl" style="width: 100%">
                <asp:Label ID="lblFrontendPermissions" Text="Role Backend Controls Permissions: "
                    runat="server" ClientIDMode="Static" />
            </div>
            <div class="txt" style="padding-left: 10px; width: 98%">
                <div id="rptFrontEndMenu_NoAccess" class="NoAccessBox" runat="server" visible="false">
                </div>
                <asp:Repeater ID="rptFrontEndMenu" runat="server">
                    <ItemTemplate>
                        <div class='<%# IIF(CType(Eval("MenuParentId"), Integer) = 0, "RolesPermissionsMenus", "RolesPermissionsMenus_Sub") %>'>
                            <asp:Label Text='<%# Eval("MenuName") %>' data-MenuId='<%# Eval("MenuId") %>' runat="server"
                                CssClass="RolesPermissionsMenuName" />
                            <asp:Repeater runat="server" ID="rptPagesControlsPermissions" OnItemDataBound="rptPagesControlsPermissions_ItemDataBound">
                                <ItemTemplate>
                                    <div class="Table">
                                        <div class="TableRow RolesPagesControlsPermissionsTableRow">
                                            <div class="TableCell RolesPagesControlsPermissionsTableCell">
                                                <asp:Label ID="lblPageControlName" Text='<%# Eval("PermissionControlName") %>' runat="server"
                                                    data-PermissionControlId='<%# Eval("PermissionControlId") %>' CssClass="RolesPermissions_ControlName" />
                                            </div>
                                            <div class="TableCell RolesPagesControlsPermissionsTableCell">
                                                <asp:CheckBoxList ID="cblPageControlActions" CssClass="cblPageControlActions" runat="server"
                                                    RepeatDirection="Horizontal" />
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div style="width: 100%; height: 50px; float: left">
            <div class="btn">
                <asp:Button ID="btnClearBottom" ClientIDMode="Static" Text="Clear" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="false" CausesValidation="false" />
                <asp:Button ID="btnUpdate" ClientIDMode="Static" Text="Update Role" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="true" CausesValidation="true"
                    OnClientClick="if(Page_ClientValidate()) { if (!ConfirmAction(msgUpdateAction)) { return false } }" />
                <asp:Button ID="btnInsert" ClientIDMode="Static" Text="Insert Role" runat="server"
                    CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="true" CausesValidation="true"
                    OnClientClick="if(Page_ClientValidate()) { if (!ConfirmAction(msgInsertAction)) { return false } }" />
                <asp:Button ID="btnInsertAndNew" ClientIDMode="Static" Text="Insert Role And New"
                    runat="server" CssClass="dxbButton_Office2010Blue" UseSubmitBehavior="true" CausesValidation="true"
                    OnClientClick="if(Page_ClientValidate()) { if (!ConfirmAction(msgInsertAction)) { return false } }" />
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
        var CreateUserActionId = 1;
        var ReadUserActionId = 2;
        var UpdateUserActionId = 3;
        var DeleteUserActionId = 4;
        var msgUpdateAction = "Are you sure you want to update this role?";
        var msgInsertAction = "Are you sure you want to insert this role?";

        $(function () {
            $("#menuParentItem_UsersManagement").addClass("pressed");
            $("#txtRoleName").focus();

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

            // Handle Read Action Checkbox
            $(".cblPageControlActions").find("input[value='" + ReadUserActionId + "']").click(function () {
                var checked = $(this).prop("checked");
                if (!checked)
                    UncheckAllActions(this);
            })

            $(".cblPageControlActions").find("input[value='" + CreateUserActionId + "']").click(function () {
                var checked = $(this).prop("checked");
                if (checked)
                    CheckReadAction(this);
            })
            $(".cblPageControlActions").find("input[value='" + UpdateUserActionId + "']").click(function () {
                var checked = $(this).prop("checked");
                if (checked)
                    CheckReadAction(this);
            })
            $(".cblPageControlActions").find("input[value='" + DeleteUserActionId + "']").click(function () {
                var checked = $(this).prop("checked");
                if (checked)
                    CheckReadAction(this);
            })

            //Read permission for control and parent page
            $("div[class^='RolesPermissionsMenus']").each(function (i, cntrl) {
                var cbxParentRead;
                var tableItem;
                var tableItems;
                var checked;
                var tables = $(cntrl).find(".Table");
                if (tables.length >= 2) {
                    $(tables).each(function (j, table) {
                        if (j == 0) {
                            $(table).find(".cblPageControlActions").find("input[value='" + ReadUserActionId + "']").change(function () {
                                if (!$(this).prop("checked")) {
                                    tableItems = $(this).parent().parent().parent().parent().parent().parent().parent().parent().find(".Table");
                                    $(tableItems).find("input[type='checkbox']").prop("checked", false);
                                }
                            });
                        } else {
                            $(table).find(".cblPageControlActions").find("input[value='" + ReadUserActionId + "']").change(function () {
                                if ($(this).prop("checked")) {
                                    tableItem = $(this).parent().parent().parent().parent().parent().parent().parent().parent().find(".Table")[0];
                                    cbxParentRead = $(tableItem).find("input[value='" + ReadUserActionId + "']");
                                    $(cbxParentRead).prop("checked", true);
                                }
                            });
                        }
                    });
                }
            });
        });

        function ConfirmAction(msg) {
            var msgData = $("#lblRoleName").text() + $("#txtRoleName").val() + "\n" + $("#lblRoleActive").text() + ($("#cbxActive").is(':checked') ? "True" : "False");
            return confirm(msg + "\n\n" + msgData);
        }

        function UncheckAllActions(obj) {
            $(obj).parent().parent().find("input").prop("checked", false).trigger("change");
        }

        function CheckReadAction(obj) {
            $(obj).parent().parent().find("input[value='" + ReadUserActionId + "']").prop("checked", true).trigger("change");
        }
    </script>
</asp:Content>
