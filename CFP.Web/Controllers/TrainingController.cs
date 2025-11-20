using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    public class TrainingController : BaseController
    {
        #region Variables

        public IWebHostEnvironment _webHostEnvironment { get; }
        #endregion

        #region Constructor
        public TrainingController(ICommonProvider commonProvider, ISessionManager sessionManager, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion
        public IActionResult Index()
        {
            return View();
        }
    }
}
