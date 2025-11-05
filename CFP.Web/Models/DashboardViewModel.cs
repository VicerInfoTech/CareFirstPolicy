using CFP.Common.Business_Entities;

namespace CFP.Web.Models
{
    public class DashboardViewModel
    {
        public int RoleId { get; set; }
        public bool IsEdit { get; set; }
        public AgentMasterModel AgentMasterModel { get; set; }
        public List<AgentMasterModel> AgentMasterModels { get; set; }
     
    }
}
