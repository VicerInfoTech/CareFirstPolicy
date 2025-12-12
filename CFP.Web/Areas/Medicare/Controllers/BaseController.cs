using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Areas.Medicare.Controllers
{
    [Area("Medicare")]
    public class BaseController : Controller
    {
        #region Variables
        protected ICommonProvider _commonProvider;
        public ISessionManager _sessionManager;
        #endregion

        #region Constructor
        public BaseController(ICommonProvider commonProvider, ISessionManager sessionManager)
        {
            _commonProvider = commonProvider;
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
                UserAccess = _sessionManager.UserAccess,
            };
            return sessionProviderModel;
        }

        public DatatablePageRequestModel GetPagingRequestModel()
        {
            DatatablePageRequestModel model = new DatatablePageRequestModel
            {
                StartIndex = AppCommon.ConvertToInt32(HttpContext.Request.Form["start"]),
                PageSize = AppCommon.ConvertToInt32(HttpContext.Request.Form["length"]),
                SearchText = HttpContext.Request.Form["search[value]"],
                SortColumnName = HttpContext.Request.Form["columns[" + HttpContext.Request.Form["order[0][column]"] + "][name]"],
                SortDirection = HttpContext.Request.Form["order[0][dir]"],
                Draw = HttpContext.Request.Form["draw"],
            };

            if (HttpContext.Request.Form.Any(x => x.Key == "Id") && !string.IsNullOrEmpty(HttpContext.Request.Form["Id"].ToString()))
                model.Id = AppCommon.ConvertToInt32(HttpContext.Request.Form["Id"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "fromValue") && !string.IsNullOrEmpty(HttpContext.Request.Form["fromValue"].ToString()))
                model.FromUserId = AppCommon.ConvertToInt32(HttpContext.Request.Form["fromValue"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "toUserValue") && !string.IsNullOrEmpty(HttpContext.Request.Form["toUserValue"].ToString()))
                model.ToUserId = AppCommon.ConvertToInt32(HttpContext.Request.Form["toUserValue"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "startData") && !string.IsNullOrEmpty(HttpContext.Request.Form["startData"].ToString()))
                model.StartDate = AppCommon.ConvertToDate(HttpContext.Request.Form["startData"]);

            //if (HttpContext.Request.Form.Any(x => x.Key == "sendDateValue") && !string.IsNullOrEmpty(HttpContext.Request.Form["sendDateValue"].ToString()))
            //    model.EndDate = AppCommon.ConvertToDate(HttpContext.Request.Form["sendDateValue"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "endDate") && !string.IsNullOrEmpty(HttpContext.Request.Form["endDate"].ToString()))
                model.EndDate = AppCommon.ConvertToDate(HttpContext.Request.Form["endDate"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "roomIdValue") && !string.IsNullOrEmpty(HttpContext.Request.Form["roomIdValue"].ToString()))
                model.RoomId = AppCommon.ConvertToInt32(HttpContext.Request.Form["roomIdValue"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "msgTypeValue") && !string.IsNullOrEmpty(HttpContext.Request.Form["msgTypeValue"].ToString()))
                model.MsgTypeId = AppCommon.ConvertToInt32(HttpContext.Request.Form["msgTypeValue"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "chatTypeValue") && !string.IsNullOrEmpty(HttpContext.Request.Form["chatTypeValue"].ToString()))
                model.ChatTypeId = AppCommon.ConvertToInt32(HttpContext.Request.Form["chatTypeValue"]);

            return model;

        }

    }
}
