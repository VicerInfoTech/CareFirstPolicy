using CFP.Common.Business_Entities;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CFP.Web.Models
{
    public class ChatViewModel
    {
        public List<ChatUserListModel> UserList { get; set; }
        public List<ChatMessageModel> Messages { get; set; }
        public ChatRoomModel ChatRoomModel { get; set; }
        public int SelectedUserId { get; set; }
        public int CurrentUserId { get; set; }
        public string ConnectionId { get; set; }
        public List<SelectListItem> SelectUserList { get; set; }
        public List<int>? UserIds { get; set; }
        public bool IsEdit { get; set; }
    }
}
