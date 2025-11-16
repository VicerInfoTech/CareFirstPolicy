using CFP.Common.Utility;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CFP.Common.Business_Entities
{
    public class UserMasterModel
    {
        public string? EncId { get; set; }
        public int UserMasterId { get; set; }

        [Required(ErrorMessage = "Please specify email")]
        [DisplayName("Email")]
        [MaxLength(150)]
        public string Username { get; set; }

        [DisplayName("Password")]
        [Required(ErrorMessage = "Please specify password")]
        [MinLength(8, ErrorMessage = "Password must be 8 character long")]
        public string UserPassword { get; set; }

        [DisplayName("Confirm Password ")]
        [Required(ErrorMessage = "Please specify confirm password")]
        [Compare("UserPassword", ErrorMessage = "Password and Confirm Password must be same")]
        [MinLength(8, ErrorMessage = "Password must be 8 character long")]
        public string ConfirmPassword { get; set; }

        [DisplayName("Last Name")]
        [Required(ErrorMessage = "Please specify last name")]
        [MaxLength(100)]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Please specify first name")]
        [DisplayName("First Name")]
        [MaxLength(100)]
        public string FirstName { get; set; }

        [MaxLength(50)]
        [Required(ErrorMessage = "Please specify contact number")]
        [DisplayName("Contact Number")]
        public string ContactNumber { get; set; }

        [MaxLength(50)]
        [Required(ErrorMessage = "Please specify Date Of Birth")]
        [DisplayName("Date Of Birth")]
        public string DateOfBirthString { get; set; }


        [DisplayName("Receive future update via SMS?")]
        public bool IsReceiveNotification { get; set; }
        [DisplayName("Role")]
        public int RoleId { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOn { get; set; }
        public string? Ip { get; set; }
        public bool IsPasswordCreated { get; set; }
        public int NumberOfKit { get; set; }
        public string? UserCode { get; set; }
        public string? RoleName { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string FullName { get; set; }
        public string CreatedOnString
        {
            get
            {

                return CreatedOn.ToString(AppCommon.DateTimeFormat);
            }
        }
        public DateTime? LastLoginTime { get; set; }
        public string LastLoginTimeString
        {
            get
            {
                return LastLoginTime.HasValue ? LastLoginTime.Value.ToString(AppCommon.DateTimeFormat) : "";
            }
        }
    }
}
