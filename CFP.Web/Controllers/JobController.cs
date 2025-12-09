using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using ImageMagick;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace CFP.Web.Controllers
{
    public class JobController : BaseController
    {
        #region Variables
        private readonly IWebHostEnvironment _webHostEnvironment;
        private static string JobDocTempKey = "JobDoc_";

        #endregion

        #region Constructor
        public JobController(ICommonProvider commonProvider, ISessionManager sessionManager, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion

        public IActionResult Medicare()
        {
            DashboardViewModel model = new DashboardViewModel()
            {
                StateList = GetStateList(),
                CareerList = GetCareerList(),
            };
            DeleteTempData(JobDocTempKey);
            return View(model);
        }

        public JsonResult SaveJobForm(DashboardViewModel model)
        {
            var data = GetDataFromTemp(JobDocTempKey);
            var documentList = new List<JobDocModel>();
            if (!string.IsNullOrEmpty(data))
                documentList = JsonSerializer.Deserialize<List<JobDocModel>>(data);
            return Json(_commonProvider.SaveJobForm(model.MedicareJobModel, documentList, GetSessionProviderParameters()));
        }


        [HttpPost]
        public JsonResult SaveDoc(IFormFile file, int docId,int stateId)
        {
            ResponseModel model = new ResponseModel();

            try
            {
                if (file == null)
                {
                    model.IsSuccess = false;
                    model.Message = "Please select a document.";
                    return Json(model);
                }

                // folder path
                string documentFullPath = Path.Combine(_webHostEnvironment.WebRootPath, "ExtraFiles", "JobDoc");
                if (!Directory.Exists(documentFullPath))
                    Directory.CreateDirectory(documentFullPath);

                // Read existing temp data
                var data = GetDataFromTemp(JobDocTempKey);
                var documentList = new List<JobDocModel>();

                if (!string.IsNullOrEmpty(data))
                    documentList = JsonSerializer.Deserialize<List<JobDocModel>>(data) ?? new List<JobDocModel>();

                // Remove existing document for same docId
                var existingDoc = documentList.FirstOrDefault(d => d.DocId == docId && d.StateId==stateId);
                if (existingDoc != null)
                {
                    string existingFilePath = Path.Combine(documentFullPath, existingDoc.DocName);
                    if (System.IO.File.Exists(existingFilePath))
                    {
                        System.IO.File.Delete(existingFilePath); // delete old file
                    }
                    documentList.Remove(existingDoc); // remove from list
                }

                // Save new file
                string originalFileName = file.FileName;
                string newFileName = $"{Guid.NewGuid()}_{originalFileName}";
                string fullPath = Path.Combine(documentFullPath, newFileName);

                using (var stream = new FileStream(fullPath, FileMode.Create))
                {
                    file.CopyTo(stream);
                }

                // compress image if not pdf
                if (Path.GetExtension(originalFileName).ToLower() != ".pdf")
                {
                    using (MagickImage image = new MagickImage(fullPath))
                    {
                        image.Quality = 20;
                        image.Write(fullPath);
                    }
                }

                // Add new document entry
                documentList.Add(new JobDocModel
                {
                    DocName = newFileName,
                    DocId = docId,
                    StateId=docId,
                });

                // Save updated list back to TEMP
                string setData = JsonSerializer.Serialize(documentList);
                SetDataInTemp(JobDocTempKey, setData);

                model.IsSuccess = true;
                model.Message = "Document uploaded successfully.";
            }
            catch (Exception ex)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "JobController=>SaveDoc");
            }

            return Json(model);
        }
    }
}
