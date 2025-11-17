using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class ChatUserListModel
    {
        public int UserId { get; set; }                 // Unique user ID
        public string UserName { get; set; }            // Display name
        public string ProfileImageUrl { get; set; }     // Profile picture
        public string LastMessage { get; set; }         // Message preview
        public DateTime? LastMessageTime { get; set; }   // For sorting latest chat
        public int UnreadCount { get; set; }            // Badge count
        public bool IsOnline { get; set; }

    }
    public class ContactUserDto
    {
        public int ContactUserId { get; set; }
        public string Name { get; set; }
        public string ProfileImage { get; set; }
        public bool IsOnline { get; set; }
    }


}
