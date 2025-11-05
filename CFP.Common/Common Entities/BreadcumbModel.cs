namespace CFP.Common.Common_Entities
{
    public class BreadcumbModel
    {
        public string MenuName { get; set; }
        public string Title { get; set; }
        public string Icon { get; set; }

        public string ParentMenuName { get; set; }
        public string ParentIcon { get; set; }
        public string ParentController { get; set; }
        public string ParentActionMethod { get; set; }
    }
}
