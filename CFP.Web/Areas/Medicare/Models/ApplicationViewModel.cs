using CFP.Common.Business_Entities;

namespace CFP.Web.Areas.Medicare.Models
{
    public class ApplicationViewModel
    {
      public   List<MedicareJobModel> MedicareJobModelList { get; set; }=new List<MedicareJobModel>();
      public   MedicareJobModel MedicareJobModel { get; set; }=new MedicareJobModel();
        public List<JobDayCount> JobDayCounts { get; set; } = new List<JobDayCount>();
    }
}
