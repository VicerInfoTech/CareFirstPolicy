using Azure.Core.Pipeline;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using MailKit;
using MailKit.Net.Imap;
using MailKit.Search;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Hosting;
using MimeKit;

namespace CFP.Web.Hubs
{
    public class EmailReader : BackgroundService
    {
        private readonly IHubContext<ChatHub> _hubContext;
        protected IChatProvider _chatProvider;

        public EmailReader(IHubContext<ChatHub> hubContext, IChatProvider chatProvider)
        {
            _hubContext = hubContext;
            _chatProvider = chatProvider;
        }
        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await ReadEmails();
                }
                catch (Exception ex)
                {
                    AppCommon.LogException(ex, "EmailReader");
                }
                await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
            }
        }

        private async Task ReadEmails()
        {
            string[] allowedSenders = { "no-reply@idm.cms.gov" };
            string[] subjectKeywords = { "One-time verification code" };

            var agentsList = _chatProvider.GetAgents();
            foreach (var agent in agentsList)
            {
                string email = agent.Email;
                string password = agent.EmailPassword ?? "";

                if (!string.IsNullOrEmpty(email) && !string.IsNullOrEmpty(password))
                {
                    using var client = new ImapClient();
                    client.ServerCertificateValidationCallback = (_, _, _, _) => true;
                    try
                    {
                        await client.ConnectAsync("imap.hostinger.com", 993, true);
                        await client.AuthenticateAsync(email, password);

                        var inbox = client.Inbox;
                        await inbox.OpenAsync(MailKit.FolderAccess.ReadWrite);

                        var uids = await inbox.SearchAsync(SearchQuery.NotSeen);

                        foreach (var uid in uids)
                        {
                            var message = await inbox.GetMessageAsync(uid);
                            string fromAddress = message.From.Mailboxes.FirstOrDefault()?.Address ?? "";
                            string subject = message.Subject ?? "";

                            // Filter by sender
                            if (!allowedSenders.Contains(fromAddress, StringComparer.OrdinalIgnoreCase))
                                continue; // skip email

                            // Filter by subject keywords
                            if (!subjectKeywords.Any(k => subject.Contains(k, StringComparison.OrdinalIgnoreCase)))
                                continue; // skip email

                            int fromUserId = 1;
                            int toUserId = agent.UserMasterId;
                            if (toUserId > 0 && message != null && message.TextBody != null)
                            {
                                string mailbody = message.TextBody;
                                var response = _chatProvider.SaveMessage(fromUserId, toUserId, mailbody);

                                // Send to receiver if connected
                                var receiverConnectionId = _chatProvider.GetConnectionId(toUserId);
                                if (!string.IsNullOrEmpty(receiverConnectionId) && response != null)
                                {
                                    await _hubContext.Clients.Client(receiverConnectionId).SendAsync("ReceiveMessage", new
                                    {
                                        MessageId = response.ChatMessageId,
                                        FromUserId = fromUserId,
                                        ToUserId = toUserId,
                                        Message = mailbody,
                                        SentAt = AppCommon.CurrentDate,
                                        isOwnMessage = false,
                                        response.SenderName
                                    });
                                }
                            }

                            // Mark as read
                            await inbox.AddFlagsAsync(uid, MailKit.MessageFlags.Seen, true);
                        }
                    }
                    catch (Exception ex)
                    {
                        AppCommon.LogException(ex, "EmailReader=>" + email);
                    }
                    finally
                    {
                        if (client.IsConnected)
                            await client.DisconnectAsync(true);
                    }
                }
            }
        }
    }
}
