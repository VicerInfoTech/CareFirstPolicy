using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class State
{
    public int StateId { get; set; }

    public string StateCode { get; set; } = null!;

    public string StateName { get; set; } = null!;

    public bool IsActive { get; set; }

    public virtual ICollection<MedicareJobApplication> MedicareJobApplications { get; set; } = new List<MedicareJobApplication>();

    public virtual ICollection<MedicareJobApplicationsDoc> MedicareJobApplicationsDocs { get; set; } = new List<MedicareJobApplicationsDoc>();
}
