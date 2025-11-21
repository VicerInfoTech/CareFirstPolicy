using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
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
        private readonly IWebHostEnvironment _webHostEnvironment;
        private static readonly HashSet<string> AllowedExtensions = new(StringComparer.OrdinalIgnoreCase)
    {
        ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".png", ".jpg", ".jpeg", ".txt", ".zip"
    };
        private const long MaxFileSizeBytes = 15 * 1024 * 1024; // 15MB
        #endregion

        #region Constructor
        public ChatController(ICommonProvider commonProvider, ISessionManager sessionManager, IChatProvider chatProvider, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _chatProvider = chatProvider;
            _webHostEnvironment = webHostEnvironment;
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
                model.ChatRoomModel = _chatProvider.GetRoomById(_commonProvider.UnProtect(id), GetSessionProviderParameters());
            }

            return PartialView(model);
        }

        [HttpPost]
        public IActionResult SaveRoom(ChatViewModel model)
        {
            return Json(_chatProvider.CreateRoom(model.ChatRoomModel, GetSessionProviderParameters()));
        }


        [HttpPost]
        public JsonResult Delete(string id)
        {
            return Json(_chatProvider.Delete(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
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
            return Json(_chatProvider.GetRoomById(roomId, GetSessionProviderParameters()));
        }
        [HttpGet("/chat/getroommessages")]
        public IActionResult GetRoomMessages(int roomId)
        {
            var messages = _chatProvider.GetRoomMessages(roomId);
            return Json(messages);
        }

        [HttpPost]
        public async Task<IActionResult> UploadAttachment(int chatRoomId, IFormFile file)
        {
            if (file == null || file.Length == 0) return BadRequest("No file selected.");

            var ext = Path.GetExtension(file.FileName);
           // var guidFileName = $"{Guid.NewGuid()}{ext}";
            var guidFileName=  Guid.NewGuid().ToString() + AppCommon.FileNameSeperator + file.FileName;

            var uploadPath = GetChatUploadPath(chatRoomId);
            var filePath = Path.Combine(uploadPath, guidFileName);

            using (var stream = System.IO.File.Create(filePath))
                await file.CopyToAsync(stream);

            // Return metadata
            return Ok(new
            {
                guidFileName,
                fileName = file.FileName,
                downloadUrl = Url.Action("DownloadAttachment", "Chat", new { roomId = chatRoomId, file = guidFileName })
            });
        }

        [HttpGet]
        public async Task<IActionResult> DownloadAttachment(int roomId, string file)
        {
            if (string.IsNullOrEmpty(file)) return BadRequest();

            var uploadRoot = GetChatUploadPath(roomId);
            var filePath = Path.Combine(uploadRoot, file);

            if (!System.IO.File.Exists(filePath)) return NotFound();

            var memory = new MemoryStream();
            await using (var stream = System.IO.File.OpenRead(filePath))
                await stream.CopyToAsync(memory);
            memory.Position = 0;

            string[]fileNameArray= file.Split(AppCommon.FileNameSeperator);
            var originalFileName = fileNameArray[fileNameArray.Length-1];

            return File(memory, "application/octet-stream", originalFileName);
        }

        private string GetChatUploadPath(int chatRoomId)
        {
            var path = Path.Combine(_webHostEnvironment.WebRootPath, "ExtraFiles", "Uploads", "Chat", chatRoomId.ToString());
            Directory.CreateDirectory(path);
            return path;
        }


        #endregion
    }
}
