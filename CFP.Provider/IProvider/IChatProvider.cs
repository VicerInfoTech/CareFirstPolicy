using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;

namespace CFP.Provider.IProvider
{
    public interface IChatProvider
    {
        void SaveConnection(string connectionId, SessionProviderModel sessionProviderModel);
    }
}
