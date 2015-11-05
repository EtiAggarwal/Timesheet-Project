using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

        protected void btchangepwd_Click(object sender, EventArgs e)
        {

        }
    } 
}