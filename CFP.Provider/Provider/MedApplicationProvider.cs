using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static CFP.Common.Utility.Enumeration;

namespace CFP.Provider.Provider
{
    public class MedApplicationProvider : IMedApplicationProvider
    {
        #region Variable
        private UnitOfWork unitOfWork = new UnitOfWork();
        private ICommonProvider _commonProvider;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public MedApplicationProvider(IMapper mapper, ICommonProvider commonProvider)
        {
            _commonProvider = commonProvider;
            _mapper = mapper;
        }
        #endregion

        public DatatablePageResponseModel<MedicareJobModel> GetApplicationList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel)
        {
            DatatablePageResponseModel<MedicareJobModel> list = new DatatablePageResponseModel<MedicareJobModel>()
            {
                data = new List<MedicareJobModel>(),
                draw = requestModel.Draw
            };

            try
            {
                var dataList = unitOfWork.MedicareJobApplication.GetAll()
                    .Select(x => new MedicareJobModel()
                    {
                        JobApplicationId = x.JobApplicationId,
                        FirstName = x.FirstName,
                        LastName = x.LastName,
                        CreatedOn = x.CreatedOn,
                        IsActive = x.IsActive,
                        Email = x.Email,
                        PhoneNo = x.PhoneNo,
                        Dob = x.Dob,
                        StateLicence = x.StateLicence,
                        Status= x.Status,
                    }).OrderBy(x => x.FirstName).ToList();

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

                list.recordsFiltered = dataList.Count();

                // ✅ Safe Sorting (Fix)
                //if (!string.IsNullOrEmpty(requestModel.SortColumnName))
                //{
                //    var prop = typeof(AgentMasterModel).GetProperty(requestModel.SortColumnName);
                //    if (prop != null)
                //    {
                //        if (requestModel.SortDirection.ToLower() == "asc")
                //            dataList = dataList.OrderBy(x => prop.GetValue(x, null)).ToList();
                //        else
                //            dataList = dataList.OrderByDescending(x => prop.GetValue(x, null)).ToList();
                //    }
                //}

                // Paging

                list.data = dataList.Skip(requestModel.StartIndex).Take(requestModel.PageSize).ToList().Select(x =>
                {
                    x.EncJobApplicationId = _commonProvider.ProtectLong(x.JobApplicationId);
                    var stateList = unitOfWork.State.GetAll(s => s.IsActive).ToList();

                    var stateIds = x.StateLicence?.Split(',') ?? Array.Empty<string>();

                    x.StateLicence = string.Join(",", stateList.Where(s => stateIds.Contains(s.StateId.ToString())).Select(s => s.StateName)
                    );
                    x.DobString = x.Dob.ToString("MM/dd/yyyy");
                    x.CreatedOnString = x.CreatedOn.ToString("MM/dd/yyyy");
                    return x;
                }).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "MedApplicationProvider=>GetApplicationList");
            }

            return list;
        }

        public MedicareJobModel GetApplicationById(int id)
        {
            MedicareJobModel model = new MedicareJobModel();
            try
            {
                var jobData = unitOfWork.MedicareJobApplication.Get(id);
                if (jobData != null)
                {

                    model = _mapper.Map<MedicareJobModel>(jobData);

                    model.CreatedOnString = jobData.CreatedOn.ToString("MM/dd/yyyy");
                    model.DobString = jobData.Dob.ToString("MM/dd/yyyy");
                    model.StateName = jobData.State.StateName;
                    var state = unitOfWork.State.GetAll().ToList();
                    foreach (var item in model.MedicareJobApplicationsDocs)
                    {
                        item.StateName = state.Where(x => x.StateId == item.StateId).FirstOrDefault().StateName;
                       
                    }
                    if (!string.IsNullOrEmpty(jobData.Carrer))
                    {
                        var careerValues = jobData.Carrer.Split(',');  // "1,3" → ["1","3"]

                        var careerNames = careerValues
                            .Select(x =>
                            {
                                if (int.TryParse(x, out int val))
                                {
                                    return AppCommon.GetEnumDisplayName((Career)val);
                                }
                                return string.Empty;
                            })
                            .Where(s => !string.IsNullOrEmpty(s))
                            .ToList();

                        model.Carrer = string.Join(", ", careerNames);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return model;
        }

      public  ResponseModel SaveStatus(MedicareJobModel model, SessionProviderModel sessionProviderModel)
        {
            ResponseModel response= new ResponseModel();    
            try
            {
                var jobData = unitOfWork.MedicareJobApplication.Get(_commonProvider.UnProtect(model.EncJobApplicationId));
                if (jobData != null) { 
                   jobData.Status= model.Status;
                    jobData.Comment= model.Comment;
                    unitOfWork.MedicareJobApplication.Update(jobData);
                    unitOfWork.Save();
                    response.Message = "Job application status updated successfully";
                    response.IsSuccess = true;
                }
            }
            catch (Exception)
            {
                response.Message = "Something went wrong";
                response.IsSuccess = false;
                throw;
            }
            return response;
        }


    }
}
