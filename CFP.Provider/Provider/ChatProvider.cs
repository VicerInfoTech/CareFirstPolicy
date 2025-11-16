using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

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
                ChatConnection conn = new ChatConnection
                {
                    UserMasterId = sessionProviderModel.UserId,
                    ConnectionId = connectionId
                };

                unitOfWork.ChatConnection.Insert(conn, sessionProviderModel.UserId, sessionProviderModel.Ip);
                unitOfWork.Save();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public string GetConnectionId(int userId)
        {
            return unitOfWork.ChatConnection
                     .GetAll(x => x.UserMasterId == userId)
                     .OrderByDescending(x => x.ChatConnectionId)
                     .Select(x => x.ConnectionId)
                     .FirstOrDefault();
        }

        //public void SaveMessage(int toUserId, string msg, SessionProviderModel sessionProviderModel)
        //{
        //    try
        //    {

        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //}
        public long SaveMessage(int fromUserId, int toUserId, string message)
        {
            var msg = new ChatMessage
            {
                FromUserId = fromUserId,
                ToUserId = toUserId,
                Message = message,
                SentAt = DateTime.Now
            };

            unitOfWork.ChatMessage.Insert(msg);
            unitOfWork.Save();
            return msg.ChatMessageId;
        }

        public List<ChatMessageModel> GetMessages(int currentUserId, int targetUserId)
        {
            var chatData = unitOfWork.ChatMessage
                .GetAll(x =>
                    (x.FromUserId == currentUserId && x.ToUserId == targetUserId) ||
                    (x.FromUserId == targetUserId && x.ToUserId == currentUserId)
                )
                .OrderByDescending(x => x.ChatMessageId)
                .Take(20)
                .OrderBy(x => x.ChatMessageId)
                .ToList();

            // Map to model
            var chatMessages = _mapper.Map<List<ChatMessageModel>>(chatData);

            // Set IsOwnMessage for each message
            foreach (var msg in chatMessages)
            {
                msg.isOwnMessage = msg.FromUserId == currentUserId;
            }

            return chatMessages;
        }


        public List<ChatUserListModel> GetChatUsers(int userId)
        {
            // Step 1: Fetch all users with roles 2 or 3 except current user
            var users = unitOfWork.UserMaster.GetAll(u => u.UserMasterId != userId).ToList();

            // Step 2: Fetch all messages involving current user
            var messages = unitOfWork.ChatMessage.GetAll(m => m.FromUserId == userId || m.ToUserId == userId)
                .ToList();

            // Step 3: Fetch all active connections
            var connections = unitOfWork.ChatConnection.GetAll(c => c.UserMasterId != userId)
                .ToList();

            // Step 4: Prepare the user list with last message, last message time, and online status
            var list = users.Select(user =>
            {
                var lastMsg = messages
                    .Where(m => (m.FromUserId == user.UserMasterId && m.ToUserId == userId) ||
                                (m.ToUserId == user.UserMasterId && m.FromUserId == userId))
                    .OrderByDescending(m => m.ChatMessageId)
                    .FirstOrDefault();

                // Check if user has any active connection
                bool isOnline = connections.Any(c => c.UserMasterId == user.UserMasterId);

                int unreadCount = messages.Where(m =>
              m.FromUserId == user.UserMasterId &&     // message sent BY the other user
              m.ToUserId == userId &&                 // message sent TO current user
              m.IsRead == false                       // unread
          ).Count();
                return new ChatUserListModel
                {
                    UserId = user.UserMasterId,
                    UserName = user.FirstName,
                    LastMessage = lastMsg?.Message ?? "",
                    LastMessageTime = lastMsg?.SentAt,
                    IsOnline = isOnline,
                    UnreadCount = unreadCount // new property in model
                };
            }).OrderByDescending(x => x.IsOnline).ThenByDescending(x => x.LastMessageTime ?? DateTime.MinValue).ToList();

            return list;
        }


        public void MarkMessagesRead(int currentUserId, int targetUserId)
        {
            var unread = unitOfWork.ChatMessage.GetAll()
                .Where(x => x.FromUserId == targetUserId && x.ToUserId == currentUserId && x.IsRead == false)
                .ToList();
            unread.ForEach(m => m.IsRead = true);
            unitOfWork.Save();

        }

        public void RemoveConnection(string connectionId, SessionProviderModel sessionProvider)
        {
            try
            {
                var existingConnection = unitOfWork.ChatConnection
                    .GetAll(x => x.UserMasterId == sessionProvider.UserId && x.ConnectionId == connectionId)
                    .SingleOrDefault();

                if (existingConnection != null)
                {
                    unitOfWork.ChatConnection.Delete(existingConnection);
                    unitOfWork.Save();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<ContactUserDto> GetContacts(int loggedInUserId)
        {
            return unitOfWork.UserMaster.GetAll(c => c.UserMasterId != loggedInUserId)
                 .Select(c => new ContactUserDto
                 {
                     ContactUserId = c.UserMasterId,
                     Name = c.FirstName + " " + c.LastName,
                 }).OrderBy(x=>x.Name).ToList();
        }

        #endregion
    }
}
