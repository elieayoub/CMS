<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ErrorLogs.aspx.vb" Inherits="Web.ErrorLogs"
    MasterPageFile="~/Admin/Admin.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">
    <asp:HiddenField ID="hfErrorLogId" runat="server" />
    <div id="ErrorLogsContent">
        <div class="ContentHeaderTitle">
            Error Logs
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
                From:
            </div>
            <div>
                <asp:TextBox ID="txtErrorLogDateFrom" ClientIDMode="Static" runat="server" Style="width: 130px" />
            </div>
            <div>
                To:
            </div>
            <div>
                <asp:TextBox ID="txtErrorLogDateTo" ClientIDMode="Static" runat="server" Style="width: 130px" />
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
                <asp:GridView ID="gvSearch" CssClass="gvSearch" runat="server" AllowPaging="true" AutoGenerateSelectButton="true"
                    CellPadding="5" AutoGenerateColumns="false" DataKeyNames="ErrorLogId" Style="margin-top: 10px"
                    AllowSorting="true" SelectedRowStyle-BackColor="Gold" HeaderStyle-BackColor="#DDDDDD"
                    HeaderStyle-Height="25" RowStyle-BackColor="#FFFFFF" PagerStyle-BackColor="#DDDDDD"
                    RowStyle-Height="23">
                    <Columns>
                        <asp:BoundField DataField="ErrorLogDate" SortExpression="ErrorLogDate" HeaderText="Date" />
                        <asp:BoundField DataField="Message" SortExpression="Message" HeaderText="Message" />
                        <asp:BoundField DataField="Source" SortExpression="Source" HeaderText="Source" />
                        <asp:BoundField DataField="Username" SortExpression="Username" HeaderText="Username" />
                        <asp:BoundField DataField="PermissionControlName" SortExpression="PermissionControlName"
                            HeaderText="Control Name" />
                        <asp:BoundField DataField="UserActionName" SortExpression="UserActionName" HeaderText="UserActionName" />
                    </Columns>
                </asp:GridView>
                <asp:EntityDataSource ContextTypeName="Model.ABC_CMSApplicationEntities" ID="ESSearchErrorLogs"
                    runat="server" ConnectionString="name=ABC_CMSApplicationEntities" DefaultContainerName="ABC_CMSApplicationEntities"
                    EnableFlattening="False" EntitySetName="v_GetErrorLogsInformation" Select="it.[ErrorLogId],it.[ErrorLogDate],it.[ErrorLogDateMMS],it.[Message],it.[StackTrace],it.[InnerException],it.[Source],it.[Username],it.[PermissionControlName],it.[UserActionName]"
                    Where="((it.[Message] Like '%' + @SearchText + '%' Or it.[StackTrace] Like '%' + @SearchText + '%' Or it.[InnerException] Like '%' + @SearchText + '%' Or it.[Source] Like '%' + @SearchText + '%') And ((@ErrorLogDateFromMMS <> 0 And it.[ErrorLogDateMMS] >= @ErrorLogDateFromMMS) Or (@ErrorLogDateFromMMS = 0 And it.[ErrorLogDateMMS] > 0)) And ((@ErrorLogDateToMMS <> 0 And it.[ErrorLogDateMMS] <= @ErrorLogDateToMMS) Or (@ErrorLogDateToMMS = 0 And it.[ErrorLogDateMMS] <= 999999)) And ((@Username = 0 And it.[UserId] Is Not Null) Or (@Username > 0 And it.[UserId] = @Username)))"
                    OrderBy="it.[ErrorLogDate] DESC">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="txtSearchFor" Type="String" Name="SearchText" PropertyName="Text"
                            DefaultValue="%" />
                        <asp:Parameter Name="ErrorLogDateFromMMS" Type="Int32" />
                        <asp:Parameter Name="ErrorLogDateToMMS" Type="Int32" />
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
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogDate" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Message: " ClientIDMode="Static" ID="lblMessageText" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogMessage" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Stack Trace: " ClientIDMode="Static" ID="lblStackTrace" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogStackTrace" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Inner Exception: " ClientIDMode="Static" ID="lblInnerException"
                    runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogInnerException" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Source: " ClientIDMode="Static" ID="lblSource" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogSource" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Username: " ClientIDMode="Static" ID="lblUsername" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogUsername" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Control Name: " ClientIDMode="Static" ID="lblControlName" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogControlName" runat="server"></asp:Label>
            </div>
        </div>
        <div class="rows">
            <div class="lbl">
                <asp:Label Text="Action: " ClientIDMode="Static" ID="lblAction" runat="server"></asp:Label>
            </div>
            <div class="txt">
                <asp:Label Text="" ClientIDMode="Static" ID="lblErrorLogActionName" runat="server"></asp:Label>
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

            $("#txtErrorLogDateTo").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy'
            });

            $("#txtErrorLogDateFrom").datepicker({
                showButtonPanel: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd MM yy'
            });
            //$("#txtErrorLogDateFrom").datepicker("setDate", new Date());

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
