using PPPStorageApplication.Core.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Contracts
{
    public interface IBuyerService
    {
        public Task<List<BuyerDto>> GetAll();
        public Task<BuyerDto> GetById(long id);
        public Task<BuyerDto> Add(BuyerDto buyerDto);

        public Task<BuyerDto> Update(BuyerDto buyerDto);

        //public Task Delete(long buyerDtoId);
    }
}
