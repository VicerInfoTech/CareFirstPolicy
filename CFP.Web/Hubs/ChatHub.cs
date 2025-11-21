using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Web.Filter;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using OfficeOpenXml.FormulaParsing.Utilities;

namespace CFP.Web.Hubs
{
    [Authorize]
    public class ChatHub : Hub
    {
        #region Variables
        protected IChatProvider _chatProvider;
        public ISessionManager _sessionManager;
        #endregion

        #region Constructor
        public ChatHub(ISessionManager sessionManager, IChatProvider chatProvider)
        {
            _chatProvider = chatProvider;
            _sessionManager = sessionManager;
        }
        #endregion

        [NonAction]
        protected SessionProviderModel GetSessionProviderParameters()
        {
            SessionProviderModel sessionProviderModel = new SessionProviderModel
            {
                UserId = _sessionManager.UserId,
                RoleId = _sessionManager.RoleId,
                AgentId = _sessionManager.AgentId,
                Username = _sessionManager.Username,
                Ip = _sessionManager.GetIP(),
                FirstName = _sessionManager.FirstName,
                LastName = _sessionManager.LastName,
            };
            return sessionProviderModel;
        }        
        public override async Task OnConnectedAsync()
        {
            try
            {
                // Block unauthenticated connections
                if (Context.User?.Identity == null || !Context.User.Identity.IsAuthenticated)
                {
                    Context.Abort();
                    return;
                }
                // Validate internal session
                var session = GetSessionProviderParameters();
                if (session == null || session.UserId == 0)
                {
                    Context.Abort();
                    return;
                }
                _chatProvider.SaveConnection(Context.ConnectionId, session);
            }
            catch
            {
                Context.Abort();
                return;
            }

            await base.OnConnectedAsync();
        }


        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            try
            {
                var session = GetSessionProviderParameters();
                if (session != null)
                {
                    _chatProvider.RemoveConnection(Context.ConnectionId, session);
                }
            }
            catch
            {
                // ignore disconnect errors
            }

            await base.OnDisconnectedAsync(exception);
        }

        // Called by client to send a message
        public async Task SendMessage(int toUserId, string message)
        {
            var session = GetSessionProviderParameters();
            if (session == null || session.UserId == 0)
            {
                await Clients.Caller.SendAsync("ForceLogout");
                Context.Abort();
                return;
            }

            int fromUserId = session.UserId;

            // Save message
            var msgId = _chatProvider.SaveMessage(fromUserId, toUserId, message);

            // Build payload
            var payload = new
            {
                MessageId = msgId,
                FromUserId = fromUserId,
                ToUserId = toUserId,
                Message = message,
                SentAt = AppCommon.CurrentDate
            };

            // Send back to caller (so UI can show it instantly)
            await Clients.Caller.SendAsync("ReceiveMessage", new
            {
                MessageId = msgId,
                FromUserId = fromUserId,
                ToUserId = toUserId,
                Message = message,
                SentAt = AppCommon.CurrentDate,
                isOwnMessage = true

            });

            // Send to receiver if connected
            var receiverConnectionId = _chatProvider.GetConnectionId(toUserId);
            if (!string.IsNullOrEmpty(receiverConnectionId))
            {
                await Clients.Client(receiverConnectionId).SendAsync("ReceiveMessage", new
                {
                    MessageId = msgId,
                    FromUserId = fromUserId,
                    ToUserId = toUserId,
                    Message = message,
                    SentAt = AppCommon.CurrentDate,
                    isOwnMessage = false

                });
            }
        }

        // Optional: client can call to load previous messages via hub instead of controller
        public Task<List<ChatMessageModel>> LoadMessages(int targetUserId, int page = 1)
        {
            var session = GetSessionProviderParameters();
            if (session == null || session.UserId == 0)
            {
                Clients.Caller.SendAsync("ForceLogout").RunSynchronously();
                Context.Abort();
                return Task.FromResult(new List<ChatMessageModel>());
            }

            var msgs = _chatProvider.GetMessages(session.UserId, targetUserId);
            // mark read
            _chatProvider.MarkMessagesRead(session.UserId, targetUserId);
            return Task.FromResult(msgs);
        }

        public async Task SendRoomMessage(ChatMessageModel model)
        {
            var messageId = _chatProvider.SaveRoomMessage(model);
           
            await Clients.Group(model.ChatRoomId.ToString())
                .SendAsync("ReceiveRoomMessage", new
                {
                    model.Message,
                    model.ChatRoomId,
                    model.FromUserId,
                    SentAt = AppCommon.CurrentDate,
                    model.IsAttachment,
                    model.FileName
                });
        }

    }
}
