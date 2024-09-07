using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class Price
{
    public long Id { get; set; }

    public double Amount { get; set; }

    public virtual ICollection<ProductPrice> ProductPrices { get; set; } = new List<ProductPrice>();
}
