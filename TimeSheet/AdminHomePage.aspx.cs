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
        //When user clicks search, pull selected dates, project, and employee
        //from SQL and pass data to the graph via json object
        protected void btSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                DataAccessLayer DAL = new DataAccessLayer();
                List<string> Employees = new List<string>();
                List<string> Projects = new List<string>();
                String startDate = tbStartDate.Text;
                String enddate = tbEndDate.Text;

                foreach (ListItem item in lbEmployee.Items)
                {
                    if (item.Selected)
                    {
                        Employees.Add(item.Value.ToString());
                    }
                }
                foreach (ListItem item in lbProjects.Items)
                {
                    if (item.Selected)
                    {
                        Projects.Add(item.Value.ToString());
                    }
                }
                DataTable dt = DAL.GetReportData(startDate, enddate, Projects, Employees);
                string json = JsonConvert.SerializeObject(dt, Formatting.Indented);
               
                hdnData.Value = json;
                
            }
            catch
            {
                throw;
            }
        }      
    }
}