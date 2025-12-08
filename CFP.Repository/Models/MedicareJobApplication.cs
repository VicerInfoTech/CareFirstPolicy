using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class MedicareJobApplication
{
    public int JobApplicationId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string Address1 { get; set; } = null!;

    public string? Address2 { get; set; }

    public string City { get; set; } = null!;

    public string ZipCode { get; set; } = null!;

    public int StateId { get; set; }

    public string Npn { get; set; } = null!;

    public DateOnly Dob { get; set; }

    public string Email { get; set; } = null!;

    public string PhoneNo { get; set; } = null!;

    public string? AboutAgent { get; set; }

    public string StateLicence { get; set; } = null!;

    public decimal Yoe { get; set; }

    public byte? Carrier { get; set; }

    public bool? Ahip { get; set; }

    public string? AboutUs { get; set; }

    public string StateLicenceNo { get; set; } = null!;

    public string StateLicenceDoc { get; set; } = null!;

    public string ProfileDoc { get; set; } = null!;

    public string AccHolderName { get; set; } = null!;

    public string BankName { get; set; } = null!;

    public string BankAccNo { get; set; } = null!;

    public string? AssignmentCommissionDoc { get; set; }

    public string? EnoCertificateDoc { get; set; }

    public bool IsActive { get; set; }

    public DateTime CreatedOn { get; set; }

    public virtual State State { get; set; } = null!;
}
