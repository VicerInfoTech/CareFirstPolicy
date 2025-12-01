using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class AppMasterModel
    {
        public int AppId { get; set; }

        public string AppName { get; set; } = null!;

        public string AppDesc { get; set; } = null!;

        public string LogoName { get; set; } = null!;

        public bool IsActive { get; set; }

    }
}
