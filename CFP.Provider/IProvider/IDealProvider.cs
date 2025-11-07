using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Provider.IProvider
{
    public interface IDealProvider
    {
        DatatablePageResponseModel<DealModel> GetUserList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel);
        ResponseModel Save(DealModel model, SessionProviderModel sessionProviderModel);
        DealModel GetById(int id);
        ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel);
    }
}
