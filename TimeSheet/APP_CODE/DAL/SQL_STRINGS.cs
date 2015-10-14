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
        public static  String GET_ALL_ENTRIES_FOR_DATE_FOR_EMPLOYEE = "SELECT * FROM TIMELOG WHERE DATE=@DATE AND EMPLOYEE_ID=@EMPID";
    }
}