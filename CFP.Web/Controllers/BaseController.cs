using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CFP.Patient.Controllers
{
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

            return model;

        }

        public List<SelectListItem> GetAgentList()
        {
            var agentList = _commonProvider.GetAgentList()
                 .Select(x => new SelectListItem { Text = x.Text, Value = x.Value });

            if (_sessionManager.RoleId == (int)Enumeration.Role.Agent)
                agentList = agentList.Where(x => x.Value == _sessionManager.AgentId.ToString());

            var list = agentList.ToList();
            return list;
        }

        public List<SelectListItem> GetRoleList()
        {
            List<SelectListItem> list = new List<SelectListItem>();
            list.Add(new SelectListItem() { Value = ((int)Enumeration.Role.Agent).ToString(), Text = "Agent" });
            list.Add(new SelectListItem() { Value = ((int)Enumeration.Role.User).ToString(), Text = "User" });

            return list;
        }

        #region Temp Data Methods
        public void DeleteAllFilter()
        {
            DeleteTempData(AppCommon.TMP_ENC_KIT_ID);
        }
        public void SetDataInTemp(string TempDataKey, string data)
        {
            TempData[TempDataKey] = null;
            TempData[TempDataKey] = data;
            //KeepTempData(TempDataKey);
        }
        public string GetDataFromTemp(string TempDataKey)
        {
            string data = "";
            if (TempData[TempDataKey] != null)
            {
                data = TempData[TempDataKey].ToString();
                //KeepTempData(TempDataKey);
            }
            return data;
        }
        public void KeepTempData(string TempDataKey)
        {
            if (TempData[TempDataKey] != null)
                TempData.Keep();
        }
        public void DeleteTempData(string TempDataKey)
        {
            TempData[TempDataKey] = null;
        }
        #endregion

    }

}
