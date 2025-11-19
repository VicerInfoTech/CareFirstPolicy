using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;

namespace CFP.Provider.IProvider
{
    public interface ICommonProvider
    {
        #region Encrypt Properties

        string Protect(int value);

        string ProtectLong(long value);

        string ProtectShort(short value);

        int UnProtect(string value);

        string ProtectString(string value);

        string UnProtectString(string value);

        long UnProtectLong(string value);
        #endregion

        #region Other Methods
        List<MenuModel> GetMenuList(SessionProviderModel sessionProviderModel);
        List<DropDownModel> GetAgentList();
        List<DropDownModel> GetLeaderBoard();
        int GetDealCount(SessionProviderModel sessionProviderModel);
        bool IsAuthorized(int roleId, int menuId);
        List<DropDownModel> GetUserList();
        #endregion

    }
}
