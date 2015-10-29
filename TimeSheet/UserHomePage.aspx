<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserHomePage.aspx.cs" Inherits="TimeSheet.UserHomePage"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home Page</title>
    <style type="text/css">
        #GSCCModal{
    height: 400px;
    top: calc(50% - 200px) !important;
}
         .well {
    height: calc(100vh - 145px);
}
    </style>
 <script src="Scripts/Timer.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="col-md-3">

        <div class="well container-fluid">
            <table align="center" width="50%">
                <tr>
                    <td align="center">

                        <asp:LinkButton ID="lbtQuickPrevDay" runat="server" CssClass="btn btn-info btn-xs" CausesValidation="false" OnClick="lbtQuickPrevDay_Click">
                  <span aria-hidden="true" class="glyphicon glyphicon-chevron-left" ></span>
                        </asp:LinkButton></td>
                    <td align="center"><b>Qiuck View</b></td>
                    <td align="center">
                        <asp:LinkButton ID="lbtQuickNextDay" runat="server" CssClass="btn btn-info btn-xs" CausesValidation="false" OnClick="lbtQuickNextDay_Click">
                  <span aria-hidden="true" class="glyphicon glyphicon-chevron-right"></span>
                        </asp:LinkButton></td>
                </tr>
            </table>
            <br />
            <asp:Calendar ID="calMonthView" runat="server" BackColor="White"
                BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px" Style="margin: auto" OnSelectionChanged="calMonthView_SelectionChanged">
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
        <asp:Panel runat="server" ID="messageDiv">
            <asp:ValidationSummary ID="valSummary" runat="server" class="alert alert-dismissible alert-danger" ValidationGroup="addForm" />
            <asp:Label ID="lbMessage" runat="server" Text="" Visible="false"></asp:Label>
        </asp:Panel>

        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Add new Entries for
                    <asp:Label ID="lbAddFormDate" runat="server" Text="Label"></asp:Label>
                </h3>
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
                            <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-control input-sm" AutoPostBack="true" DataSourceID="odsGetAllProjectsFromJira" DataTextField="Name"
                                DataValueField="Id" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged" OnDataBound="ddlProject_DataBound" CausesValidation="false" ValidationGroup="addForm">
                            </asp:DropDownList>


                        </td>
                        <td>

                            <asp:DropDownList ID="ddlTask" runat="server" CssClass="form-control input-sm" ValidationGroup="addForm">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <table style="width: 90%">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbHours" runat="server" CssClass="form-control input-sm" Width="55px" ValidationGroup="addForm" ClientIDMode="Static"></asp:TextBox>
                                    </td>
                                    <td style="vertical-align: central">

                                        <div class="proj-div" data-toggle="modal" data-target="#GSCCModal">
                                            <span class="glyphicon glyphicon-time" style="cursor: pointer; font-size: 1.5em" id="InitialStartTimer" ></span>
                                        </div>

                                        <div id="GSCCModal" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">

                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-body">
                                                        <div id="time" align="center">
                                                           <h1> <span id="hours">00</span> :
                                                            <span id="minutes">00</span> :
                                                            <span id="seconds">00</span></h1>

                                                        </div>
                                                        <br /><br />
                                        <div id="controls" align="center">
                                      <button id="pause_resume" class="btn btn-default">Pause</button>
                                        <button id="reset" class="btn btn-default">Reset</button>
                                             <button id="saveTime" class="btn btn-default" type="button">Submit</button>
                                         </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>



                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <asp:TextBox ID="tbComments" runat="server" CssClass="form-control input-sm" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Button ID="btAddNewEntry" runat="server" Text="Add Entry" class="btn btn-primary btn-sm" ValidationGroup="addForm" OnClick="btAddNewEntry_Click" />
                        </td>
                    </tr>

                </table>

            </div>
        </div>
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">Time Sheet Entries for
                    <asp:Label ID="lbViewSummaryDate" runat="server" Text="Label"></asp:Label>
                </h3>
            </div>
            <div class="panel-body" style="padding-bottom: 5px">
                <asp:GridView ID="grvTimeEntriesForDay" runat="server" AutoGenerateColumns="False" EmptyDataText="No Timesheet entries for the day"
                    CssClass="table table-striped table-hover table-condensed" DataSourceID="odsTimeEntriesForDay" DataKeyNames="ID">
                    <Columns>
                        <asp:BoundField HeaderText="Project" DataField="PROJECT_NAME" InsertVisible="false" ReadOnly="true" />
                        <asp:BoundField HeaderText="Task" DataField="TASK_JIRA_ISSUE_PROXY_KEY" InsertVisible="false" ReadOnly="true" />
                        <asp:BoundField HeaderText="Hours" DataField="HOURS_PER_DAY" DataFormatString="{0:F2}" />
                        <asp:BoundField HeaderText="Comments" DataField="COMMENTS" />
                        <asp:CommandField ShowEditButton="True" ButtonType="Link" EditText="<i aria-hidden='true' class='glyphicon glyphicon-pencil'></i>"
                            CancelText="<i aria-hidden='true' class='glyphicon glyphicon-remove-circle'></i>" UpdateText="<i aria-hidden='true' class='glyphicon glyphicon-ok'></i>" />
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Link" CausesValidation="false" DeleteText="<i aria-hidden='true' class='glyphicon glyphicon-remove'></i>" />
                        <asp:BoundField HeaderText="Id" DataField="ID" Visible="False" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="odsGetAllProjectsFromJira" runat="server" SelectMethod="GetProjects" TypeName="TimeSheet.APP_CODE.DAL.JiraAccessLayer"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTimeEntriesForDay" runat="server" SelectMethod="GetTimeSheetForEmpForDate" TypeName="TimeSheet.APP_CODE.DAL.DataAccessLayer" UpdateMethod="updateTimeSheet">
        <SelectParameters>
            <asp:SessionParameter Name="empId" SessionField="EmployeeId" Type="String" />
            <asp:ControlParameter ControlID="calMonthView" Name="date" PropertyName='SelectedDate' Type="DateTime" />
        </SelectParameters>


        <UpdateParameters>
            <asp:Parameter Name="ID" Type="String" />
            <asp:SessionParameter Name="empId" SessionField="EmployeeId" Type="String" />
            <asp:ControlParameter ControlID="calMonthView" Name="forDate" PropertyName='SelectedDate' Type="DateTime" />
            <asp:Parameter Name="HOURS_PER_DAY" Type="Single" />
            <asp:Parameter Name="COMMENTS" Type="String" />
        </UpdateParameters>


    </asp:ObjectDataSource>
    <asp:RequiredFieldValidator ID="rfvProject" runat="server" ErrorMessage="No Project Selected" ControlToValidate="ddlProject" InitialValue="--Select--" ForeColor="Red" Display="None" ValidationGroup="addForm"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="rfvTotalHours" runat="server" ErrorMessage="No. of Hours Not Entered" ControlToValidate="tbHours" ForeColor="Red" Display="None" ValidationGroup="addForm"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="regValTotalHours" runat="server" ErrorMessage="Invalid Number of Hours" ControlToValidate="tbHours" ForeColor="Red" Display="None" ValidationExpression="^\d*\.?\d*$" ValidationGroup="addForm"></asp:RegularExpressionValidator>
    <asp:RangeValidator ID="rangeValTotalHours" runat="server" ErrorMessage="Hours Should Be > 0 and < 24" ControlToValidate="tbHours" ForeColor="Red" MaximumValue="24" MinimumValue="0.0000001" Type="Double" Display="None" ValidationGroup="addForm"></asp:RangeValidator>
    <asp:RequiredFieldValidator ID="rfvTask" runat="server" ErrorMessage="No Task Selected" ControlToValidate="ddlTask" InitialValue="--Select--" Display="None" ValidationGroup="addForm"></asp:RequiredFieldValidator>
</asp:Content>

