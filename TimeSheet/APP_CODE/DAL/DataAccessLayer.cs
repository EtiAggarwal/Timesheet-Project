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

        public DataTable getAllTimeLog()
        {
            SqlDataAdapter da = new SqlDataAdapter("select ProjectId,TaskId,StartTime,EndTime from Time_Log", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            return dt;
        }

        public void addTimeLog(String projectID, String taskId, String startTime, String endTime)
        {
            SqlCommand comm = new SqlCommand("INSERT INTO TIME_LOG VALUES(@P,@T,getdate(),@S,@E)", con);
            comm.Parameters.AddWithValue("@P", projectID);
            comm.Parameters.AddWithValue("@T", taskId);

            comm.Parameters.AddWithValue("@S", startTime);
            comm.Parameters.AddWithValue("@E", endTime);
            con.Open();
            comm.ExecuteNonQuery();
            con.Close();


        }
    }
}