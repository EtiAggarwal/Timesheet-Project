using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using TimeSheet.APP_CODE.Entities.Issues;
using TimeSheet.APP_CODE.Entities.Projects;
using TimeSheet.APP_CODE.JIRA;

namespace TimeSheet.APP_CODE.DAL
{
    public class JiraAccessLayer
    {
        public List<ProjectDescription> GetProjects()
        {
            try {

                JiraManager manager = new JiraManager("", "");

                List<ProjectDescription> projects = manager.GetProjects();
                // return ConvertToDataTable(projects);
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

        public DataTable ConvertToDataTable<T>(IList<T> data)
        {
            PropertyDescriptorCollection properties =
               TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            foreach (PropertyDescriptor prop in properties)
                table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
            foreach (T item in data)
            {
                DataRow row = table.NewRow();
                foreach (PropertyDescriptor prop in properties)
                    row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
                table.Rows.Add(row);
            }
            return table;

        }
    }
}