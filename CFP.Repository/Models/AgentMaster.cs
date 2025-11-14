using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class AgentMaster
{
    public int AgentMasterId { get; set; }

    public int UserMasterId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public DateOnly? Dob { get; set; }

    public string Email { get; set; } = null!;

    public string? Ssn { get; set; }

    public string? ContactNumber { get; set; }

    public string? Designation { get; set; }

    public string? Npn { get; set; }

    public string? ChaseExt { get; set; }

    public string? ChaseDataUsername { get; set; }

    public string? ChaseDataPassword { get; set; }

    public string? HealthSherpaUsername { get; set; }

    public string? HealthSherpaPassword { get; set; }

    public string? MyMfgUsername { get; set; }

    public string? MyMfgPassword { get; set; }

    public string? FfmUsername { get; set; }

    public string? Forwarding { get; set; }

    public string? PayStructure { get; set; }

    public bool IsActive { get; set; }

    public int CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public int? UpdatedBy { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public string Ip { get; set; } = null!;

    public virtual UserMaster CreatedByNavigation { get; set; } = null!;

    public virtual ICollection<Deal> Deals { get; set; } = new List<Deal>();

    public virtual UserMaster? UpdatedByNavigation { get; set; }

    public virtual UserMaster UserMaster { get; set; } = null!;
}
