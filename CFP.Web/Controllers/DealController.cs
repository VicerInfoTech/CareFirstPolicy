using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Filter;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    [Authorization(MenuId = 4)]
    public class DealController : BaseController
    {
        #region Variables
        IDealProvider _provider;
        private IAgentMasterProvider _agentMasterProvider;
        #endregion

        #region Constructor
        public DealController(ICommonProvider commonProvider, ISessionManager sessionManager, IDealProvider userProvider, IAgentMasterProvider agentMasterProvider) : base(commonProvider, sessionManager)
        {
            _provider = userProvider;
            _agentMasterProvider = agentMasterProvider;
        }
        #endregion
        public IActionResult Index()
        {
            return View();
        }

        public JsonResult GetList()
        {
            return Json(_provider.GetUserList(GetPagingRequestModel(), GetSessionProviderParameters()));
        }

        public IActionResult _Details(string id)
        {
            DashboardViewModel viewModel = new DashboardViewModel();
            viewModel.RoleId = _sessionManager.RoleId;
            viewModel.AgentList = GetAgentList();
            viewModel.CareerList = GetCareerList();
            viewModel.DealModel = _provider.GetById(_commonProvider.UnProtect(id));
            if (string.IsNullOrEmpty(id))
            {
                viewModel.DealModel.CloseDate = AppCommon.CurrentDate;
                viewModel.DealModel.AgentId = _sessionManager.AgentId;
            }

            return PartialView(viewModel);
        }

        public JsonResult Save(DashboardViewModel model)
        {
            return Json(_provider.Save(model.DealModel, GetSessionProviderParameters()));
        }

        [HttpPost]
        public JsonResult DeActivate(string id)
        {
            return Json(_provider.DeActivate(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
        }


    }
}
