///
/// Project : Time tracking system
/// Created On : 10.5.2015
/// 
///
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// const class to store all the sql queries at one place
/// </summary>
namespace TimeSheet.APP_CODE.DAL
{
    public class SQL_STRINGS
    {
        public static String SQL_GET_TIMESHEET_FOR_EMP = "SELECT ID,PROJECT_ID, PROJECT_NAME, TASK_JIRA_ISSUE_PROXY_KEY, HOURS_PER_DAY, COMMENTS FROM TIMESHEET WHERE EMPLOYEE_ID = @EMPLOYEE_ID ORDER BY ENTRY_ADD_DATE DESC";
        public static String SQL_GET_TIMESHEET_FOR_EMP_FOR_DATE = "SELECT ID,PROJECT_ID, PROJECT_NAME, TASK_JIRA_ISSUE_PROXY_KEY, HOURS_PER_DAY, COMMENTS FROM TIMESHEET WHERE EMPLOYEE_ID = @EMPLOYEE_ID AND TIMESHEET_DATE = CONVERT(DATETIME,@TDATE,101) ORDER BY ENTRY_ADD_DATE DESC";
        public static String SP_INSERT_TIMESHEET_ENTRY = "SP_INSERT_TIMESHEET_ENTRY";

    }
}