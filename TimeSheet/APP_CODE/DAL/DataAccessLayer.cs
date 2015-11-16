///
/// Project : Time tracking system
/// Created On : 10.5.2015
///
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using TimeSheet.APP_CODE.AppSec;
using TimeSheet.APP_CODE.BO;

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
       public int? AddNewUser(String empId, String firstName, String lastName, String email, String password)
        {
            int? ret = null;
            try
            {

                // First create a new Guid for the user. This will be unique for each user
                Guid userGuid = System.Guid.NewGuid();

                // Hash the password together with our unique userGuid
                string hashedPassword = AppSecurity.HashSHA1(password + userGuid.ToString());

                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_ADD_NEW_USER, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                selectCommand.Parameters.AddWithValue("@FIRST_NAME", firstName);
                selectCommand.Parameters.AddWithValue("@LAST_NAME", lastName);
                selectCommand.Parameters.AddWithValue("@EMAIL_ID", email);
                selectCommand.Parameters.AddWithValue("@PASS", hashedPassword);
                selectCommand.Parameters.AddWithValue("@USER_GUID", userGuid);
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


        public  int ValidateUserLogin(string empId, string password , ref Employee employee)
        {
            // this is the value we will return
            int ret = -1;

            using (SqlCommand cmd = new SqlCommand(SQL_STRINGS.SQL_VALIDATE_LOGIN, con))
            {
                cmd.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    // dr.Read() = we found user(s) with matching username!

                    string dbEmpId = Convert.ToString(dr["EMPLOYEE_ID"]);
                    string dbPassword = Convert.ToString(dr["PASS"]);
                    string dbUserGuid = Convert.ToString(dr["USER_GUID"]);
                    string dbFirstName = Convert.ToString(dr["FIRST_NAME"]);
                    string dbLastName = Convert.ToString(dr["LAST_NAME"]);
                    string dbEmail = Convert.ToString(dr["EMAIL_ID"]);
                    string guid = Convert.ToString(dr["USER_GUID"]);
                    int isAdmin = Convert.ToInt16(dr["IS_ADMIN"]);
                    // Now we hash the UserGuid from the database with the password we wan't to check
                    // In the same way as when we saved it to the database in the first place. (see AddUser() function)
                    string hashedPassword = AppSecurity.HashSHA1(password + dbUserGuid);

                    // if its correct password the result of the hash is the same as in the database
                    if (dbPassword == hashedPassword)
                    {
                        // The password is correct
                        employee = new Employee();
                        employee.EmployeeId = dbEmpId;
                        employee.FirstName = dbFirstName;
                        employee.LastName = dbLastName;
                        employee.Email = dbEmail;
                        employee.GUID = guid;
                        if (isAdmin == 0)
                        {
                            employee.IsAdmin = false;
                        }
                        else if (isAdmin == 1)
                        {
                            employee.IsAdmin = true;
                        }

                        ret = 1;
                    }
                }
                con.Close();
            }

            // Return the user id which is 0 if we did not found a user.
            return ret;
        }


        public DataTable GetAllUsers()
        {
             try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_GET_ALL_USERS, con);
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
        /// <summary>
        /// method to update user account info by user
        /// </summary>
        
        public int? UpdateAccountInfo(Employee emp,string pass)
        {
            int? ret = null;
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_UPDATE_ACCOUNT_INFO, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", emp.EmployeeId);
                selectCommand.Parameters.AddWithValue("@FIRST_NAME",emp.FirstName);
                selectCommand.Parameters.AddWithValue("@LAST_NAME",emp.LastName);
                selectCommand.Parameters.AddWithValue("@EMAIL_ID", emp.Email);
                selectCommand.Parameters.AddWithValue("@PASS", pass);

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

        /// <summary>
        /// method to update user password info by user
        /// </summary>

        public int? UpdatePasswordUser(string empId, string oldPass, string newPass)
        {
            int? ret = null;
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_RESET_PASS_USER, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", empId);
                selectCommand.Parameters.AddWithValue("@OLD_PASS", oldPass);
                selectCommand.Parameters.AddWithValue("@NEW_PASS", newPass);
               
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

        /// <summary>
        /// Delete user account
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>

        public int? DeleteUserAccountByAdmin(String EmployeeId)
        {
            int? ret = null;
            try
            {
                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SQL_DELETE_USER_ACC, con);
                selectCommand.Parameters.AddWithValue("@EMP_ID", EmployeeId);
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
        /// Reset user pass admin
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>

        public int? ResetUserPasswordByAdmin(String EmployeeId, String newUSerPass, String adminId, String adminPass, String adminGUID)
        {
            int? ret = null;
            try
            {
                // First create a new Guid for the user. This will be unique for each user
                Guid userGuid = System.Guid.NewGuid();

                // Hash the password together with our unique userGuid
                string userHashedPassword = AppSecurity.HashSHA1(newUSerPass + userGuid.ToString());
                string adminHashedPassword = AppSecurity.HashSHA1(adminPass + adminGUID);

                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_RESET_USER_PASS_ADMIN, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", EmployeeId);
                selectCommand.Parameters.AddWithValue("@ADMIN_ID", adminId);
                selectCommand.Parameters.AddWithValue("@NEW_USER_PASS", userHashedPassword);
                selectCommand.Parameters.AddWithValue("@NEW_USER_GUID", userGuid);
                selectCommand.Parameters.AddWithValue("@ADMIM_PASS", adminHashedPassword);

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

        /// <summary>
        /// Update User Type admin
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>

        public int? UpdateUserTypeByAdmin(String EmployeeId, bool isAdmin, String adminId, String adminPass, String adminGUID)
        {
            int? ret = null;
            try
            {

                string adminHashedPassword = AppSecurity.HashSHA1(adminPass + adminGUID);

                SqlCommand selectCommand = new SqlCommand(SQL_STRINGS.SP_UPDATE_USER_TYPE_ADMIN, con);
                selectCommand.Parameters.AddWithValue("@EMPLOYEE_ID", EmployeeId);
                selectCommand.Parameters.AddWithValue("@ADMIN_ID", adminId);
                selectCommand.Parameters.AddWithValue("@NEW_IS_ADMIN", isAdmin);
                selectCommand.Parameters.AddWithValue("@ADMIM_PASS", adminHashedPassword);

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


        /// <summary>
        /// Get Data For Report
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>

        public DataTable GetReportData(String startDate, String endDate, List<string> Projects, List<string> Employees)
        {
            
            try
            {
              
                StringBuilder SQL_GET_REPORT_DATA = new StringBuilder (SQL_STRINGS.SQL_GET_REPORT_DATA);

                SqlCommand selectCommand = new SqlCommand();
                // date filter selected
                if (!(String.IsNullOrEmpty(startDate) && String.IsNullOrEmpty(endDate)))
                {
                    SQL_GET_REPORT_DATA.Append(" WHERE ");
                    SQL_GET_REPORT_DATA.Append(SQL_STRINGS.SQL_GET_REPORT_DATA_DATE_FILTER);
                    selectCommand.Parameters.AddWithValue("@STARTDATE", startDate);
                    selectCommand.Parameters.AddWithValue("@ENDDATE", endDate);

                }
                //project filter selected
                if (Projects.Count > 0)
                {
                    if (!SQL_GET_REPORT_DATA.ToString().Contains("WHERE"))
                        SQL_GET_REPORT_DATA.Append(" WHERE ");
                    else
                        SQL_GET_REPORT_DATA.Append(" AND ");
                    SQL_GET_REPORT_DATA.Append(SQL_STRINGS.SQL_GET_REPORT_DATA_PROJECT_FILTER);
                    for(int i=0;i<Projects.Count;++i)
                    {
                        SQL_GET_REPORT_DATA.Append("@P" + i);
                        selectCommand.Parameters.AddWithValue("@P" + i, Projects[i]);
                    }
                    SQL_GET_REPORT_DATA.Append(" ) ");

                }
                //employee filter selected
                if (Employees.Count > 0)
                {
                    if (!SQL_GET_REPORT_DATA.ToString().Contains("WHERE"))
                        SQL_GET_REPORT_DATA.Append(" WHERE ");
                    else
                        SQL_GET_REPORT_DATA.Append(" AND ");
                    SQL_GET_REPORT_DATA.Append(SQL_STRINGS.SQL_GET_REPORT_DATA_EMPLOYEE_FILTER);
                    for (int i = 0; i < Employees.Count; ++i)
                    {
                        SQL_GET_REPORT_DATA.Append("@E" + i);
                        selectCommand.Parameters.AddWithValue("@E" + i, Employees[i]);
                    }
                    SQL_GET_REPORT_DATA.Append(" ) ");

                }
                selectCommand.CommandText = SQL_GET_REPORT_DATA.ToString();
                selectCommand.Connection = con;
                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(selectCommand);
                sda.Fill(dt);
                return dt;

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