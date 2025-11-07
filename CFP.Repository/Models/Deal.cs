using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class Deal
{
    public int DealId { get; set; }

    public string TypeOfCoverage { get; set; } = null!;

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public int NoOfApplicants { get; set; }

    public string Ffm { get; set; } = null!;

    public int Career { get; set; }

    public int TypeOfWork { get; set; }

    public int MonthlyIncome { get; set; }

    public int DocNeeded { get; set; }

    public int SocialProvided { get; set; }

    public int CustomerLanguage { get; set; }

    public DateTime CloseDate { get; set; }

    public string Notes { get; set; } = null!;

    public int AgentId { get; set; }

    public bool IsActive { get; set; }
    public int CreatedBy { get; set; }

    public DateTime CreatedOn { get; set; }

    public int? UpdatedBy { get; set; }

    public DateTime? UpdatedOn { get; set; }

    public string Ip { get; set; } = null!;

    public virtual AgentMaster Agent { get; set; } = null!;

    public virtual UserMaster CreatedByNavigation { get; set; } = null!;

    public virtual UserMaster? UpdatedByNavigation { get; set; }
}
