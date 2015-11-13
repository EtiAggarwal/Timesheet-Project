using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeSheet.APP_CODE.DAL;
using TimeSheet.APP_CODE.Entities.Projects;

namespace TimeSheet
{
    public partial class AdminHomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeId"] == null)
            {
                Response.Redirect("Login.aspx");

            }

        }
        protected void btSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                DataAccessLayer DAL = new DataAccessLayer();
                ArrayList Employees = new ArrayList();
                ArrayList Projects = new ArrayList();
                String startDate = tbStartDate.Text;
                String enddate = tbEndDate.Text;
                foreach (ListItem item in lbEmployee.Items)
                {
                    if (item.Selected)
                    {
                        Employees.Add(item.Value);
                    }
                }
                foreach (ListItem item in lbProjects.Items)
                {
                    if (item.Selected)
                    {
                        Projects.Add(item.Value);
                    }
                }
                DataTable dt = DAL.GetReportData(startDate, enddate, Employees, Projects);
                string json = JsonConvert.SerializeObject(dt, Formatting.Indented);
            }
            catch
            {
                throw;
            }
        }

        //protected void ddlProjects_DataBound(object sender, EventArgs e)
        //{
        //    ddlProjects.Items.Insert(0, "--Select--");
        //}       
    }
}