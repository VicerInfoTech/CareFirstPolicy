using System;
using System.Collections.Generic;
using System.Text;

namespace CFP.Common.Common_Entities
{
    public class SessionProviderModel
    {
        public int UserId { get; set; }
        public int RoleId { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Ip { get; set; }
    }
}
