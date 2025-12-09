using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class MedicareJobApplicationsDoc
{
    public int JobApplicatonDocId { get; set; }

    public int JobApplicationId { get; set; }

    public int StateId { get; set; }

    public string DocName { get; set; } = null!;

    public virtual MedicareJobApplication JobApplication { get; set; } = null!;

    public virtual State State { get; set; } = null!;
}
