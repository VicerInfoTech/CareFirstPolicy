using System;
using System.Collections.Generic;
using System.Text;

namespace CFP.Common.Utility
{
    public interface ISessionManager
    {
        int UserId { get; set; }
        int RoleId { get; set; }
        string Username { get; set; }
        string FirstName { get; set; }
        string LastName { get; set; }
        string FullName { get; set; }
        string GetSessionId();
        void ClearSession();
        string GetIP();
    }
}
