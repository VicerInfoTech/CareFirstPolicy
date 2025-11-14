using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using OfficeOpenXml.FormulaParsing.Utilities;

namespace CFP.Web.Hubs
{
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
            _chatProvider.SaveConnection(Context.ConnectionId, GetSessionProviderParameters());
            await base.OnConnectedAsync();
        }


        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            //var user = _db.Users.FirstOrDefault(u => u.ConnectionId == Context.ConnectionId);
            //if (user != null)
            //{
            //    user.ConnectionId = null!;
            //    _db.SaveChanges();
            //}
            await base.OnDisconnectedAsync(exception);
        }
    }
}
