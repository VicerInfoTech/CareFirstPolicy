namespace CFP.Common.Common_Entities
{
    public class DatatablePageRequestModel
    {
        public int StartIndex { get; set; } = 0;
        public int PageSize { get; set; } = 10;
        public string SearchText { get; set; } = "";
        public string SortColumnName { get; set; } = "";
        public string SortDirection { get; set; } = "";
        public object Draw { get; set; } = "";
        public int Id { get; set; }
        public int StringId { get; set; }
        public int FromUserId { get; set; }
        public int ToUserId { get; set; }
        public int ChatTypeId { get; set; }
        public int MsgTypeId { get; set; }
        public int RoomId { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
  
    }
}
