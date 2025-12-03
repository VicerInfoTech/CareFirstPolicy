using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Filter;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.ComponentModel;
using System.Drawing;
using LicenseContext = OfficeOpenXml.LicenseContext;

namespace CFP.Web.Controllers
{
    [Authorization(MenuId = 3)]
    public class AgentController : BaseController
    {
        #region Variables
        IAgentMasterProvider _provider;
        private readonly IWebHostEnvironment _hostingEnvironment;
        #endregion

        #region Constructor
        public AgentController(ICommonProvider commonProvider, ISessionManager sessionManager, IAgentMasterProvider userProvider, IWebHostEnvironment hostingEnvironment) : base(commonProvider, sessionManager)
        {
            _provider = userProvider;
            _hostingEnvironment = hostingEnvironment;
        }
        #endregion
        public IActionResult Index()
        {
            return View();
        }

        public JsonResult GetList()
        {
            return Json(_provider.GetUserList(GetPagingRequestModel(), GetSessionProviderParameters()));
        }

        public IActionResult _Details(string id)
        {
            AgentViewModel agentViewModel = new AgentViewModel();
            agentViewModel.AgentMasterModel = _provider.GetById(_commonProvider.UnProtect(id));
            agentViewModel.AppMasterModels = _commonProvider.GetAppsList();
            return PartialView(agentViewModel);
        }

        public JsonResult Save(AgentViewModel model)
        {
            return Json(_provider.Save(model.AgentMasterModel, GetSessionProviderParameters()));
        }

        [HttpPost]
        public JsonResult DeActivate(string id)
        {
            return Json(_provider.DeActivate(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
        }

        [HttpPost]
        public JsonResult ReActivate(string id)
        {
            return Json(_provider.ReActivate(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
        }

        [HttpGet]
        public PartialViewResult _Reset(int id)
        {
            ResetPasswordModel model = new ResetPasswordModel() { EncId = _commonProvider.Protect(id) };
            return PartialView(model);
        }

        [HttpPost]
        public JsonResult ResetPassword(ResetPasswordModel model)
        {
            return Json(_provider.ResetPassword(model, _sessionManager.GetIP()));
        }


        public JsonResult DownloadAgentData(string searchValue)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                DatatablePageRequestModel model = new DatatablePageRequestModel
                {
                    StartIndex = 0,
                    PageSize = int.MaxValue,
                    SortColumnName = "FirstName",
                    SortDirection = "ASC",
                    SearchText = searchValue,
                };

                var listData = _provider.GetUserList(model, GetSessionProviderParameters());
                if (listData != null && listData.data.Count > 0)
                {
                    string fileName = "Agent_Details_" + Guid.NewGuid().ToString() + ".xlsx";
                    string fullPath = Path.Combine(_hostingEnvironment.WebRootPath, "ExtraFiles", "Temp");

                    if (!Directory.Exists(fullPath))
                        Directory.CreateDirectory(fullPath);

                    fullPath = Path.Combine(fullPath, fileName);

                    if (System.IO.File.Exists(fullPath))
                        System.IO.File.Delete(fullPath);

                    ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

                    using (ExcelPackage package = new ExcelPackage(new FileInfo(fullPath)))
                    {
                        var workSheet = package.Workbook.Worksheets.Add("Sheet1");

                        int index = 1;
                        int k = 1;

                        int indFName = index++;
                        int indLName = index++;
                        int indEmail = index++;
                        int indRole = index++;
                        int indStatus = index++;

                        // Header
                        workSheet.Cells[k, indFName].Value = "First Name";
                        workSheet.Cells[k, indLName].Value = "Last Name";
                        workSheet.Cells[k, indEmail].Value = "Email";
                        workSheet.Cells[k, indRole].Value = "Role";
                        workSheet.Cells[k, indStatus].Value = "Status";

                        workSheet.Cells[k, 1, k, indStatus].Style.Fill.PatternType = ExcelFillStyle.Solid;
                        workSheet.Cells[k, 1, k, indStatus].Style.Fill.BackgroundColor.SetColor(ColorTranslator.FromHtml("#666666"));
                        workSheet.Cells[k, 1, k, indStatus].Style.Font.Color.SetColor(Color.White);
                        workSheet.Cells[k, 1, k, indStatus].Style.Font.Bold = true;
                        workSheet.Cells[k, 1, k, indStatus].Style.Font.Size = 11;

                        k++;

                        foreach (var item in listData.data)
                        {
                            workSheet.Cells[k, indFName].Value = item.FirstName;
                            workSheet.Cells[k, indLName].Value = item.LastName;
                            workSheet.Cells[k, indEmail].Value = item.Email;
                            workSheet.Cells[k, indRole].Value = item.RoleName;

                            var cell = workSheet.Cells[k, indStatus];
                            cell.Value = item.IsActive ? "Active" : "InActive";

                            // Status color handling
                            cell.Style.Fill.PatternType = ExcelFillStyle.Solid;

                            if (item.IsActive)
                            {
                                cell.Style.Fill.BackgroundColor.SetColor(Color.LightGreen);
                                cell.Style.Font.Color.SetColor(Color.DarkGreen);
                            }
                            else
                            {
                                cell.Style.Fill.BackgroundColor.SetColor(Color.LightPink);
                                cell.Style.Font.Color.SetColor(Color.DarkRed);
                            }

                            k++;
                        }

                        workSheet.Cells.AutoFitColumns();
                        workSheet.Cells[1, 1, k - 1, indStatus].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indStatus].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indStatus].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indStatus].Style.Border.Right.Style = ExcelBorderStyle.Thin;

                        package.Save();
                        response.IsSuccess = true;
                        response.Message = Url.Content("~/ExtraFiles/Temp/" + fileName);
                    }
                }
                else
                {
                    response.IsSuccess = false;
                    response.Message = "No data available to download";
                }
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "AgentController=>DownloadAgentData");
            }

            return Json(response);
        }


    }
}
