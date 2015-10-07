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
            
            if (Session["isAdmin"] != null && (bool)Session["isAdmin"] == true)
            {
                SiteMapDataSource.SiteMapProvider = "AdminSiteMap";
            }
            else
            {
                SiteMapDataSource.SiteMapProvider = "UserSiteMap";
            }
        }
    }
}