using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class DealDocument
{
    public long DealDocId { get; set; }

    public int DealId { get; set; }

    public string DocName { get; set; } = null!;

    public DateOnly UploadedDate { get; set; }

    public virtual Deal Deal { get; set; } = null!;
}
