using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace CFP.Web.Models
{
    public class DashboardViewModel
    {
        public int RoleId { get; set; }
        public int AgentId { get; set; }
        public int UserAccess { get; set; }
        public bool IsEdit { get; set; }
        public bool IsView { get; set; }
        public bool IsLogin { get; set; }=false;
        public DealModel DealModel { get; set; } = new DealModel();
        public int DealCount { get; set; } = 0;
        public List<DealDocModel> DealDocList { get; set; } = new List<DealDocModel>();
        public List<DealSummaryModel> DealSummaryList { get; set; } = new List<DealSummaryModel>();
        public List<DropDownModel> LeaderBoard { get; set; }
        public List<SelectListItem> AgentList { get; set; }
        public List<SelectListItem> RoomList { get; set; }
        public List<SelectListItem> CareerList { get; set; }
        public List<NotificationDto> NotificationList { get; set; }
        public List<AppMasterModel> AgentAppList { get; set; }
        public List<IFormFile> PictureofProblemList { get; set; }
        public DateOnly StartDate { get; set; }
        public DateOnly EndDate { get; set; }
        public DateOnly DealStartDate { get; set; }
        public DateOnly DealEndDate { get; set; }
    }
}
