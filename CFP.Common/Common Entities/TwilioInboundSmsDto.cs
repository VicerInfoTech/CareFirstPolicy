using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Common_Entities
{
    public class TwilioInboundSmsDto
    {
        public string MessageSid { get; set; }
        public string MessagingServiceSid { get; set; }

        public string From { get; set; }
        public string To { get; set; }

        public string Body { get; set; }
        public int NumMedia { get; set; }
    }
}
