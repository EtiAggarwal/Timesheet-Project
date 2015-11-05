<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditAccountInfo.aspx.cs" Inherits="TimeSheet.EditAccountInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Edit Account Information</title>
    <style>
        .panel-success {
            height: calc(100vh - 145px);
        }

            .panel-success .panel-body {
                padding: 20px;
            }

        .table {
            width: 40%;
            
        }

            .table td {
                border-top: none !important;
                
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="col-md-12">

        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">User Profile</h3>
            </div>
            <div class="panel-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab">Edit Account</a></li>
                    <li><a href="#profile" data-toggle="tab">Reset Passowrd</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade active in" id="home">
                        <br />
                        <table class="table">
                            <tr>
                                <td>
                                    <label for="Employee ID">Employee ID</label>
                                </td>
                                <td>
                                    <asp:Label ID="lbEmployeeId" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="firstname">First Name</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbFirstName" runat="server"  CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="lastname">Last Name</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbLastName" runat="server"  CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Email</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEmailId" runat="server"  CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChangeProfPass" runat="server"  CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Confirm Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChangeProfConfPass" runat="server" CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr><td colspan="2"></td></tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btChangeProfSave" runat="server" Text="Save" class="btn btn-primary btn-sm"/>
                                &nbsp; &nbsp;
                                    <asp:Button ID="btChangeProfCan" runat="server" Text="Reset" class="btn btn-primary btn-sm"/>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div class="tab-pane fade" id="profile">
                        <br />
                        <table class="table" id="pwdchange" >
                    <tr>
                        <td>
                            <label for="Oldpwd">Enter Current Password</label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbChPassCurr" runat="server" placeholder="Current Password" CssClass="form-control input-sm"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="Newpwd">Enter New Password</label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbChPassNew" runat="server" placeholder="New Password" CssClass="form-control input-sm"></asp:TextBox>
                        </td>
                    </tr>
                            
                    <tr>
                        <td>
                            <label for="Confirmpwd">Confirm New Password</label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbChPassConf" runat="server" placeholder="Confirm Password" CssClass="form-control input-sm"></asp:TextBox>
                        </td>
                    </tr>
                            <tr><td colspan="2"></td></tr>
                             <tr>
                                <td colspan="2">
                                    <asp:Button ID="btChPassSave" runat="server" Text="Save" class="btn btn-primary btn-sm"/>
                                &nbsp; &nbsp;
                                    <asp:Button ID="btChPassCan" runat="server" Text="Reset" class="btn btn-primary btn-sm"/>
                                </td>
                            </tr>
                </table>
                    </div>
                    
                </div>


                
            </div>

        </div>
    </div>
</asp:Content>
