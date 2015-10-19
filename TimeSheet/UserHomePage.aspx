<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserHomePage.aspx.cs" Inherits="TimeSheet.UserHomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home Page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-md-3">

        <div class="well container-fluid">
            <table align="center">
                <tr>
                    <td>

                        <asp:LinkButton ID="lbtQuickPrevDay" runat="server" CssClass="btn btn-primary btn-xs">
                  <span aria-hidden="true" class="glyphicon glyphicon-chevron-left"></span>
                        </asp:LinkButton></td>
                    <td>Qiuck View</td>
                    <td>
                        <asp:LinkButton ID="lbtQuickNextDay" runat="server" CssClass="btn btn-primary btn-xs">
                  <span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span>
                        </asp:LinkButton></td>
                </tr>
            </table>
            <br />
            <asp:Calendar ID="calMonthView" runat="server" BackColor="White"
                BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px" Style="margin: auto">
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#808080" />
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" />
                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                <WeekendDayStyle BackColor="#FFFFCC" />
            </asp:Calendar>
            <br />
            <br />
        </div>

    </div>
    <div class="col-md-9">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Add new Entries for &ltdate&gt</h3>
            </div>
            <div class="panel-body" style="padding-bottom: 5px">

                <table class="table table-striped table-condensed">
                    <tr>
                        <th>Project*</th>
                        <th>Task*</th>
                        <th>Hours*</th>
                        <th>Comments</th>

                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control input-sm" AutoPostBack="True" DataSourceID="odsGetAllProjectsFromJira" DataTextField="Name" DataValueField="Id" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged" />


                        </td>
                        <td>

                            <%--<div class="span4 proj-div" data-toggle="modal" data-target="#GSCCModal">
                                <span aria-hidden="true" class="glyphicon glyphicon-chevron-left" />
                            </div>

                            <div id="GSCCModal" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">Select a Task</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p></p>
                                        </div>

                                    </div>
                                </div>

                            </div>--%>


                            <asp:DropDownList ID="ddlTask" runat="server" CssClass="form-control input-sm">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox ID="tbHours" runat="server" CssClass="form-control input-sm" Width="40px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control input-sm" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Button ID="btAddNewEntry" runat="server" Text="Add Entry" class="btn btn-primary btn-sm" OnClick="btAddNewEntry_Click" />
                        </td>
                    </tr>

                </table>

            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">Time Sheet Entries for &ltdate&gt</h3>
            </div>
            <div class="panel-body" style="padding-bottom: 5px">
                <asp:GridView ID="grvTimeEntriesForDay" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-striped table-hover table-condensed" DataSourceID="odsTimeEntriesForDay" AllowPaging="True" PageSize="5" DataKeyNames="ID">
                    <Columns>
                        <asp:BoundField HeaderText="Project" DataField="PROJECT_NAME" InsertVisible="false" ReadOnly="true"/>
                        <asp:BoundField HeaderText="Task" DataField="TASK_JIRA_ISSUE_PROXY_KEY"  InsertVisible="false" ReadOnly="true"/>
                        <asp:BoundField HeaderText="Hours" DataField="HOURS_PER_DAY"  />
                        <asp:BoundField DataField="COMMENTS" HeaderText="Comments" />
                        <asp:CommandField ShowEditButton="True" ButtonType="Link" EditText="<i aria-hidden='true' class='glyphicon glyphicon-pencil'></i>"
                            CancelText="<i aria-hidden='true' class='glyphicon glyphicon-remove-circle'></i>" UpdateText="<i aria-hidden='true' class='glyphicon glyphicon-ok'></i>" />
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Link" DeleteText="<i aria-hidden='true' class='glyphicon glyphicon-remove'></i>" />
                        <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="odsGetAllProjectsFromJira" runat="server" SelectMethod="GetProjects" TypeName="TimeSheet.APP_CODE.DAL.JiraAccessLayer"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTimeEntriesForDay" runat="server" SelectMethod="GetTimeSheetForEmp" TypeName="TimeSheet.APP_CODE.DAL.DataAccessLayer">
        <SelectParameters>
            <asp:SessionParameter Name="empId" SessionField="EmployeeId" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

