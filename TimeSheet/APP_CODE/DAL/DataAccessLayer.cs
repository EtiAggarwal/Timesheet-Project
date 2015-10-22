﻿///
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
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_GET_TIMESHEET_FOR_EMP, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                SqlDataAdapter sqlAdapter = new SqlDataAdapter(selectCommand);
                DataTable dt = new DataTable();
                sqlAdapter.Fill(dt);
                return dt;
            }
            catch
            {
                throw;
            }
        }

        public DataTable GetTimeSheetForEmpForDate(String empId, DateTime date)
        {
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_GET_TIMESHEET_FOR_EMP_FOR_DATE, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                selectCommand.Parameters.AddWithValue("@TDATE", date.ToString("MM/dd/yyyy"));
                SqlDataAdapter sqlAdapter = new SqlDataAdapter(selectCommand);
                DataTable dt = new DataTable();
                sqlAdapter.Fill(dt);
                return dt;
            }
            catch
            {
                throw;
            }
        }

        public int? addTimeSheet(String empId,int projectId, String projectName, String task_jira_proxy_key,String timesheetDate, float hrsPerDay, String comments)
        {
            int? ret = null;
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_INSERT_TIMESHEET_ENTRY, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                selectCommand.Parameters.AddWithValue("@PROJECT_ID", projectId);
                selectCommand.Parameters.AddWithValue("@PROJECT_NAME", projectName);
                selectCommand.Parameters.AddWithValue("@TASK_JIRA_ISSUE_PROXY_KEY", task_jira_proxy_key);
                selectCommand.Parameters.AddWithValue("@TIMESHEET_DATE", timesheetDate);
                selectCommand.Parameters.AddWithValue("@HOURS_PER_DAY", hrsPerDay);
                selectCommand.Parameters.AddWithValue("@COMMENTS", comments);
                SqlParameter retParam = new SqlParameter();
                retParam.ParameterName = "@RetVal";
                retParam.Direction = ParameterDirection.ReturnValue;
                retParam.SqlDbType = SqlDbType.Int;
                selectCommand.Parameters.Add(retParam);
                selectCommand.CommandType = CommandType.StoredProcedure;
                con.Open();
                selectCommand.ExecuteNonQuery();
                con.Close();
                ret = (int)retParam.Value;
                return ret;

            }
            catch
            {
                throw;
            }
            finally
            {
                con.Close();
            }

        }
    }
}