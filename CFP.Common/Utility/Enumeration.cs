using System.ComponentModel.DataAnnotations;

namespace CFP.Common.Utility
{
    public class Enumeration
    {
        public enum Role
        {
            [Display(Name = "Super Admin")]
            Super_Admin = 1,
            [Display(Name = "Agent Lead")]
            AgentLead = 2,
            [Display(Name = "Agent")]
            Agent = 3,
            [Display(Name = "User")]
            User = 4,

        }

        public enum ActiveInActiveStatus
        {
            Active = 1,
            In_Active = 2,
        }
        public enum Career
        {
            [Display(Name = "AMBETTER")]
            Ambetter = 1,

            [Display(Name = "AETNA")]
            Aetna = 2,

            [Display(Name = "BCBS")]
            Bcbs = 3,

            [Display(Name = "CARESOURCE")]
            Caresource = 4,

            [Display(Name = "CIGNA")]
            Cigna = 5,

            [Display(Name = "MOLINA")]
            Molina = 6,

            [Display(Name = "OSCAR")]
            Oscar = 7,

            [Display(Name = "UNITED HEALTHCARE")]
            UnitedHealthcare = 8,

            [Display(Name = "FLORIDA BLUE")]
            FloridaBlue = 9,

            [Display(Name = "HEALTH FIRST")]
            HealthFirst = 10,

            [Display(Name = "UNIV OF UTHA")]
            UnivOfUtha = 11,

            [Display(Name = "MEDICA")]
            Medica = 12,

            [Display(Name = "ALLIANT HEALTH")]
            AlliantHealth = 13,

            [Display(Name = "AMERIHEALTH")]
            AmeriHealth = 14,

            [Display(Name = "PRIORITY HEALTH")]
            PriorityHealth = 15,

            [Display(Name = "FIRST CHOICE")]
            FirstChoice = 16,

            [Display(Name = "AMERITAS")]
            Ameritas = 17,

            [Display(Name = "WELLPOINT")]
            Wellpoint = 18,

            [Display(Name = "INSTIL")]
            Instil = 19,

            [Display(Name = "ANTHEM")]
            Anthem = 20
        }
    }
}
