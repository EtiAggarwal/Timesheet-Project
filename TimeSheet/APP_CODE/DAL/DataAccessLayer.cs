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
using TimeSheet.APP_CODE.

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

        public DataSet GetReportData(string startDate, string enddate, string project_name, string project_id, string employee)
        {
            throw new NotImplementedException();
        }

        public DataTable GetEmployee()
        {
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_GET_EMPLOYEE, con);
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

        public int? updateTimeSheet(String ID, String empId,DateTime forDate,float HOURS_PER_DAY, String COMMENTS)
        {
            int? ret = null;
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_UPDATE_TIMESHEET_ENTRY, con);
                selectCommand.Parameters.AddWithValue("@ID", ID);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                selectCommand.Parameters.AddWithValue("@TIMESHEET_DATE", forDate.Date.ToString("MM/dd/yyyy"));
                selectCommand.Parameters.AddWithValue("@HOURS_PER_DAY",HOURS_PER_DAY);
                selectCommand.Parameters.AddWithValue("@COMMENTS", COMMENTS);
           
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

        public int? DeleteTimeSheetRecord(String ID)
        {
            int? ret = null;
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_DELETE_TIMESHEET_RECORD, con);
                selectCommand.Parameters.AddWithValue("@ROW_ID", ID);
                con.Open();
                ret = selectCommand.ExecuteNonQuery();
                con.Close();
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
        /// <summary>
        /// Add New User to Database
        /// </summary>
       public int? AddNewUser(String empId, String firstName, String lastName, String email, String userName, String password)
        {
            int? ret = null;
            try
            {

                // First create a new Guid for the user. This will be unique for each user
                Guid userGuid = System.Guid.NewGuid();

                // Hash the password together with our unique userGuid
                //string hashedPassword = AppSecurity.HashSHA1(password + userGuid.ToString());

                //SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_INSERT_TIMESHEET_ENTRY, con);
                //selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                //selectCommand.Parameters.AddWithValue("@PROJECT_ID", projectId);
                //selectCommand.Parameters.AddWithValue("@PROJECT_NAME", projectName);
                //selectCommand.Parameters.AddWithValue("@TASK_JIRA_ISSUE_PROXY_KEY", task_jira_proxy_key);
                //selectCommand.Parameters.AddWithValue("@TIMESHEET_DATE", timesheetDate);
                //selectCommand.Parameters.AddWithValue("@HOURS_PER_DAY", hrsPerDay);
                //selectCommand.Parameters.AddWithValue("@COMMENTS", comments);
                //SqlParameter retParam = new SqlParameter();
                //retParam.ParameterName = "@RetVal";
                //retParam.Direction = ParameterDirection.ReturnValue;
                //retParam.SqlDbType = SqlDbType.Int;
                //selectCommand.Parameters.Add(retParam);
                //selectCommand.CommandType = CommandType.StoredProcedure;
                //con.Open();
                //selectCommand.ExecuteNonQuery();
                //con.Close();
                //ret = (int)retParam.Value;
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