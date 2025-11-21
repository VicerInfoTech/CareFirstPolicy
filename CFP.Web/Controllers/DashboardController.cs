using System.Diagnostics;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Provider.Provider;
using CFP.Web.Filter;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    [Authorization(MenuId = 1)]
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
                AgentId = _sessionManager.AgentId,
                DealCount = _commonProvider.GetDealCount(GetSessionProviderParameters()),
                DealSummaryList = _commonProvider.GetDealSummary(),
                AgentList = GetAgentList()
            };
            return View(model);
        }
        public JsonResult SaveTempFilter(string KitId, string PatientId)
        {
            SetDataInTemp(AppCommon.TMP_ENC_KIT_ID, KitId);
            SetDataInTemp(AppCommon.TMP_ENC_PATIENT_ID, PatientId);
            return Json(true);
        }
        public JsonResult LeaderBoard()
        {
            return Json(_commonProvider.GetLeaderBoard().Select(x => new { x.Text, x.ExtraValue }).OrderByDescending(x => x.ExtraValue).ToList());
        }
        public JsonResult FetchDealData(int agentId)
        {
            var chartData = _commonProvider.GetDealDataForChart(agentId);
            var payload = chartData.Select(d => new
            {
                date = d.Date.ToString("MM/dd/yyyy"), // consistent client format
                label = d.DateLabel,
                applicantCount = d.ApplicantCount,
                dealCount = d.DealCount,
                agentCount=d.AgentCount
            }).ToList();
            return Json(payload);
        }

        [HttpPost]
        public JsonResult FetchDealDataAllAgents(int days)
        {
            return Json(_commonProvider.GetAgentDealDashboard(days));
        }

        #endregion
    }
}
