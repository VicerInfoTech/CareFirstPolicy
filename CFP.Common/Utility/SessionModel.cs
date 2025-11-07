using System;
using System.Collections.Generic;
using System.Text;

namespace CFP.Common.Utility
{
    [Serializable]
    public class SessionModel
    {
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public int AgentId { get; set; }
        public string Username { get; set; }
        public string FullName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
