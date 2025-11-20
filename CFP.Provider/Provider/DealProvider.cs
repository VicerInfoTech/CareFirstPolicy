using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using Microsoft.Extensions.Logging;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Twilio.Jwt.Taskrouter;
using Microsoft.AspNetCore.Hosting;
namespace CFP.Provider.Provider
{
    public class DealProvider : IDealProvider
    {
        #region Variable
        private UnitOfWork unitOfWork = new UnitOfWork();
        private ICommonProvider _commonProvider;
        private readonly IHostingEnvironment _hostingEnvironment;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public DealProvider(IMapper mapper, ICommonProvider commonProvider, IHostingEnvironment hostingEnvironment)
        {
            _commonProvider = commonProvider;
            _hostingEnvironment = hostingEnvironment;
            _mapper = mapper;
        }
        #endregion

        #region Method
        public DatatablePageResponseModel<DealModel> GetDealList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel)
        {
            DatatablePageResponseModel<DealModel> list = new DatatablePageResponseModel<DealModel>()
            {
                data = new List<DealModel>(),
                draw = requestModel.Draw
            };

            try
            {
                var dataList = unitOfWork.Deal.GetAll(x => x.IsActive)
                    .Select(x => new DealModel()
                    {
                        EncId = _commonProvider.Protect(x.DealId),
                        FirstName = x.FirstName,
                        LastName = x.LastName,
                        FullName = x.FirstName + " " + x.LastName,
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
                        AgentId = x.AgentId,
                        AgentName = $"{x.Agent.FirstName} {x.Agent.LastName}",
                        IsActive = x.IsActive,
                        CreatedBy = x.CreatedBy,
                        CreatedByString = x.CreatedByNavigation.FirstName + " " + x.CreatedByNavigation.LastName,
                        DealId = x.DealId,
                        RoleId = sessionProviderModel.RoleId,
                        IsShowEditBtn = sessionProviderModel.RoleId == (int)Enumeration.Role.Super_Admin ||
                                       (
                                           (sessionProviderModel.RoleId == (int)Enumeration.Role.Agent ||
                                            sessionProviderModel.RoleId == (int)Enumeration.Role.AgentLead)
                                           && x.CreatedOn.AddHours(24) >= AppCommon.CurrentDate
                                       ),
                        IsShowDelBtn = sessionProviderModel.RoleId == (int)Enumeration.Role.Super_Admin,

                    }).OrderByDescending(x => x.DealId).ToList();
                if (sessionProviderModel.RoleId != (int)Enumeration.Role.Super_Admin)
                {
                    dataList = dataList.Where(x => x.AgentId == sessionProviderModel.AgentId).ToList();
                }
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
                list.data = dataList.Skip(requestModel.StartIndex).Take(requestModel.PageSize).Select(x =>
                {
                    x.TypeOfCoverages = x.TypeOfCoverage.Split(',');
                    x.CreatedOnString = x.CreatedOn.ToString("MM/dd/yyyy hh:mm tt");
                    x.CareerName = AppCommon.GetEnumDisplayName((Enumeration.Career)x.Career);
                    x.CloseDateString = x.CloseDate.ToString("MM/dd/yyyy hh:mm tt");
                    x.DealIdString = x.DealId.ToString("000000");
                    return x;
                }).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "DealProvider=>GetUserList");
            }

            return list;
        }

        public ResponseModel Save(DealModel model, List<DealDocModel> docList, SessionProviderModel sessionProviderModel)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                if (model.NoOfApplicants == null || model.NoOfApplicants == 0)
                {
                    response.IsSuccess = false;
                    response.Message = "No. of Applicants is invalid.";
                    return response;
                }

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
                agent.TypeOfCoverage = string.Join(",", model.TypeOfCoverages);
                if (_temp == null)
                {
                    foreach (var item in docList)
                    {
                        agent.DealDocuments.Add(new DealDocument
                        {
                            DocName = item.DocName,
                            UploadedDate = DateOnly.FromDateTime(agent.CreatedOn),
                        });
                    }


                    agent.IsActive = true;
                    response.Message = "Deal added successfully";
                    unitOfWork.Deal.Insert(agent, sessionProviderModel.UserId, sessionProviderModel.Ip);
                }
                else
                {

                    var curDoc = agent.DealDocuments.ToList();
                    List<long> removedDoc = curDoc.Select(x => x.DealDocId).ToList();
                    foreach (var item in docList)
                    {
                        if (item.DealDocId > 0)
                        {
                            var tmp = curDoc.Where(x => x.DealDocId == item.DealDocId).FirstOrDefault();
                            if (tmp != null)

                                removedDoc.Remove(tmp.DealDocId);

                        }
                        else
                        {
                            agent.DealDocuments.Add(new DealDocument
                            {
                                DocName = item.DocName,
                                UploadedDate = DateOnly.FromDateTime(agent.CreatedOn),
                            });
                        }
                    }
                    if (removedDoc.Any())
                        unitOfWork.DealDocument.DeleteAll(unitOfWork.DealDocument.GetAll(x => removedDoc.Contains(x.DealDocId)));

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
                    model.TypeOfCoverages = data.TypeOfCoverage.Split(',');
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

                    var Doc = unitOfWork.DealDocument.GetAll(x => x.DealId == data.DealId).ToList();
                    if (Doc != null && Doc.Count() > 0)
                    {
                        foreach (var item in Doc)
                        {

                            string fullPath = Path.Combine(_hostingEnvironment.WebRootPath, "ExtraFiles", "DealDoc", item.DocName);
                            if (File.Exists(fullPath))
                            {
                                File.Delete(fullPath);
                            }

                        }
                        unitOfWork.DealDocument.DeleteAll(Doc);
                        unitOfWork.Save();

                    }

                    data.IsActive = false;
                    unitOfWork.Deal.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
                    unitOfWork.Save();
                    model.IsSuccess = true;
                    model.Message = "Deal deleted Successfully";
                }
                else
                    model.Message = "Deal records not found.";
            }
            catch (Exception ex)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "DealProvider=>DeActivate");
            }
            return model;
        }

        public List<DealDocModel> GetDealDocList(int id)
        {
            List<DealDocModel> dealDocModels = new List<DealDocModel>();

            var imagedata = unitOfWork.DealDocument.GetAll(x => x.DealId == id).ToList();
            foreach (var item in imagedata)
            {
                dealDocModels.Add(new DealDocModel()
                {
                    DocName = item.DocName,
                    DealId = id,
                    Tempid = dealDocModels.Count + 1,
                    DealDocId = item.DealDocId,
                    DocumentPath = "ExtraFiles/DealDoc/" + item.DocName,
                });
            }
            return dealDocModels;
        }
        #endregion
    }
}
