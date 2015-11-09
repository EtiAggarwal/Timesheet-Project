using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeSheet.APP_CODE;
using TimeSheet.APP_CODE.AppSec;
using TimeSheet.APP_CODE.BO;
using TimeSheet.APP_CODE.DAL;

namespace TimeSheet
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check for cookies to provide remember me functionality
            if (!IsPostBack)
            {
                if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
                {
                    string userName = AppSecurity.Base64Decode(Request.Cookies["UserName"].Value.ToString());
                    tbLoginUserName.Text = userName;
                    string password = AppSecurity.Base64Decode(Request.Cookies["Password"].Value.ToString());
                    tbLoginPassword.Attributes["value"] = password;
                }
            }
        }



        /// <summary>
        /// calls add new user in data access layer
        /// </summary>
        protected void btSignUp_Click(object sender, EventArgs e)
        {
            try
            {
                String empId = tbEmployeeId.Text.Trim();
                String firstName = tbFirstName.Text.Trim();
                String lastName = tbLastName.Text.Trim();
                String emailId = tbEmailId.Text.Trim();
                String password = tbPassword.Text;

                DataAccessLayer dal = new DataAccessLayer();
                int? ret = dal.AddNewUser(empId, firstName, lastName, emailId, password);
                switch (ret)
                {
                    case -1:
                        {
                            loginbox.Style.Add("display", "none");
                            signupbox.Style.Add("display", "inline");
                            signupalert.Style.Add("display", "inline");
                            signupalert.Attributes.Add("class", "alert-danger");
                            signupalert.InnerText = "Account with this Employee ID already exists.";
                            break;
                        }
                    case 0:
                        {
                            loginbox.Style.Add("display", "none");
                            signupbox.Style.Add("display", "inline");
                            signupalert.Style.Add("display", "inline");
                            signupalert.Attributes.Add("class", "alert-danger");
                            signupalert.InnerText = "Some Error Occured. Try Again Later.";
                            break;
                        }
                    case 1:
                        {
                            signupbox.Style.Add("display", "none");
                            loginbox.Style.Add("display", "inline");
                            loginAlert.Style.Add("display", "inline");
                            loginAlert.Attributes.Add("class", "alert-success");
                            loginAlert.InnerText = "Account Created. Please Sign In to Continue.";
                            break;
                        }
                    
                }
                }
            catch
            {
                throw;
            }
        }

        protected void btLogin_Click(object sender, EventArgs e)
        {
            try
            {
                String empId = tbLoginUserName.Text.Trim();
                String password = tbLoginPassword.Text.Trim();
                DataAccessLayer dal = new DataAccessLayer();
                Employee emp = null;
                int ret = dal.ValidateUserLogin(empId, password, ref emp);

                if (ret == 1)
                {
                    loginAlert.Style.Add("display", "none");
                    if (chbRememberMe.Checked)
                    {
                        // Encode cookie for username
                        HttpCookie cookieUserName = new HttpCookie("UserName");
                        cookieUserName.Value = AppSecurity.Base64Encode(empId);
                        cookieUserName.Expires = DateTime.Now.AddDays(7);

                        //Encode cookie for password
                        HttpCookie cookiePassword = new HttpCookie("Password");
                        cookiePassword.Value = AppSecurity.Base64Encode(password);
                        cookiePassword.Expires = DateTime.Now.AddDays(7);

                        //Add cookies to response
                        Response.Cookies.Add(cookieUserName);
                        Response.Cookies.Add(cookiePassword);
                    }
                    else
                    {
                        Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);
                    }

                    if (emp != null)
                    {
                        Session["EmployeeId"] = empId;
                        Session["FirstName"] = emp.FirstName;
                        Session["LastName"] = emp.LastName;
                        Session["EMAIL"] = emp.Email;
                        Session["USER_GUID"] = emp.GUID;
                        if (emp.IsAdmin)
                        {
                            Session["isAdmin"] = true;
                            Response.Redirect("AdminHomePage.aspx");
                        }
                        else
                        {
                            Session["isAdmin"] = false;
                            Response.Redirect("UserHomePage.aspx");
                        }
                    }
                }
                else if (ret == -1)
                {
                    signupbox.Style.Add("display", "none");
                    loginbox.Style.Add("display", "inline");
                    loginAlert.Style.Add("display", "inline");
                    loginAlert.Attributes.Add("class", "alert-danger");
                    loginAlert.InnerText = "Incorrect Login Credentials";
                }
            }
            catch
            {
                throw;
            }
        }
    }
}