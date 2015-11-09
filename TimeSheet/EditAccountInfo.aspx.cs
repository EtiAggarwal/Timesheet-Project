using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeSheet.APP_CODE.AppSec;
using TimeSheet.APP_CODE.BO;
using TimeSheet.APP_CODE.DAL;

namespace TimeSheet
{
    public partial class EditAccountInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] == null)
            {
                Response.Redirect("Login.aspx");

            }
            if (!IsPostBack)
            {
                lbEmployeeId.Text = Session["EmployeeId"].ToString();
                tbFirstName.Text = Session["FirstName"].ToString();
                tbLastName.Text = Session["LastName"].ToString();
                tbEmailId.Text = Session["EMAIL"].ToString();
            }

        }


        protected void btChangeProfCan_Click(object sender, EventArgs e)
        {
            lbEmployeeId.Text = Session["EmployeeId"].ToString();
            tbFirstName.Text = Session["FirstName"].ToString();
            tbLastName.Text = Session["LastName"].ToString();
            tbEmailId.Text = Session["EMAIL"].ToString();
        }

        protected void btChPassSave_Click(object sender, EventArgs e)
        {
            hfTab.Value = "profile";
            string oldPass = tbChPassCurr.Text;
            string newPass = tbChPassNew.Text;
            string empId = Session["EmployeeId"].ToString();
            string oldHashedPassword = AppSecurity.HashSHA1(oldPass + Session["USER_GUID"].ToString());
            string newHashedPassword = AppSecurity.HashSHA1(newPass + Session["USER_GUID"].ToString());
            DataAccessLayer dal = new DataAccessLayer();
            int? ret = dal.UpdatePasswordUser(empId, oldHashedPassword, newHashedPassword);
            switch (ret)
            {

                case 1:
                    {
                        //show success message
                        editAlert.Style.Add("display", "inline");
                        editAlert.Attributes.Add("class", "alert-success");
                        editAlert.InnerText = "Password Reset Successfully";
                    }
                    break;
                case -1:
                    {
                        //invalid password
                        editAlert.Style.Add("display", "inline");
                        editAlert.Attributes.Add("class", "alert-danger");
                        editAlert.InnerText = "Incorrect Old Password";

                    }
                    break;
                case 0:
                    {
                        //invalid password
                        editAlert.Style.Add("display", "inline");
                        editAlert.Attributes.Add("class", "alert-danger");
                        editAlert.InnerText = "Database Error Occured. Information could not be saved.";

                    }
                    break;
            }
        }

        protected void btChangeProfSave_Click(object sender, EventArgs e)
        {

            hfTab.Value = "home";
            Employee emp = new Employee();
            emp.EmployeeId = Session["EmployeeId"].ToString();
            emp.FirstName = tbFirstName.Text;
            emp.LastName = tbLastName.Text;
            emp.Email = tbEmailId.Text;
            string pass = tbChangeProfPass.Text;
            string hashedPassword = AppSecurity.HashSHA1(pass + Session["USER_GUID"].ToString());
            DataAccessLayer dal = new DataAccessLayer();
            int? ret = dal.UpdateAccountInfo(emp, hashedPassword);
            switch (ret)
            {

                case 1:
                    {
                        // update session information
                        Session["FirstName"] = emp.FirstName;
                        Session["LastName"] = emp.LastName;
                        Session["EMAIL"] = emp.Email;
                        ((Label)Master.FindControl("lbUserName")).Text = emp.FirstName + " " + emp.LastName;
                        //show success message
                       
                        editAlert.Style.Add("display", "inline");
                        editAlert.Attributes.Add("class", "alert-success");
                        editAlert.InnerText = "Account Information Successfully Updated";
                    } break;
                case -1:
                    {
                        //invalid password
                        editAlert.Style.Add("display", "inline");
                        editAlert.Attributes.Add("class", "alert-danger");
                        editAlert.InnerText = "Incorrect Password";
                                                
                    }
                    break;
                case 0:
                    {
                        //invalid password
                        editAlert.Style.Add("display", "inline");
                        editAlert.Attributes.Add("class", "alert-danger");
                        editAlert.InnerText = "Database Error Occured. Information could not be saved.";

                    }
                    break;
            }
        }
    }
}