using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using System.Linq.Dynamic.Core;
using static CFP.Common.Utility.Enumeration;

namespace CFP.Provider.Provider
{
    public class AgentMasterProvider : IAgentMasterProvider
    {
        #region Variable
        private UnitOfWork unitOfWork = new UnitOfWork();
        private ICommonProvider _commonProvider;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public AgentMasterProvider(IMapper mapper, ICommonProvider commonProvider)
        {
            _commonProvider = commonProvider;
            _mapper = mapper;
        }
        #endregion

        #region Method
        public DatatablePageResponseModel<AgentMasterModel> GetUserList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel)
        {
            DatatablePageResponseModel<AgentMasterModel> list = new DatatablePageResponseModel<AgentMasterModel>()
            {
                data = new List<AgentMasterModel>(),
                draw = requestModel.Draw
            };

            try
            {
                var dataList = unitOfWork.AgentMaster.GetAll()
                    .Select(x => new AgentMasterModel()
                    {
                        FirstName = x.FirstName,
                        LastName = x.LastName,
                        CreatedOn = x.CreatedOn,
                        IsActive = x.IsActive,
                        Email = x.Email,
                        UserMasterId = x.UserMasterId,
                        EncId = _commonProvider.Protect(x.AgentMasterId),
                        AgentMasterId=x.AgentMasterId,
                        RoleName=AppCommon.GetEnumDisplayName((Enumeration.Role)x.UserMaster.RoleId)
                    }).OrderByDescending(x=>x.AgentMasterId).ToList();

                list.recordsTotal = dataList.Count();

                // Search filter
                if (!string.IsNullOrEmpty(requestModel.SearchText))
                {
                    string search = requestModel.SearchText.ToLower();
                    dataList = dataList.Where(x =>
                        x.FirstName.ToLower().Contains(search) ||
                        x.LastName.ToLower().Contains(search) ||
                        x.Email.ToLower().Contains(search)
                    ).ToList();
                }

                // Status filter
                //if (requestModel.Status == (short)Enumeration.ActiveInActiveStatus.Active)
                //    dataList = dataList.Where(x => x.IsActive).ToList();
                //else if (requestModel.Status == (short)Enumeration.ActiveInActiveStatus.In_Active)
                //    dataList = dataList.Where(x => !x.IsActive).ToList();

                list.recordsFiltered = dataList.Count();

                // ✅ Safe Sorting (Fix)
                if (!string.IsNullOrEmpty(requestModel.SortColumnName))
                {
                    var prop = typeof(AgentMasterModel).GetProperty(requestModel.SortColumnName);
                    if (prop != null)
                    {
                        if (requestModel.SortDirection.ToLower() == "asc")
                            dataList = dataList.OrderBy(x => prop.GetValue(x, null)).ToList();
                        else
                            dataList = dataList.OrderByDescending(x => prop.GetValue(x, null)).ToList();
                    }
                }

                // Paging
                list.data = dataList.Skip(requestModel.StartIndex).Take(requestModel.PageSize).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "AgentMasterProvider=>GetUserList");
            }

            return list;
        }


        public ResponseModel Save(AgentMasterModel model, SessionProviderModel sessionProviderModel)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                if (!string.IsNullOrEmpty(model.EncId))
                    model.AgentMasterId = _commonProvider.UnProtect(model.EncId);

                if (unitOfWork.UserMaster.Any(x => x.Username.ToLower() == model.Email.ToLower()
                && x.UserMasterId != model.UserMasterId))
                {
                    response.IsSuccess = false;
                    response.Message = "Email address already registred.";
                    return response;
                }

                var _temp = unitOfWork.AgentMaster.Get(x => x.AgentMasterId == model.AgentMasterId);

                //string code = _commonProvider.GetUserCode();
                model.ContactNumber = AppCommon.RemoveExtra(model.ContactNumber);
                var agent = _mapper.Map<AgentMasterModel, AgentMaster>(model, _temp);
                agent.IsActive = true;
                if (_temp == null)
                {
                    UserMaster userMaster = new UserMaster()
                    {
                        Username = model.Email.ToLower(),
                        LastName = model.LastName,
                        FirstName = model.FirstName,
                        ContactNumber = AppCommon.RemoveExtra(model.ContactNumber),
                        RoleId = model.RoleId,
                        IsFirstTimeLogin = true,
                        TwoStepAuth = false,
                        IsActive = true,
                    };
                    userMaster.UserPassword = PasswordHash.CreateHash(AppCommon.CommonPassword);
                    unitOfWork.UserMaster.Insert(userMaster, sessionProviderModel.UserId, sessionProviderModel.Ip);
                    unitOfWork.Save();
                    agent.UserMasterId = userMaster.UserMasterId;
                    agent.Email = model.Email.ToLower();
                    response.Message = "Agent added successfully";
                    unitOfWork.AgentMaster.Insert(agent, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                else
                {
                    _temp.UserMaster.Username = model.Email;
                    _temp.UserMaster.LastName = model.LastName;
                    _temp.UserMaster.FirstName = model.FirstName;
                    _temp.UserMaster.ContactNumber = AppCommon.RemoveExtra(model.ContactNumber);
                    _temp.UserMaster.UpdatedBy = sessionProviderModel.UserId;
                    _temp.UserMaster.UpdatedOn = AppCommon.CurrentDate;

                    response.Message = "Agent updated successfully";
                    unitOfWork.AgentMaster.Update(agent, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                unitOfWork.Save();
                response.IsSuccess = true;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "AgentMasterProvider=>Save");
                response.IsSuccess = false;
                response.Message = AppCommon.ErrorMessage;
            }
            return response;
        }

        public AgentMasterModel GetById(int id)
        {
            AgentMasterModel model = new AgentMasterModel();
            try
            {
                var data = unitOfWork.AgentMaster.GetAll(x => x.AgentMasterId == id).FirstOrDefault();
                if (data != null)
                {
                    model = _mapper.Map<AgentMasterModel>(data);
                    model.EncId = _commonProvider.Protect(id);
                }
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "AgentMasterProvider=>GetById");
            }
            return model;
        }
        public ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var data = unitOfWork.AgentMaster.Get(id);
                if (data != null)
                {
                    data.IsActive = false;
                    unitOfWork.AgentMaster.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
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
                AppCommon.LogException(ex, "AgentMasterProvider=>DeActivate");
            }
            return model;
        }
        public ResponseModel ReActivate(int id, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var data = unitOfWork.AgentMaster.Get(id);
                if (data != null)
                {
                    data.IsActive = true;
                    unitOfWork.AgentMaster.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
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
                AppCommon.LogException(ex, "AgentMasterProvider=>ReActivate");
            }
            return model;
        }
        public ResponseModel ResetPassword(ResetPasswordModel userData, string IP)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                userData.UserMasterId = _commonProvider.UnProtect(userData.EncId);
                var validate = ValidatePassword(userData,false);
                if (validate.IsSuccess)
                {
                    var user = unitOfWork.UserMaster.Get(x => x.UserMasterId == userData.UserMasterId);
                    if (user != null)
                    {
                        user.UserPassword = PasswordHash.CreateHash(userData.Password);
                        unitOfWork.UserMaster.Update(user, user.UserMasterId, IP);
                        unitOfWork.Save();
                        model.Message = "Password reset successfully.";
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
        #endregion
    }
}
