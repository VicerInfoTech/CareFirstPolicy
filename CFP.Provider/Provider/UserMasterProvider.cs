using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using AutoMapper;
using System.Linq.Dynamic.Core;

namespace CFP.Provider.Provider
{
    public class UserMasterProvider : IUserMasterProvider
    {
        #region Variable
        private UnitOfWork unitOfWork = new UnitOfWork();
        private ICommonProvider _commonProvider;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor

        public UserMasterProvider(IMapper mapper, ICommonProvider commonProvider)
        {
            _commonProvider = commonProvider;
            _mapper = mapper;
        }
        #endregion

        #region Methods
        public AuthResultModel Authentication(LoginModel login, string sessionId, string Ip)
        {
            AuthResultModel model = new AuthResultModel();
            try
            {
                var userData = unitOfWork.UserMaster.GetAll(x => x.Username == login.UserName).FirstOrDefault();
                if (userData != null)
                {
                    if (!userData.IsActive)
                    {
                        model.IsSuccess = false;
                        model.Message = "Your account is not active. Please contact administrator.";
                        return model;
                    }

                    int loginAtmpt = GetLoginAttampt(login.UserName);
                    if (loginAtmpt >= 3)
                    {
                        model.IsSuccess = false;
                        model.Message = "Failed to Login, Your account is blocked for 15 min.!";
                        return model;
                    }

                    if (PasswordHash.ValidatePassword(AES.DecryptAES(login.UserPassword), userData.UserPassword))
                    {
                        model.UserId = userData.UserMasterId;
                        model.Username = userData.Username;
                        model.FirstName = userData.FirstName;
                        model.LastName = userData.LastName;
                        model.RoleId = userData.RoleId;
                        model.FullName = userData.FirstName + " " + userData.LastName;
                        model.IsSuccess = true;
                        InsertLoginHistory(userData.UserMasterId, sessionId, Ip);
                        RemoveLoginFailure(login.UserName);
                    }
                    else
                    {
                        model.IsSuccess = false;
                        int loginAttempt = InsertLoginFailure(login, userData.UserMasterId, Ip);
                        if (loginAttempt < 3)
                            model.Message = "Invalid Password. " + (3 - loginAttempt) + " attempt left!";
                        else
                            model.Message = "Invalid Password. Your account is blocked for 15 min.!";
                    }

                }
                else
                {
                    model.IsSuccess = false;
                    model.Message = "Invalid Username";
                }
            }
            catch (Exception ex)
            {
                model.Message = AppCommon.ErrorMessage;
                model.IsSuccess = false;
                AppCommon.LogException(ex, "UserMasterProvider => Authentication");
            }
            return model;
        }
        private void RemoveLoginFailure(string userName)
        {
            try
            {
                var loginFailHistory = unitOfWork.LoginFailure.GetAll(x => x.Username == userName);
                if (loginFailHistory != null)
                {
                    unitOfWork.LoginFailure.DeleteAll(loginFailHistory);
                    unitOfWork.Save();
                }
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider => RemoveLoginFailure");
            }
        }
        private int InsertLoginFailure(LoginModel login, int userId, string Ip)
        {
            try
            {
                LoginFailure failure = new LoginFailure
                {
                    Username = login.UserName
                };
                unitOfWork.LoginFailure.Insert(failure, userId, Ip);
                unitOfWork.Save();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider => InsertLoginFailure");
            }
            return GetLoginAttampt(login.UserName);
        }
        private int GetLoginAttampt(string userName)
        {
            int count = 0;
            try
            {
                DateTime currentdatetime = AppCommon.CurrentDate.AddMinutes(-15);
                count = unitOfWork.LoginFailure.GetAll(x => x.Username == userName && x.CreatedOn > currentdatetime).Count();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider => GetLoginAttampt");
            }
            return count;
        }
        public ResponseModel InsertLoginHistory(int userId, string sessionId, string ip)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                LoginHistory history = new LoginHistory
                {
                    UserMasterId = userId,
                    LoggedInTime = AppCommon.CurrentDate,
                    Ip = sessionId,
                };
                unitOfWork.LoginHistory.Insert(history, 1, ip);
                unitOfWork.Save();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>InsertLoginHistory");
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
            }
            return model;
        }
        public UserMasterModel GetById(int id)
        {
            UserMasterModel model = new UserMasterModel();
            try
            {
                var data = unitOfWork.UserMaster.Get(x => x.UserMasterId == id);
                if (data != null)
                {
                    model = _mapper.Map<UserMasterModel>(data);
                    model.RoleName = data.Role.RoleName;
                    model.EncId = _commonProvider.Protect(id);
                }
                else
                    model = null;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>GetById");
            }
            return model;
        }
        public ResponseModel ChangeOrResetPassword(ResetPasswordModel userData, bool isChangePwd, string IP)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                userData.UserMasterId = _commonProvider.UnProtect(userData.EncId);
                var validate = ValidatePassword(userData, isChangePwd);
                if (validate.IsSuccess)
                {
                    var user = unitOfWork.UserMaster.Get(x => x.UserMasterId == userData.UserMasterId);
                    if (user != null)
                    {
                        user.UserPassword = PasswordHash.CreateHash(userData.Password);
                        unitOfWork.UserMaster.Update(user, user.UserMasterId, IP);
                        unitOfWork.Save();
                        model.Message = "Password " + (isChangePwd ? "changed" : "reset") + " successfully.";
                        model.IsSuccess = true;
                    }
                    else
                        model.Message = "User record not found";
                }
                else
                    return validate;
            }
            catch (Exception)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
            }
            return model;
        }

        public ResponseModel CreatePassword(ResetPasswordModel userData, string IP)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                userData.UserMasterId = _commonProvider.UnProtect(userData.EncId);
                var validate = ValidatePassword(userData, false);
                if (validate.IsSuccess)
                {
                    var user = unitOfWork.UserMaster.Get(x => x.UserMasterId == userData.UserMasterId);
                    if (user != null)
                    {
                        user.UserPassword = PasswordHash.CreateHash(userData.Password);
                        //user.IsPasswordCreated = true;
                        unitOfWork.UserMaster.Update(user, user.UserMasterId, IP);
                        unitOfWork.Save();
                        model.Message = "Password created successfully.";
                        model.IsSuccess = true;
                    }
                    else
                        model.Message = "User record not found";
                }
                else
                    return validate;
            }
            catch (Exception)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
            }
            return model;
        }
        public ResponseModel ValidatePassword(ResetPasswordModel userData, bool isChangePwd)
        {
            try
            {
                ResponseModel model = new ResponseModel();
                if (userData.UserMasterId == 0 && isChangePwd)
                {
                    model.IsSuccess = false;
                    model.Message = "User not exist.";
                    return model;
                }
                else if (userData.Password.Length < 8)
                {
                    model.IsSuccess = false;
                    model.Message = "Password must be 8 character long";
                    return model;
                }
                else if (userData.Password != userData.ConfirmPassword)
                {
                    model.IsSuccess = false;
                    model.Message = "New & confirm password is not matched.";
                    return model;
                }
                else
                {
                    if (isChangePwd)
                    {
                        var user = unitOfWork.UserMaster.GetAll(x => x.UserMasterId == userData.UserMasterId).FirstOrDefault();
                        if (user != null)
                        {
                            if (PasswordHash.ValidatePassword(userData.OldPassword, user.UserPassword))
                                model.IsSuccess = true;
                            else
                            {
                                model.IsSuccess = false;
                                model.Message = "Invalid old password";
                                return model;
                            }
                        }
                        else
                        {
                            model.IsSuccess = false;
                            model.Message = "User not exist.";
                            return model;
                        }
                    }
                    else
                        model.IsSuccess = true;
                }
                return model;
            }
            catch (Exception)
            {
                throw;
            }

        }
        public ResponseModel ValidatePasswordPatient(ResetPasswordModel userData, bool isChangePwd)
        {
            try
            {
                ResponseModel model = new ResponseModel();
                if (userData.UserMasterId == 0 && isChangePwd)
                {
                    model.IsSuccess = false;
                    model.Message = "User not exist.";
                    return model;
                }
                else if (userData.Password.Length < 8)
                {
                    model.IsSuccess = false;
                    model.Message = "Password must be 8 character long";
                    return model;
                }
                else if (userData.Password != userData.ConfirmPassword)
                {
                    model.IsSuccess = false;
                    model.Message = "New & confirm password is not matched.";
                    return model;
                }
                else
                {
                    if (isChangePwd)
                    {
                        var user = unitOfWork.UserMaster.GetAll(x => x.UserMasterId == userData.UserMasterId).FirstOrDefault();
                        if (user != null)
                        {
                            if (PasswordHash.ValidatePassword(userData.OldPassword, user.UserPassword))
                                model.IsSuccess = true;
                            else
                            {
                                model.IsSuccess = false;
                                model.Message = "Invalid old password";
                                return model;
                            }
                        }
                        else
                        {
                            model.IsSuccess = false;
                            model.Message = "User not exist.";
                            return model;
                        }
                    }
                    else
                        model.IsSuccess = true;
                }
                return model;
            }
            catch (Exception)
            {
                throw;
            }

        }
        public ResponseModel SendRessetPasswordMail(ForgotPasswordModel model)
        {
            ResponseModel res = new ResponseModel();
            try
            {
                var _user = unitOfWork.UserMaster.GetAll(x => x.Username == model.Username && x.IsActive).FirstOrDefault();
                if (_user != null)
                {
                    if (_user.IsActive)
                    {

                        string resetLink = AppCommon.APP_URL + "Account/Reset/" + _commonProvider.ProtectString(_user.UserMasterId.ToString() + "|" + AppCommon.CurrentDate.Ticks.ToString());

                        string mailBody = $@"Hello {_user.FirstName} {_user.LastName},<br><br>
                                    
                                        Click below link to reset your password. <br><br> 
                                        <a href='{resetLink}'>{resetLink}</a><br>   <br>                                   
                                        <b>Note:</b> Above link will expire with in 30 min.<br> 
                                        If link is not clickable then please copy and paste in your browser.<br><br>

                                        <b>Thanks & Regard</b><br>
                                        {AppCommon.ApplicationTitle}
                                    ";

                        //EmailSender.SendEmail(_user.Username, AppCommon.ApplicationTitle, "Reset Password", mailBody);
                        //TwilioAPI.SendEmail(_user.Username, AppCommon.ApplicationTitle, "Reset Password", mailBody).Wait();
                        res.IsSuccess = true;
                        res.Message = "Reset password link sent to your email. Please check your inbox/junk folder.";
                    }
                    else
                        res.Message = "'" + model.Username + "' is inactive, Please contact administrator.";
                }
                else
                    res.Message = "This email address is not registered. Please verify!";

            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>SendRessetPasswordMail");
                res.IsSuccess = false;
                res.Message = AppCommon.ErrorMessage;
            }
            return res;
        }
        public ResponseModel SendRessetPasswordMailPatient(ForgotPasswordModel model)
        {
            ResponseModel res = new ResponseModel();
            try
            {
                var _user = unitOfWork.UserMaster.GetAll(x => x.Username == model.Username && x.IsActive).FirstOrDefault();
                if (_user != null)
                {
                    if (_user.IsActive)
                    {

                        string resetLink = AppCommon.APP_URL + "Account/Reset/" + _commonProvider.ProtectString(_user.UserMasterId.ToString() + "|" + AppCommon.CurrentDate.Ticks.ToString());

                        string mailBody = $@"Hello {_user.FirstName} {_user.LastName},<br><br>
                                    
                                        Click below link to reset your password. <br><br> 
                                        <a href='{resetLink}'>{resetLink}</a><br>   <br>                                   
                                        <b>Note:</b> Above link will expire with in 30 min.<br> 
                                        If link is not clickable then please copy and paste in your browser.<br><br>

                                        <b>Thanks & Regard</b><br>
                                        {AppCommon.ApplicationTitle}
                                    ";

                        EmailSender.SendEmail(_user.Username, AppCommon.ApplicationTitle, "Reset Password", mailBody);
                        // TwilioAPI.SendEmail(_user.Username, AppCommon.ApplicationTitle, "Reset Password", mailBody).Wait();
                        res.IsSuccess = true;
                        res.Message = "Reset password link sent to your email. Please check your inbox/junk folder.";
                    }
                    else
                        res.Message = "'" + model.Username + "' is inactive, Please contact administrator.";
                }
                else
                    res.Message = "This email address is not registered. Please verify!";

            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>SendRessetPasswordMail");
                res.IsSuccess = false;
                res.Message = AppCommon.ErrorMessage;
            }
            return res;
        }

        public ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var data = unitOfWork.UserMaster.GetAll(x => x.UserMasterId == id).FirstOrDefault();
                if (data != null)
                {
                    data.IsActive = false;
                    unitOfWork.UserMaster.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
                    unitOfWork.Save();
                    model.IsSuccess = true;
                    model.Message = "User De Activated Successfully";
                }
                else
                    model.Message = "User Records not found.";
            }
            catch (Exception ex)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "UserMasterProvider=>DeActivate");
            }
            return model;
        }
        public ResponseModel ReActivate(int id, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var data = unitOfWork.UserMaster.GetAll(x => x.UserMasterId == id).FirstOrDefault();
                if (data != null)
                {
                    data.IsActive = true;
                    unitOfWork.UserMaster.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
                    unitOfWork.Save();
                    model.IsSuccess = true;
                    model.Message = "Kit Re Activated Successfully";
                }
                else
                    model.Message = "Kit Records not found.";
            }
            catch (Exception ex)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "UserMasterProvider=>ReActivate");
            }
            return model;
        }


        public DatatablePageResponseModel<UserMasterModel> GetUserList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel)
        {
            DatatablePageResponseModel<UserMasterModel> list = new DatatablePageResponseModel<UserMasterModel>()
            {
                data = new List<UserMasterModel>(),
                draw = requestModel.Draw
            };
            try
            {
                var users = unitOfWork.UserMaster.GetAll(x => x.RoleId != (short)Enumeration.Role.Super_Admin
                && x.UserMasterId != sessionProviderModel.UserId)
                    .Select(x => new UserMasterModel()
                    {
                        FirstName = x.FirstName,
                        LastName = x.LastName,
                        RoleName = x.Role.RoleName,
                        CreatedOn = x.CreatedOn,
                        IsActive = x.IsActive,
                        Username = x.Username,
                        UserMasterId = x.UserMasterId,
                        EncId = _commonProvider.Protect(x.UserMasterId),
                        RoleId = x.RoleId,
                    }).ToList();

                list.recordsTotal = users.Count();
                if (!string.IsNullOrEmpty(requestModel.SearchText))
                {
                    users = users.Where(x =>
                    x.FirstName.ToLower().Contains(requestModel.SearchText.ToLower())
                    || x.LastName.ToLower().Contains(requestModel.SearchText.ToLower())
                    || (x.RoleName ?? "").ToLower().Contains(requestModel.SearchText.ToLower())
                    || x.Username.ToLower().Contains(requestModel.SearchText.ToLower())
                    ).ToList();
                }

              
                list.recordsFiltered = users.Count();

                if (!string.IsNullOrEmpty(requestModel.SortColumnName) && !string.IsNullOrEmpty(requestModel.SortDirection))
                {
                    users = users.AsQueryable().OrderBy(requestModel.SortColumnName + " " + requestModel.SortDirection).ToList();
                }

                list.data = users.Skip(requestModel.StartIndex).Take(requestModel.PageSize).Select(x =>
                {

                    var lastLogIn = unitOfWork.LoginHistory.GetAll(c => c.UserMasterId == x.UserMasterId).OrderByDescending(c => c.UserMasterId).FirstOrDefault();
                    if (lastLogIn != null)
                        x.LastLoginTime = lastLogIn.LoggedInTime;

                    x.UserMasterId = 0;
                    return x;
                }).ToList();

            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>GetUserList");
            }
            return list;
        }
        public ResponseModel Save(UserMasterModel model, SessionProviderModel sessionProviderModel)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                if (!string.IsNullOrEmpty(model.EncId))
                    model.UserMasterId = _commonProvider.UnProtect(model.EncId);

                if (unitOfWork.UserMaster.Any(x => x.Username.ToLower() == model.Username.ToLower()
                && x.UserMasterId != model.UserMasterId))
                {
                    response.IsSuccess = false;
                    response.Message = "Email address already registred.";
                    return response;
                }

                UserMaster _temp = unitOfWork.UserMaster.Get(x => x.UserMasterId == model.UserMasterId);

                //string code = _commonProvider.GetUserCode();
                model.ContactNumber = AppCommon.RemoveExtra(model.ContactNumber);
                UserMaster user = _mapper.Map<UserMasterModel, UserMaster>(model, _temp);
                user.IsActive = true;
                // user.IsPasswordCreated = true;
                if (_temp == null)
                {
                    // user.UserCode = code;
                    user.UserPassword = PasswordHash.CreateHash(AppCommon.CommonPassword);
                    response.Message = "User added successfully";
                    unitOfWork.UserMaster.Insert(user, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                else
                {
                    response.Message = "User updated successfully";
                    unitOfWork.UserMaster.Update(user, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                unitOfWork.Save();

                if (_temp == null)
                {
                    string resetLink = AppCommon.APP_URL.Replace("patient", "portal-admin") + "Account/Reset/" + _commonProvider.ProtectString(user.UserMasterId.ToString() + "|" + AppCommon.CurrentDate.Ticks.ToString());

                    string rolename = unitOfWork.Role.Get(user.Role).RoleName;
                    string subject = $"Welcome to {AppCommon.ApplicationTitle} - Created New User Account";
                    string message = @$"Hello {user.FirstName} {user.LastName},<br><br>
                                    Welcome to {AppCommon.ApplicationTitle}, new user account created for you as <b>{rolename}</b>.<br><br>
                                    Below are your login details to access portal.<br>
                                    <b>Login URL: </b>{AppCommon.APP_URL.Replace("patient", "portal-admin")}<br>
                                    <b>Username: </b>{user.Username}<br><br>
                                    
                                    Click below link to create your password. <br><br> 
                                    <a href='{resetLink}'>{resetLink}</a><br>   <br>                                   
                                    <b>Note:</b> above link will be expired in 30 min.<br> 
                                    If this link is not clickable then please copy and paste in your browser.<br><br>
                                    Thanks<br>"
                                    + AppCommon.EmailFooterName;

                    //TwilioAPI.SendEmail(user.Username, AppCommon.ApplicationTitle, subject, message).Wait();
                }

                response.IsSuccess = true;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>Save");
                response.IsSuccess = false;
                response.Message = AppCommon.ErrorMessage;
            }
            return response;
        }

        public ResponseModel ResetAndSendPassword(int userId, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var user = unitOfWork.UserMaster.Get(x => x.UserMasterId == userId);
                if (user == null)
                {
                    model.IsSuccess = false;
                    model.Message = AppCommon.NotFound;
                    return model;
                }

                string password = AppCommon.GenerateRandomPassword(10);
                user.UserPassword = PasswordHash.CreateHash(password);
                unitOfWork.UserMaster.Update(user, sessionProviderModel.UserId, sessionProviderModel.Ip);
                unitOfWork.Save();

                string resetLink = AppCommon.APP_URL.Replace("patient", "portal-admin") + "Account/Reset/" + _commonProvider.ProtectString(user.UserMasterId.ToString() + "|" + AppCommon.CurrentDate.Ticks.ToString());

                string subject = $"Reset Password";
                string message = @$"Hello {user.FirstName} {user.LastName}<br><br>
                                    Below are your login details to logged into portal.<br>
                                    <b>Login URL: </b>{AppCommon.APP_URL.Replace("patient", "portal-admin")}<br>
                                    <b>Username: </b>{user.Username}<br>
                                    
                                    Click below link to reset your password. <br><br> 
                                    <a href='{resetLink}'>{resetLink}</a><br>   <br>                                   
                                    <b>Note:</b> above link will be expired in 30 min.<br> 
                                    If this link is not clickable then please copy and paste in your browser.<br><br>
                                    Thanks<br>"
                                    + AppCommon.EmailFooterName;

                //TwilioAPI.SendEmail(user.Username, AppCommon.ApplicationTitle, subject, message).Wait();
                model.Message = "Reset password link sent to your user's email.";
                model.IsSuccess = true;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>ResetAndSendPassword");
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
            }
            return model;
        }
        public ResponseModel ResetAndSendPasswordForPatient(int userId, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var user = unitOfWork.UserMaster.Get(x => x.UserMasterId == userId);
                if (user == null)
                {
                    model.IsSuccess = false;
                    model.Message = AppCommon.NotFound;
                    return model;
                }

                string password = AppCommon.GenerateRandomPassword(10);
                user.UserPassword = PasswordHash.CreateHash(password);
                unitOfWork.UserMaster.Update(user, sessionProviderModel.UserId, sessionProviderModel.Ip);
                unitOfWork.Save();

                string resetLink = AppCommon.APP_URL.Replace("patient", "portal-admin") + "Account/Reset/" + AppCommon.Encrypt(user.UserMasterId.ToString()) + "|" + AppCommon.CurrentDate.Ticks.ToString();

                string subject = $"Reset Password";
                string message = @$"Hello {user.FirstName} {user.LastName}<br><br>
                                    Below are your login details to logged into portal.<br>
                                    <b>Login URL: </b>{AppCommon.APP_URL.Replace("patient", "portal-admin")}<br>
                                    <b>Username: </b>{user.Username}<br>
                                    
                                    Click below link to reset your password. <br><br> 
                                    <a href='{resetLink}'>{resetLink}</a><br>   <br>                                   
                                    <b>Note:</b> above link will be expired in 30 min.<br> 
                                    If this link is not clickable then please copy and paste in your browser.<br><br>
                                    Thanks<br>"
                                    + AppCommon.EmailFooterName;

                //  TwilioAPI.SendEmail(user.Username, AppCommon.ApplicationTitle, subject, message).Wait();
                model.Message = "Reset password link sent to your user's email.";
                model.IsSuccess = true;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "UserMasterProvider=>ResetAndSendPassword");
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
            }
            return model;
        }
        #endregion


    }
}
