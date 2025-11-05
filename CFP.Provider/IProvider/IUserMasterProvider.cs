using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;

namespace CFP.Provider.IProvider
{
    public interface IUserMasterProvider
    {
        AuthResultModel Authentication(LoginModel login, string sessionId, string Ip);
        ResponseModel InsertLoginHistory(int userId, string sessionId, string ip);
        UserMasterModel GetById(int id);
        ResponseModel ChangeOrResetPassword(ResetPasswordModel userData, bool isChangePwd, string IP);
        ResponseModel CreatePassword(ResetPasswordModel userData, string IP);
        ResponseModel ValidatePassword(ResetPasswordModel userData, bool isChangePwd);
         ResponseModel ValidatePasswordPatient(ResetPasswordModel userData, bool isChangePwd);
        ResponseModel SendRessetPasswordMail(ForgotPasswordModel model);
        ResponseModel SendRessetPasswordMailPatient(ForgotPasswordModel model);
        ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel);
        ResponseModel ReActivate(int id, SessionProviderModel sessionProviderModel);
        DatatablePageResponseModel<UserMasterModel> GetUserList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel);
        ResponseModel Save(UserMasterModel model, SessionProviderModel sessionProviderModel);
        ResponseModel ResetAndSendPassword(int userId, SessionProviderModel sessionProviderModel);
        ResponseModel ResetAndSendPasswordForPatient(int userId, SessionProviderModel sessionProviderModel);
    }

}
