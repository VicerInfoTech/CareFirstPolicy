using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class AppMaster
{
    public int AppId { get; set; }

    public string AppName { get; set; } = null!;

    public string AppDesc { get; set; } = null!;

    public string LogoName { get; set; } = null!;

    public bool IsActive { get; set; }

    public virtual ICollection<AgentApp> AgentApps { get; set; } = new List<AgentApp>();

    public virtual ICollection<Menu> Menus { get; set; } = new List<Menu>();
}
