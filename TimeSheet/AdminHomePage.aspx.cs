using System;
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

                String startDate = tbStartDate.Text;
                String enddate = tbEndDate.Text;
                //String project_name = ddlProjects.SelectedItem.Text;
                //String project_id = ddlProjects.SelectedItem.Value;
                String employee = ddlEmployees.SelectedItem.Value;

                //DataSet ds = DAL.GetReportData(startDate, enddate, project_name, project_id, employee);
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

        protected void tbProjects_search_OnTextChanged(object sender, EventArgs e)
        {
           
            String searchproj = tbProjects_search.Text;

            if (!String.IsNullOrEmpty(searchproj))
            {
                ListItem lstItem = lbProjects.Items.FindByText(searchproj);
                if (lstItem != null)
                {
                    lstItem.Selected = true;
                    
                }
            }
           
        }

        //protected void ddlEmployees_DataBound(object sender, EventArgs e)
        //{
        //    ddlEmployees.Items.Insert(0, "--Select--");
        //}
    }
}