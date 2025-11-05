using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class LoginFailure
{
    public long LoginFailureId { get; set; }

    public string Username { get; set; } = null!;

    public DateTime CreatedOn { get; set; }

    public string Ip { get; set; } = null!;
}
