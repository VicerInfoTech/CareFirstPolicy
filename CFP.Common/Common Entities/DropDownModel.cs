namespace CFP.Common.Common_Entities
{
    public class DropDownModel
    {
        public string Text { get; set; }
        public string Value { get; set; }
        public int ExtraValue { get; set; }
    }

    public class DealChartViewModel
    {
        public string Date { get; set; }       
        public int TotalDeal { get; set; }        
    }
    public class AgentDealChartViewModel
    {
        public int AgentId { get; set; }
        public string AgentName { get; set; }
        public int DealCount { get; set; }
    }

    public class AgentDealDashboardViewModel
    {
        public List<AgentDealChartViewModel> ChartAgents { get; set; }
        public List<AgentDealChartViewModel> TopAgents { get; set; }
    }



}
