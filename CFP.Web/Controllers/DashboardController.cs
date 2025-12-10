using AspNetCoreGeneratedDocument;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Provider.Provider;
using CFP.Web.Filter;
using CFP.Web.Models;
using ImageMagick;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;
using OfficeOpenXml.FormulaParsing.Excel.Functions.DateTime;
using OfficeOpenXml.Style;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Text.Json;
using Twilio.Types;

namespace CFP.Web.Controllers
{

    [Authorization(MenuId = 1)]
    public class DashboardController : BaseController
    {

        #region Variables
        IUserMasterProvider _userProvider;
        private readonly IWebHostEnvironment _webHostEnvironment;
        private static string JobDocTempKey = "JobDoc_";

        #endregion

        #region Constructor
        public DashboardController(ICommonProvider commonProvider, ISessionManager sessionManager, IUserMasterProvider userProvider, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _userProvider = userProvider;
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion

        #region Methods
        public IActionResult Index()
        {
            ViewBag.IsAuthenticated = User.Identity.IsAuthenticated;
            DashboardViewModel model = new DashboardViewModel()
            {
                RoleId = _sessionManager.RoleId,
                AgentId = _sessionManager.AgentId,
                UserAccess = _sessionManager.UserAccess,
                DealCount = _commonProvider.GetDealCount(GetSessionProviderParameters()),
                IsLogin = TempData["IsLogin"] != null,
                StartDate = new DateOnly(AppCommon.CurrentDate.Year, AppCommon.CurrentDate.Month, 1),
                EndDate = DateOnly.FromDateTime(AppCommon.CurrentDate),
                DealStartDate = DateOnly.FromDateTime(AppCommon.CurrentDate.AddDays(-5)),
                DealEndDate = DateOnly.FromDateTime(AppCommon.CurrentDate),
                AgentList = GetAgentList()
            };
            return View(model);
        }
        public JsonResult SaveTempFilter(string KitId, string PatientId)
        {
            SetDataInTemp(AppCommon.TMP_ENC_KIT_ID, KitId);
            SetDataInTemp(AppCommon.TMP_ENC_PATIENT_ID, PatientId);
            return Json(true);
        }
        public JsonResult LeaderBoard(string startDate)
        {
            return Json(_commonProvider.GetLeaderBoard(startDate).Select(x => new { x.Text, x.ExtraValue }).OrderByDescending(x => x.ExtraValue).ToList());
        }
        public JsonResult FetchDealData(int agentId)
        {
            var chartData = _commonProvider.GetDealDataForChart(agentId);
            var payload = chartData.Select(d => new
            {
                date = d.Date.ToString("MM/dd/yyyy"), // consistent client format
                label = d.DateLabel,
                applicantCount = d.ApplicantCount,
                dealCount = d.DealCount,
                agentCount = d.AgentCount
            }).ToList();
            return Json(payload);
        }

        [HttpPost]
        public JsonResult FetchDealDataAllAgents(string startDate, string endDate)
        {
            return Json(_commonProvider.GetAgentDealDashboard(startDate, endDate));
        }


        //public IActionResult LoadAppSelector()
        //{
        //    DashboardViewModel viewModel = new DashboardViewModel();
        //    viewModel.AgentAppList = _commonProvider.GetAgentAppList(GetSessionProviderParameters());

        //    return PartialView("_SelectAppPartial", viewModel);
        //}
        public IActionResult UpdateAppId(int appId = 0)
        {
            //if (appId == 2)
            //{
            //    _sessionManager.AppId = appId;
            //    return RedirectToAction("Index", "Dashboard", new { area = "Medicare" });
            //}

            if (appId != 0)
                _sessionManager.AppId = appId;

            return RedirectToAction("Index", "Dashboard", new { area = "" }); // default area
        }


        public IActionResult DealSummary(string startDate, string endDate)
        {
            DashboardViewModel viewModel = new DashboardViewModel();
            viewModel.DealSummaryList = _commonProvider.GetDealSummary(startDate, endDate);

            return PartialView(viewModel);
        }
        public JsonResult DownloadDealSummaryData(string startDate, string endDate)
        {
            ResponseModel response = new ResponseModel();

            try
            {
                var listData = _commonProvider.GetDealSummary(startDate, endDate);

                if (listData == null || listData.Count == 0)
                {
                    response.IsSuccess = false;
                    response.Message = "No data available to download";
                    return Json(response);
                }

                string fileName = "Deal_Summary_" + Guid.NewGuid() + ".xlsx";
                string fullPath = Path.Combine(_webHostEnvironment.WebRootPath, "ExtraFiles", "Temp");

                if (!Directory.Exists(fullPath))
                    Directory.CreateDirectory(fullPath);

                fullPath = Path.Combine(fullPath, fileName);

                if (System.IO.File.Exists(fullPath))
                    System.IO.File.Delete(fullPath);

                ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

                using (ExcelPackage package = new ExcelPackage(new FileInfo(fullPath)))
                {
                    var ws = package.Workbook.Worksheets.Add("Deal Summary");

                    int row = 1;
                    int col = 1;

                    // -----------------------------
                    // HEADER ROW 1 (Dates merged)
                    // -----------------------------
                    ws.Cells[row, col].Value = "Agent Name";
                    ws.Cells[row, col, row + 1, col].Merge = true; // merge for two rows
                    ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    ws.Cells[row, col].Style.VerticalAlignment = ExcelVerticalAlignment.Center;

                    col++;

                    var firstAgentCounts = listData.First().Counts;

                    foreach (var day in firstAgentCounts)
                    {
                        // Merge 2 columns for each date
                        ws.Cells[row, col, row, col + 1].Merge = true;
                        ws.Cells[row, col].Value = day.Date.ToString("dd-MMM-yyyy");
                        ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        ws.Cells[row, col].Style.VerticalAlignment = ExcelVerticalAlignment.Center;

                        col += 2;
                    }

                    // -----------------------------
                    // HEADER ROW 2 (Forms / Deals)
                    // -----------------------------
                    row++;
                    col = 2; // start after Agent Name

                    foreach (var day in firstAgentCounts)
                    {
                        ws.Cells[row, col].Value = "Forms";
                        ws.Cells[row, col + 1].Value = "Deals";

                        ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        ws.Cells[row, col + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                        col += 2;
                    }

                    // -----------------------------
                    // Apply header styling
                    // -----------------------------
                    using (var rng = ws.Cells[1, 1, 2, col - 1])
                    {
                        rng.Style.Fill.PatternType = ExcelFillStyle.Solid;
                        rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(240, 240, 240));
                        rng.Style.Font.Bold = true;
                        rng.Style.Border.BorderAround(ExcelBorderStyle.Thin);
                    }

                    // -----------------------------
                    // BODY ROWS
                    // -----------------------------
                    row++;
                    foreach (var agent in listData.OrderBy(x => x.AgentName))
                    {
                        col = 1;

                        ws.Cells[row, col].Value = agent.AgentName;
                        col++;

                        foreach (var c in agent.Counts)
                        {
                            ws.Cells[row, col].Value = c.DealCount > 0 ? c.DealCount : (object)"";
                            ws.Cells[row, col + 1].Value = c.ApplicantCount > 0 ? c.ApplicantCount : (object)"";

                            ws.Cells[row, col].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                            ws.Cells[row, col + 1].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                            col += 2;
                        }

                        row++;
                    }

                    // -----------------------------
                    // Borders
                    // -----------------------------
                    using (var rng = ws.Cells[1, 1, row - 1, col - 1])
                    {
                        rng.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        rng.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        rng.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        rng.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    }

                    ws.Cells.AutoFitColumns();
                    package.Save();
                }

                response.IsSuccess = true;
                response.Message = Url.Content("~/ExtraFiles/Temp/" + fileName);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = "Error occurred while generating file";
                AppCommon.LogException(ex, "DownloadDealSummaryData");
            }

            return Json(response);
        }



        #endregion
    }
}
