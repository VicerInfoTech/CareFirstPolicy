using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Patient.ViewComponents
{
    [ViewComponent(Name = "Notification")]
    public class NotificationViewComponent : ViewComponent
    {
        public ISessionManager _sessionManager = null;
       // IDashboardProvider _provider;

        public NotificationViewComponent(ISessionManager sessionManager)
        {
            _sessionManager = sessionManager;
           // _provider = provider;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            DashboardViewModel model = new DashboardViewModel()
            {
                //Notifications = _provider.GetNotification(new SessionProviderModel()
                //{
                //    UserId = _sessionManager.UserId,
                //    RoleId = _sessionManager.RoleId
                //})
            };
            return View(model);
        }
    }
}
