<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminHomePage.aspx.cs" Inherits="TimeSheet.AdminHomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin Home Page</title>
    <style>
        .panel-success {
            height: calc(100vh - 145px);
        }
        .panel-success .panel-body{
           padding-bottom: 15px;

        }
        .panel-success .panel-default{
             margin-bottom:10px;
        }
    </style>
    <link href="Content/datepicker.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/bootstrap-datepicker.js"></script>
    <script>
        $(document).ready(function () {
            $('.collapse').on('shown.bs.collapse', function () {
                $(this).parent().find(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
            }).on('hidden.bs.collapse', function () {
                $(this).parent().find(".glyphicon-chevron-up").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
            });
        });

        $(function () {
            var nowTemp = new Date();
            var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

            var checkin = $('#tbStartDate').datepicker().on('changeDate', function (ev) {
                if (ev.date.valueOf() > checkout.date.valueOf()) {
                    var newDate = new Date(ev.date)
                    newDate.setDate(newDate.getDate());
                    checkout.setValue(newDate);

                }
                checkin.hide();
                checkout.update();
                $('#tbEndDate')[0].focus();
            }).data('datepicker');
            var checkout = $('#tbEndDate').datepicker({
                onRender: function (date) {
                    if ($('#tbStartDate').val().length > 0)
                        return date.valueOf() < new Date($('#tbStartDate').val()) ? 'disabled' : '';
                    else
                        return '';
                }
            }).on('changeDate', function (ev) {
                checkout.hide();


            }).data('datepicker');

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-md-3">
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">Search Filters</h3>
            </div>
            <div class="panel-body">
                <div class="panel-group" id="accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <span class="glyphicon glyphicon-chevron-up" style="font-size: .8em"></span>
                                <a data-toggle="collapse" href="#collapseOne">Date Filter</a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table width="70%">
                                    <tr>
                                        <td><strong>Start Date</strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="tbStartDate" runat="server" ClientIDMode="Static" CssClass="form-control input-sm"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td><strong>End Date</strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="tbEndDate" runat="server" ClientIDMode="Static" CssClass="form-control input-sm"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>

                            </div>

                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <span class="glyphicon glyphicon-chevron-up" style="font-size: .8em"></span>
                                <a data-toggle="collapse" href="#collapseTwo">Project Filter</a>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table width="70%">
                                    <tr>
                                        <td><strong>Select a project</strong> </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%--<asp:DropDownList ID="ddlProjects" runat="server" CssClass="form-control input-sm" DataSourceID="obdsGetAllProjects" DataTextField="Name" DataValueField="Id" OnDataBound="ddlProjects_DataBound"></asp:DropDownList>--%>
                                            <asp:TextBox ID="tbProjects_search" runat="server" OnTextChanged="tbProjects_search_TextChanged" AutoPostBack="True"></asp:TextBox>
                                            <asp:ListBox ID="lbProjects" runat="server" CssClass="form-control input-sm" DataSourceID="obdsGetAllProjects" DataTextField="Name" DataValueField="Id"></asp:ListBox>
                                        
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <span class="glyphicon glyphicon-chevron-up" style="font-size: .8em"></span>
                                <a data-toggle="collapse" href="#collapseThree">Employee Filter</a>
                            </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <table width="70%">
                                    <tr>
                                        <td><strong>Select an employee</strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="ddlEmployees" runat="server" CssClass="form-control input-sm"></asp:DropDownList>

                                        </td>
                                    </tr>
                                </table>

                            </div>

                        </div>
                    </div>

                    <div align="center">
                        
                        <asp:Button ID="btSubmit" runat="server" Text="Search" OnClick="btSubmit_Click" class="btn btn-primary btn-sm" />
                    </div>
                </div>
                <asp:ObjectDataSource ID="obdsGetAllEmployees" runat="server" SelectMethod ="GetEmployees"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="obdsGetAllProjects" runat="server" SelectMethod="GetProjects" TypeName="TimeSheet.APP_CODE.DAL.JiraAccessLayer"></asp:ObjectDataSource>
            </div>
        </div>
    </div>

</asp:Content>
