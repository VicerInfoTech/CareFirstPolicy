using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Provider.IProvider
{
    public interface IAgentMasterProvider
    {
        DatatablePageResponseModel<AgentMasterModel> GetUserList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel);
        ResponseModel Save(AgentMasterModel model, SessionProviderModel sessionProviderModel);
        AgentMasterModel GetById(int id);
        ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel);
        ResponseModel ReActivate(int id, SessionProviderModel sessionProviderModel);
        ResponseModel ResetPassword(ResetPasswordModel userData, string IP);
    }
}
