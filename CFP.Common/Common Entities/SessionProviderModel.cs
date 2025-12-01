using System;
using System.Collections.Generic;
using System.Text;

namespace CFP.Common.Common_Entities
{
    public class SessionProviderModel
    {
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public int AgentId { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int UserAccess { get; set; }
        public string Ip { get; set; }
        public int AppId { get; set; }
    }
}
