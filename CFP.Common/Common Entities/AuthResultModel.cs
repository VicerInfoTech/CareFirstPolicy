namespace CFP.Common.Common_Entities
{
    public class AuthResultModel : ResponseModel
    {
        public int UserId { get; set; }
        public string Username { get; set; }
        public int RoleId { get; set; }
        public int AgentId { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string FullName { get; set; }
        public string Ip { get; set; }
        public bool IsEnableTwoStepAuth { get; set; }
    }
}
