using CFP.Repository.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Repository.Repository
{
    public class UnitOfWork
    {
        #region Variables
        private EndeavorCRMContext context = new EndeavorCRMContext();
        #endregion

        #region Save and Dispose
        public void Save()
        {
            context.SaveChanges();
        }

        private bool disposed = false;
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                    context.Dispose();
            }
            disposed = true;
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #endregion

        #region Model Variables

        private GenericRepository<LoginFailure> _LoginFailure;
        private GenericRepository<LoginHistory> _LoginHistory;
        private GenericRepository<Menu> _Menu;
        private GenericRepository<MenuRole> _MenuRole;
        private GenericRepository<Role> _Role;
        private GenericRepository<UserMaster> _UserMaster;
        private GenericRepository<AgentMaster> _AgentMaster;
        private GenericRepository<Deal> _Deal;
        private GenericRepository<ChatConnection> _ChatConnection;
        private GenericRepository<ChatMessage> _ChatMessage;
        private GenericRepository<ChatRoom> _ChatRoom;
        private GenericRepository<ChatRoomMember> _ChatRoomMember;
        #endregion

        #region Generic Classes Of DB Entities
        public GenericRepository<LoginFailure> LoginFailure
        {
            get
            {
                if (_LoginFailure == null)
                    _LoginFailure = new GenericRepository<LoginFailure>(context);
                return _LoginFailure;
            }
        }
        public GenericRepository<LoginHistory> LoginHistory
        {
            get
            {
                if (_LoginHistory == null)
                    _LoginHistory = new GenericRepository<LoginHistory>(context);
                return _LoginHistory;
            }
        }
        public GenericRepository<Menu> Menu
        {
            get
            {
                if (_Menu == null)
                    _Menu = new GenericRepository<Menu>(context);
                return _Menu;
            }
        }
        public GenericRepository<MenuRole> MenuRole
        {
            get
            {
                if (_MenuRole == null)
                    _MenuRole = new GenericRepository<MenuRole>(context);
                return _MenuRole;
            }
        }
        public GenericRepository<Role> Role
        {
            get
            {
                if (_Role == null)
                    _Role = new GenericRepository<Role>(context);
                return _Role;
            }
        }
        public GenericRepository<UserMaster> UserMaster
        {
            get
            {
                if (_UserMaster == null)
                    _UserMaster = new GenericRepository<UserMaster>(context);
                return _UserMaster;
            }
        }
        public GenericRepository<AgentMaster> AgentMaster
        {
            get
            {
                if (_AgentMaster == null)
                    _AgentMaster = new GenericRepository<AgentMaster>(context);
                return _AgentMaster;
            }
        }
        public GenericRepository<Deal> Deal
        {
            get
            {
                if (_Deal == null)
                    _Deal = new GenericRepository<Deal>(context);
                return _Deal;
            }
        }

        public GenericRepository<ChatConnection> ChatConnection
        {
            get
            {
                if (_ChatConnection == null)
                    _ChatConnection = new GenericRepository<ChatConnection>(context);
             return _ChatConnection;
            }
        }
        public GenericRepository<ChatMessage> ChatMessage
        {
            get
            {
                if (_ChatMessage == null)
                    _ChatMessage = new GenericRepository<ChatMessage>(context);
             return _ChatMessage;
            }
        }
        public GenericRepository<ChatRoom> ChatRoom
        {
            get
            {
                if (_ChatRoom == null)
                    _ChatRoom = new GenericRepository<ChatRoom>(context);
             return _ChatRoom;
            }
        }
        public GenericRepository<ChatRoomMember> ChatRoomMember
        {
            get
            {
                if (_ChatRoomMember == null)
                    _ChatRoomMember = new GenericRepository<ChatRoomMember>(context);
             return _ChatRoomMember;
            }
        }
        #endregion
    }
}
