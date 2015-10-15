using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using TimeSheet.APP_CODE.Entities.Projects;
using TimeSheet.APP_CODE.Entities.Issues;
using TimeSheet.APP_CODE.Entities.Searching;
using Newtonsoft.Json;

namespace TimeSheet.APP_CODE.JIRA
{
    public class JiraManager
    {
        private const string m_BaseUrl = "https://jira.atlassian.com/rest/api/latest/";
        private string m_Username;
        private string m_Password;

        public JiraManager(string username, string password)
        {
            m_Username = username;
            m_Password = password;
        }

        /// <summary>
        /// Runs a query towards the JIRA REST api
        /// </summary>
        /// <param name="resource">The kind of resource to ask for</param>
        /// <param name="argument">Any argument that needs to be passed, such as a project key</param>
        /// <param name="data">More advanced data sent in POST requests</param>
        /// <param name="method">Either GET or POST</param>
        /// <returns></returns>
        protected string RunQuery(
            JiraResource resource, 
            string argument = null, 
            string data = null,
            string method = "GET")
        {
            string url = string.Format("{0}{1}/", m_BaseUrl, resource.ToString());

            if (argument != null)
            {
                url = string.Format("{0}{1}/", url, argument);
            }

            HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
            request.ContentType = "application/json";
            request.Method = method;

            if (data != null)
            {
                using (StreamWriter writer = new StreamWriter(request.GetRequestStream()))
                {
                    writer.Write(data);
                }
            }

            //string base64Credentials = GetEncodedCredentials();
            //request.Headers.Add("Authorization", "Basic " + base64Credentials);

            HttpWebResponse response = request.GetResponse() as HttpWebResponse;

            string result = string.Empty;
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                result = reader.ReadToEnd();
            }

            return result;
        }

        public List<ProjectDescription> GetProjects()
        {
            List<ProjectDescription> projects = new List<ProjectDescription>();
            string projectsString = RunQuery(JiraResource.project);

            return JsonConvert.DeserializeObject<List<ProjectDescription>>(projectsString);
        }

        public List<Issue> GetIssues(
            string jql, 
            List<string> fields = null,
            int startAt = 0, 
            int maxResult = 3000)
        {
            fields = fields ?? new List<string>{"summary", "status", "assignee"};

            SearchRequest request = new SearchRequest();
            request.Fields = fields;
            request.JQL = jql;
            request.MaxResults = maxResult;
            request.StartAt = startAt;

            string data = JsonConvert.SerializeObject(request);
            string result = RunQuery(JiraResource.search, data: data, method: "POST");

            SearchResponse response = JsonConvert.DeserializeObject<SearchResponse>(result);

            return response.IssueDescriptions;
        }

        private string GetEncodedCredentials()
        {
            string mergedCredentials = string.Format("{0}:{1}", m_Username, m_Password);
            byte[] byteCredentials = UTF8Encoding.UTF8.GetBytes(mergedCredentials);
            return Convert.ToBase64String(byteCredentials);
        }
    }
}
