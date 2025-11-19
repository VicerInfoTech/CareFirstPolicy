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
using System.Collections.Generic;
using System.Text.Json;

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
            return View();
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
    }
}
