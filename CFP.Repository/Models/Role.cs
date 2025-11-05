using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class Role
{
    public int RoleId { get; set; }

    public string RoleName { get; set; } = null!;

    public bool IsActive { get; set; }

    public virtual ICollection<MenuRole> MenuRoles { get; set; } = new List<MenuRole>();

    public virtual ICollection<UserMaster> UserMasters { get; set; } = new List<UserMaster>();
}
