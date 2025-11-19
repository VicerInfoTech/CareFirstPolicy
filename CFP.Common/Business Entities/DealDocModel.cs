using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Twilio.TwiML.Voice;

namespace CFP.Common.Business_Entities
{
    public class DealDocModel
    {
        public long DealDocId { get; set; }

        public int DealId { get; set; }

        public string DocName { get; set; } = null!;

        public DateOnly UploadedDate { get; set; }

        public int Tempid { get; set; }

        public string? DocumentPath { get; set; }
    }
}
