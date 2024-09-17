using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.DTO
{
    public class OrderItemDto
    {
        public string ProductName { get; set; } = null!;
        public string ProductMeasurementUnit { get; set; } = null!;

        public long quantity { get; set; }
    }
}
