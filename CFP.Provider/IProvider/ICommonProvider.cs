using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Repository.Models;

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
        List<DropDownModel> GetLeaderBoard(string startDate);
        int GetDealCount(SessionProviderModel sessionProviderModel);
        bool IsAuthorized(int roleId, int menuId,int userAccess);
        List<DropDownModel> GetUserList();
        List<DropDownModel> GetRoomList();
        List<DropDownModel> GetStateList();
        List<AppMasterModel> GetAppsList();
        List<DealChartPoint> GetDealDataForChart(int agentId);
        AgentDealDashboardViewModel GetAgentDealDashboard(string startDate, string endDate);
        List<DealSummaryModel> GetDealSummary(string startDate, string endDate);
        DatatablePageResponseModel<ChatMessageModel> GetChatHistoryList(DatatablePageRequestModel requestModel, SessionProviderModel sessionProviderModel);
        List<NotificationDto> GetNotification(SessionProviderModel sessionProviderModel);
        List<AppMasterModel> GetAgentAppList(SessionProviderModel sessionProviderModel);
        ResponseModel SaveJobForm(MedicareJobModel model, List<JobDocModel> docList, SessionProviderModel sessionProviderModel);
        List<JobDayCount> GetJobDayCount();
        #endregion

    }
}
