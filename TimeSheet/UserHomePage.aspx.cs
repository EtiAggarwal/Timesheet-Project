using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TimeSheet
{
    public partial class UserHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btAddNewEntry_Click(object sender, EventArgs e)
        {

            odsTimeEntriesForDay.InsertParameters[0].DefaultValue = ddlProject.SelectedItem.Value;
            odsTimeEntriesForDay.InsertParameters[1].DefaultValue = ddlTask.SelectedItem.Value;
            odsTimeEntriesForDay.InsertParameters[2].DefaultValue = tbStart.Text;
            odsTimeEntriesForDay.InsertParameters[3].DefaultValue = tbEnd.Text;
            odsTimeEntriesForDay.Insert();
            grvTimeEntriesForDay.DataBind();
        }
    }
}