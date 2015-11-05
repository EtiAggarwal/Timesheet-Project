using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TimeSheet
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["FirstName"] != null)
            {
                lbUserName.Text = Session["FirstName"].ToString() +" " + Session["LastName"].ToString();
            }
            if (Session["isAdmin"] != null && (bool)Session["isAdmin"] == true)
            {
                SiteMapDataSource.SiteMapProvider = "AdminSiteMap";
            }
            else
            {
                SiteMapDataSource.SiteMapProvider = "UserSiteMap";
            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}