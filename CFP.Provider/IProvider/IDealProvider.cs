using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Repository.Models;
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
        ResponseModel Save(DealModel model, List<DealDocModel> docList, SessionProviderModel sessionProviderModel);
        DealModel GetById(int id);
        ResponseModel DeActivate(int id, SessionProviderModel sessionProviderModel);
        List<DealDocModel> GetDealDocList(int id);
    }
}
