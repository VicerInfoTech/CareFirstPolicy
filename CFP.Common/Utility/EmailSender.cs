using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Net;
using System.Text;

namespace CFP.Common.Utility
{
    public class EmailSender
    {

        #region Variables
        //private static readonly string SMTPHost = "smtp.office365.com";
        //private static readonly int SMTPPort = 587;
        //private static readonly string SMTPUserName = "no-reply@accqdata.net";
        //private static readonly string SMTPPassword = "Florida2019!!";
        #endregion


        /// <summary>
        /// Method for sending email
        /// </summary>
        /// <param name="mailMessage"></param>
        public static void SendEmail(string ToEmail, string Name, string Subject, string Body, string CCEmail = "", string Filepath = "")
        {
            SmtpClient smtpClient = new SmtpClient(AppCommon.SMTPHost, AppCommon.SMTPPort);
            try
            {
                MailMessage mailMessage = new MailMessage
                {
                    IsBodyHtml = true,
                    Body = Body,
                    From = new MailAddress(AppCommon.SMTPUserName, Name)
                };
                mailMessage.To.Add(ToEmail);
                mailMessage.Subject = Subject;
                if (!string.IsNullOrEmpty(CCEmail))
                    mailMessage.CC.Add(CCEmail);
                if (!string.IsNullOrEmpty(Filepath))
                    mailMessage.Attachments.Add(new Attachment(Filepath));
                smtpClient.EnableSsl = true;
                smtpClient.Credentials = new NetworkCredential(AppCommon.SMTPUserName, AppCommon.SMTPPassword);
                smtpClient.Send(mailMessage);
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "EmailSender=>SendEmail");
                throw;
            }
        }

    }
}
