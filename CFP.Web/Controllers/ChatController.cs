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
        public IActionResult Index()
        {
            ChatViewModel viewModel = new ChatViewModel();
            viewModel.CurrentUserId = _sessionManager.UserId;
            return View(viewModel);
        }
        [HttpGet]
        public IActionResult GetChatUsers()
        {
            var userId = _sessionManager.UserId;
            var users = _chatProvider.GetChatUsers(userId);
            return Json(users);
        }
        [HttpGet]
        public IActionResult GetMessages(int targetUserId)
        {
            var userId = _sessionManager.UserId;
            var messages = _chatProvider.GetMessages(userId, targetUserId);
            // mark as read (server side)
            _chatProvider.MarkMessagesRead(userId, targetUserId);
            return Json(messages);
        }

        [HttpGet]
        public IActionResult MarkMessagesRead(int targetUserId)
        {
            var userId = _sessionManager.UserId;

            _chatProvider.MarkMessagesRead(userId, targetUserId);

            return Json(new { success = true });
        }
        [HttpPost]
        public IActionResult RemoveConnection([FromBody] string connectionId)
        {
            if (!string.IsNullOrEmpty(connectionId))
            {
                _chatProvider.RemoveConnection(connectionId, new SessionProviderModel());
            }
            return Json("");
        }
        [HttpGet]
        public IActionResult GetContacts()
        {
            var contacts = _chatProvider.GetContacts(_sessionManager.UserId);

            return Json(contacts);
        }

    }
}
