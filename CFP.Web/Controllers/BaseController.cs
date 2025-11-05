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

            if (HttpContext.Request.Form.Any(x => x.Key == "KitId") && !string.IsNullOrEmpty(HttpContext.Request.Form["KitId"].ToString()))
                model.KitId = AppCommon.ConvertToInt32(HttpContext.Request.Form["KitId"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "UserId") && !string.IsNullOrEmpty(HttpContext.Request.Form["UserId"].ToString()))
                model.UserId = AppCommon.ConvertToInt32(HttpContext.Request.Form["UserId"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "PatientId") && !string.IsNullOrEmpty(HttpContext.Request.Form["PatientId"].ToString()))
                model.PatientId = AppCommon.ConvertToInt32(HttpContext.Request.Form["PatientId"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "Status") && !string.IsNullOrEmpty(HttpContext.Request.Form["Status"].ToString()))
                model.Status = AppCommon.ConvertToInt32(HttpContext.Request.Form["Status"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "PrintStatus") && !string.IsNullOrEmpty(HttpContext.Request.Form["PrintStatus"].ToString()))
                model.PrintStatus = AppCommon.ConvertToInt32(HttpContext.Request.Form["PrintStatus"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "Date") && !string.IsNullOrEmpty(HttpContext.Request.Form["Date"].ToString()))
                model.Date = HttpContext.Request.Form["Date"];

            if (HttpContext.Request.Form.Any(x => x.Key == "OrderListType") && !string.IsNullOrEmpty(HttpContext.Request.Form["OrderListType"].ToString()))
                model.OrderListType = Convert.ToInt32(HttpContext.Request.Form["OrderListType"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "TestType") && !string.IsNullOrEmpty(HttpContext.Request.Form["TestType"].ToString()))
                model.TestType = Convert.ToInt32(HttpContext.Request.Form["TestType"]);

            if (HttpContext.Request.Form.Any(x => x.Key == "RoleId") && !string.IsNullOrEmpty(HttpContext.Request.Form["RoleId"].ToString()))
                model.RoleId = Convert.ToInt32(HttpContext.Request.Form["RoleId"]);

            return model;

        }

        //public List<SelectListItem> GetUserList()
        //{
        //    return _commonProvider.GetUserDropDown().Select(x => new SelectListItem() { Text = x.Text, Value = x.Value }).ToList();
        //}

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
