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
        #region PrivateMessage
        void SaveConnection(string connectionId, SessionProviderModel sessionProviderModel);

        string GetConnectionId(int userId);

        long SaveMessage(int fromUserId, int toUserId, string message);

        List<ChatMessageModel> GetMessages(int currentUserId, int targetUserId);

        List<ChatUserListModel> GetChatUsers(int userId);
        void RemoveConnection(string connectionId,SessionProviderModel sessionProviderModel);
        void MarkMessagesRead(int currentUserId, int targetUserId);
        List<ContactUserDto> GetContacts(int loggedInUserId);
        #endregion

        #region RoomMessage
        List<ChatRoomModel> GetAllRooms();
        int CreateRoom(string roomName, List<int> users, SessionProviderModel providerModel);
        void AddMemberToRoom(int roomId, int userId);
        List<UserMasterModel> GetRoomMembers(int roomId);
        #endregion


    }
}
