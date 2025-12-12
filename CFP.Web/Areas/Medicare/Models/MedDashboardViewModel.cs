using CFP.Common.Business_Entities;

namespace CFP.Web.Areas.Medicare.Models
{
    public class MedDashboardViewModel
    {
        public List<JobDayCount> JobDayCounts { get; set; } = new List<JobDayCount>();
        public int RoleId { get; set; }
    }
}
