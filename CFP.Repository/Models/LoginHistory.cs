using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class LoginHistory
{
    public int LoginHistoryId { get; set; }

    public int UserMasterId { get; set; }

    public DateTime LoggedInTime { get; set; }

    public string Ip { get; set; } = null!;

    public virtual UserMaster UserMaster { get; set; } = null!;
}
