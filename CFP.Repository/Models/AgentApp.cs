using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class AgentApp
{
    public int AgentAppId { get; set; }

    public int AgentId { get; set; }

    public int AppId { get; set; }

    public bool IsActive { get; set; }

    public int CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public int? UpdatedBy { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public string Ip { get; set; } = null!;

    public virtual AgentMaster Agent { get; set; } = null!;

    public virtual AppMaster App { get; set; } = null!;

    public virtual UserMaster CreatedByNavigation { get; set; } = null!;

    public virtual UserMaster? UpdatedByNavigation { get; set; }
}
