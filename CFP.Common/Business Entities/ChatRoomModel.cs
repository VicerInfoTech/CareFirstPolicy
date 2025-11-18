using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class ChatRoomModel
    {
        public int ChatRoomId { get; set; }

        public string RoomName { get; set; } = null!;

        public bool IsActive { get; set; }

        public int CreatedBy { get; set; }

        public DateTime CreatedOn { get; set; }

        public int? UpdatedBy { get; set; }

        public DateTime? UpdatedOn { get; set; }

        public string Ip { get; set; } = null!;
        public int MemberCount { get; set; }
        public virtual ICollection<ChatMessageModel> ChatMessages { get; set; } = new List<ChatMessageModel>();


        public virtual UserMasterModel CreatedByNavigation { get; set; } = null!;

        public virtual UserMasterModel? UpdatedByNavigation { get; set; }
    }
}
