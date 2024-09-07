using System;
using System.Collections.Generic;

namespace PPPStorageApplication.Persistance.Models;

public partial class City
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<LegalEntity> LegalEntities { get; set; } = new List<LegalEntity>();
}
