using System.ComponentModel.DataAnnotations;
using System.Linq.Expressions;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace CFP.Common.Utility
{
    public class AppCommon
    {

        #region Variables
        public static int CommonUserId = 1;
        public static string IP = "AUTO";
        public static string ErrorMessage = "Something Went Wrong. Please Contact Administrator!";
        public static string ApplicationTitle = "Care First Policy";
        public static string Protection = "CFP";
        public static string SessionName = "CFP.Session";
        public static string ConnectionString = "";
        public static string CommonPassword = "Admin@2025";
        public static string SMTPHost = "smtp.office365.com";
        public static int SMTPPort = 587;
        public static string SMTPUserName = "";
        public static string SMTPPassword = "";
        public static string APP_URL = "";
        public static string CFP_URL = "";
        public static string NotFound = "Record not found. Please Contact Administrator!";
        public static string DateOnlyFormat = "MM/dd/yyyy";
        public static string TimeFormat = "hh:mm tt";
        public static string DateTimeFormat = "MM/dd/yyyy hh:mm tt";
        public static string DateTimeSimpleFormat = "MMddyyyyhhmmss";
        private static byte[] _salt = Encoding.ASCII.GetBytes("o6806642kbM7c5");
        private static string _encSecret = "CFP";
        public static string EmailMessage = @"";
        public static string EmailFooterName = "Care First Policy";
        public static string ErrorTempKeyName = "Temp_Error";
        public static string SuccessTempKeyName = "Temp_Success";
        #endregion

        #region Temp Data Variables
        public static string TMP_ENC_KIT_ID = "TMP_ENC_KIT_ID";
        public static string TMP_ENC_PATIENT_ID = "TMP_ENC_USER_ID";
        #endregion
        public static DateTime CurrentDate
        {
            get
            {
                return DateTime.UtcNow;
            }
        }
        public static DateTime ConvertToCST(DateTime date)
        {
            return TimeZoneInfo.ConvertTimeFromUtc(date.ToUniversalTime(), TimeZoneInfo.FindSystemTimeZoneById("Central Standard Time"));
        }
        public static void LogException(Exception ex, string source = "")
        {
            try
            {
                var TraceMsg = ex.StackTrace.ToString();
                var ErrorLineNo = TraceMsg.Substring(ex.StackTrace.Length - 7, 7);
                var ErrorMsg = ex.Message.ToString();
                var ErrorMsginDept = ex.InnerException;
                var Errortype = ex.GetType().ToString();
                var ErrorLocation = ex.Message.ToString();
                string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/LogFiles/");
                filePath = filePath.Replace("CFP.API", "CFP.Patient").Replace("WebAPI\\", "");

                if (!Directory.Exists(filePath))
                    Directory.CreateDirectory(filePath);
                filePath = filePath + AppCommon.CurrentDate.ToString("dd-MMM-yyyy") + ".txt";
                using (StreamWriter sw = File.AppendText(filePath))
                {
                    sw.WriteLine("---------------------------------------------------------------------------------------");
                    sw.WriteLine("Log date time     : " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss"));
                    sw.WriteLine("Source			: " + source);
                    sw.WriteLine("Error line number : " + ErrorLineNo);
                    sw.WriteLine("Error message     : " + ErrorMsg + ErrorLocation);
                    sw.WriteLine("Trace message     : " + TraceMsg);
                    sw.WriteLine("Inner Exception   : " + ErrorMsginDept);
                    sw.WriteLine("----------------------------------------------------------------------------------------");
                    sw.WriteLine("\n");
                    sw.Flush();
                    sw.Close();
                }
            }
            catch (IOException)
            {
                System.Threading.Thread.Sleep(100);
            }
        }
        public static void Log(string source)
        {
            try
            {
                string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/LogFiles/");
                filePath = filePath.Replace("CFP.API", "CFP.Patient").Replace("WebAPI\\", "");

                if (!Directory.Exists(filePath))
                    Directory.CreateDirectory(filePath);
                filePath = filePath + DateTime.Now.ToString("dd-MMM-yyyy") + ".txt";
                using (StreamWriter sw = File.AppendText(filePath))
                {
                    sw.WriteLine("---------------------------------------------------------------------------------------");
                    sw.WriteLine(source);
                    sw.WriteLine("----------------------------------------------------------------------------------------");
                    sw.WriteLine("\n");
                    sw.Flush();
                    sw.Close();
                }
            }
            catch (IOException)
            {
                System.Threading.Thread.Sleep(100);
            }
        }

        public static void SaveFile(string folderName, string fileName, string content)
        {
            try
            {
                string filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "ExtraFiles", folderName);
                filePath = filePath.Replace("CFP.API", "CFP.Patient").Replace("WebAPI\\", "");

                if (!Directory.Exists(filePath))
                    Directory.CreateDirectory(filePath);
                string fullPath = Path.Combine(filePath, fileName);
                if (File.Exists(fullPath))
                    File.Delete(fullPath);

                using (StreamWriter sw = File.AppendText(fullPath))
                {
                    sw.WriteLine(content);
                    sw.Flush();
                    sw.Close();
                }
            }
            catch (IOException)
            {
                System.Threading.Thread.Sleep(100);
            }
        }

        public static string RemoveExtra(string value)
        {
            if (string.IsNullOrEmpty(value)) return value;
            value = value.Replace("~", "").Replace("_", "").Replace("!", "").Replace("@", "").Replace("#", "").Replace("$", "")
                .Replace("%", "").Replace("^", "").Replace("&", "").Replace("(", "").Replace(")", "").Replace("-", "").Replace("+", "").Replace("+", "").Replace("{", "")
                .Replace("}", "").Replace("[", "").Replace("]", "").Replace("\\", "").Replace("|", "").Replace(":", "").Replace(";", "").Replace("\"", "").Replace("'", "")
                .Replace("<", "").Replace(",", "").Replace(".", "").Replace(">", "").Replace("?", "").Replace("/", "").Replace("*", "").Replace(" ", "");
            return value;
        }
        public static int ConvertToInt32(string value)
        {
            try
            {
                if (string.IsNullOrEmpty(value))
                    return 0;
                return Convert.ToInt32(value);
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public static long ConvertToInt64(string value)
        {
            try
            {
                if (string.IsNullOrEmpty(value))
                    return 0;
                return Convert.ToInt64(value);
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public static decimal ConvertToDecimal(string value)
        {
            try
            {
                if (string.IsNullOrEmpty(value))
                    return 0;
                return Convert.ToDecimal(value);
            }
            catch (Exception)
            {
                return 0;
            }
        }
        public static DateTime? ConvertToDate(string value)
        {
            try
            {
                if (string.IsNullOrEmpty(value))
                    return null;
                DateTime.TryParse(value.Replace(",", ""), out var date);
                return date;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static string ToUpper(string value)
        {
            if (!string.IsNullOrEmpty(value))
                return value.Trim().ToUpper();
            else
                return value;
        }
        public static string ToLower(string value)
        {
            if (!string.IsNullOrEmpty(value))
                return value.Trim().ToLower();
            else
                return value;
        }
        public static List<string> SplitString(string value, string delimiter)
        {
            if (!string.IsNullOrEmpty(value))
                return value.Split(delimiter).ToList();
            return new List<string>();
        }
        public static string Trim(string value)
        {
            if (!string.IsNullOrEmpty(value))
                return value.Trim();
            return value;
        }
        public static string FormatKitId(string value)
        {
            if (!string.IsNullOrEmpty(value))
            {
                value = Trim(value.Replace("-", ""));
                if (value.Length == 16)
                {
                    return $"{value.Substring(0, 6)}-{value.Substring(6, 6)}-{value.Substring(12)}";
                }
                else if (value.Length == 22)
                {
                    return $"{value.Substring(0, 6)}-{value.Substring(6, 6)}-{value.Substring(12, 6)}-{value.Substring(18)}";
                }
                else
                    return value;
            }
            return value;
        }
        public static string GetFormatedPhoneNumber(string phone)
        {
            phone = RemoveExtra(phone);
            if (!string.IsNullOrEmpty(phone) && phone != "" && phone.Trim().Length == 10)
                return string.Format("({0}) {1}-{2}", phone.Substring(0, 3), phone.Substring(3, 3), phone.Substring(6));
            return phone;
        }
        public static int GenerateRandomNumber(int start, int end)
        {
            Random random = new Random();
            return random.Next(start, end);
        }
        public static string GenerateOTP()
        {
            return GenerateRandomNumber(1, 999999).ToString("D6");
        }
        public static string GenerateRandomAlphaNumericString(int length)
        {
            string input = "ABCDEFGHJKLMNPRTUVWXYZ2345679";
            StringBuilder builder = new StringBuilder();
            char ch;
            for (int i = 0; i < length; i++)
            {
                ch = input[GenerateRandomNumber(0, input.Length)];
                builder.Append(ch);
            }
            return builder.ToString();
        }
        public static string GenerateRandomAlphaString(int length)
        {
            string input = "ABCEFGHJKLMNPQRSTUVWXYZ";
            StringBuilder builder = new StringBuilder();
            char ch;
            for (int i = 0; i < length; i++)
            {
                ch = input[GenerateRandomNumber(0, input.Length)];
                builder.Append(ch);
            }
            return builder.ToString();
        }
        public static string GenerateRandomNumberString(int length)
        {
            string input = "123456789";
            StringBuilder builder = new StringBuilder();
            char ch;
            for (int i = 0; i < length; i++)
            {
                ch = input[GenerateRandomNumber(0, input.Length)];
                builder.Append(ch);
            }
            return builder.ToString();
        }
        public static string GetFormatedZipCode(string zipCode)
        {
            if (!string.IsNullOrEmpty(zipCode))
            {
                zipCode = RemoveExtra(zipCode);
                int len = zipCode.Trim().Length;
                if (len > 5 && len <= 9)
                {
                    int pos = len - 5;
                    return string.Format("{0}-{1}", zipCode.Substring(0, 5), zipCode.Substring(5, pos));
                }
                else
                    return zipCode;
            }
            return "";
        }
        public static string FormatAddress(string addressLine1, string addressLine2, string city, string state, string zip)
        {
            var lst = new List<string> { addressLine1, addressLine2, city, state }.Where(x => !string.IsNullOrEmpty(x)).ToList(); ;
            return string.Join(",", lst) + " " + GetFormatedZipCode(zip);
        }
        public static string GenerateRandomPassword(int passLength)
        {
            var chars = "abcdefghijklmnopqrstuvwxyz@#$&ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            var random = new Random();
            var result = new string(
                Enumerable.Repeat(chars, passLength)
                          .Select(s => s[random.Next(s.Length)])
                          .ToArray());
            return result;
        }
        public static int GetOnlyNumber(string value)
        {
            string resultString = "0";
            try
            {
                resultString = Regex.Match(value, @"\d+").Value;
            }
            catch (Exception)
            {

                throw;
            }
            return Int32.Parse(resultString);
        }

        public static string GenerateUniqueKitId(string sku)
        {
            string middleForm = CurrentDate.ToString("yy") + GenerateRandomAlphaString(2)
                       + CurrentDate.ToString("MM") + GenerateRandomAlphaString(2)
                       + CurrentDate.ToString("dd") + GenerateRandomAlphaString(2);
            return sku + middleForm + GenerateRandomAlphaNumericString(4);
        }
        public static string GenerateLotNo(DateTime mfgDate, DateTime expDate)
        {
            string lotNo = "";
            switch (mfgDate.Month)
            {
                case 1: lotNo = "A"; break;
                case 2: lotNo = "B"; break;
                case 3: lotNo = "C"; break;
                case 4: lotNo = "D"; break;
                case 5: lotNo = "E"; break;
                case 6: lotNo = "F"; break;
                case 7: lotNo = "G"; break;
                case 8: lotNo = "H"; break;
                case 9: lotNo = "I"; break;
                case 10: lotNo = "J"; break;
                case 11: lotNo = "K"; break;
                case 12: lotNo = "L"; break;
                default: break;
            }
            lotNo += mfgDate.ToString("yyyy").Substring(2, 1);
            lotNo += mfgDate.ToString("dd");
            lotNo += mfgDate.ToString("yyyy").Substring(3);
            lotNo += expDate.ToString("MM");
            lotNo += expDate.ToString("yyyy").Substring(2);

            return lotNo;
        }

        public static string Decrypt(string str)
        {
            if (string.IsNullOrEmpty(str))
                return str;
            str = HttpUtility.UrlDecode(str);
            str = str.Replace(' ', '+');
            str = DecryptStringAES(str, _encSecret);
            return str;
        }
        public static string Encrypt(string str)
        {
            if (string.IsNullOrEmpty(str))
                return str;
            str = EncryptStringAES(str, _encSecret).Replace("+", " ");
            str = HttpUtility.UrlEncode(str);
            return str;
        }
        public static string EncryptStringAES(string plainText, string sharedSecret)
        {
            if (string.IsNullOrEmpty(plainText))
                throw new ArgumentNullException("plainText");
            if (string.IsNullOrEmpty(sharedSecret))
                throw new ArgumentNullException("sharedSecret");

            string outStr = null;                       // Encrypted string to return
            RijndaelManaged aesAlg = null;              // RijndaelManaged object used to encrypt the data.

            try
            {
                Rfc2898DeriveBytes key = new Rfc2898DeriveBytes(sharedSecret, _salt);
                aesAlg = new RijndaelManaged();
                aesAlg.Key = key.GetBytes(aesAlg.KeySize / 8);
                aesAlg.IV = key.GetBytes(aesAlg.BlockSize / 8);
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            swEncrypt.Write(plainText);
                        }
                    }
                    outStr = Convert.ToBase64String(msEncrypt.ToArray());
                }
            }
            finally
            {
                if (aesAlg != null)
                    aesAlg.Clear();
            }

            return outStr;
        }
        public static string DecryptStringAES(string cipherText, string sharedSecret)
        {
            if (string.IsNullOrEmpty(cipherText))
                throw new ArgumentNullException("cipherText");
            if (string.IsNullOrEmpty(sharedSecret))
                throw new ArgumentNullException("sharedSecret");

            RijndaelManaged aesAlg = null;
            string plaintext = null;

            try
            {
                Rfc2898DeriveBytes key = new Rfc2898DeriveBytes(sharedSecret, _salt);

                aesAlg = new RijndaelManaged();
                aesAlg.Key = key.GetBytes(aesAlg.KeySize / 8);
                aesAlg.IV = key.GetBytes(aesAlg.BlockSize / 8);

                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
                byte[] bytes = Convert.FromBase64String(cipherText);
                using (MemoryStream msDecrypt = new MemoryStream(bytes))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                            plaintext = srDecrypt.ReadToEnd();
                    }
                }
            }
            finally
            {
                if (aesAlg != null)
                    aesAlg.Clear();
            }

            return plaintext;
        }

        public static string GetEnumDisplayName(Enum value)
        {
            if (value == null)
            {
                return "";
            }
            var fieldInfo = value.GetType().GetField(value.ToString());
            if (fieldInfo != null)
            {
                var displayAttribute = fieldInfo.GetCustomAttribute<DisplayAttribute>();
                if (displayAttribute != null)
                {
                    return displayAttribute.Name;
                }
            }
            return value.ToString();
        }
    }

}