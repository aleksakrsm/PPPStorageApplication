using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class ProductPrice
{
    public long ProductId { get; set; }

    public long PriceId { get; set; }

    public DateOnly StartingDate { get; set; }

    public DateOnly EndingDate { get; set; }

    public virtual Price Price { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;
}
