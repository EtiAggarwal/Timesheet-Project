<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminUserManagement.aspx.cs" Inherits="TimeSheet.AdminUserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-condensed > thead > tr > th, .table-condensed > tbody > tr > th, .table-condensed > tfoot > tr > th, .table-condensed > thead > tr > td, .table-condensed > tbody > tr > td, .table-condensed > tfoot > tr > td {
            padding: 1px;
        }

        #GSCCModal {
            top: calc(50% - 210px) !important;
        }

        .modal-body {
            overflow: auto;
            height: auto;
        }

        .table td {
            border-top: none !important;
        }

        .panel-success {
            height: calc(100vh - 145px);
            width: 98%;
            float: none;
            margin-left: auto;
            margin-right: auto;
        }

        .modal-align {
            height: calc(100vh - 450px);
        }

        .modal.modal-wide .modal-dialog {
            width: 55%;
        }

        .modal-wide .modal-body {
            overflow-y: auto;
        }

        .al-bt1 {
            height: calc(100vh - 555px);
        }

        .al-bt2 {
            height: calc(100vh - 565px);
        }
    </style>
   <script type="text/javascript">
       function openDetailsModal(empId, isAdmin) {
           
               $('#lbUserNameForEdit').text(empId);
               $("select[id$='ddlUserType'] option[value='"+isAdmin+"']").attr("selected", "selected");
               $('#GSCCModal').modal('show');
           
       }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="modal modal-wide" id="GSCCModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="font-size: small">x</button>
                    <h4 class="modal-title">Edit User Profile For :
                        <asp:Label ID="lbUserNameForEdit" runat="server" ClientIDMode="Static"></asp:Label></h4>
                </div>
                <div class="modal-body">

                    <div class="alert alert-success col-lg-6  modal-align" style="margin-left: -5px">
                        <table class="table">
                            <tr>
                                <td>
                                    <label for="email">User Type</label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control input-sm" ClientIDMode="Static">
                                        <asp:ListItem Text="Admin" Value="True"></asp:ListItem>
                                        <asp:ListItem Text="User" Value="False"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>

                            <tr class="al-bt1">
                                <td colspan="2" style="vertical-align: bottom; text-align: center">
                                    <asp:Button ID="btUpdateUserType" runat="server" Text="Update User Type" CssClass="btn btn-primary btn-sm" ValidationGroup="UpdateUserType" />

                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="alert alert-success col-lg-6 pull-right modal-align" style="margin-right: -5px">
                        <table class="table">
                            <tr>
                                <td>New Password
                                </td>
                                <td>
                                    <asp:TextBox ID="tbResetPassNew" runat="server" TextMode="Password" CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Confirm Password
                                </td>
                                <td>
                                    <asp:TextBox ID="tbResetPassConf" runat="server" TextMode="Password" CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                            </tr>

                            <tr class="al-bt2">
                                <td colspan="2" style="vertical-align: bottom; text-align: center">
                                    <asp:Button ID="btResetPass" runat="server" Text="Reset Password" CssClass="btn btn-primary btn-sm" ValidationGroup="ResetPass" />
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-heading">
            <h3 class="panel-title">Manage Users</h3>
        </div>
        <div class="panel-body">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table style="width: 25%;">
                        <tr>
                            <td><strong>
                                <h6>Search User :</h6>
                            </strong></td>
                            <td>
                                <asp:TextBox ID="tbEmpId" runat="server" placeholder="Employee ID" CssClass="form-control input-sm"></asp:TextBox>
                            </td>
                            <td align="center">
                                <asp:Button ID="btSearch" runat="server" Text="Search" OnClick="btSearch_Click" CssClass="btn btn-primary btn-sm" />
                            </td>
                        </tr>
                    </table>

                    <asp:GridView ID="grvUsers" runat="server" DataSourceID="odsUsers" CssClass="table table-hover table-condensed"
                        AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="EMPLOYEE_ID" OnRowCommand="grvUsers_RowCommand">
                        <HeaderStyle BackColor="Gainsboro" />
                        <Columns>
                            <asp:BoundField DataField="EMPLOYEE_ID" HeaderText="Employee ID" />
                            <asp:BoundField DataField="FIRST_NAME" HeaderText="FIRST NAME" />
                            <asp:BoundField DataField="LAST_NAME" HeaderText="LAST NAME" />
                            <asp:BoundField DataField="EMAIL_ID" HeaderText="EMAIL" />
                            <asp:TemplateField HeaderText="ROLE">
                                <ItemTemplate><%# (Boolean.Parse(Eval("IS_ADMIN").ToString())) ? "Admin" : "User" %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="false" CommandName="Delete" CommandArgument='<%# Eval("EMPLOYEE_ID").ToString() %>' OnClientClick="return confirm('Are you sure?')"><i aria-hidden='true' class='glyphicon glyphicon-trash'></i></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <a href="#" onclick='openDetailsModal("<%# Eval("EMPLOYEE_ID").ToString()%>","<%# Eval("IS_ADMIN").ToString()%>")'><i aria-hidden='true' class='glyphicon glyphicon-cog'></i></a>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>


    <asp:ObjectDataSource ID="odsUsers" runat="server" SelectMethod="GetAllUsers" TypeName="TimeSheet.APP_CODE.DAL.DataAccessLayer" DeleteMethod="DeleteUserAccountByAdmin">
        <DeleteParameters>
            <asp:Parameter Name="EmployeeId" Type="String" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
