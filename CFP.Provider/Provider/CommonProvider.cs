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
                                           ExtraValue = x.Deals.Count()
                                       }).OrderBy(x => x.Text).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "CommonProvider=>GetAgentList");
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

        //public bool IsAuthorized(int roleId, int menuId)
        //{
        //    bool isAuthorized = false;
        //    try
        //    {
        //        if (roleId == (int)Enumeration.Role.Super_Admin)
        //            isAuthorized = true;
        //        else
        //        {
        //            var menu = unitOfWork.Menu.Get(x => x.MenuId == menuId);
        //            if (menu != null)
        //            {
        //                if (menu.MenuRole.Any(x => x.RoleId == roleId))
        //                    isAuthorized = true;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        AppCommon.LogException(ex, "CommonProvider=>IsAuthorized");
        //    }
        //    return isAuthorized;
        //}


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
