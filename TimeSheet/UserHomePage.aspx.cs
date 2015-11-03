using System;
using System.Collections.Generic;
using TimeSheet.APP_CODE.DAL;
using TimeSheet.APP_CODE.Entities.Issues;
using TimeSheet.APP_CODE.Entities.Projects;
using TimeSheet.APP_CODE.JIRA;


namespace TimeSheet
{
    public partial class UserHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] == null)
            {
                Response.Redirect("Login.aspx");

            }
           
            if (!Page.IsPostBack)
            {
                calMonthView.SelectedDate = DateTime.Now.Date;
                lbAddFormDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
                lbViewSummaryDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
                ddlTask.Enabled = false;
                
            }
            
        }

        protected void btAddNewEntry_Click(object sender, EventArgs e)
        {
            messageDiv.CssClass = "alert alert-dismissible alert-danger";
            DataAccessLayer dal = new DataAccessLayer();
            int? ret = dal.addTimeSheet(Session["EmployeeId"].ToString(),Convert.ToInt32(ddlProject.SelectedItem.Value), ddlProject.SelectedItem.Text, ddlTask.SelectedItem.Value,calMonthView.SelectedDate.ToString("MM/dd/yyyy"),float.Parse(tbHours.Text), tbComments.Text);
            switch (ret)
            {
                case -2:
                    {
                        messageDiv.CssClass = "alert alert-dismissible alert-danger";
                        messageDiv.Visible = true;
                        lbMessage.Text = "Already submitted 24 hours for this date";
                        lbMessage.Visible = true;
                        break;
                    }
                case -1:
                    {
                        messageDiv.CssClass = "alert alert-dismissible alert-danger";
                        lbMessage.Text = "Cannot submit "+tbHours.Text +". Total hours getting > 24";
                        messageDiv.Visible = true;
                        lbMessage.Visible = true;
                        break;
                    }
                case 0:
                    {
                        messageDiv.CssClass = "alert alert-dismissible alert-danger";
                        lbMessage.Text = "Some Error Occured. Could not save data in database";
                        messageDiv.Visible = true;
                        lbMessage.Visible = true;
                        break;
                    }
                case 1:
                    {
                        messageDiv.CssClass = "alert alert-dismissible alert-success";
                        lbMessage.Text = "Timesheet Entry submitted successfully";
                        grvTimeEntriesForDay.DataBind(); 
                        messageDiv.Visible = true;
                        lbMessage.Visible = true;
                        break;
                    }
                    
            }
                
          
        }

        protected void ddlProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlProject.SelectedItem.Value != "--Select--")
                {
                    JiraAccessLayer jal = new JiraAccessLayer();
                    List<Issue> issuesForProject = jal.GetIssuesForProject(ddlProject.SelectedItem.Value);
                    if (issuesForProject.Count > 0)
                    {
                        ddlTask.DataTextField = "ProxyKey";
                        ddlTask.DataValueField = "ProxyKey";
                        ddlTask.DataSource = issuesForProject;
                        ddlTask.DataBind();
                        ddlTask.Items.Insert(0, "--Select--");
                        ddlTask.SelectedIndex = 0;
                        ddlTask.Enabled = true;
                        
                    }
                    else
                    {
                        // in case no issues write code here to handle it
                        ddlTask.Enabled = true;
                        ddlTask.Items.Clear();
                         ddlTask.Items.Insert(0, "--Select--");
                        ddlTask.SelectedIndex = 0;
                    }

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

        protected void calMonthView_SelectionChanged(object sender, EventArgs e)
        {
            //on change of date on calendar clear the selected values in dropdowns
            ddlProject.SelectedIndex = 0;
            ddlTask.Items.Clear();
            ddlTask.Enabled = false;
            messageDiv.Visible = false;
            lbMessage.Visible = false;
            lbAddFormDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
            lbViewSummaryDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
            tbHours.Text = "";
            tbComments.Text = "";
        }

        protected void lbtQuickPrevDay_Click(object sender, EventArgs e)
        {
            //on quick view prev day move to the prev day and clear selected values
            calMonthView.SelectedDate = calMonthView.SelectedDate.Date.AddDays(-1);
            ddlProject.SelectedIndex = 0;
            ddlTask.Items.Clear();
            ddlTask.Enabled = false;
            messageDiv.Visible = false;
            lbMessage.Visible = false;
            lbAddFormDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
            lbViewSummaryDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
            tbHours.Text = "";
            tbComments.Text = "";
        }

        protected void lbtQuickNextDay_Click(object sender, EventArgs e)
        {
            //on quick view next day move to the next day and clear selected values
            calMonthView.SelectedDate = calMonthView.SelectedDate.Date.AddDays(1);
            ddlProject.SelectedIndex = 0;
            ddlTask.Items.Clear();
            ddlTask.Enabled = false;
            messageDiv.Visible = false;
            lbMessage.Visible = false;
            lbAddFormDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
            lbViewSummaryDate.Text = calMonthView.SelectedDate.ToString("MM/dd/yyyy");
            tbHours.Text = "";
            tbComments.Text = "";
        }

       
    }
}