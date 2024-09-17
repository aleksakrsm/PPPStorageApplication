using PPPStorageApplication.Core.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Contracts
{
    public interface IOrderService
    {
        public Task<List<OrderDto>> GetAll();
        public Task<OrderDto> GetById(long id);
        public Task Add(AddOrderDto orderDto);

        //public Task<long> GetTotalPrice(long id);

        //public Task Delete(long orderDtoId);
    }
}
