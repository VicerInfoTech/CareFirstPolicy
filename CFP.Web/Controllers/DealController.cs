using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    public class DealController : BaseController
    {
        #region Variables
        IDealProvider _provider;
        #endregion

        #region Constructor
        public DealController(ICommonProvider commonProvider, ISessionManager sessionManager, IDealProvider userProvider) : base(commonProvider, sessionManager)
        {
            _provider = userProvider;
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
            viewModel.AgentList = GetAgentList();
            viewModel.DealModel = _provider.GetById(_commonProvider.UnProtect(id));
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
