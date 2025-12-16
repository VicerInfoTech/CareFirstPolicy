using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Web.Areas.Medicare.Models;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Areas.Medicare.Controllers
{
    [Area("Medicare")]
    public class ApplicationController : BaseController
    {
        #region Variables
        IUserMasterProvider _userProvider;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly IMedApplicationProvider _medApplicationProvider;

        #endregion

        #region Constructor
        public ApplicationController(ICommonProvider commonProvider, ISessionManager sessionManager, IWebHostEnvironment webHostEnvironment, IMedApplicationProvider medApplicationProvider) : base(commonProvider, sessionManager)
        {
            _webHostEnvironment = webHostEnvironment;
            _medApplicationProvider = medApplicationProvider;
        }
        #endregion
        public IActionResult Index()
        {
            ApplicationViewModel viewModel= new ApplicationViewModel();
           
            return View(viewModel);
        }

        public JsonResult GetList()
        {
            return Json(_medApplicationProvider.GetApplicationList(GetPagingRequestModel(), GetSessionProviderParameters()));
        }


        public IActionResult _ApplicationSummary(string id)
        {
            ApplicationViewModel viewModel = new ApplicationViewModel();
            viewModel.MedicareJobModel = _medApplicationProvider.GetApplicationById(_commonProvider.UnProtect(id));
            return PartialView(viewModel);
        }
        public IActionResult _UpdateStatus(string id,byte status)
        {
            ApplicationViewModel viewModel = new ApplicationViewModel();
            viewModel.MedicareJobModel.Status = status;
            viewModel.MedicareJobModel.EncJobApplicationId = id;
            return PartialView(viewModel);
        }
        public JsonResult SaveStatus(ApplicationViewModel model)
        {
            return Json(_medApplicationProvider.SaveStatus(model.MedicareJobModel,GetSessionProviderParameters()));
        }
    }
}
