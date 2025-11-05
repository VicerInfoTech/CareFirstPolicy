using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.ViewComponents
{

    [ViewComponent(Name = "UserNameHeader")]
    public class UserNameHeaderViewComponent : ViewComponent
    {
        public ISessionManager _sessionManager = null;
        IUserMasterProvider _userMasterProvider;

        public UserNameHeaderViewComponent( ISessionManager sessionManager, IUserMasterProvider userMasterProvider)
        {
            _sessionManager = sessionManager;
            _userMasterProvider = userMasterProvider;
        }
        public async Task<IViewComponentResult> InvokeAsync()
        {
            UserHeaderDetailModel model = new UserHeaderDetailModel();
            if (_sessionManager.UserId > 0)
            {
                var userDetails = _userMasterProvider.GetById(_sessionManager.UserId);
                if (userDetails != null)
                {
                    model.Username = userDetails.Username;
                    model.FirstName = userDetails.FirstName;
                    model.LastName = userDetails.LastName;
                    model.UserMasterId = userDetails.UserMasterId;
                    model.RoleId = userDetails.RoleId;
                    model.RoleName = userDetails.RoleName;
                }
            }
            return View(model);
        }

    }
}
