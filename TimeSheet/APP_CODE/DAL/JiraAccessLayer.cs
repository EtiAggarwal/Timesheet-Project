using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TimeSheet.APP_CODE.Entities.Issues;
using TimeSheet.APP_CODE.Entities.Projects;
using TimeSheet.APP_CODE.JIRA;

namespace TimeSheet.APP_CODE.DAL
{
    public class JiraAccessLayer
    {
        public IEnumerable GetProjects()
        {
            try {

                JiraManager manager = new JiraManager("", "");

                List<ProjectDescription> projects = manager.GetProjects();
                return projects;
            }
            catch
            {
                throw;
            }
        }

        public List<Issue> GetIssuesForProject(String projectKey)
        {
            try
            {
                JiraManager manager = new JiraManager("", "");
                string jql = "project = " + projectKey + " and ( status = 'Open' or status = 'In Progress' or status = 'Reopened' )";// or status = 'In Testing' or status = 'Additional Information Needed' or status = 'Testing Rejected' or status = 'In Progress – Paused' or status = 'To Do' or status = 'Code Complete' )";
                List<Issue> issueDescriptions = manager.GetIssues(jql);
                return issueDescriptions;
            }
            catch
            {
                throw;
            }
        }
    }
}