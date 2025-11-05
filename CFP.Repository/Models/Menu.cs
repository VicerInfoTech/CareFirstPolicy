using System;
using System.Collections.Generic;

namespace CFP.Repository.Models;

public partial class Menu
{
    public int MenuId { get; set; }

    public string MenuName { get; set; } = null!;

    public string MenuNameId { get; set; } = null!;

    public string PageUrl { get; set; } = null!;

    public string Icon { get; set; } = null!;

    public int ParentId { get; set; }

    public short DisplayOrder { get; set; }

    public bool IsHaveChild { get; set; }

    public bool IsActive { get; set; }

    public bool IsShowtoAdmin { get; set; }

    public virtual ICollection<MenuRole> MenuRoles { get; set; } = new List<MenuRole>();
}
