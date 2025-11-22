using AutoMapper;
using CFP.Common.Business_Entities;
using CFP.Common.Common_Entities;
using CFP.Common.Utility;
using CFP.Provider.IProvider;
using CFP.Repository.Models;
using CFP.Repository.Repository;
using OfficeOpenXml.FormulaParsing.Excel.Functions.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Twilio.TwiML.Voice;

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

        #region PrivateMessage
        public void SaveConnection(string connectionId, SessionProviderModel sessionProviderModel)
        {
            try
            {
                //var previousConnection = unitOfWork.ChatConnection
                //    .GetAll(x => x.UserMasterId == sessionProviderModel.UserId && x.ConnectionId != connectionId)
                //    .ToList();

                //if (previousConnection != null && previousConnection.Any())
                //{
                //    unitOfWork.ChatConnection.DeleteAll(previousConnection);
                //    unitOfWork.Save();
                //}

                ChatConnection conn = new ChatConnection
                {
                    UserMasterId = sessionProviderModel.UserId,
                    ConnectionId = connectionId
                };

                unitOfWork.ChatConnection.Insert(conn, sessionProviderModel.UserId, sessionProviderModel.Ip);
                unitOfWork.Save();

                //Delete old connections
                var existingConnection = unitOfWork.ChatConnection
                   .GetAll(x => x.CreatedOn < AppCommon.CurrentDate.AddDays(-1))
                   .ToList();

                if (existingConnection != null && existingConnection.Any())
                {
                    unitOfWork.ChatConnection.DeleteAll(existingConnection);
                    unitOfWork.Save();
                }
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


        public long SaveMessage(int fromUserId, int toUserId, string message)
        {
            var msg = new ChatMessage
            {
                FromUserId = fromUserId,
                ToUserId = toUserId,
                Message = message,
                SentAt = AppCommon.CurrentDate
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

            var chatMessages = _mapper.Map<List<ChatMessageModel>>(chatData);

            foreach (var msg in chatMessages)
            {
                msg.isOwnMessage = msg.FromUserId == currentUserId;
            }

            return chatMessages;
        }


        public List<ChatUserListModel> GetChatUsers(int userId)
        {
            List<ChatUserListModel> list = new List<ChatUserListModel>();
            try
            {


                var users = unitOfWork.UserMaster.GetAll(u => u.UserMasterId != userId).ToList();

                var messages = unitOfWork.ChatMessage.GetAll(m => m.FromUserId == userId || m.ToUserId == userId).ToList();

                var connections = unitOfWork.ChatConnection.GetAll(c => c.UserMasterId != userId).ToList();
                list = users.Select(user =>
               {
                   var lastMsg = messages.Where(m => (m.FromUserId == user.UserMasterId && m.ToUserId == userId) ||
                                   (m.ToUserId == user.UserMasterId && m.FromUserId == userId)).OrderByDescending(m => m.ChatMessageId).FirstOrDefault();

                   bool isOnline = connections.Any(c => c.UserMasterId == user.UserMasterId);

                   int unreadCount = messages.Where(m => m.FromUserId == user.UserMasterId && m.ToUserId == userId && m.IsRead == false).Count();

                   DateTime? lastLogin = user.LoginHistories.OrderByDescending(x => x.LoggedInTime).Select(x => (DateTime?)x.LoggedInTime).FirstOrDefault();

                   DateTime? lastConnection = user.ChatConnections.OrderByDescending(c => c.CreatedOn).Select(c => (DateTime?)c.CreatedOn).FirstOrDefault();

                   DateTime? lastMessage = user.ChatMessageFromUsers.OrderByDescending(m => m.SentAt).Select(m => (DateTime?)m.SentAt).FirstOrDefault();
                   // Take latest datetime among the three
                   DateTime? lastSeen = new[] { lastLogin, lastConnection, lastMessage }
                                        .Where(dt => dt.HasValue).OrderByDescending(dt => dt.Value).FirstOrDefault();
                   return new ChatUserListModel
                   {
                       UserId = user.UserMasterId,
                       UserName = user.FirstName + " " + user.LastName,
                       LastMessage = lastMsg?.Message ?? "",
                       LastMessageTime = lastMsg?.SentAt,
                       IsOnline = isOnline,
                       UnreadCount = unreadCount,
                       LastSeen = lastSeen,
                   };
               }).OrderByDescending(x => x.IsOnline).ThenByDescending(x => x.LastMessageTime ?? DateTime.MinValue).ToList();
            }
            catch (Exception ex)
            {
                AppCommon.LogException(ex, "ChatProvider=>GetChatUsers");
            }
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
                     IsOnline = c.ChatConnections.Any()
                 }).OrderBy(x => x.Name).ToList();
        }
        #endregion
        #region RoomMessage
        public List<ChatRoomModel> GetAllRooms(SessionProviderModel sessionProviderModel)
        {
            return unitOfWork.ChatRoom
                .GetAll(x => x.IsActive &&
                             x.ChatRoomMembers.Any(u => u.UserMasterId == sessionProviderModel.UserId))
                .Select(x => new ChatRoomModel
                {
                    ChatRoomId = x.ChatRoomId,
                    RoomName = x.RoomName,
                    CreatedOn = x.CreatedOn
                })
                .ToList();
        }


        public ResponseModel CreateRoom(ChatRoomModel inputModel, SessionProviderModel providerModel)
        {
            ResponseModel response = new ResponseModel();
            try
            {
                if (!string.IsNullOrEmpty(inputModel.EncChatRoomId))
                    inputModel.ChatRoomId = _commonProvider.UnProtect(inputModel.EncChatRoomId);

                if (unitOfWork.ChatRoom.Any(x => x.RoomName.ToLower() == inputModel.RoomName.ToLower() && x.ChatRoomId != inputModel.ChatRoomId))
                {
                    response.IsSuccess = false;
                    response.Message = "Channel name  already created.";
                    return response;
                }

                var _temp = unitOfWork.ChatRoom.Get(x => x.ChatRoomId == inputModel.ChatRoomId);
                var roomData = _mapper.Map<ChatRoomModel, ChatRoom>(inputModel, _temp);
                if (_temp == null)
                {
                    ChatRoom room = new ChatRoom
                    {
                        RoomName = inputModel.RoomName,
                        IsActive = true,
                    };
                    foreach (var uid in inputModel.UserIds)
                    {
                        room.ChatRoomMembers.Add(new ChatRoomMember
                        {
                            UserMasterId = uid,
                        });
                    }
                    //Add Current User While Creating New Room
                    if (!room.ChatRoomMembers.Any(x => x.UserMasterId == providerModel.UserId))
                    {
                        room.ChatRoomMembers.Add(new ChatRoomMember
                        {
                            UserMasterId = providerModel.UserId,
                        });
                    }
                    unitOfWork.ChatRoom.Insert(room, providerModel.UserId, providerModel.Ip);
                    unitOfWork.Save();
                    response.IsSuccess = true;
                    response.Message = "Channel created successfully";
                    response.ChatRoomId = room.ChatRoomId;
                }
                else
                {

                    var curDoc = roomData.ChatRoomMembers.ToList();
                    List<int> removedDoc = curDoc.Select(x => x.ChatRoomMemberId).ToList();
                    foreach (var item in inputModel.UserIds)
                    {
                        var tmp = curDoc.Where(x => x.UserMasterId == item).FirstOrDefault();
                        if (tmp != null)
                            removedDoc.Remove(tmp.ChatRoomMemberId);
                        else
                        {
                            roomData.ChatRoomMembers.Add(new ChatRoomMember
                            {
                                UserMasterId = item,
                            });
                        }
                    }
                    if (removedDoc.Any())
                        unitOfWork.ChatRoomMember.DeleteAll(unitOfWork.ChatRoomMember.GetAll(x => removedDoc.Contains(x.ChatRoomMemberId)));
                    response.Message = "Channel updated successfully";
                    unitOfWork.ChatRoom.Update(roomData, providerModel.UserId, providerModel.Ip);
                    unitOfWork.Save();
                    response.IsSuccess = true;
                    response.ChatRoomId = roomData.ChatRoomId;
                }

            }
            catch (Exception)
            {

                throw;
            }
            return response;
        }

        // ADD MEMBER
        public void AddMemberToRoom(int roomId, int userId)
        {
            if (!unitOfWork.ChatRoomMember.Any(m => m.ChatRoomId == roomId && m.UserMasterId == userId))
            {
                ChatRoomMember cm = new ChatRoomMember
                {
                    ChatRoomId = roomId,
                    UserMasterId = userId
                };

                unitOfWork.ChatRoomMember.Insert(cm);
                unitOfWork.Save();
            }
        }

        public List<UserMasterModel> GetRoomMembers(int roomId)
        {
            var members = (from m in unitOfWork.ChatRoomMember.GetAll(x => x.ChatRoomId == roomId)
                           join u in unitOfWork.UserMaster.GetAll()
                           on m.UserMasterId equals u.UserMasterId
                           select new UserMasterModel
                           {
                               UserMasterId = u.UserMasterId,
                               FullName = u.FirstName + " " + u.LastName
                           }).ToList();

            return members;
        }
        public ChatRoomModel GetRoomById(int roomId, SessionProviderModel providerModel)
        {
            ChatRoomModel roomModel = new ChatRoomModel();
            var charRoom = unitOfWork.ChatRoom.GetAll(x => x.ChatRoomId == roomId).FirstOrDefault();
            roomModel = _mapper.Map<ChatRoomModel>(charRoom);
            roomModel.EncChatRoomId = _commonProvider.Protect(roomModel.ChatRoomId);
            roomModel.UserIds = charRoom.ChatRoomMembers.Select(x => x.UserMasterId).ToList();
            roomModel.MemberCount = charRoom.ChatRoomMembers.Count();
            roomModel.IsShowActionBtn = charRoom.CreatedBy == providerModel.UserId;
            return roomModel;
        }
        public List<ChatMessageModel> GetRoomMessages(int roomId)
        {
            List<ChatMessageModel> chatMessages = new List<ChatMessageModel>();
            var roomMessage = unitOfWork.ChatMessage.GetAll(x => x.ChatRoomId == roomId)
                .OrderBy(x => x.SentAt).ToList();
            chatMessages = _mapper.Map<List<ChatMessageModel>>(roomMessage);
            foreach (var item in chatMessages)
            {
                item.SenderName = item.FromUser.FirstName + " " + item.FromUser.LastName;
                if (item.IsAttachment)
                {
                    var parts = item.Message?.Split(new[] { "__--__" }, StringSplitOptions.None);
                    //var fileId = parts != null && parts.Length > 0 ? parts[0] : "";
                    //var fileName = parts != null && parts.Length > 1 ? parts[1] : "";
                    item.FileName = parts != null ? parts[parts.Length - 1] : "";
                }
            }
            return chatMessages;
        }

        public long SaveRoomMessage(ChatMessageModel model)
        {
            var entity = new ChatMessage
            {
                FromUserId = model.FromUserId,
                ToUserId = null,                 // Room message → no direct user
                ChatRoomId = model.ChatRoomId,   // Important
                Message = model.Message,
                SentAt = AppCommon.CurrentDate,
                IsRead = false,
                IsAttachment = model.IsAttachment,
            };

            unitOfWork.ChatMessage.Insert(entity);
            unitOfWork.Save();

            return entity.ChatMessageId;
        }

        public ResponseModel Delete(int id, SessionProviderModel sessionProviderModel)
        {
            ResponseModel model = new ResponseModel();
            try
            {
                var data = unitOfWork.ChatRoom.Get(id);
                if (data != null)
                {
                    data.IsActive = false;
                    unitOfWork.ChatRoom.Update(data, sessionProviderModel.UserId, sessionProviderModel.Ip);
                    unitOfWork.Save();
                    model.IsSuccess = true;
                    model.Message = "Channel deleted Successfully";
                }
                else
                    model.Message = "Channel records not found.";
            }
            catch (Exception ex)
            {
                model.IsSuccess = false;
                model.Message = AppCommon.ErrorMessage;
                AppCommon.LogException(ex, "ChatProvider=>Delete");
            }
            return model;
        }

        #endregion

        #endregion
    }
}
