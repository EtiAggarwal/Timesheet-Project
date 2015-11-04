<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditAccountInfo.aspx.cs" Inherits="TimeSheet.EditAccountInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Edit Account Information</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btchangepwd").click(function () {
                $("#pwdchange").toggle();
                
            });
        });
       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <div class="panel panel-success" width ="60%">
        <div class="panel-heading">
            <h3 class="panel-title">Edit User Account</h3>
        </div>
        <div class="panel-body">

            <table align="center" width="30%">
                <tr>
                    <td>
                        <label for="firstname" >First Name</label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbFirstName" runat="server" placeholder="First Name" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>          
                <tr>
                    <td>           
                        <label for="lastname">Last Name</label>
                    </td>
                    <td>           
                        <asp:TextBox ID="tbLastName" runat="server" placeholder="Last Name" CssClass="form-control"></asp:TextBox>
                    </td>
                 </tr>                  
                    <tr>          
                        <td>   
                                <label for="email">Email</label>
                        </td>
                        <td>      
                                <asp:TextBox ID="tbEmailId" runat="server" placeholder="Email" CssClass="form-control"></asp:TextBox>
                        </td>
                        </tr> 
                    <tr>
                        <td>
                            <input id="btchangepwd" type="button" value="Change Password" />
                        </td>
                    </tr>
                </table>
            <div id ="pwdchange" style="display:none">
                <table align="center" width="30%">
                <tr>
                    <td>
                        <label for="Oldpwd" >Enter Current Password</label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox4" runat="server" placeholder="Current Password" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>          
                <tr>
                    <td>           
                        <label for="Newpwd">Enter New Password</label>
                    </td>
                    <td>           
                        <asp:TextBox ID="TextBox5" runat="server" placeholder="New Password" CssClass="form-control"></asp:TextBox>
                    </td>
                 </tr>                  
                    <tr>          
                        <td>   
                                <label for="Confirmpwd">Confirm New Password</label>
                        </td>
                        <td>      
                                <asp:TextBox ID="TextBox6" runat="server" placeholder="Confirm Password" CssClass="form-control"></asp:TextBox>
                        </td>
                        </tr>
                    </table>
            </div>                      
            </div>
        </div>
</asp:Content>
