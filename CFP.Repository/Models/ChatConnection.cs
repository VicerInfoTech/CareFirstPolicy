using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class ChatConnection
{
    public long ChatConnectionId { get; set; }

    public int UserMasterId { get; set; }

    public string ConnectionId { get; set; } = null!;

    public virtual UserMaster UserMaster { get; set; } = null!;
}
