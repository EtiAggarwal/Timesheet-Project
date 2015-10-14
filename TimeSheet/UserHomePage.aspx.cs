using System;
using System.Collections.Generic;
using TimeSheet.APP_CODE.DAL;
using TimeSheet.APP_CODE.Entities.Projects;
using TimeSheet.APP_CODE.JIRA;


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

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            JiraAccessLayer jal = new JiraAccessLayer();
            ddlTask.DataSource = jal.GetIssuesForProject(ddlProject.SelectedItem.Value);
            ddlTask.DataTextField = "ProxyKey";
            ddlTask.DataValueField = "ProxyKey";
            ddlTask.DataBind();
        }
    }
}