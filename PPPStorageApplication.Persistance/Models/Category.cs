﻿using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class Category
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
