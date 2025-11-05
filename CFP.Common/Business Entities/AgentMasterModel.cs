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
        public string Degiganition { get; set; } = null!;
        [DisplayName("Email")]
        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Please enter a valid email address.")]
        public string Username { get; set; } = null!;

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
        [Required(ErrorMessage = "Designation is required.")]
        [MaxLength(100, ErrorMessage = "Designation cannot exceed 100 characters.")]
        public string Designation { get; set; } = null!;
        public bool IsActive { get; set; }

        public int CreatedBy { get; set; }

        public DateTime CreatedOn { get; set; }

        public int? UpdatedBy { get; set; }

        public DateTime? UpdatedOn { get; set; }

        public string Ip { get; set; } = null!;
        public virtual UserMasterModel CreatedByNavigation { get; set; } = null!;

        public virtual UserMasterModel? UpdatedByNavigation { get; set; }

        public virtual UserMasterModel UserMaster { get; set; } = null!;
    }
}
