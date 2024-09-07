using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class LegalEntity
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public long CityId { get; set; }

    public virtual Buyer? Buyer { get; set; }

    public virtual City City { get; set; } = null!;

    public virtual Supplier? Supplier { get; set; }
}
