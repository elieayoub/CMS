<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActionLogs.aspx.vb" Inherits="Web.ActionLogs"
    MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <asp:HiddenField ID="hfActionLogId" runat="server" />
    <div id="ActionLogsContent">
        <div class="ContentHeaderTitle">
            Action Logs
        </div>
        <div style="width: 100%; margin-bottom: 10px; float: left">
            <asp:Label Text="" ID="lblError" runat="server" CssClass="validators" />
        </div>
        <div id="SearchContainer">
            <div>
                Page Name:
            </div>
            <div>
                <asp:TextBox runat="server" ID="txtSearchFor" ClientIDMode="Static" />
            </div>
            <div>
                From:
            </div>
            <div>
                <asp:TextBox ID="txtActionLogDateFrom" ClientIDMode="Static" runat="server" Style="width: 130px" />
            </div>
            <div>
                To:
            </div>
            <div>
                <asp:TextBox ID="txtActionLogDateTo" ClientIDMode="Static" runat="server" Style="width: 130px" />
            </div>
            <div>
                Username:
            </div>
            <div>
                <asp:DropDownList runat="server" ID="ddlUsername" ClientIDMode="Static">
                </asp:DropDownList>
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
                <asp:GridView ID="gvSearch" CssClass="gvSearch" runat="server" AllowPaging="true"
                    AutoGenerateSelectButton="true" CellPadding="5" AutoGenerateColumns="false" DataKeyNames="ActionLogId"
                    Style="margin-top: 10px" AllowSorting="true" SelectedRowStyle-BackColor="Gold"
                    HeaderStyle-BackColor="#DDDDDD" HeaderStyle-Height="25" RowStyle-BackColor="#FFFFFF"
                    PagerStyle-BackColor="#DDDDDD" RowStyle-Height="23">
                    <Columns>
                        <asp:BoundField DataField="ActionLogDate" SortExpression="ActionLogDate" HeaderText="Date" />
                        <asp:BoundField DataField="Username" SortExpression="Username" HeaderText="Username" />
                        <asp:BoundField DataField="PageName" SortExpression="PageName" HeaderText="PageName" />
                        <asp:BoundField DataField="UserActionName" SortExpression="UserActionName" HeaderText="UserActionName" />
                    </Columns>
                </asp:GridView>
                <asp:EntityDataSource ContextTypeName="Model.ABC_CMSApplicationEntities" ID="ESSearchActionLogs"
                    runat="server" ConnectionString="name=ABC_CMSApplicationEntities" DefaultContainerName="ABC_CMSApplicationEntities"
                    EnableFlattening="False" EntitySetName="v_GetActionLogsInformation" Select="it.[ActionLogId],it.[UserId],it.[PagePermissionId],it.[ActionLogControlId],it.[ActionLogDate],it.[ActionLogDateMMS],it.[UserActionId],it.[Username],it.[PagePermissionName],it.[PermissionControlName],it.[UserActionName],it.[PageId],it.[PageName]"
                    Where="((it.[PageName] Like '%' + @SearchText + '%') And ((@ActionLogDateFromMMS <> 0 And it.[ActionLogDateMMS] >= @ActionLogDateFromMMS) Or (@ActionLogDateFromMMS = 0 And it.[ActionLogDateMMS] > 0)) And ((@ActionLogDateToMMS <> 0 And it.[ActionLogDateMMS] <= @ActionLogDateToMMS) Or (@ActionLogDateToMMS = 0 And it.[ActionLogDateMMS] <= 999999)) And ((@Username = 0 And it.[UserId] Is Not Null) Or (@Username > 0 And it.[UserId] = @Username)))"
                    OrderBy="it.[ActionLogDate] DESC">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="txtSearchFor" Type="String" Name="SearchText" PropertyName="Text"
                            DefaultValue="%" />
                        <asp:Parameter Name="ActionLogDateFromMMS" Type="Int32" />
                        <asp:Parameter Name="ActionLogDateToMMS" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlUsername" Type="Int32" Name="Username" PropertyName="SelectedValue" />
                    </WhereParameters>
                </asp:EntityDataSource>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Log Date: " ClientIDMode="Static" ID="lblLogDate" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionLogDate" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Username: " ClientIDMode="Static" ID="lblUsername" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionLogUsername" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Page Name: " ClientIDMode="Static" ID="lblPageName" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionLogPageName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Page Permission: " ClientIDMode="Static" ID="lblPagePermission"
                    runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionLogPagePermissionName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Control Name: " ClientIDMode="Static" ID="lblControlName" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionLogControlName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Action: " ClientIDMode="Static" ID="lblAction" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionLogActionName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Description: " ClientIDMode="Static" ID="lblDescription" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblActionDescription" runat="server"></asp:Label>
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

        $(function () {
            $("#menuParentItem_Logs").addClass("pressed");

            $("#txtActionLogDateTo").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy'
            });

            $("#txtActionLogDateFrom").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy'
            });
            //$("#txtActionLogDateFrom").datepicker("setDate", new Date());

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

            $("#txtSearchFor").keypress(function (e) {
                if (e.which == 13) {
                    $("#btnSearch").click();
                }
            });
        });
    </script>
</asp:Content>
