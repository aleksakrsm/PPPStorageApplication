using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class Order
{
    public long Id { get; set; }

    public DateTime Timestamp { get; set; }

    public long BuyerId { get; set; }

    public virtual Buyer Buyer { get; set; } = null!;

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
}
