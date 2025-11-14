using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{
    public class AgentMasterModel
    {
        public int AgentMasterId { get; set; }
        public string? EncId { get; set; }
        [DisplayName("DOB")]
        public DateOnly? Dob { get; set; }
        [DisplayName("Email")]
        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Please enter a valid email address.")]
        [MaxLength(50, ErrorMessage = "Email cannot exceed 50 characters.")]
        public string Email { get; set; } = null!;
        [MaxLength(50, ErrorMessage = "SSN cannot exceed 50 characters.")]
        [DisplayName("SSN")]
        public string? Ssn { get; set; }

        [Required]
        public int UserMasterId { get; set; }
        [DisplayName("Last Name")]
        [Required(ErrorMessage = "Last Name is required.")]
        [MaxLength(50, ErrorMessage = "Last Name cannot exceed 50 characters.")]
        public string LastName { get; set; } = null!;

        [DisplayName("First Name")]
        [Required(ErrorMessage = "First Name is required.")]
        [MaxLength(50, ErrorMessage = "First Name cannot exceed 50 characters.")]
        public string FirstName { get; set; } = null!;
        [DisplayName("Contact Number")]
        [Phone(ErrorMessage = "Invalid contact number.")]
        [MaxLength(15, ErrorMessage = "Contact Number should not exceed 15 digits.")]
        public string? ContactNumber { get; set; }
        [DisplayName("Designation")]
        [MaxLength(100, ErrorMessage = "Designation cannot exceed 100 characters.")]
        public string? Designation { get; set; } = null!;
        [DisplayName("NPN")]
        [MaxLength(50, ErrorMessage = "NPN cannot exceed 50 characters.")]
        public string? Npn { get; set; }
        [DisplayName("Chase Ext.")]
        [MaxLength(50, ErrorMessage = "Chase ext. cannot exceed 50 characters.")]
        public string? ChaseExt { get; set; }
        [DisplayName("Chase Data Username")]
        [MaxLength(100, ErrorMessage = "Chase data username cannot exceed 100 characters.")]
        public string? ChaseDataUsername { get; set; }
        [DisplayName("Chase Data Password")]
        [MaxLength(50, ErrorMessage = "Chase data password cannot exceed 50 characters.")]
        public string? ChaseDataPassword { get; set; }
        [DisplayName("HealthSherpa Username")]
        [MaxLength(100, ErrorMessage = "HealthSherpa username cannot exceed 100 characters.")]
        public string? HealthSherpaUsername { get; set; }
        [DisplayName("HealthSherpa Password")]
        [MaxLength(50, ErrorMessage = "HealthSherpa password cannot exceed 50 characters.")]
        public string? HealthSherpaPassword { get; set; }
        [DisplayName("MyMFG Username")]
        [MaxLength(100, ErrorMessage = "MyMFG username cannot exceed 100 characters.")]
        public string? MyMfgUsername { get; set; }
        [DisplayName("MyMFG Password")]
        [MaxLength(50, ErrorMessage = "MyMFG password cannot exceed 50 characters.")]
        public string? MyMfgPassword { get; set; }
        [DisplayName("FFM Username")]
        [MaxLength(100, ErrorMessage = "FFM username cannot exceed 100 characters.")]
        public string? FfmUsername { get; set; }
        [DisplayName("Forwarding")]
        [MaxLength(150, ErrorMessage = "Forwarding cannot exceed 150 characters.")]
        public string? Forwarding { get; set; }
        [DisplayName("Pay Structure")]
        [MaxLength(50, ErrorMessage = "Email cannot exceed 50 characters.")]
        public string? PayStructure { get; set; }
        public bool IsActive { get; set; }

        public int CreatedBy { get; set; }

        public DateTime CreatedOn { get; set; }

        public int? UpdatedBy { get; set; }

        public DateTime? UpdatedOn { get; set; }

        public string Ip { get; set; } = null!;
        public string RoleName { get; set; } = null!;
        [DisplayName("Role")]
        public int RoleId { get; set; }
        public virtual UserMasterModel CreatedByNavigation { get; set; } = null!;

        public virtual UserMasterModel? UpdatedByNavigation { get; set; }

        public virtual UserMasterModel UserMaster { get; set; } = null!;
    }
}
