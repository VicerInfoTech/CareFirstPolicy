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
        public int KitId { get; set; }
        public int UserId { get; set; }
        public int PatientId { get; set; }
        public int Status { get; set; }
        public int PrintStatus { get; set; }
        public string Date { get; set; }
        public int TestType { get; set; }
        public int OrderListType { get; set; }
        public int RoleId { get; set; }
    }
}
