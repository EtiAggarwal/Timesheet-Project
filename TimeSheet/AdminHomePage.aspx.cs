using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TimeSheet
{
    public partial class AdminHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btSubmit_Click(object sender, EventArgs e)
        {
            String startDate = tbStartDate.Text;
            String enddate = tbEndDate.Text;
            //String.IsNullOrEmpty(startDate)
            //{
            
            //}
            //String.IsNullOrEmpty(endDate)
            //{

            //}
        }

        protected void ddlProjects_DataBound(object sender, EventArgs e)
        {
            ddlProjects.Items.Insert(0, "--Select--");
        }
    }
}