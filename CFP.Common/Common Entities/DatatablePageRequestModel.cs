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
  
    }
}
