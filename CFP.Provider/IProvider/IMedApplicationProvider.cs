using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Provider.IProvider
{
    public interface IMedApplicationProvider
    {
        DatatablePageResponseModel<MedicareJobModel> GetApplicationList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel);
        MedicareJobModel GetApplicationById(int id);
       
    }
}
