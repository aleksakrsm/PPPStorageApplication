using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class ProductPrice
{
    public long ProductId { get; set; }

    public long PriceId { get; set; }

    public DateTime StartingDate { get; set; }

    public DateTime? EndingDate { get; set; } = null!;

    public virtual Price Price { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
