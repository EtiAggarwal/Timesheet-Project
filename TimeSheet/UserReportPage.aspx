<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserReportPage.aspx.cs" Inherits="TimeSheet.UserReportPage" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <asp:Chart ID="Chart1" runat="server" DataSourceID="odsChart">

        <Series>
            <asp:Series Name="Series1" XValueMember="PROJECT_NAME" YValueMembers="HOURS"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
                <AxisY Title="Total Hours">
                </AxisY>
                <AxisX Title="Project">
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    <asp:ObjectDataSource ID="odsChart" runat="server" SelectMethod="GetReportDataForUser" TypeName="TimeSheet.APP_CODE.DAL.DataAccessLayer">
        <SelectParameters>
            <asp:SessionParameter Name="empId" SessionField="EmployeeId" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
