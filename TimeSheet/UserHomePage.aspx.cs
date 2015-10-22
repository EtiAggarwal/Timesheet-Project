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
            if (!Page.IsPostBack)
            {
                Session["EmployeeId"] = "101";
                calMonthView.SelectedDate = DateTime.Now.Date;
                lbAddFormDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
                lbViewSummaryDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
                ddlTask.Enabled = false;
            }
           
        }

        protected void btAddNewEntry_Click(object sender, EventArgs e)
        {
            DataAccessLayer dal = new DataAccessLayer();
            int? ret = dal.addTimeSheet(Session["EmployeeId"].ToString(),Convert.ToInt32(ddlProject.SelectedItem.Value), ddlProject.SelectedItem.Text, ddlTask.SelectedItem.Value,calMonthView.SelectedDate.ToString("MM/dd/yyyy"),float.Parse(tbHours.Text), tbComments.Text);
            grvTimeEntriesForDay.DataBind();
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlProject.SelectedItem.Value != "--Select--")
                {
                    JiraAccessLayer jal = new JiraAccessLayer();
                    ddlTask.DataSource = jal.GetIssuesForProject(ddlProject.SelectedItem.Value);
                    ddlTask.DataTextField = "ProxyKey";
                    ddlTask.DataValueField = "ProxyKey";
                    ddlTask.DataBind();
                    ddlTask.Enabled = true;
                }
                else
                {
                    ddlTask.Enabled = false;
                    ddlTask.Items.Clear();
                    ddlTask.DataSource = null;
                    ddlTask.DataBind();
                }
            }
            catch
            {
                throw;
            }
        }

        protected void ddlProject_DataBound(object sender, EventArgs e)
        {
            ddlProject.Items.Insert(0, "--Select--");
        }
    }
}