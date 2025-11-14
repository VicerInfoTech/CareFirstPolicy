using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class LeadMaster
{
    public int LeadId { get; set; }

    public string? LeadSource { get; set; }

    public string CustomerName { get; set; } = null!;

    public string? ContactNumber { get; set; }

    public string? Email { get; set; }

    public string? Address { get; set; }

    public string? InterestedCoverage { get; set; }

    public int LeadStatus { get; set; }

    public int? AssignedAgentId { get; set; }

    public string? Notes { get; set; }

    public int CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public int? UpdatedBy { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public bool IsActive { get; set; }
}
