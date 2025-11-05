using System;
using System.Collections.Generic;
using System.Text;

namespace CFP.Common.Common_Entities
{
    public class DatatablePageResponseModel<T> where T : class
    {
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public List<T> data { get; set; }
        public object draw { get; set; }
    }
    public class DatatableSpDataResponseModel<T> where T : class
    {
        public int recordsTotal { get; set; }
        public int recordsFiltered { get; set; }
        public T data { get; set; }
        public T footer { get; set; }
        public object draw { get; set; }
    }
}
