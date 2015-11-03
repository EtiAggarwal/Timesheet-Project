using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeSheet.APP_CODE;
using TimeSheet.APP_CODE.BO;
using TimeSheet.APP_CODE.DAL;

namespace TimeSheet
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                    if (emp != null)
                    {
                        Session["EmployeeId"] = empId;
                        Session["EmployeeName"] = emp.FirstName +" "+ emp.LastName;

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