using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

namespace CFP.Web.Controllers
{
    public class ChatController : BaseController
    {
        #region Variables
        IAgentMasterProvider _provider;
        private readonly IChatProvider _chatProvider;
        #endregion

        #region Constructor
        public ChatController(ICommonProvider commonProvider, ISessionManager sessionManager, IChatProvider chatProvider) : base(commonProvider, sessionManager)
        {
            _chatProvider = chatProvider;
        }
        #endregion

        #region PrivateMessage
        public IActionResult Index()
        {
            ChatViewModel viewModel = new ChatViewModel();
            viewModel.CurrentUserId = _sessionManager.UserId;           
            return View(viewModel);
        }
        [HttpGet]
        public IActionResult GetChatUsers()
        {
            var users = _chatProvider.GetChatUsers(_sessionManager.UserId);
            return Json(users);
        }
        [HttpGet]
        public IActionResult GetMessages(int targetUserId)
        {
            var messages = _chatProvider.GetMessages(_sessionManager.UserId, targetUserId);
            _chatProvider.MarkMessagesRead(_sessionManager.UserId, targetUserId);
            return Json(messages);
        }

        [HttpGet]
        public IActionResult MarkMessagesRead(int targetUserId)
        {
            _chatProvider.MarkMessagesRead(_sessionManager.UserId, targetUserId);

            return Json(new { success = true });
        }
        [HttpPost]
        [Route("Chat/RemoveConnection")]
        public IActionResult RemoveConnection([FromBody] ChatViewModel model)
        {
            if (!string.IsNullOrEmpty(model.ConnectionId))
            {
                _chatProvider.RemoveConnection(model.ConnectionId, new SessionProviderModel());
            }

            return Json(true);
        }


        [HttpGet]
        public IActionResult GetContacts()
        {
            var contacts = _chatProvider.GetContacts(_sessionManager.UserId);

            return Json(contacts);
        }
        #endregion

        #region RoomMessage
        [HttpGet("/chat/getrooms")]
        public IActionResult GetRooms()
        {
            return Json(_chatProvider.GetAllRooms(GetSessionProviderParameters()));
        }

        public PartialViewResult _RoomDetails(string id)
        {
            ChatViewModel model = new ChatViewModel();
            model.SelectUserList = GetSelectUserList();
            if (!string.IsNullOrEmpty(id))
            {
                model.IsEdit = true;
                model.ChatRoomModel = _chatProvider.GetRoomById(_commonProvider.UnProtect(id));
            }

            return PartialView(model);
        }

        [HttpPost]
        public IActionResult SaveRoom(ChatViewModel model)
        {
            return Json(_chatProvider.CreateRoom(model.ChatRoomModel, GetSessionProviderParameters()));
        }

        [HttpPost]
        public IActionResult AddMember(int roomId, int userId)
        {
            _chatProvider.AddMemberToRoom(roomId, userId);
            return Json(new { success = true });
        }
        [HttpGet]
        public IActionResult GetRoomMembers(int roomId)
        {
            var members = _chatProvider.GetRoomMembers(roomId);
            return Json(members);
        }

        [HttpGet("/chat/getroom")]
        public IActionResult GetRoom(int roomId)
        {
            return Json(_chatProvider.GetRoomById(roomId));
        }
        [HttpGet("/chat/getroommessages")]
        public IActionResult GetRoomMessages(int roomId)
        {
            var messages = _chatProvider.GetRoomMessages(roomId);
            return Json(messages);
        }

        #endregion
    }
}
