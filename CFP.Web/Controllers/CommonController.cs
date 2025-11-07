using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Web.Controllers
{
    public class CommonController : BaseController
    {
        #region Variables
        IUserMasterProvider _userProvider;
        IWebHostEnvironment _webHostEnvironment;
        #endregion

        #region Constructor
        public CommonController(ICommonProvider commonProvider, ISessionManager sessionManager, IUserMasterProvider userProvider, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _userProvider = userProvider;
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion

        #region Methods
        public PartialViewResult _ChangePassword(int id)
        {
            string encId = "";
            bool IsAgent = false;
            if (id > 0)
            {
                encId = _commonProvider.Protect(id);
                IsAgent = true;
            }
            else
                encId = _commonProvider.Protect(_sessionManager.UserId);
            ResetPasswordModel model = new ResetPasswordModel() { EncId = encId, IsAgent = IsAgent };
            return PartialView("_ChangePassword", model);
        }
        [HttpPost]
        public JsonResult ChangePassword(ResetPasswordModel model)
        {
            return Json(_userProvider.ChangeOrResetPassword(model, true, _sessionManager.GetIP()));
        }
        #endregion
    }
}
