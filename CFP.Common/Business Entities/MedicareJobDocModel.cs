using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class MedicareJobDocModel
    {
        public int JobApplicatonDocId { get; set; }

        public int JobApplicationId { get; set; }

        public int StateId { get; set; }

        public string DocName { get; set; } = null!;
        public string StateName { get; set; } = null!;


    }
}
