///
/// Project : Time tracking system
/// Created On : 10.5.2015
///
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DataAccessLayers
/// </summary>

namespace TimeSheet.APP_CODE.DAL
{
    public class DataAccessLayer
    {
        SqlConnection con;
        String conString;

        public DataAccessLayer()
        {
            conString = ConfigurationManager.ConnectionStrings["SqlServerConString"].ToString();
            con = new SqlConnection(conString);
          
        }

        public DataTable GetTimeSheetForEmp(String empId)
        {
            SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_GET_TIMESHEET_FOR_EMP, con);
            selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
            SqlDataAdapter sqlAdapter = new SqlDataAdapter(selectCommand);
            DataTable dt = new DataTable();
            sqlAdapter.Fill(dt);
            return dt;
        }

        public void addTimeSheet(int projectId, String projectName, String task_jira_proxy_key, float hrsPerDay, String comments)
        {
           


        }
    }
}