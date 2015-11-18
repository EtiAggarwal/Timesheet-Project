<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminHomePage.aspx.cs" Inherits="TimeSheet.AdminHomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--Admin Home Page--%>
    <title>Admin Home Page</title>
    <style>
        .panel-success {
            height: calc(100vh);
        }

            .panel-success .panel-body {
                padding-bottom: 15px;
            }

            .panel-success .panel-default {
                margin-bottom: 10px;
            }
          h1, .h1 {
    font-size: 36px;
}
    </style>
    <link href="Content/datepicker.css" rel="stylesheet" />
    <link href="Content/barchart.css" rel="stylesheet" />
    
    <script type="text/javascript" src="Scripts/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="Scripts/d3.min.js"></script>
    <script>
        $(document).ready(function () {
            //According function
            $('.collapse').on('shown.bs.collapse', function () {
                $(this).parent().find(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
            }).on('hidden.bs.collapse', function () {
                $(this).parent().find(".glyphicon-chevron-up").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
            });
            //Project search textbox
            $('#tbProjects_search').on('change', function (event) {
                selectByTextProj($.trim($('#tbProjects_search').val()));
            });
            //Project search filter
            function selectByTextProj(txt) {
                $('#lbProjects option')
                .filter(function () { return $.trim($(this).text()) == txt; })
                .attr('selected', true);
            }
            //Employee search textbox
            $('#tbEmployee_Search').on('change', function (event) {
                selectByTextEmp($.trim($('#tbEmployee_Search').val()));
            });
            //Employee search filter
            function selectByTextEmp(txt) {
                $('#lbEmployee option')
                .filter(function () { return $.trim($(this).text()) == txt; })
                .attr('selected', true);
            }

            $('#lbData').html($('#hdnData').val());
        });
        //Date picker function
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
        <asp:Label ID="lbData" runat="server" ClientIDMode="Static" ViewStateMode="Disabled"></asp:Label>
        <asp:HiddenField ID="hdnData" runat="server" ClientIDMode="Static"/>
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
                                <%--Table for datepicker--%>
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
                                <%--Table for Project select--%>
                                <table width="100%">
                                    <tr>
                                        <td><strong>Select a project</strong> </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <strong>
                                                            <h6>Search Project :</h6>
                                                        </strong>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="tbProjects_search" runat="server" CssClass="form-control input-sm" placeholder="Project Name" ClientIDMode="Static"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:ListBox ID="lbProjects" runat="server" ClientIDMode="Static" CssClass="form-control" DataSourceID="obdsGetAllProjects" DataTextField="Name" DataValueField="Id" SelectionMode="Multiple"></asp:ListBox>
                                                    </td>
                                                </tr>
                                            </table>
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
                                <%--Table for Emplyee select--%>
                                <table width="100%">
                                    <tr>
                                        <td><strong>Select an employee</strong></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <strong>
                                                            <h6>Search Employee :</h6>
                                                        </strong>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="tbEmployee_Search" runat="server" CssClass="form-control input-sm" placeholder="Employee Name" ClientIDMode="Static"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:ListBox ID="lbEmployee" runat="server" ClientIDMode="Static" CssClass="form-control" DataSourceID="obdsGetAllEmployees" DataTextField="FIRST_NAME" DataValueField="EMPLOYEE_ID" SelectionMode="Multiple"></asp:ListBox>
                                                    </td>
                                                </tr>
                                            </table>
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
                <asp:ObjectDataSource ID="obdsGetAllEmployees" runat="server" SelectMethod="GetAllUsers" TypeName="TimeSheet.APP_CODE.DAL.DataAccessLayer"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="obdsGetAllProjects" runat="server" SelectMethod="GetProjects" TypeName="TimeSheet.APP_CODE.DAL.JiraAccessLayer"></asp:ObjectDataSource>
            </div>
        </div>
    </div>
    <%--Graph section--%>
    <div class="col-md-9">
      
    <svg id="chart"></svg>
        <div id="ctooltip"></div>
        <script type="text/javascript" src="Scripts/barchart.js">

            
        </script>
        <div id="pichart"></div>
        <script type="text/javascript" src="Scripts/pichart.js"></script>
    </div>
</asp:Content>
