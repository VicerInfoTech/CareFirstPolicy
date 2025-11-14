using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class ChatRoom
{
    public int ChatRoomId { get; set; }

    public string RoomName { get; set; } = null!;

    public bool IsActive { get; set; }

    public int CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public int? UpdatedBy { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public string Ip { get; set; } = null!;

    public virtual ICollection<ChatMessage> ChatMessages { get; set; } = new List<ChatMessage>();

    public virtual ICollection<ChatRoomMember> ChatRoomMembers { get; set; } = new List<ChatRoomMember>();

    public virtual UserMaster CreatedByNavigation { get; set; } = null!;

    public virtual UserMaster? UpdatedByNavigation { get; set; }
}
