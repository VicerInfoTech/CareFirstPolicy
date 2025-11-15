using CFP.Common.Business_Entities;

namespace CFP.Web.Models
{
    public class ChatViewModel
    {
        public List<ChatUserListModel> UserList { get; set; }
        public List<ChatMessageModel> Messages { get; set; }
        public int SelectedUserId { get; set; }
        public int CurrentUserId { get; set; }
    }
}
