using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeSheet.APP_CODE.DAL;

namespace TimeSheet
{
    public partial class AdminUserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            odsUsers.FilterExpression = null;
        }
        
        protected void btSearch_Click(object sender, EventArgs e)
        {
            String searchEmp = tbEmpId.Text;

            if (!String.IsNullOrEmpty(searchEmp))
            {
                odsUsers.FilterExpression = "EMPLOYEE_ID LIKE '" + tbEmpId.Text + "%'";
            }
            else
            {
                odsUsers.FilterExpression = null;
            }
        }

        protected void grvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string val = e.CommandArgument.ToString();
                odsUsers.DeleteParameters["EmployeeId"].DefaultValue= val;
                int ret = odsUsers.Delete();
            }
           
        }

        protected void btUpdateUserType_Click(object sender, EventArgs e)
        {
            string employeeIdUser = hdEmpUSerId.Value;
            string adminId = Session["EmployeeId"].ToString();
            bool isAdmin = bool.Parse(ddlUserType.SelectedItem.Value);
            string adminPass = tbAdminPassUsserType.Text;
            string adminGUID = Session["USER_GUID"].ToString();
            DataAccessLayer dal = new DataAccessLayer();
            int? ret = dal.UpdateUserTypeByAdmin(employeeIdUser, isAdmin, adminId, adminPass, adminGUID);

            switch (ret)
            {

                case 1:
                    {
                        //show success message
                        adminEditUserAlert.Style.Add("display", "inline");
                        adminEditUserAlert.Attributes.Add("class", "alert-success");
                        adminEditUserAlert.InnerText = "User Type updated for " + employeeIdUser;
                        grvUsers.DataBind();
                    }
                    break;
                case -1:
                    {
                        //invalid password
                        adminEditUserAlert.Style.Add("display", "inline");
                        adminEditUserAlert.Attributes.Add("class", "alert-danger");
                        adminEditUserAlert.InnerText = "Incorrect Admin Password";

                    }
                    break;
                case 0:
                    {
                        //invalid password
                        adminEditUserAlert.Style.Add("display", "inline");
                        adminEditUserAlert.Attributes.Add("class", "alert-danger");
                        adminEditUserAlert.InnerText = "Database Error Occured. Information could not be saved.";

                    }
                    break;
            }

        }

        protected void btResetPass_Click(object sender, EventArgs e)
        {
            string employeeIdUser = hdEmpUSerId.Value;
            string adminId = Session["EmployeeId"].ToString();
            string newUserPass = tbResetPassNew.Text;
            string adminPass = tbAdminPassReset.Text;
            string adminGUID = Session["USER_GUID"].ToString();
            DataAccessLayer dal = new DataAccessLayer();
            int? ret = dal.ResetUserPasswordByAdmin(employeeIdUser, newUserPass, adminId, adminPass, adminGUID);

            switch (ret)
            {

                case 1:
                    {
                        //show success message
                        adminEditUserAlert.Style.Add("display", "inline");
                        adminEditUserAlert.Attributes.Add("class", "alert-success");
                        adminEditUserAlert.InnerText = "Password Reset Successfully For "+employeeIdUser;
                    }
                    break;
                case -1:
                    {
                        //invalid password
                        adminEditUserAlert.Style.Add("display", "inline");
                        adminEditUserAlert.Attributes.Add("class", "alert-danger");
                        adminEditUserAlert.InnerText = "Incorrect Admin Password";

                    }
                    break;
                case 0:
                    {
                        //invalid password
                        adminEditUserAlert.Style.Add("display", "inline");
                        adminEditUserAlert.Attributes.Add("class", "alert-danger");
                        adminEditUserAlert.InnerText = "Database Error Occured. Information could not be saved.";

                    }
                    break;
            }
            }
    }
}