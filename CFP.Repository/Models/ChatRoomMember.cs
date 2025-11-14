using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class ChatRoomMember
{
    public int ChatRoomMemberId { get; set; }

    public int ChatRoomId { get; set; }

    public int UserMasterId { get; set; }

    public virtual ChatRoom ChatRoom { get; set; } = null!;

    public virtual UserMaster UserMaster { get; set; } = null!;
}
