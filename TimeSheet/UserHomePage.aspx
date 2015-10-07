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
                            <th>Project</th>
                            <th>Task</th>
                            <th>Start Time</th>
                            <th>End Time</th>

                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control input-sm">
                                    <asp:ListItem Value="P1">P1</asp:ListItem>
                                    <asp:ListItem Value="P2">P2</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTask" runat="server" CssClass="form-control input-sm">
                                    <asp:ListItem Value="T1">T1</asp:ListItem>
                                    <asp:ListItem Value="T2">T2</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:TextBox ID="tbStart" runat="server" CssClass="form-control input-sm" Width="53px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="tbEnd" runat="server" CssClass="form-control input-sm" Width="53px"></asp:TextBox>
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
                        CssClass="table table-striped table-hover table-condensed" DataSourceID="odsTimeEntriesForDay" AllowPaging="True" PageSize="5">
                        <Columns>
                            <asp:BoundField HeaderText="Project" DataField="ProjectId" />
                            <asp:BoundField HeaderText="Task" DataField="TaskId" />
                            <asp:BoundField HeaderText="Start Time" DataField="StartTime" />
                            <asp:BoundField HeaderText="End Time" DataField="EndTime" />
                            <asp:CommandField ShowEditButton="True" ButtonType="Link" EditText="<i aria-hidden='true' class='glyphicon glyphicon-pencil'></i>"
                                CancelText="<i aria-hidden='true' class='glyphicon glyphicon-remove-circle'></i>" UpdateText="<i aria-hidden='true' class='glyphicon glyphicon-ok'></i>" />
                            <asp:CommandField ShowDeleteButton="True" ButtonType="Link" DeleteText="<i aria-hidden='true' class='glyphicon glyphicon-remove'></i>" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <asp:ObjectDataSource ID="odsTimeEntriesForDay" runat="server" SelectMethod="getAllTimeLog" TypeName="DataAccessLayer" InsertMethod="addTimeLog">
            <InsertParameters>
                <asp:Parameter Name="projectID" Type="String" />
                <asp:Parameter Name="taskId" Type="String" />
                <asp:Parameter Name="startTime" Type="String" />
                <asp:Parameter Name="endTime" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
</asp:Content>

