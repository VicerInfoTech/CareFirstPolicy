using CFP.Common.Business_Entities;

namespace CFP.Web.Models
{
    public class AgentViewModel
    {
      public   AgentMasterModel AgentMasterModel { get; set; }=new AgentMasterModel();
       public List<AppMasterModel> AppMasterModels { get; set; } = new List<AppMasterModel>();
    }
}
