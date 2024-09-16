using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.DTO
{
    public class ProductDto
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string MeasurementUnit { get; set; } = null!;
        public long SupplierId{ get; set; }
        public long CategoryId { get; set; }
    }
}
