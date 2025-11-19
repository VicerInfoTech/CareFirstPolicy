using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CFP.Web.Models
{
    public class DashboardViewModel
    {
        public int RoleId { get; set; }
        public bool IsEdit { get; set; }
        public bool IsView { get; set; }
        public DealModel DealModel { get; set; } = new DealModel();
        public int DealCount { get; set; } = 0;
        public List<DealDocModel> DealDocList { get; set; } = new List<DealDocModel>();
        public List<DropDownModel> LeaderBoard { get; set; }
        public List<SelectListItem> AgentList { get; set; }
        public List<SelectListItem> CareerList { get; set; }
        public List<IFormFile> PictureofProblemList { get; set; }
    }
}
