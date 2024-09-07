using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class Supplier
{
    public long LegalEntityId { get; set; }

    public virtual LegalEntity LegalEntity { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
