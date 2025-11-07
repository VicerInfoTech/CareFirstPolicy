using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class DealModel
    {
        public string? EncId { get; set; }

        public int  DealId { get; set; }
        public string AgentName { get; set; }

        [Display(Name = "Type of Coverage")]
        [Required(ErrorMessage = "Type of Coverage is required.")]
        public string[] TypeOfCoverages { get; set; } = Array.Empty<string>();

        public string TypeOfCoverage { get; set; } = null!;

        [Display(Name = "First Name")]
        [Required(ErrorMessage = "First Name is required.")]
        public string FirstName { get; set; } = null!;

        [Display(Name = "Last Name")]
        [Required(ErrorMessage = "Last Name is required.")]
        public string LastName { get; set; } = null!;

        [Display(Name = "Number of Applicants")]
        [Range(1, 20, ErrorMessage = "No. of Applicants must be greater than 0.")]
        public int NoOfApplicants { get; set; }

        [Display(Name = "FFM")]
        [Required(ErrorMessage = "FFM is required.")]
        public string Ffm { get; set; } = null!;

        [Display(Name = "Career")]
        [Required(ErrorMessage = "Career selection is required.")]
        public int Career { get; set; }

        [Display(Name = "Type of Work")]
        [Required(ErrorMessage = "Type of Work selection is required.")]
        public int TypeOfWork { get; set; }

        [Display(Name = "Monthly Income")]
        [Range(0, 1000000, ErrorMessage = "Monthly Income must be valid.")]
        public int MonthlyIncome { get; set; }

        [Display(Name = "Documents Needed")]
        public int DocNeeded { get; set; }

        [Display(Name = "Social Provided")]
        public int SocialProvided { get; set; }

        [Display(Name = "Customer Language")]
        public int CustomerLanguage { get; set; }

        [Display(Name = "Close Date")]
        [Required(ErrorMessage = "Close Date is required.")]
        public DateTime CloseDate { get; set; }

        [Display(Name = "Notes")]
        public string Notes { get; set; } = null!;

        [Display(Name = "Agent")]
        [Required(ErrorMessage = "Please select an Agent.")]
        public int AgentId { get; set; }

        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }

        public DateTime CreatedOn { get; set; }

        public int? UpdatedBy { get; set; }

        public DateTime? UpdatedOn { get; set; }

        public string Ip { get; set; } = null!;

        public virtual AgentMasterModel Agent { get; set; } = null!;

        public virtual UserMasterModel CreatedByNavigation { get; set; } = null!;

        public virtual UserMasterModel? UpdatedByNavigation { get; set; }
    }
}
