using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CFP.Common.Business_Entities
{

    public class MedicareJobModel
    {
        public int JobApplicationId { get; set; }
        public string EncJobApplicationId { get; set; }

        [Required(ErrorMessage = "First name is required.")]
        public string FirstName { get; set; } = null!;

        [Required(ErrorMessage = "Last name is required.")]
        public string LastName { get; set; } = null!;

        [Required(ErrorMessage = "Address 1 is required.")]
        public string Address1 { get; set; } = null!;

        public string? Address2 { get; set; }

        [Required(ErrorMessage = "City is required.")]
        public string City { get; set; } = null!;

        [Required(ErrorMessage = "State is required.")]
        public int StateId { get; set; }
        public string StateName { get; set; }
        [Required(ErrorMessage = "Zip code is required.")]
        [StringLength(5, MinimumLength = 5, ErrorMessage = "Zip code must be exactly 5 digits.")]
        [RegularExpression(@"^\d{5}$", ErrorMessage = "Zip code must contain only digits.")]
        public string ZipCode { get; set; } = null!;

        [Required(ErrorMessage = "NPN is required.")]
        [StringLength(7, MinimumLength = 7, ErrorMessage = "NPN must be exactly 7 digits.")]
        [RegularExpression(@"^\d{7}$", ErrorMessage = "NPN must contain only digits.")]
        public string Npn { get; set; } = null!;


        [Required(ErrorMessage = "Date of birth is required.")]
        public DateOnly Dob { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Enter a valid email address.")]

        public string Email { get; set; } = null!;


        [Required(ErrorMessage = "Phone number is required.")]
        [Phone(ErrorMessage = "Invalid phone number.")]
        public string PhoneNo { get; set; } = null!;

        public string? AboutAgent { get; set; }

        [Required(ErrorMessage = "State Licence is required.")]
        public string StateLicence { get; set; } = null!;

        [Required(ErrorMessage = "State Licence list is required.")]
        public string[] StateLicenceList { get; set; } = Array.Empty<string>();

        [Required(ErrorMessage = "Years of experience is required.")]
        [Range(0, int.MaxValue, ErrorMessage = "Years of experience cannot be negative.")]
        public decimal Yoe { get; set; }

        [Required(ErrorMessage = "Carrier is required.")]
        public string[] CarrierList { get; set; } = Array.Empty<string>();

        [Required(ErrorMessage = "AHIP selection is required.")]
        public bool Ahip { get; set; }
        public string? Ahipdoc { get; set; }

        [Required(ErrorMessage = "State Licence No is required.")]
        public string StateLicenceNo { get; set; } = null!;

        public string StateLicenceDoc { get; set; } = null!;

        public string ProfileDoc { get; set; } = null!;

        [Required(ErrorMessage = "Bank Name is required.")]
        public string BankName { get; set; } = null!;

        [Required(ErrorMessage = "Account holder name is required.")]
        public string AccHolderName { get; set; } = null!;

        [Required(ErrorMessage = "Bank Account Number is required.")]
        public string BankAccNo { get; set; } = null!;

        public string? AssignmentCommissionDoc { get; set; }
        public string? EnoCertificateDoc { get; set; }

        public bool IsActive { get; set; }

        public DateTime CreatedOn { get; set; }
        public string DobString { get; set; }
        public string CreatedOnString { get; set; }
        public string Carrer { get; set; } = null!; 

        public List<MedicareJobDocModel> MedicareJobApplicationsDocs { get; set; } = new List<MedicareJobDocModel>();

    }


    public class JobDayCount
    {
        public DateTime Date { get; set; }
        public int Count { get; set; }
    }

}
