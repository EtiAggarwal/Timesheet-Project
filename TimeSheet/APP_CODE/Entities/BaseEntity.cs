
using Newtonsoft.Json;

namespace TimeSheet.APP_CODE.Entities
{
    public class BaseEntity
    {
        [JsonProperty("self")]
        public string Self { get; set; }
    }
}
