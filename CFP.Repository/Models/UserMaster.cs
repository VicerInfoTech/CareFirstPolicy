using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class UserMaster
{
    public int UserMasterId { get; set; }

    public string Username { get; set; } = null!;

    public string UserPassword { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string FirstName { get; set; } = null!;

    public string? ContactNumber { get; set; }

    public int RoleId { get; set; }

    public bool IsFirstTimeLogin { get; set; }

    public bool TwoStepAuth { get; set; }

    public bool IsActive { get; set; }

    public int CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public int? UpdatedBy { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public string Ip { get; set; } = null!;

    public virtual ICollection<AgentMaster> AgentMasterCreatedByNavigations { get; set; } = new List<AgentMaster>();

    public virtual ICollection<AgentMaster> AgentMasterUpdatedByNavigations { get; set; } = new List<AgentMaster>();

    public virtual ICollection<AgentMaster> AgentMasterUserMasters { get; set; } = new List<AgentMaster>();

    public virtual ICollection<Deal> DealCreatedByNavigations { get; set; } = new List<Deal>();

    public virtual ICollection<Deal> DealUpdatedByNavigations { get; set; } = new List<Deal>();

    public virtual ICollection<LoginHistory> LoginHistories { get; set; } = new List<LoginHistory>();

    public virtual Role Role { get; set; } = null!;
}
