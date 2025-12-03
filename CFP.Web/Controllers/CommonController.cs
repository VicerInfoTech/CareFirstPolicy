using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Patient.Controllers;
using CFP.Provider.IProvider;
using CFP.Web.Models;
using Microsoft.AspNetCore.Mvc;
using OfficeOpenXml;
using OfficeOpenXml.FormulaParsing.Utilities;
using OfficeOpenXml.Style;
using System.Drawing;

namespace CFP.Web.Controllers
{
    public class CommonController : BaseController
    {
        #region Variables
        IUserMasterProvider _userProvider;
        IWebHostEnvironment _webHostEnvironment;
        #endregion

        #region Constructor
        public CommonController(ICommonProvider commonProvider, ISessionManager sessionManager, IUserMasterProvider userProvider, IWebHostEnvironment webHostEnvironment) : base(commonProvider, sessionManager)
        {
            _userProvider = userProvider;
            _webHostEnvironment = webHostEnvironment;
        }
        #endregion

        #region Methods
        public PartialViewResult _ChangePassword(int id)
        {
            string encId = "";
            bool IsAgent = false;
            if (id > 0)
            {
                encId = _commonProvider.Protect(id);
                IsAgent = true;
            }
            else
                encId = _commonProvider.Protect(_sessionManager.UserId);
            ResetPasswordModel model = new ResetPasswordModel() { EncId = encId, IsAgent = IsAgent };
            return PartialView("_ChangePassword", model);
        }
        [HttpPost]
        public JsonResult ChangePassword(ResetPasswordModel model)
        {
            return Json(_userProvider.ChangeOrResetPassword(model, true, _sessionManager.GetIP()));
        }
        public IActionResult ChatHistory()
        {
            ViewBag.IsAuthenticated = User.Identity.IsAuthenticated;
            DashboardViewModel model = new DashboardViewModel()
            {
                AgentList = GetSelectUserList(),
                RoomList = GetRoomList(),
                StartDate = new DateOnly(AppCommon.CurrentDate.Year, AppCommon.CurrentDate.Month, 1),
                EndDate = DateOnly.FromDateTime(AppCommon.CurrentDate),
            };
            return View(model);
        }

        public JsonResult GetChatHistoryList()
        {
            return Json(_commonProvider.GetChatHistoryList(GetPagingRequestModel(), GetSessionProviderParameters()));
        }

        public IActionResult ShowNotification()
        {
            DashboardViewModel viewModel = new DashboardViewModel();
            viewModel.NotificationList = _commonProvider.GetNotification(GetSessionProviderParameters());
            return PartialView("_Notification", viewModel);
        }

        public JsonResult DownloadChatHistData(string searchValue, int chatTypeValue, int fromValue, DateTime? startDate, DateTime? endDate, int toUserValue, int roomIdValue, int msgTypeValue)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                DatatablePageRequestModel model = new DatatablePageRequestModel
                {
                    StartIndex = 0,
                    PageSize = int.MaxValue,
                    SortColumnName = "SendAtString",
                    SortDirection = "ASC",
                    SearchText = searchValue,
                    ChatTypeId = chatTypeValue,
                    FromUserId = fromValue,
                    StartDate = startDate,
                    EndDate = endDate,
                    ToUserId = toUserValue,
                    RoomId = roomIdValue,
                    MsgTypeId = msgTypeValue,
                };

                var listData = _commonProvider.GetChatHistoryList(model, GetSessionProviderParameters());
                if (listData != null && listData.data.Count > 0)
                {
                    string fileName = "Chat_History_" + Guid.NewGuid().ToString() + ".xlsx";

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

                        int indSendTime = index++;
                        int indSenderName = index++;
                        int indReceiverName = index++;
                        int indMessage = index++;
                        int indMessageType = index++;

                        // Header
                        workSheet.Cells[k, indSendTime].Value = "Send Time";
                        workSheet.Cells[k, indSenderName].Value = "Sender Name";
                        workSheet.Cells[k, indReceiverName].Value = "Receiver Name";
                        workSheet.Cells[k, indMessage].Value = "Message ";
                        workSheet.Cells[k, indMessageType].Value = "Message Type";

                        workSheet.Cells[k, 1, k, indMessageType].Style.Fill.PatternType = ExcelFillStyle.Solid;
                        workSheet.Cells[k, 1, k, indMessageType].Style.Fill.BackgroundColor.SetColor(ColorTranslator.FromHtml("#666666"));
                        workSheet.Cells[k, 1, k, indMessageType].Style.Font.Color.SetColor(Color.White);
                        workSheet.Cells[k, 1, k, indMessageType].Style.Font.Bold = true;
                        workSheet.Cells[k, 1, k, indMessageType].Style.Font.Size = 11;

                        k++;

                        foreach (var item in listData.data)
                        {
                            workSheet.Cells[k, indSendTime].Value = item.SendAtString;
                            workSheet.Cells[k, indSenderName].Value = item.SenderName;
                            workSheet.Cells[k, indMessage].Value = item.Message;
                            workSheet.Cells[k, indMessageType].Value = item.IsAttachment ? "Media" : "Text";
                            var cell = workSheet.Cells[k, indReceiverName];
                            cell.Value = item.ReceiverName;

                            // Status color handling
                            cell.Style.Fill.PatternType = ExcelFillStyle.Solid;

                            if (item.ChatRoomId != 0)
                            {
                                cell.Style.Fill.BackgroundColor.SetColor(Color.LightGreen);
                                cell.Style.Font.Color.SetColor(Color.DarkGreen);
                            }
                            else
                                cell.Style.Fill.PatternType = ExcelFillStyle.None; // optional


                            k++;
                        }

                        workSheet.Cells.AutoFitColumns();
                        workSheet.Cells[1, 1, k - 1, indMessageType].Style.Border.Top.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indMessageType].Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indMessageType].Style.Border.Left.Style = ExcelBorderStyle.Thin;
                        workSheet.Cells[1, 1, k - 1, indMessageType].Style.Border.Right.Style = ExcelBorderStyle.Thin;

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
                AppCommon.LogException(ex, "CommonController=>DownloadChatHistData");
            }

            return Json(response);
        }
        #endregion
    }
}
