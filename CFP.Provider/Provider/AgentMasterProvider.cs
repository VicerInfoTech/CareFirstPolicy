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
                        Username = x.Username,
                        UserMasterId = x.UserMasterId,
                        EncId = _commonProvider.Protect(x.AgentMasterId),
                    }).ToList();

                list.recordsTotal = dataList.Count();

                // Search filter
                if (!string.IsNullOrEmpty(requestModel.SearchText))
                {
                    string search = requestModel.SearchText.ToLower();
                    dataList = dataList.Where(x =>
                        x.FirstName.ToLower().Contains(search) ||
                        x.LastName.ToLower().Contains(search) ||
                        x.Username.ToLower().Contains(search)
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

                if (unitOfWork.UserMaster.Any(x => x.Username.ToLower() == model.Username.ToLower()
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
                        Username = model.Username,
                        LastName = model.LastName,
                        FirstName = model.FirstName,
                        ContactNumber = AppCommon.RemoveExtra(model.ContactNumber),
                        RoleId = (int)Enumeration.Role.Agent,
                        IsFirstTimeLogin = true,
                        TwoStepAuth = false,
                        IsActive = true,
                    };
                    userMaster.UserPassword = PasswordHash.CreateHash(AppCommon.CommonPassword);
                    unitOfWork.UserMaster.Insert(userMaster, sessionProviderModel.UserId, sessionProviderModel.Ip);
                    unitOfWork.Save();
                    agent.UserMasterId = userMaster.UserMasterId;
                    response.Message = "Agent added successfully";
                    unitOfWork.AgentMaster.Insert(agent, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                else
                {
                    _temp.UserMaster.Username = model.Username;
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


        #endregion
    }
}
