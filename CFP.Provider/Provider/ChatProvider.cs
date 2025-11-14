using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using CFP.Common.Common_Entities;
using CFP.Provider.IProvider;
using CFP.Repository.Repository;

namespace CFP.Provider.Provider
{
    public class ChatProvider : IChatProvider
    {
        #region Variable
        private UnitOfWork unitOfWork = new UnitOfWork();
        private ICommonProvider _commonProvider;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public ChatProvider(IMapper mapper, ICommonProvider commonProvider)
        {
            _commonProvider = commonProvider;
            _mapper = mapper;
        }
        #endregion

        #region Methods
        public void SaveConnection(string connectionId, SessionProviderModel sessionProviderModel)
        {
            try
            {

            }
            catch (Exception)
            {

                throw;
            }
        }
        public void SaveMessage(int toUserId, string msg, SessionProviderModel sessionProviderModel)
        {
            try
            {

            }
            catch (Exception)
            {

                throw;
            }
        }
        #endregion
    }
}
