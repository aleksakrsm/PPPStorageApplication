using PPPStorageApplication.Core.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Contracts
{
    public interface ICityService
    {
        public Task<List<CityDto>> GetAll();
        public Task<CityDto> GetById(int id);
        public Task<CityDto> Add(CityDto cityDto);

        public Task<CityDto> Update(CityDto cityDto);
        public Task Delete(long cityDtoId);
    }
}
