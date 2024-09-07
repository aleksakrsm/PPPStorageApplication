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
    }
}
