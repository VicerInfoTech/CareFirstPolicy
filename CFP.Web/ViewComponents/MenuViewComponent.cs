using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.ViewComponents
{
    [ViewComponent(Name = "Menu")]
    public class MenuViewComponent : ViewComponent
    {
        public ISessionManager _sessionManager = null;
        ICommonProvider _commonProvider;

        public MenuViewComponent(ISessionManager sessionManager, ICommonProvider commonProvider)
        {
            _sessionManager = sessionManager;
            _commonProvider = commonProvider;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var list = _commonProvider.GetMenuList(
                new Common.Common_Entities.SessionProviderModel()
                {
                    UserId = _sessionManager.UserId,
                    RoleId = _sessionManager.RoleId
                });
            return View(list);
        }

    }
}
