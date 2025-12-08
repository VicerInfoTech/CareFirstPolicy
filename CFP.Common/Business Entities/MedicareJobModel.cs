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
        [Required(ErrorMessage = "Zip code is required.")]
        public string ZipCode { get; set; } = null!;
        [Required(ErrorMessage = "NPN is required.")]
        public string Npn { get; set; } = null!;

        [Required(ErrorMessage = "Date of birth is required.")]
        public DateOnly Dob { get; set; }

        [Required(ErrorMessage = "Email is required.")]
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
        public byte? Carrier { get; set; }

        [Required(ErrorMessage = "AHIP selection is required.")]
        public bool Ahip { get; set; }

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
    }

}
