using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Provider.Provider;
using CFP.Web.Areas.Medicare.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Areas.Medicare.Controllers
{
    [Area("Medicare")]
    public class DashboardController : BaseController
    {
        #region Variables
        IUserMasterProvider _userProvider;
        private readonly IWebHostEnvironment _webHostEnvironment;

        #endregion

        #region Constructor
        public DashboardController(ICommonProvider commonProvider, ISessionManager sessionManager, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion
        public IActionResult Index()
        {
            MedDashboardViewModel viewModel = new MedDashboardViewModel();

            viewModel.JobDayCounts = _commonProvider.GetJobDayCount();
            viewModel.RoleId = _sessionManager.RoleId;
            return View(viewModel);
        }
    }
}
