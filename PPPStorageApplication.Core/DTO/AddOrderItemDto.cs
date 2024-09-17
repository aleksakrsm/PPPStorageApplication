using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.DTO
{
    public class AddOrderItemDto
    {
        public long product_id { get; set; }

        public long quantity { get; set; }
    }
}
