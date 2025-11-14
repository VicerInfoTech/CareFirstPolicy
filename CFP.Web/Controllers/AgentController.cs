using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Filter;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    [Authorization(MenuId = 3)]
    public class AgentController : BaseController
    {
        #region Variables
        IAgentMasterProvider _provider;
        #endregion

        #region Constructor
        public AgentController(ICommonProvider commonProvider, ISessionManager sessionManager, IAgentMasterProvider userProvider) : base(commonProvider, sessionManager)
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

            return PartialView(_provider.GetById(_commonProvider.UnProtect(id)));
        }

        public JsonResult Save(AgentMasterModel model)
        {
            return Json(_provider.Save(model, GetSessionProviderParameters()));
        }

        [HttpPost]
        public JsonResult DeActivate(string id)
        {
            return Json(_provider.DeActivate(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
        }

        [HttpPost]
        public JsonResult ReActivate(string id)
        {
            return Json(_provider.ReActivate(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
        }

        [HttpGet]
        public PartialViewResult _Reset(int id)
        {
            ResetPasswordModel model = new ResetPasswordModel() { EncId = _commonProvider.Protect(id) };
            return PartialView(model);
        }

        [HttpPost]
        public JsonResult ResetPassword(ResetPasswordModel model)
        {
            return Json(_provider.ResetPassword(model, _sessionManager.GetIP()));
        }
    }
}
