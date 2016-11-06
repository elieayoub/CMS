<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="WebApplication1._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="x-ua-compatible" content="IE=8">
<meta http-equiv="content-type" content="text/html; charset=windows-1250">
    <title>ABC CMS Installation</title>
    <link href="Styles/Site.css" rel="Stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.10.1.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="Header">
    </div>
    <div style="width: 100%; height: auto; float: left;">
        <asp:Label Text="" runat="server" ID="lblError" CssClass="error" />
    </div>
    <div class="Step" id="Step1">
        <div class="Title">
            <h1>
                Step 1 - Specify database information</h1>
        </div>
        <div class="Content">
            <div>Please provide information about the project database that should be already created.</div>
            <div style="height:20px;"></div>
            <div>
                <label>
                    Database Server Name:</label>
                <asp:TextBox runat="server" ID="txtDatabaseServerName" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVDatabaseServerName" ControlToValidate="txtDatabaseServerName"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Database Name:</label>
                <asp:TextBox runat="server" ID="txtDatabaseName" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVDatabaseName" ControlToValidate="txtDatabaseName"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Database Owner Username:</label>
                <asp:TextBox runat="server" ID="txtDatabaseOwnerUsername" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVDatabaseOwnerUsername" ControlToValidate="txtDatabaseOwnerUsername"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Database Owner Password:</label>
                <asp:TextBox runat="server" ID="txtDatabaseOwnerPassword" ClientIDMode="Static" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ID="RVDatabaseOwnerPassword" ControlToValidate="txtDatabaseOwnerPassword"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
        </div>
        <div class="Buttons">
            <div>
                <input type="button" class="btnNext dxbButton_Office2010Blue" id="btnNext_Step1"
                    value="Next" onclick="if (ValidStep1()) { GoToStep2(); }" />
            </div>
        </div>
    </div>
    <div class="Step DisplayNone" id="Step2">
        <div class="Title">
            <h1>
                Step 2 - Specify CMS Administrator information</h1>
        </div>
        <div class="Content">
            <div>Please provide information for the Administrator that will have access to the backend.</div>
            <div style="height:20px;"></div>
            <div>
                <label>
                    Administrator Username:</label>
                <asp:TextBox runat="server" ID="txtAdministratorUsername" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVAdministratorUsername" ControlToValidate="txtAdministratorUsername"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Administrator Password:</label>
                <asp:TextBox runat="server" ID="txtAdministratorPassword" ClientIDMode="Static" TextMode="Password" />
                <asp:RequiredFieldValidator runat="server" ID="RVAdministratorPassword" ControlToValidate="txtAdministratorPassword"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Administrator Role name:</label>
                <asp:TextBox runat="server" ID="txtAdministratorRoleName" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVAdministratorRoleName" ControlToValidate="txtAdministratorRoleName"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Administrator Firstname:</label>
                <asp:TextBox runat="server" ID="txtAdministratorFirstname" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVAdministratorFirstname" ControlToValidate="txtAdministratorFirstname"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Administrator Lastname:</label>
                <asp:TextBox runat="server" ID="txtAdministratorLastname" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVAdministratorLastname" ControlToValidate="txtAdministratorLastname"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
            <div>
                <label>
                    Administrator Email:</label>
                <asp:TextBox runat="server" ID="txtAdministratorEmail" ClientIDMode="Static" />
                <asp:RequiredFieldValidator runat="server" ID="RVAdministratorEmail" ControlToValidate="txtAdministratorEmail"
                    ErrorMessage="Required" CssClass="validators" ClientIDMode="Static" />
            </div>
        </div>
        <div class="Buttons">
            <div>
                <input type="button" class="btnNext dxbButton_Office2010Blue" id="btnNext_Step2" onclick="if (ValidStep2()) { GoToStep3(); }"
                    value="Next" />
            </div>
            <div>
                <input type="button" class="btnPrevious dxbButton_Office2010Blue" id="btnPrevious_Step2"  onclick="BackToStep1()"
                    value="Previous" />
            </div>
        </div>
    </div>
    <div class="Step DisplayNone" id="Step3">
        <div class="Title">
            <h1>
                Step 3 - Download project</h1>
        </div>
        <div class="Content">
            <div>
                Click Finish to finalize and download the new project with CMS.
            </div>
            <div>
                <br />
                <asp:Label ID="lblMessage" runat="server" CssClass="message" />
                <br /><br />
                <asp:Label Id="lblDownloadProject" runat="server" />
            </div>
        </div>
        <div class="Buttons">
            <div>
                <asp:Button Text="Finish" class="btnNext dxbButton_Office2010Blue" ID="btnFinish"
                    runat="server" />
            </div>
            <div>
                <input type="button" class="btnPrevious dxbButton_Office2010Blue" id="btnPrevious_Step3"
                    value="Previous" onclick="BackToStep2()" />
            </div>
        </div>
    </div>
    <div id="Footer">
    </div>
    </form>
    <script type="text/javascript">
        $(function () {

            $(".btnNext").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $(".btnNext").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $(".btnNext").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $(".btnNext").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });

            $(".btnPrevious").hover(function () {
                $(this).addClass("dxbButtonHover_Office2010Blue");
            });
            $(".btnPrevious").mousedown(function () {
                $(this).addClass("dxbButtonPressed_Office2010Blue");
            });
            $(".btnPrevious").mouseup(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });
            $(".btnPrevious").mouseout(function () {
                $(this).removeClass("dxbButtonHover_Office2010Blue");
                $(this).removeClass("dxbButtonPressed_Office2010Blue");
            });

        });

        function ValidStep1() {
            var valid = true;

            if ($("#txtDatabaseOwnerPassword").val() == "") {
                valid = false;
                $("#RVDatabaseOwnerPassword").css("visibility", "visible");
                $("#txtDatabaseOwnerPassword").focus();
            }
            if ($("#txtDatabaseOwnerUsername").val() == "") {
                valid = false;
                $("#RVDatabaseOwnerUsername").css("visibility", "visible");
                $("#txtDatabaseOwnerUsername").focus();
            }
            if ($("#txtDatabaseName").val() == "") {
                valid = false;
                $("#RVDatabaseName").css("visibility", "visible");
                $("#txtDatabaseName").focus();
            }
            if ($("#txtDatabaseServerName").val() == "") {
                valid = false;
                $("#RVDatabaseServerName").css("visibility", "visible");
                $("#txtDatabaseServerName").focus();
            }
            return valid;
        }

        function ValidStep2() {
            var valid = true;

            if ($("#txtAdministratorEmail").val() == "") {
                valid = false;
                $("#RVAdministratorEmail").css("visibility", "visible");
                $("#txtAdministratorEmail").focus();
            }
            if ($("#txtAdministratorLastname").val() == "") {
                valid = false;
                $("#RVAdministratorLastname").css("visibility", "visible");
                $("#txtAdministratorLastname").focus();
            }
            if ($("#txtAdministratorFirstname").val() == "") {
                valid = false;
                $("#RVAdministratorFirstname").css("visibility", "visible");
                $("#txtAdministratorFirstname").focus();
            }
            if ($("#txtAdministratorRoleName").val() == "") {
                valid = false;
                $("#RVAdministratorRoleName").css("visibility", "visible");
                $("#txtAdministratorRoleName").focus();
            }
            if ($("#txtAdministratorPassword").val() == "") {
                valid = false;
                $("#RVAdministratorPassword").css("visibility", "visible");
                $("#txtAdministratorPassword").focus();
            }
            if ($("#txtAdministratorUsername").val() == "") {
                valid = false;
                $("#RVAdministratorUsername").css("visibility", "visible");
                $("#txtAdministratorUsername").focus();
            }
            return valid;
        }

        function GoToStep2() {
            $(".Step").addClass("DisplayNone");
            $("#Step2").removeClass("DisplayNone");
        }
        function BackToStep1() {
            $(".Step").addClass("DisplayNone");
            $("#Step1").removeClass("DisplayNone");
        }
        function GoToStep3() {
            $(".Step").addClass("DisplayNone");
            $("#Step3").removeClass("DisplayNone");
        }
        function BackToStep2() {
            $(".Step").addClass("DisplayNone");
            $("#Step2").removeClass("DisplayNone");
        }
    </script>
</body>
</html>
