using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using TimeSheet.APP_CODE.Entities.Misc;

namespace TimeSheet.APP_CODE.Entities.Projects
{
    /// <summary>
    /// A class representing a project descriptin in JIRA
    /// </summary>
    public class ProjectDescription : BaseEntity
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("key")]
        public string Key { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("avatarUrls")]
        public AvatarUrls AvatarUrls { get; set; }
    }
}
