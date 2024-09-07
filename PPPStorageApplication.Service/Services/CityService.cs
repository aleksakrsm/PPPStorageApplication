using AutoMapper;
using Microsoft.EntityFrameworkCore;
using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Persistance;
using PPPStorageApplication.Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Service.Services
{
    public class CityService : ICityService
    {
        private readonly IMapper _mapper;
        private readonly MyDbContext _db;


        public CityService(IMapper mapper, MyDbContext db)
        {
            _mapper = mapper;
            _db = db;
        }
        public async Task<List<CityDto>> GetAll()
        {
            //var cities1 = _db.Cities.FromSql(FormattableString).ToList();
            var cities = _db.Cities.FromSqlRaw("CALL getAllCities").ToList();
            return cities != null ? cities.Select(x => _mapper.Map<CityDto>(x)).ToList() : new List<CityDto>(); 

        }
    }
}
