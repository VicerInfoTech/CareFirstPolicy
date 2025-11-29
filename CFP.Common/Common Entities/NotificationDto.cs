using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Common_Entities
{
    public class NotificationDto
    {
        public string SenderName { get; set; }
        public string Message { get; set; }
        public string ProfilePic { get; set; }
        public string TimeAgo { get; set; }
        public int? SenderUserId { get; set; }   // For private chat
        public int? RoomId { get; set; }         // For room chat

    }
}
