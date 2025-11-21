using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using AutoMapper;
using Microsoft.AspNetCore.DataProtection;
using OfficeOpenXml;
using System.Dynamic;
using System.Reflection;
using static CFP.Common.Utility.Enumeration;
using Microsoft.EntityFrameworkCore;

namespace CFP.Provider.Provider
{
    public class CommonProvider : ICommonProvider
    {
        #region Variable
        private IDataProtector _IDataProtector;
        private UnitOfWork unitOfWork = new UnitOfWork();
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public CommonProvider(IDataProtectionProvider dataProtector, IMapper mapper)
        {
            _IDataProtector = dataProtector.CreateProtector(AppCommon.Protection);
            _mapper = mapper;
        }
        #endregion

        #region Encrypt/Decrypt

        public string Protect(int value)
        {
            return _IDataProtector.Protect(value.ToString());
        }
        public string ProtectLong(long value)
        {
            return _IDataProtector.Protect(value.ToString());
        }
        public string ProtectShort(short value)
        {
            return _IDataProtector.Protect(value.ToString());
        }
        public int UnProtect(string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                string data = _IDataProtector.Unprotect(value);
                data = data ?? "0";
                return AppCommon.ConvertToInt32(data);
            }
            else
                return 0;

        }
        public string ProtectString(string value)
        {
            value = value ?? string.Empty;
            return _IDataProtector.Protect(value);
        }
        public string UnProtectString(string value)
        {
            return _IDataProtector.Unprotect(value);
        }
        public long UnProtectLong(string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                string data = _IDataProtector.Unprotect(value);
                data = data ?? "0";
                return AppCommon.ConvertToInt64(data);
            }
            else
                return 0;
        }

        #endregion

        #region Methods

        //create drop down list method for user table
        public List<DropDownModel> GetUserDropDown()
        {
            List<DropDownModel> list = new List<DropDownModel>();
            try
            {
                list = unitOfWork.UserMaster.GetAll(x => x.IsActive == true).Select(
                                       x => new DropDownModel
                                       {
                                           Text = x.FirstName + " " + x.LastName,
                                           Value = x.UserMasterId.ToString()
                                       }).OrderBy(x => x.Text).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetUserDropDown");
            }
            return list;
        }
        public List<DropDownModel> GetAgentList()
        {
            List<DropDownModel> list = new List<DropDownModel>();
            try
            {
                list = unitOfWork.AgentMaster.GetAll(x => x.IsActive == true).Select(
                                       x => new DropDownModel
                                       {
                                           Text = x.FirstName + " " + x.LastName,
                                           Value = x.AgentMasterId.ToString()
                                       }).OrderBy(x => x.Text).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetAgentList");
            }
            return list;
        }
        public List<DropDownModel> GetLeaderBoard()
        {
            List<DropDownModel> list = new List<DropDownModel>();
            try
            {
                list = unitOfWork.AgentMaster.GetAll(x => x.IsActive == true).Select(
                                       x => new DropDownModel
                                       {
                                           Text = x.FirstName + " " + x.LastName,
                                           ExtraValue = x.Deals.Where(x => x.IsActive && x.CreatedOn.Date == AppCommon.CurrentDate.Date).Sum(x => x.NoOfApplicants)
                                       }).OrderBy(x => x.Text).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetAgentList");
            }
            return list;
        }
        public int GetDealCount(SessionProviderModel sessionProviderModel)
        {
            int dealCount = 0;
            try
            {
                var dealList = unitOfWork.Deal.GetAll(x => x.IsActive);
                if (sessionProviderModel.RoleId != (short)Enumeration.Role.Super_Admin)
                    dealList = dealList.Where(x => x.AgentId == sessionProviderModel.AgentId);
                dealCount = dealList.Sum(x => x.NoOfApplicants);
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetAgentList");
            }
            return dealCount;
        }
        public List<DropDownModel> GetUserList()
        {
            List<DropDownModel> list = new List<DropDownModel>();
            try
            {


                list = unitOfWork.UserMaster.GetAll(x => x.IsActive == true).Select(
                                       x => new DropDownModel
                                       {
                                           Text = x.FirstName + " " + x.LastName,
                                           Value = x.UserMasterId.ToString()
                                       }).OrderBy(x => x.Text).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetUserList");
            }
            return list;
        }
        public List<MenuModel> GetMenuList(SessionProviderModel sessionProviderModel)
        {
            List<MenuModel> list = new List<MenuModel>();
            try
            {
                var menuList = unitOfWork.Menu.GetAll(x => x.IsActive).OrderBy(x => x.DisplayOrder).ToList();
                if (sessionProviderModel.RoleId != (int)Enumeration.Role.Super_Admin)
                {
                    menuList = menuList.Where(x => x.MenuRoles.Any(y => y.RoleId == sessionProviderModel.RoleId)).ToList();
                }
                list = _mapper.Map<List<MenuModel>>(menuList);
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetMenuList");
            }
            return list;
        }
        public bool IsAuthorized(int roleId, int menuId)
        {
            bool isAuthorized = false;
            try
            {
                if (roleId == (int)Enumeration.Role.Super_Admin)
                    isAuthorized = true;
                else
                {
                    var menu = unitOfWork.Menu.Get(x => x.MenuId == menuId);
                    if (menu != null)
                    {
                        if (menu.MenuRoles.Any(x => x.RoleId == roleId))
                            isAuthorized = true;
                    }
                }
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>IsAuthorized");
            }
            return isAuthorized;
        }
        public ResponseModel CovertExcelToModel<TDATA>(Stream file, ref List<TDATA> tDATAs) where TDATA : new()
        {
            ResponseModel returnResult = new ResponseModel();
            ExcelPackage package = new ExcelPackage();
            ExcelWorksheets currentSheet = package.Workbook.Worksheets;
            ExcelWorksheet workSheet = currentSheet.FirstOrDefault();
            try
            {
                package.Load(file);
                ImportColumnWithDataModel hwdModel = new ImportColumnWithDataModel();
                hwdModel.ColumnWithData = new List<KeyValuePair<string, List<string>>>();
                using (currentSheet = package.Workbook.Worksheets)
                {
                    using (workSheet = currentSheet.First())
                    {
                        var noOfCol = workSheet.Dimension.End.Column;
                        var noOfRow = workSheet.Dimension.End.Row;

                        //getting all column headers first
                        for (int i = 1; i <= workSheet.Dimension.End.Column; i++)
                        {
                            hwdModel.ColumnWithData.Add(new KeyValuePair<string, List<string>>(workSheet.Cells[1, i].Text.ToLower(), new List<string>()));
                        }

                        if (noOfRow <= 1)
                        {
                            returnResult.Message = "<span style='color:red'>No data available in uploaded file.</span>";
                            returnResult.IsSuccess = false;
                            return returnResult;
                        }

                        var hObj = new KeyValuePair<string, List<string>>();
                        for (int rowIterator = 2; rowIterator <= noOfRow; rowIterator++)
                        {
                            int hIndx = 1;
                            if (!IsWholeRowEmpty(workSheet, rowIterator, noOfCol))
                            {
                                foreach (var header in hwdModel.ColumnWithData)
                                {
                                    hObj = hwdModel.ColumnWithData.FirstOrDefault(t => t.Key.ToLower().Trim() == header.Key.ToLower().Trim());
                                    hObj.Value.Add(Convert.ToString(workSheet.Cells[rowIterator, hIndx].Value));
                                    hIndx++;
                                }
                            }
                        }


                        if (hwdModel != null && hwdModel.ColumnWithData != null && hwdModel.ColumnWithData.Count() > 0)
                        {
                            var DyObjectsList = new List<dynamic>();
                            int rowCount = hwdModel.ColumnWithData.FirstOrDefault().Value.Count();
                            PropertyInfo prop = null;
                            for (int i = 0; i < rowCount; i++)
                            {
                                var dynModel = new ExpandoObject() as IDictionary<string, Object>;
                                TDATA tdata = new TDATA();
                                foreach (var header in hwdModel.ColumnWithData)
                                {
                                    prop = tdata.GetType().GetProperty(GetFormattedColumnName(header.Key), BindingFlags.Public | BindingFlags.Instance);
                                    if (prop != null && prop.CanWrite)
                                        prop.SetValue(tdata, header.Value[i], null);
                                }
                                tDATAs.Add(tdata);
                            }
                        }


                    }
                }
            }

            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>CovertExcelToModel");
            }
            if (tDATAs.Any())
            {
                returnResult.Message = "Success";
                returnResult.IsSuccess = true;
            }
            else
            {
                returnResult.Message = "<span style='color:red'>No data available in uploaded file.</span>";
                returnResult.IsSuccess = true;
            }
            return returnResult;
        }
        //public List<DealChartViewModel> GetDealDataForChart(int agentId)
        //{
        //    try
        //    {

        //        var query = unitOfWork.Deal.GetAll(x =>
        //            x.IsActive &&
        //            x.CreatedOn.Date >= AppCommon.CurrentDate.AddDays(-9) &&
        //            (agentId == -1 || x.AgentId == agentId)
        //        ).ToList();

        //        var result = query
        //            .GroupBy(x => x.CreatedOn.Date)
        //            .Select(g => new DealChartViewModel
        //            {
        //                Date = g.Key.ToString("MM/dd/yyyy"),
        //                TotalDeal = g.Sum(x => x.NoOfApplicants)
        //            })
        //            .OrderBy(x => x.Date)
        //            .ToList();

        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        AppCommon.LogException(ex, "Error in GetDealDataForChart");
        //        return new List<DealChartViewModel>();
        //    }
        //}

        public List<DealChartPoint> GetDealDataForChart(int agentId)
        {
            try
            {
                var startDate = AppCommon.CurrentDate.AddDays(-10).Date;

                var query = unitOfWork.Deal.GetAll(d => d.IsActive && d.CreatedOn.Date >= startDate && (agentId == -1 || d.AgentId == agentId))
                            .Select(d => new
                            {
                                DealDate = d.CreatedOn.Date,
                                Applicants = d.NoOfApplicants,
                                AgentId = d.AgentId
                            })
                            .ToList();

                var grouped = query.GroupBy(x => x.DealDate)
                    .Select(g => new DealChartPoint
                    {
                        Date = g.Key,
                        ApplicantCount = g.Sum(x => x.Applicants),
                        DealCount = g.Count(),
                        AgentCount = g.Select(x => x.AgentId).Distinct().Count()
                    }).OrderBy(x => x.Date).ToList();

                var fullDates = Enumerable.Range(0, 10).Select(i => AppCommon.CurrentDate.AddDays(-10 + i).Date).ToList();

                var final = fullDates
                    .Select(d => grouped.FirstOrDefault(gp => gp.Date == d) ?? new DealChartPoint
                    {
                        Date = d,
                        ApplicantCount = 0,
                        DealCount = 0,
                        AgentCount = 0
                    })
                    .ToList();

                return final;
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "GetDealChartData");
                return new List<DealChartPoint>();
            }
        }



        public AgentDealDashboardViewModel GetAgentDealDashboard(int days)
        {
            try
            {
                DateTime fromDate = AppCommon.CurrentDate.AddDays(-days);

                // Fetch deals
                var deals = unitOfWork.Deal
                    .GetAll(d => d.IsActive && d.CreatedOn.Date >= fromDate)
                    .ToList();

                // Fetch agents only once
                var allAgents = unitOfWork.AgentMaster
                    .GetAll(a => a.IsActive)
                    .Select(a => new { a.AgentMasterId, a.FirstName, a.LastName })
                    .ToList();

                // Build full list with deal counts
                var agentList = allAgents
                    .Select(a =>
                    {
                        int count = deals.Where(x => x.AgentId == a.AgentMasterId).Sum(x => x.NoOfApplicants);

                        return new AgentDealChartViewModel
                        {
                            AgentId = a.AgentMasterId,
                            AgentName = $"{a.FirstName} {a.LastName}",
                            DealCount = count
                        };
                    })
                    .ToList();

                // ---------------------------
                // 1️⃣ Donut Chart List (Only agents with deals > 0)
                // ---------------------------
                var chartList = agentList
                    .Where(x => x.DealCount > 0)
                    .OrderByDescending(x => x.DealCount)
                    .ToList();

                // ---------------------------
                // 2️⃣ Top 5 Display List (Always 5)
                // ---------------------------
                var top5List = agentList
                    .OrderByDescending(x => x.DealCount > 0)
                    .ThenByDescending(x => x.DealCount)
                    .ThenBy(x => x.AgentName)
                    .Take(5)
                    .ToList();

                return new AgentDealDashboardViewModel
                {
                    ChartAgents = chartList,
                    TopAgents = top5List
                };
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "Error in GetAgentDealDashboard");
                return new AgentDealDashboardViewModel();
            }
        }

        public List<DealSummaryModel> GetDealSummary()
        {
            var summaryData = new List<DealSummaryModel>();

            try
            {
                var deals = unitOfWork.Deal.GetAll(d => d.CreatedOn >= AppCommon.CurrentDate.AddDays(-30)).ToList();

                var last7ActiveDays = deals.Select(d => d.CreatedOn.Date).Distinct().Take(7).ToList();

                summaryData = deals
                    .GroupBy(d => d.Agent.FirstName + " " + d.Agent.LastName)
                    .Select(g => new DealSummaryModel
                    {
                        AgentName = g.Key,
                        Counts = last7ActiveDays.Select(day => new DayCount
                        {
                            Date = day,
                            ApplicantCount = g.Where(d => d.CreatedOn.Date == day).Sum(d => d.NoOfApplicants),
                            DealCount = g.Count(d => d.CreatedOn.Date == day)
                        }).ToList()
                    })
                    .ToList();
            }
            catch (Exception)
            {
                throw;
            }

            return summaryData;
        }
        #endregion

        #region Email & SMS Methods
        public void SendRegistrationMail(int userMasterId)
        {
            try
            {
                var user = unitOfWork.UserMaster.Get(x => x.UserMasterId == userMasterId);
                if (user != null)
                {
                    string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ExtraFiles", "Templates", "Registration.html");
                    filePath = filePath.Replace("CFP.API", "CFP.Patient").Replace("WebAPI\\", "");

                    if (File.Exists(filePath))
                    {
                        string msgBody = File.ReadAllText(filePath);
                        msgBody = msgBody.Replace("[UserName]", user.FirstName + " " + user.LastName)
                            .Replace("[URL]", AppCommon.CFP_URL)
                            .Replace("[Email]", user.Username)
                            .Replace("[AppName]", AppCommon.ApplicationTitle);

                        string subject = $"Account Created: Get Started with {AppCommon.ApplicationTitle} Now!";
                        //if (!string.IsNullOrEmpty(msgBody))
                        //{
                        //    new Thread(() =>
                        //    {
                        //        try
                        //        {
                        //            TwilioAPI.SendEmail(user.Username, AppCommon.ApplicationTitle, subject, msgBody).Wait();

                        //        }
                        //        catch (Exception)
                        //        {
                        //        }
                        //    }).Start();
                        //}
                    }
                }
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>SendRegistrationMail");
            }
        }
        #endregion

        #region Private Methods
        private string GetFormattedColumnName(string inputstring)
        {
            return inputstring.Replace(" ", "").Replace("_", "").Replace("-", "").Replace("=", "").Replace("#", "").Replace("(", "").Replace(")", "").Replace("/", "").Replace("\\", "").Replace(".", "").Replace(":", "").Replace("<br>", "").Replace("?", "").Trim();
        }
        private bool IsWholeRowEmpty(ExcelWorksheet sheet, int rowIndex, int totalColumns)
        {
            for (int i = 1; i <= totalColumns; i++)
            {
                if (sheet.Cells[rowIndex, i].Value != null && !string.IsNullOrEmpty(sheet.Cells[rowIndex, i].Value.ToString()) && !string.IsNullOrWhiteSpace(sheet.Cells[rowIndex, i].Value.ToString()))
                    return false;
            }
            return true;
        }


        #endregion
    }
}
