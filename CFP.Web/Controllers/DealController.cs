using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Filter;
using CFP.Web.Models;
using ImageMagick;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Collections.Generic;
using System.Drawing;
using System.Text.Json;
using static CFP.Common.Utility.Enumeration;

namespace CFP.Web.Controllers
{
    [Authorization(MenuId = 4)]
    public class DealController : BaseController
    {
        #region Variables
        IDealProvider _provider;
        private IAgentMasterProvider _agentMasterProvider;
        private static string DealDocTempKey = "DealDoc_";

        public IWebHostEnvironment _webHostEnvironment { get; }
        #endregion

        #region Constructor
        public DealController(ICommonProvider commonProvider, ISessionManager sessionManager, IDealProvider userProvider, IAgentMasterProvider agentMasterProvider, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _provider = userProvider;
            _agentMasterProvider = agentMasterProvider;
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion
        public IActionResult Index()
        {
            DashboardViewModel viewModel = new DashboardViewModel();
           viewModel.StartDate = new DateOnly(AppCommon.CurrentDate.Year, AppCommon.CurrentDate.Month, 1);
            viewModel.EndDate = DateOnly.FromDateTime(AppCommon.CurrentDate);
            return View(viewModel);
        }

        public JsonResult GetList()
        {
            return Json(_provider.GetDealList(GetPagingRequestModel(), GetSessionProviderParameters()));
        }

        public IActionResult _Details(string id, bool isView = false)
        {
            DashboardViewModel viewModel = new DashboardViewModel();
            viewModel.RoleId = _sessionManager.RoleId;
            viewModel.AgentList = GetAgentList();
            viewModel.CareerList = GetCareerList();
            viewModel.IsView = isView;
            viewModel.DealModel = _provider.GetById(_commonProvider.UnProtect(id));
            DeleteTempData(DealDocTempKey + viewModel.DealModel.DealId);
            if (string.IsNullOrEmpty(id))
            {

                viewModel.DealModel.CloseDate = AppCommon.CurrentDate;
                viewModel.DealModel.AgentId = _sessionManager.AgentId;
                viewModel.DealModel.CreatedOn = AppCommon.CurrentDate;
            }
            else
            {
                var documentList = _provider.GetDealDocList(_commonProvider.UnProtect(id));
                var setData = JsonSerializer.Serialize(documentList);
                SetDataInTemp(DealDocTempKey + _commonProvider.UnProtect(id), setData);
            }
            return PartialView(viewModel);
        }

        public JsonResult Save(DashboardViewModel model)
        {
            var data = GetDataFromTemp(DealDocTempKey + _commonProvider.UnProtect(model.DealModel.EncId));
            var documentList = new List<DealDocModel>();
            if (!string.IsNullOrEmpty(data))
                documentList = JsonSerializer.Deserialize<List<DealDocModel>>(data);
            return Json(_provider.Save(model.DealModel, documentList, GetSessionProviderParameters()));
        }

        [HttpPost]
        public JsonResult Delete(string id)
        {
            return Json(_provider.DeActivate(_commonProvider.UnProtect(id), GetSessionProviderParameters()));
        }

        public JsonResult SaveDoc(DashboardViewModel viewModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                List<IFormFile> files = new List<IFormFile>();

                files = viewModel.PictureofProblemList.ToList();

                string docFileName = "";
                int numId = _commonProvider.UnProtect(viewModel.DealModel.EncId);
                string documentFullPath = Path.Combine(_webHostEnvironment.WebRootPath, "ExtraFiles", "DealDoc");
                var data = GetDataFromTemp(DealDocTempKey + numId);
                var documentList = new List<DealDocModel>();
                if (!string.IsNullOrEmpty(data))
                    documentList = JsonSerializer.Deserialize<List<DealDocModel>>(data);
                if (documentList == null)
                    documentList = new List<DealDocModel>();
                if (!Directory.Exists(documentFullPath))
                    Directory.CreateDirectory(documentFullPath);
                foreach (var file in files)
                {


                    docFileName = file.FileName;
                    string fileName = Guid.NewGuid().ToString() + AppCommon.FileNameSeperator + docFileName;
                    string fullPath = Path.Combine(documentFullPath, fileName);

                    // Save the PDF directly
                    using (var stream = new FileStream(fullPath, FileMode.Create))
                    {
                        file.CopyTo(stream);
                    }
                    var quality = 20;
                    if (Path.GetExtension(file.FileName).ToLower() != ".pdf")
                    {
                        using (MagickImage image = new MagickImage(fullPath))

                        {
                            image.Quality = (uint)quality;
                            image.Write(fullPath);
                        }
                    }
                    documentList.Add(new DealDocModel()
                    {
                        DocName = fileName,
                        DealId = numId,
                        Tempid = documentList.Count + 1,
                        DocumentPath = "ExtraFiles/DealDoc/" + fileName,
                    });
                }
                var setData = JsonSerializer.Serialize(documentList);
                SetDataInTemp(DealDocTempKey + numId, setData);
                model.IsSuccess = true;
            }
            catch (Exception ex)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "DealController=>SaveDocument");
            }
            return Json(model);
        }

        public PartialViewResult _DealDocList(string id, bool isView)
        {
            DashboardViewModel viewModel = new DashboardViewModel();
            viewModel.IsView = isView;
            var docData = GetDataFromTemp(DealDocTempKey + _commonProvider.UnProtect(id));
            if (!string.IsNullOrEmpty(docData))
                viewModel.DealDocList = JsonSerializer.Deserialize<List<DealDocModel>>(docData);
            return PartialView(viewModel);
        }


        public JsonResult DeleteDoc(int id, string EncId)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                int dealId = _commonProvider.UnProtect(EncId);
                var data = GetDataFromTemp(DealDocTempKey + dealId);
                var documents = new List<DealDocModel>();
                if (!string.IsNullOrEmpty(data))
                    documents = JsonSerializer.Deserialize<List<DealDocModel>>(data);
                var doc = documents.FirstOrDefault(x => x.Tempid == id);
                if (doc != null)
                {
                    string documentPath = Path.Combine(_webHostEnvironment.WebRootPath, "ExtraFiles", "DealDoc", doc.DocName);
                    if (System.IO.File.Exists(documentPath))
                    {
                        // model = _MaintenanceProvider.DeleteDocument(doc.RepairMaintenanceDocumentId);
                        System.IO.File.Delete(documentPath);
                        model.Message = "Document deleted successfully";
                        model.IsSuccess = true;
                    }
                    else
                        model.Message = "Document not found";
                    documents = documents.Where(x => x.Tempid != id).ToList();
                    var setData = JsonSerializer.Serialize(documents);
                    SetDataInTemp(DealDocTempKey + dealId, setData);

                }
                else
                {
                    model.Message = "Document not found";
                    model.IsSuccess = false;
                }
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "DealController=>DeleteDocument");
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
            }
            return Json(model);
        }

        public JsonResult DownloadDealData(string searchValue,string startDate, string endDate)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                DatatablePageRequestModel model = new DatatablePageRequestModel
                {
                    StartIndex = 0,
                    PageSize = int.MaxValue,
                    SortColumnName = "DealIdString",
                    SortDirection = "DESC",
                    SearchText = searchValue,
                    StartDate= AppCommon.ConvertToDate(startDate),
                    EndDate= AppCommon.ConvertToDate(endDate)
                };

                var listData = _provider.GetDealList(model, GetSessionProviderParameters());
                if (listData != null && listData.data.Count > 0)
                {
                    string fileName = "Deal_Details_" + Guid.NewGuid().ToString() + ".xlsx";
                    string fullPath = Path.Combine(_webHostEnvironment.WebRootPath, "ExtraFiles", "Temp");

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

                        int indDealId = index++;
                        int indFullName = index++;
                        int indCoverage = index++;
                        int indApplicantNo = index++;
                        int indFfm = index++;
                        int indCareerName = index++;
                        int indWorkType = index++;
                        int indMonthIncome = index++;
                        int indNeedDoc = index++;
                        int indSocialProvided = index++;
                        int indCustLang = index++;
                        int indCloseDate = index++;
                        int indAgentName = index++;
                        int indNotes = index++;
                        int indCreatedOn = index++;
                        int indCreatedBy = index++;

                        // Header
                        workSheet.Cells[k, indDealId].Value = "Deal #";
                        workSheet.Cells[k, indFullName].Value = "Full Name";
                        workSheet.Cells[k, indCoverage].Value = "Coverage";
                        workSheet.Cells[k, indApplicantNo].Value = "# Applicants";
                        workSheet.Cells[k, indFfm].Value = "FFM";
                        workSheet.Cells[k, indCareerName].Value = "Career ";
                        workSheet.Cells[k, indWorkType].Value = "Work Type ";
                        workSheet.Cells[k, indMonthIncome].Value = "Monthly Income ";
                        workSheet.Cells[k, indNeedDoc].Value = "Documents Needed";
                        workSheet.Cells[k, indSocialProvided].Value = "Social Provided";
                        workSheet.Cells[k, indCustLang].Value = "Customer Language";
                        workSheet.Cells[k, indCloseDate].Value = "Close Date";
                        workSheet.Cells[k, indAgentName].Value = "Agent ";
                        workSheet.Cells[k, indNotes].Value = "Notes ";
                        workSheet.Cells[k, indCreatedOn].Value = "Created On";
                        workSheet.Cells[k, indCreatedBy].Value = "Created By";

                        workSheet.Cells[k, 1, k, indCreatedBy].Style.Fill.PatternType = ExcelFillStyle.Solid;
                        workSheet.Cells[k, 1, k, indCreatedBy].Style.Fill.BackgroundColor.SetColor(ColorTranslator.FromHtml("#666666"));
                        workSheet.Cells[k, 1, k, indCreatedBy].Style.Font.Color.SetColor(Color.White);
                        workSheet.Cells[k, 1, k, indCreatedBy].Style.Font.Bold = true;
                        workSheet.Cells[k, 1, k, indCreatedBy].Style.Font.Size = 11;

                        k++;

                        foreach (var item in listData.data)
                        {
                            workSheet.Cells[k, indDealId].Value = item.DealIdString;
                            workSheet.Cells[k, indFullName].Value = item.FullName;
                            workSheet.Cells[k, indCoverage].Value = string.Join(", ",
                                                                      (item.TypeOfCoverages ?? Array.Empty<string>())
                                                                          .Select(x =>
                                                                          {
                                                                              if (int.TryParse(x, out int val))
                                                                              {
                                                                                  return AppCommon.GetEnumDisplayName((Enumeration.CoverageType)val);
                                                                              }
                                                                              return "";
                                                                          })
                                                                          .Where(v => !string.IsNullOrEmpty(v)));

                            workSheet.Cells[k, indApplicantNo].Value = item.NoOfApplicants;
                            workSheet.Cells[k, indFfm].Value = item.Ffm;
                            workSheet.Cells[k, indCareerName].Value =AppCommon.GetEnumDisplayName((Career)item.Career);
                            workSheet.Cells[k, indWorkType].Value = item.TypeOfWork==1?"Full Time":"Part Time";
                            workSheet.Cells[k, indMonthIncome].Value = item.MonthlyIncome;
                            workSheet.Cells[k, indNeedDoc].Value = AppCommon.GetEnumDisplayName((DocNeeded)item.DocNeeded);
                            workSheet.Cells[k, indSocialProvided].Value =AppCommon.GetEnumDisplayName((SocialProvided)item.SocialProvided);
                            workSheet.Cells[k, indCustLang].Value = item.CustomerLanguage==1?"English": "Spanish";
                            workSheet.Cells[k, indCloseDate].Value = item.CloseDateString;
                            workSheet.Cells[k, indAgentName].Value = item.AgentName;
                            workSheet.Cells[k, indNotes].Value = item.Notes;
                            workSheet.Cells[k, indCreatedOn].Value = item.CreatedOnString;
                            workSheet.Cells[k, indCreatedBy].Value = item.CreatedByString;

                            k++;
                        }

                        workSheet.Cells.AutoFitColumns();
                        workSheet.Cells[1, 1, k - 1, indCreatedBy].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indCreatedBy].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indCreatedBy].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indCreatedBy].Style.Border.Right.Style = ExcelBorderStyle.Thin;

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
                AppCommon.LogException(ex, "DealController=>DownloadDealData");
            }

            return Json(response);
        }

    }
}
