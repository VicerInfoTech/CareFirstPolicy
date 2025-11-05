using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class MenuModel
    {
        public int MenuId { get; set; }

        public string MenuName { get; set; } = null!;

        public string MenuNameId { get; set; } = null!;

        public string PageUrl { get; set; } = null!;

        public string Icon { get; set; } = null!;

        public int ParentId { get; set; }

        public short DisplayOrder { get; set; }

        public bool IsHaveChild { get; set; }

        public bool IsActive { get; set; }

        public bool IsShowtoAdmin { get; set; }

    }
}
