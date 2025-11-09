using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace CFP.Web.Controllers
{
    public class DashboardController : BaseController
    {

        #region Variables
        IUserMasterProvider _userProvider;
        #endregion

        #region Constructor
        public DashboardController(ICommonProvider commonProvider, ISessionManager sessionManager, IUserMasterProvider userProvider) : base(commonProvider, sessionManager)
        {
            _userProvider = userProvider;
        }
        #endregion

        #region Methods
        public IActionResult Index()
        {
            DashboardViewModel model = new DashboardViewModel()
            {
                RoleId = _sessionManager.RoleId,
                
            };
            return View(model);
        } 
        public IActionResult LeaderBoard()
        {
            DashboardViewModel model = new DashboardViewModel()
            {
                RoleId = _sessionManager.RoleId,
                
            };
            model.LeaderBoard=_commonProvider.GetLeaderBoard();
            return View(model);
        }
        public JsonResult SaveTempFilter(string KitId, string PatientId)
        {
            SetDataInTemp(AppCommon.TMP_ENC_KIT_ID, KitId);
            SetDataInTemp(AppCommon.TMP_ENC_PATIENT_ID, PatientId);
            return Json(true);
        }
        

        #endregion
    }
}
