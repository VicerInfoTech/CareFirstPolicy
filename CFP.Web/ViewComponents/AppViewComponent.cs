using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Patient.ViewComponents
{
    [ViewComponent(Name = "AppList")]
    public class AppsViewComponent : ViewComponent
    {
        public ISessionManager _sessionManager = null;
        private readonly ICommonProvider _commonProvider;

        // IDashboardProvider _provider;

        public AppsViewComponent(ISessionManager sessionManager, ICommonProvider commonProvider)
        {
            _sessionManager = sessionManager;
            _commonProvider = commonProvider;
            // _provider = provider;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            DashboardViewModel model = new DashboardViewModel()
            {
                AgentAppList = _commonProvider.GetAgentAppList(new SessionProviderModel()
                {
                    UserId = _sessionManager.UserId,
                    RoleId = _sessionManager.RoleId,
                    AgentId=_sessionManager.AgentId
                })
            };
            return View(model);
        }
    }
}
