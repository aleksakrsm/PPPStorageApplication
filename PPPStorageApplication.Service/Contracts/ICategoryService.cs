using PPPStorageApplication.Core.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Contracts
{
    public interface ICategoryService
    {
        public Task<List<CategoryDto>> GetAll();
        public Task<CategoryDto> GetById(int id);
        public Task<CategoryDto> Add(CategoryDto categoryDto);

        public Task<CategoryDto> Update(CategoryDto categoryDto);
        public Task Delete(long categoryDtoId);
    }
}
