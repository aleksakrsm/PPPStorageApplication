using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class Product
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public string MeasurementUnit { get; set; } = null!;

    public long CategoryId { get; set; }

    public long SupplierId { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual ICollection<ProductPrice> ProductPrices { get; set; } = new List<ProductPrice>();

    public virtual Supplier Supplier { get; set; } = null!;
}
