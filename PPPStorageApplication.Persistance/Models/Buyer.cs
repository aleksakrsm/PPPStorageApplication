using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class Buyer
{
    public long LegalEntityId { get; set; }

    public virtual LegalEntity LegalEntity { get; set; } = null!;

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
