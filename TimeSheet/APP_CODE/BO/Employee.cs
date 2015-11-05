///
/// Project : Time tracking system
/// Created On : 10.5.2015
///
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TimeSheet.APP_CODE.BO
{
    public class Employee
    {
        private String employeeId;

        public String EmployeeId
        {
            get { return employeeId; }
            set { employeeId = value; }
        }

        private String firstName;

        public String FirstName
        {
            get { return firstName; }
            set { firstName = value; }
        }

        private String lastName;

        public String LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        private String email;

        public String Email
        {
            get { return email; }
            set { email = value; }
        }

      

        private bool isAdmin;

        public bool IsAdmin
        {
            get { return isAdmin; }
            set { isAdmin = value; }
        }

        private String guid;

        public String GUID
        {
            get { return guid; }
            set { guid = value; }
        }


    }
}