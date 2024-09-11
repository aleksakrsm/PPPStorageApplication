using PPPStorageApplication.Core.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Contracts
{
    public interface ISupplierService
    {
        public Task<List<SupplierDto>> GetAll();
        public Task<SupplierDto> GetById(long id);
        public Task<SupplierDto> Add(SupplierDto supplierDto);

        public Task<SupplierDto> Update(SupplierDto supplierDto);

        //public Task Delete(long supplierDtoId);
    }
}
