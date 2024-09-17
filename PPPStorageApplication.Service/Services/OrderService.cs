using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MySqlConnector;
using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Core.Mapper;
using PPPStorageApplication.Persistance;
using PPPStorageApplication.Persistance.Models;
using PPPStorageApplication.Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Services
{
    
    public class OrderService : IOrderService
    {
        private readonly IMapper _mapper;
        private readonly MyDbContext _db;


        public OrderService(IMapper mapper, MyDbContext db)
        {
            _mapper = mapper;
            _db = db;
        }
        public async Task<List<OrderDto>> GetAll()
        {
            var orders = await _db.Orders
            .Include(o=>o.OrderItems)
            .ThenInclude(i=>i.Product)
            .Include(o=>o.Buyer)
            .ThenInclude(b=>b.LegalEntity)
            .ToListAsync();
            return orders != null ? orders.Select(x => _mapper.Map<OrderDto>(x)).ToList() : new List<OrderDto>();
        }

        public async Task<OrderDto> GetById(long id)
        {
            var order = await _db.Orders
            .Include(o => o.OrderItems)
            .ThenInclude(i => i.Product)
            .Include(o => o.Buyer)
            .ThenInclude(b => b.LegalEntity)
            .FirstOrDefaultAsync(o => o.Id == id);
            return order != null ? _mapper.Map<OrderDto>(order) : throw new Exception("order does not exist");
        }


        public async Task Add(AddOrderDto orderDto)
        {
            await _db.Database.ExecuteSqlRawAsync(
            "CALL addOrderWithItems(@buyerId, @orderItemsJson)",
            new MySqlParameter("@buyerId", orderDto.BuyerId),
            new MySqlParameter("@orderItemsJson", JsonSerializer.Serialize(orderDto.Items))
            );
        }
    }

}
