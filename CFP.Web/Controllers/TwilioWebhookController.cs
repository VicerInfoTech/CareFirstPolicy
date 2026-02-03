using System;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Web.Hubs;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Primitives;
using Twilio.Security;
using Twilio.TwiML;
using Twilio.TwiML.Messaging;

namespace CFP.Web.Controllers
{
    [ApiController]
    [Route("api/twilio")]
    public class TwilioWebhookController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly IHubContext<ChatHub> _hubContext;
        protected IChatProvider _chatProvider;
        public TwilioWebhookController(
       IConfiguration config,
       IHubContext<ChatHub> hubContext,
       IChatProvider chatProvider)
        {
            _config = config;
            _hubContext = hubContext;
            _chatProvider = chatProvider;
        }

        [HttpPost("inbound-sms")]
        public async Task<IActionResult> ReceiveSms([FromForm] TwilioInboundSmsDto sms)
        {

            // 1️⃣ Validate Twilio signature
            if (!IsValidTwilioRequest())
            {
                AppCommon.Log("Invalid Twilio request signature." + Environment.NewLine
                    + "From:" + sms.From + Environment.NewLine
                    + "To:" + sms.To + Environment.NewLine
                    + "Message:" + sms.Body + Environment.NewLine);
                return Unauthorized();
            }

            int fromUserId = 1;
            int toUserId = _chatProvider.GetAgentByTwilio(sms.To);
            if (toUserId > 0)
            {
                string message = sms.Body;
                var response = _chatProvider.SaveMessage(fromUserId, toUserId, message);

                // Send to receiver if connected
                var receiverConnectionId = _chatProvider.GetConnectionId(toUserId);
                if (!string.IsNullOrEmpty(receiverConnectionId) && response != null)
                {
                    await _hubContext.Clients.Client(receiverConnectionId).SendAsync("ReceiveMessage", new
                    {
                        MessageId = response.ChatMessageId,
                        FromUserId = fromUserId,
                        ToUserId = toUserId,
                        Message = message,
                        SentAt = AppCommon.CurrentDate,
                        isOwnMessage = false,
                        response.SenderName
                    });
                }

                return Content("Success", "application/xml");
            }
            else
                return Content("Agent not found", "application/xml");
        }

        private bool IsValidTwilioRequest()
        {
            if (!Request.Headers.TryGetValue("X-Twilio-Signature", out StringValues signature))
                return false;

            var authToken = _config["Twilio:AuthToken"];

            var validator = new RequestValidator(authToken);

            var form = Request.Form.ToDictionary(
                x => x.Key,
                x => x.Value.ToString()
            );

            var url = $"{Request.Scheme}://{Request.Host}{Request.Path}";

            return validator.Validate(url, form, signature);
        }
    }
}
