﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.DTO
{
    public class OrderDto
    {
        public long Id { get; set; }
        public string BuyerName { get; set; } = null!;
        public List<OrderItemDto> Items { get; set; } = new List<OrderItemDto>()!;
        
    }
}
