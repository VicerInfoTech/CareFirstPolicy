using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Provider.Provider
{
    public class DealProvider : IDealProvider
    {
        #region Variable
        private UnitOfWork unitOfWork = new UnitOfWork();
        private ICommonProvider _commonProvider;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public DealProvider(IMapper mapper, ICommonProvider commonProvider)
        {
            _commonProvider = commonProvider;
            _mapper = mapper;
        }
        #endregion

        #region Method
        public DatatablePageResponseModel<DealModel> GetUserList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel)
        {
            DatatablePageResponseModel<DealModel> list = new DatatablePageResponseModel<DealModel>()
            {
                data = new List<DealModel>(),
                draw = requestModel.Draw
            };

            try
            {
                var dataList = unitOfWork.Deal.GetAll()
                    .Select(x => new DealModel()
                    {
                        EncId = _commonProvider.Protect(x.DealId),
                        FirstName = x.FirstName,
                        LastName = x.LastName,
                        TypeOfCoverage = x.TypeOfCoverage,
                        CreatedOn = x.CreatedOn,
                        NoOfApplicants = x.NoOfApplicants,
                        Ffm = x.Ffm,
                        Career = x.Career,
                        TypeOfWork = x.TypeOfWork,
                        MonthlyIncome = x.MonthlyIncome,
                        DocNeeded = x.DocNeeded,
                        SocialProvided = x.SocialProvided,
                        CustomerLanguage = x.CustomerLanguage,
                        CloseDate = x.CloseDate,
                        AgentName = $"{x.Agent.FirstName} {x.Agent.LastName}",
                        IsActive = x.IsActive,
                    }).ToList();

                list.recordsTotal = dataList.Count();

                // Search filter
                if (!string.IsNullOrEmpty(requestModel.SearchText))
                {
                    string search = requestModel.SearchText.ToLower();
                    dataList = dataList.Where(x =>
                        x.FirstName.ToLower().Contains(search) ||
                        x.LastName.ToLower().Contains(search) ||
                        x.AgentName.ToLower().Contains(search)
                    ).ToList();
                }

                list.recordsFiltered = dataList.Count();

                if (!string.IsNullOrEmpty(requestModel.SortColumnName))
                {
                    var prop = typeof(DealModel).GetProperty(requestModel.SortColumnName);
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
                AppCommon.LogException(ex, "DealProvider=>GetUserList");
            }

            return list;
        }


        public ResponseModel Save(DealModel model, SessionProviderModel sessionProviderModel)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                if (!string.IsNullOrEmpty(model.EncId))
                    model.DealId = _commonProvider.UnProtect(model.EncId);

                if (unitOfWork.Deal.Any(x => x.FirstName.ToLower() == model.FirstName.ToLower()
                && x.LastName == model.LastName && x.Career == model.Career && x.DealId != model.DealId))
                {
                    response.IsSuccess = false;
                    response.Message = "Email address already registred.";
                    return response;
                }

                var _temp = unitOfWork.Deal.Get(x => x.DealId == model.DealId);

                //string code = _commonProvider.GetUserCode();
                var agent = _mapper.Map<DealModel, Deal>(model, _temp);
                if (_temp == null)
                {
                    agent.IsActive = true;
                    response.Message = "Deal added successfully";
                    unitOfWork.Deal.Insert(agent, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                else
                {
                    response.Message = "Deal updated successfully";
                    unitOfWork.Deal.Update(agent, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                unitOfWork.Save();
                response.IsSuccess = true;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "DealProvider=>Save");
                response.IsSuccess = false;
                response.Message = AppCommon.ErrorMessage;
            }
            return response;
        }

        public DealModel GetById(int id)
        {
            DealModel model = new DealModel();
            try
            {
                var data = unitOfWork.Deal.GetAll(x => x.DealId == id).FirstOrDefault();
                if (data != null)
                {
                    model = _mapper.Map<DealModel>(data);
                    model.EncId = _commonProvider.Protect(id);
                }
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "DealProvider=>GetById");
            }
            return model;
        }
        public ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var data = unitOfWork.Deal.Get(id);
                if (data != null)
                {
                    data.IsActive = false;
                    unitOfWork.Deal.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
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
                AppCommon.LogException(ex, "DealProvider=>DeActivate");
            }
            return model;
        }
        #endregion
    }
}
