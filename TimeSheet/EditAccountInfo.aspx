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
            width: 50%;
        }

            .table td {
                border-top: none !important;
            }
    </style>
    <script type="text/javascript">
 $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "home";
            $('#Tabs a[href="#' + tabId + '"]').tab('show');
            $("#Tabs a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });

 });

        function reset_Alert() {
            
            $('#editAlert').hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="col-md-12">

        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">User Profile</h3>
            </div>
            <div class="panel-body" id="Tabs">
                   <div style="display: none" id="editAlert" class="alert alert-danger col-sm-12" runat="server" ClientIDMode="static"></div>

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#home" data-toggle="tab" onclick="reset_Alert()">Edit Account</a></li>
                    <li><a href="#profile" data-toggle="tab" onclick="reset_Alert()">Reset Passowrd</a></li>
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
                                    <asp:TextBox ID="tbFirstName" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                </td>

                                <td>
                                    <asp:RequiredFieldValidator ID="rfvFirtName" runat="server" ErrorMessage="First Name can't be blank" ControlToValidate="tbFirstName" ForeColor="Red" Font-Size="Small" ValidationGroup="Account"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="lastname">Last Name</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbLastName" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ErrorMessage="Last Name can't be blank" ControlToValidate="tbLastName" ForeColor="Red" Font-Size="Small" ValidationGroup="Account"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Email</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEmailId" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email can't be blank" ControlToValidate="tbEmailId" ForeColor="Red" Font-Size="Small" ValidationGroup="Account" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="regEmailFormat" runat="server" ErrorMessage="Invalid Email Id" ControlToValidate="tbEmailId" ForeColor="Red" Font-Size="Small" ValidationGroup="Account" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChangeProfPass" runat="server" CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvPasswordAcc" runat="server" ErrorMessage="Enter Password" ControlToValidate="tbChangeProfPass" ForeColor="Red" Font-Size="Small" ValidationGroup="Account"></asp:RequiredFieldValidator>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="email">Confirm Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChangeProfConfPass" runat="server" CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvConfPasswordAcc" runat="server" ErrorMessage="Confirm Password" ControlToValidate="tbChangeProfConfPass" ForeColor="Red" Font-Size="Small" ValidationGroup="Account" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="compValPassAcc" runat="server" ErrorMessage="Passwords Don't Match" ControlToValidate="tbChangeProfConfPass" ControlToCompare="tbChangeProfPass" ForeColor="Red" Font-Size="Small" Display="Dynamic" ValidationGroup="Account"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btChangeProfSave" runat="server" Text="Save" class="btn btn-primary btn-sm" ValidationGroup="Account" OnClick="btChangeProfSave_Click" />
                                    &nbsp; &nbsp;
                                    <asp:Button ID="btChangeProfCan" runat="server" Text="Reset" class="btn btn-primary btn-sm" CausesValidation="false" OnClick="btChangeProfCan_Click" />
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div class="tab-pane fade" id="profile">
                        <br />
                        <table class="table" id="pwdchange">
                            <tr>
                                <td>
                                    <label for="Oldpwd">Enter Current Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChPassCurr" runat="server" placeholder="Current Password" CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvCurrentPassRes" runat="server" ErrorMessage="Enter Password" ControlToValidate="tbChPassCurr" ForeColor="Red" Font-Size="Small" ValidationGroup="Pass"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="Newpwd">Enter New Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChPassNew" runat="server" placeholder="New Password" CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvNewPassRes" runat="server" ErrorMessage="Enter Password" ControlToValidate="tbChPassNew" ForeColor="Red" Font-Size="Small" ValidationGroup="Pass"></asp:RequiredFieldValidator>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label for="Confirmpwd">Confirm New Password</label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbChPassConf" runat="server" placeholder="Confirm Password" CssClass="form-control input-sm" TextMode="Password"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvConfPassRes" runat="server" ErrorMessage="Enter Password" ControlToValidate="tbChPassConf" ForeColor="Red" Font-Size="Small" ValidationGroup="Pass" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="compValPassRes" runat="server" ErrorMessage="Passwords Don't Match" ControlToValidate="tbChPassConf" ControlToCompare="tbChPassNew" ForeColor="Red" Font-Size="Small" Display="Dynamic" ValidationGroup="Pass"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btChPassSave" runat="server" Text="Save" class="btn btn-primary btn-sm" ValidationGroup="Pass" OnClick="btChPassSave_Click" />

                                </td>
                            </tr>
                        </table>
                    </div>

                </div>



            </div>

        </div>
        <asp:HiddenField ID="hfTab" runat="server" />
    </div>
</asp:Content>
