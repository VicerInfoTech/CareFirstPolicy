using CFP.Common.Business_Entities;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CFP.Web.Models
{
    public class DashboardViewModel
    {
        public int RoleId { get; set; }
        public bool IsEdit { get; set; }
        public DealModel DealModel { get; set; }
        public List<SelectListItem> AgentList { get; set; }
    }
}
