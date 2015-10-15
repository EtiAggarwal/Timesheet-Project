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
            Session["EmployeeId"] = "101";
            
        }

        protected void btAddNewEntry_Click(object sender, EventArgs e)
        {
            DataAccessLayer dal = new DataAccessLayer();
            dal.addTimeSheet(Convert.ToInt32(ddlProject.SelectedItem.Value), ddlProject.SelectedItem.Text, ddlTask.SelectedItem.Value,float.Parse(tbHours.Text), tbComments.Text);
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