using PPPStorageApplication.Core.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Contracts
{
    public interface IProductService
    {
        public Task<List<ProductWithPriceDto>> GetAll();
        public Task<ProductWithPriceDto> GetById(long id);
        public Task<ProductWithPriceDto> Add(ProductWithPriceDto productWithPriceDto);

        public Task<ProductWithPriceDto> Update(ProductWithPriceDto productWithPriceDto);

        //public Task Delete(long productDtoId);
    }
}
