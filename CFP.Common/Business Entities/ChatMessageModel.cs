using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class ChatMessageModel
    {
        public long ChatMessageId { get; set; }

        public int FromUserId { get; set; }

        public int? ToUserId { get; set; }

        public int? ChatRoomId { get; set; }

        public string Message { get; set; } = null!;

        public DateTime SentAt { get; set; }
        public bool isOwnMessage { get; set; }

        public bool IsRead { get; set; }
        public string SenderName { get; set; }
        public virtual UserMasterModel FromUser { get; set; } = null!;

        public virtual UserMasterModel? ToUser { get; set; }

    }
}
