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
    public class Timelog
    {
        private String projectId;

        public String ProjectId
        {
            get { return projectId; }
            set { projectId = value; }
        }

        private String taskId;

        public String TaskId
        {
            get { return taskId; }
            set { taskId = value; }
        }

        private float hours;

        public float Hours
        {
            get { return hours; }
            set { hours = value; }
        }
        

    }
}