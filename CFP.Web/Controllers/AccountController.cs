using CFP.Common.Business_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using Microsoft.AspNetCore.Mvc;

namespace CFP.Patient.Controllers
{
    public class AccountController : BaseController
    {
        #region Variables
        IUserMasterProvider _provider;
        IWebHostEnvironment _webHostEnvironment;

        #endregion

        #region Constructor
        public AccountController(IUserMasterProvider userMasterProvider, ICommonProvider commonProvider
            , ISessionManager sessionManager, IWebHostEnvironment webHostEnvironment
            , IHttpContextAccessor httpContextAccessor) : base(commonProvider, sessionManager)
        {
            _provider = userMasterProvider;
            _webHostEnvironment = webHostEnvironment;

        }
        #endregion

        #region Methods
        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Index(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                var response = _provider.Authentication(model, _sessionManager.GetSessionId(), _sessionManager.GetIP());
                if (response.IsSuccess)
                {
                    if (response.IsEnableTwoStepAuth)
                    {
                        TempData[AppCommon.SuccessTempKeyName] = response.Message;
                        return RedirectToAction("VerifyOTP", "Account", new { @id = response.Result });
                    }
                    else
                    {
                        _sessionManager.UserId = response.UserId;
                        _sessionManager.RoleId = response.RoleId;
                        _sessionManager.AgentId = response.AgentId;
                        _sessionManager.Username = response.Username;
                        _sessionManager.FirstName = response.FirstName;
                        _sessionManager.LastName = response.LastName;
                        _sessionManager.FullName = response.FullName;
                        return RedirectToAction("Index", "Dashboard");
                    }
                }
                else
                {
                    TempData[AppCommon.ErrorTempKeyName] = response.Message;
                    return View(model);
                }
            }
            else
                return View(model);
        }
        public IActionResult ForgetPassword()
        {
            return View();
        }
        [HttpPost]
        public IActionResult ForgetPassword(ForgotPasswordModel model)
        {
            if (string.IsNullOrEmpty(model.Username))
            {
                return View(model);
            }
            var response = _provider.SendRessetPasswordMailPatient(model);
            return View(model);
        }

        public IActionResult Logout()
        {
            _sessionManager.ClearSession();
            return RedirectToAction("Index");
           // return Redirect(AppCommon.TOD_URL);
        }

        [Route("ErrorLog")]
        public IActionResult ErrorLog()
        {
            List<string> list = new List<string>();
            try
            {
                string path = Path.Combine(_webHostEnvironment.WebRootPath, "LogFiles");
                if (Directory.Exists(path))
                {
                    FileInfo[] files = new DirectoryInfo(path).GetFiles();

                    if (files != null && files.Length > 0)
                    {
                        foreach (var item in files.OrderByDescending(x => x.CreationTime))
                        {
                            string fileName = item.Name.Split("\\").Last();
                            list.Add(fileName);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                list.Add(ex.Message);
            }
            return View(list);
        }
        public IActionResult VerifyOTP(string id)
        {
            OtpModel model = new OtpModel() { EncUserMasterId = id };
            return View(model);
        }
        // [HttpPost]
        //public IActionResult VerifyOTP(OtpModel model)
        //{
        //    try
        //    {
        //        var response = _provider.VerifyOTP(model, _sessionManager.GetSessionId(), _sessionManager.GetIP());
        //        if (response.IsSuccess)
        //        {
        //            _sessionManager.UserId = response.UserId;
        //            _sessionManager.RoleId = response.RoleId;
        //            _sessionManager.Username = response.Username;
        //            _sessionManager.FirstName = response.FirstName;
        //            _sessionManager.LastName = response.LastName;
        //            _sessionManager.FullName = response.FullName;

        //            if (response.RoleId == (short)Enumeration.Role.Super_Admin)
        //                return RedirectToAction("Index", "Dashboard");
        //            else
        //                return RedirectToAction("Index", "PatientHome");
        //        }
        //        else
        //        {
        //            TempData[AppCommon.ErrorTempKeyName] = response.Message;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        AppCommon.LogException(ex, "AccountController.VerifyOTP");
        //        TempData[AppCommon.ErrorTempKeyName] = AppCommon.ErrorMessage;
        //    }
        //    return View(model);
        //}
        //public IActionResult CreatePassword(string id)
        //{
        //    if (!string.IsNullOrEmpty(id))
        //    {
        //        ResetPasswordModel model = new ResetPasswordModel();
        //        var user = _provider.GetByCode(id);
        //        if (user != null)
        //        {
        //            if (user.IsPasswordCreated)
        //            {
        //                TempData[AppCommon.ErrorTempKeyName] = "Password already created. If you forgot your password kindly reset it.";
        //                return RedirectToAction("Index", "Account");
        //            }
        //            model = new ResetPasswordModel
        //            {
        //                EncId = _commonProvider.Protect(user.UserMasterId),
        //                Username = user.Username
        //            };
        //            return View(model);
        //        }
        //        else
        //        {

        //            TempData[AppCommon.ErrorTempKeyName] = "User not found. Please try agian.";
        //            return RedirectToAction("Index", "Account");
        //        }
        //    }
        //    else
        //    {
        //        TempData[AppCommon.ErrorTempKeyName] = "In Valid Create Password Link";
        //        return RedirectToAction("Index", "Account");
        //    }
        //}
        //[HttpPost]
        //public IActionResult CreatePassword(ResetPasswordModel model)
        //{
        //    var response = _provider.CreatePasswordPatient(model, _sessionManager.GetIP());
        //    if (response.IsSuccess)
        //    {
        //        TempData[AppCommon.SuccessTempKeyName] = response.Message;
        //        return RedirectToAction("Logout", "Account");
        //    }
        //    else
        //    {
        //        TempData[AppCommon.ErrorTempKeyName] = response.Message;
        //        return View(model);
        //    }
        //}
        #endregion
    }
}
