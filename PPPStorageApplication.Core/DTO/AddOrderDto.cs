using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.DTO
{
    public class AddOrderDto
    {
        public long Id { get; set; }
        public long BuyerId { get; set; }
        public List<AddOrderItemDto> Items { get; set; } = new List<AddOrderItemDto>()!;
        
    }
}
