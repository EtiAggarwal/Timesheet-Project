<% @ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TimeSheet.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Timesheet Login</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <style>
        body{
    background-color: #525252;
}
.centered-form{
	margin-top: 60px;
}

.centered-form .panel{
	background: rgba(255, 255, 255, 0.8);
	box-shadow: rgba(0, 0, 0, 0.3) 20px 20px 20px;
}
     .page-header {
            margin: auto;
           
        }
        .header {
             background-image: url(Content/images/pattern_4.png);
             
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal" role="form">
       <div class="container-fluid header">
            <div class="page-header">
                <h1 id="navbar"><strong> Smart Data Strategies Timesheet</strong></h1>
            </div>
        </div>
        <div class="container">
            <div id="loginbox" style="margin-top: 80px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <div class="panel-title">Sign In</div>
                        <div style="float: right; font-size: 80%; position: relative; top: -10px"><a href="#">Forgot password?</a></div>
                    </div>

                    <div style="padding-top: 30px" class="panel-body">

                        <div style="display: none" id="login-alert" class="alert alert-danger col-sm-12"></div>

                   
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <asp:TextBox ID="tbLoginUserName" runat="server" CssClass="form-control"  placeholder="username"></asp:TextBox>
        
                            </div>

                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <asp:TextBox ID="tbLoginPassword" runat="server" CssClass="form-control"  placeholder="password" TextMode="Password"></asp:TextBox>

                            </div>



                            <div class="input-group">
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="chbRememberMe" runat="server" />
                                         Remember me
                                    </label>
                                </div>
                            </div>


                            <div style="margin-top: 10px" class="form-group">
                                <!-- Button -->

                                <div class="col-sm-12 controls">
                                    <asp:Button ID="btLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-sm" />
                                 </div>
                            </div>


                            <div class="form-group">
                                <div class="col-md-12 control">
                                    <div style="border-top: 1px solid#888; padding-top: 15px; font-size: 85%">
                                        Don't have an account! 
                                        <a href="#" onclick="$('#loginbox').hide(); $('#signupbox').show()">Sign Up Here
                                        </a>
                                    </div>
                                </div>
                            </div>
                      



                    </div>
                </div>
            </div>
            <div id="signupbox" style="display: none; margin-top: 50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <div class="panel-title">Sign Up</div>
                        <div style="float: right; font-size: 85%; position: relative; top: -10px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
                    </div>
                    <div class="panel-body">
                      
                             <div id="signupalert" style="display: none" class="alert alert-danger">
                                <p>Error:</p>
                                <span></span>
                            </div>



                            <div class="form-group">
                                <label for="empid" class="col-md-3 control-label">Employee ID</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="tbEmployeeId" runat="server" placeholder="Employee ID" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="firstname" class="col-md-3 control-label">First Name</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="tbFirstName" runat="server" placeholder="First Name" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="lastname" class="col-md-3 control-label">Last Name</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="tbLastName" runat="server" placeholder="Last Name" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-md-3 control-label">Password</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="tbPassword" runat="server" placeholder="Password" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                         <div class="form-group">
                                <label for="confirmPassword" class="col-md-3 control-label">Confirm Password</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="tbConfPassword" runat="server" placeholder="Confirm Password" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email" class="col-md-3 control-label">Email</label>
                                <div class="col-md-9">
                                    <asp:TextBox ID="tbEmailId" runat="server" placeholder="Email" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group">
                                <!-- Button -->
                                <div class="col-md-offset-3 col-md-9">
                                    <asp:Button ID="btSignUp" runat="server" Text="Sign Up" CssClass="btn btn-primary btn-sm" OnClick="btSignUp_Click" />
                                </div>
                            </div>

                        
                    </div>
                </div>




            </div>
        </div>

    </form>
</body>
</html>
