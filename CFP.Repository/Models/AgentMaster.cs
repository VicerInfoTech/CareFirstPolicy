using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class AgentMaster
{
    public int AgentMasterId { get; set; }

    public string Username { get; set; } = null!;

    public int UserMasterId { get; set; }

    public string LastName { get; set; } = null!;

    public string FirstName { get; set; } = null!;

    public string? ContactNumber { get; set; }

    public string Degiganition { get; set; } = null!;

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
