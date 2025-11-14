using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class ChatMessage
{
    public long ChatMessageId { get; set; }

    public int FromUserId { get; set; }

    public int? ToUserId { get; set; }

    public int? ChatRoomId { get; set; }

    public string Message { get; set; } = null!;

    public DateTime SentAt { get; set; }

    public virtual ChatRoom? ChatRoom { get; set; }

    public virtual UserMaster FromUser { get; set; } = null!;

    public virtual UserMaster? ToUser { get; set; }
}
