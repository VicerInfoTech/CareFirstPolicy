using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class MenuModel
    {
        public short MenuId { get; set; }
        public string MenuName { get; set; }
        public string MenuNameId { get; set; }
        public string MenuUrl { get; set; }
        public string Icon { get; set; }
        public bool IsActive { get; set; }
        public short DisplayOrder { get; set; }
        public int? ParentId { get; set; }
        public bool IsHaveChild { get; set; }

    }
}
