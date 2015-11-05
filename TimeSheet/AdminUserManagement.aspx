<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminUserManagement.aspx.cs" Inherits="TimeSheet.AdminUserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-condensed > thead > tr > th, .table-condensed > tbody > tr > th, .table-condensed > tfoot > tr > th, .table-condensed > thead > tr > td, .table-condensed > tbody > tr > td, .table-condensed > tfoot > tr > td {
            padding: 1px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">Manage Users</h3>
        </div>
        <div class="panel-body">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table style="width:25%;">
                        <tr>
                            <td><strong><h6>Search User :</h6></strong></td>
                            <td>
                                <asp:TextBox ID="tbEmpId" runat="server" placeholder="Employee ID" CssClass="form-control input-sm"></asp:TextBox>
                            </td>
                            <td align="center">
                                <asp:Button ID="btSearch" runat="server" Text="Search" OnClick="btSearch_Click" CssClass="btn btn-primary btn-sm" />
                            </td>
                        </tr>
                    </table>
                    
                    <asp:GridView ID="grvUsers" runat="server" DataSourceID="odsUsers" CssClass="table table-hover table-condensed" AutoGenerateColumns="False" AllowPaging="True">
                        <HeaderStyle BackColor="Gainsboro" />
                        <Columns>
                            <asp:BoundField DataField="EMPLOYEE_ID" HeaderText="Employee ID" />
                            <asp:BoundField DataField="FIRST_NAME" HeaderText="FIRST NAME" />
                            <asp:BoundField DataField="LAST_NAME" HeaderText="LAST NAME" />
                            <asp:BoundField DataField="EMAIL_ID" HeaderText="EMAIL" />
                            <asp:TemplateField HeaderText="ROLE">
                                <ItemTemplate><%# (Boolean.Parse(Eval("IS_ADMIN").ToString())) ? "Admin" : "User" %></ItemTemplate>
                            </asp:TemplateField>
                          
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>


    <asp:ObjectDataSource ID="odsUsers" runat="server" SelectMethod="GetAllUsers" TypeName="TimeSheet.APP_CODE.DAL.DataAccessLayer"></asp:ObjectDataSource>
</asp:Content>
