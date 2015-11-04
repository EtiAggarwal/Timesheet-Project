using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
    }
}