using AutoMapper;
using Microsoft.EntityFrameworkCore;
using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Persistance;
using PPPStorageApplication.Persistance.Models;
using PPPStorageApplication.Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
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
            var cities = _db.Cities.FromSqlRaw("CALL getAllCities").ToList();
            return cities != null ? cities.Select(x => _mapper.Map<CityDto>(x)).ToList() : new List<CityDto>(); 

        }

        public async Task<CityDto> GetById(int id)
        {
            var cities = _db.Cities.FromSqlRaw("CALL getCityById({0})", id).ToList();
            return cities.First() != null ? _mapper.Map<CityDto>(cities.First()): throw new Exception("city does not exist");
        }


        public async Task<CityDto> Add(CityDto cityDto)
        {
            await _db.Database.ExecuteSqlRawAsync("CALL addCity({0})", cityDto.Name);

            var city = await _db.Cities
                .FromSqlRaw("SELECT * FROM city WHERE name = {0} LIMIT 1", cityDto.Name)
                .FirstOrDefaultAsync();

            return city != null ? _mapper.Map<CityDto>(city) : throw new Exception("City not retrieved from db");
        }
        public async Task<CityDto> Update(CityDto cityDto)
        {
            await _db.Database.ExecuteSqlRawAsync("CALL updateCity({0},{1})", cityDto.Name, cityDto.Id);

            var city = await _db.Cities
                .FromSqlRaw("SELECT * FROM city WHERE name = {0} LIMIT 1", cityDto.Name)
                .FirstOrDefaultAsync();

            return city != null ? _mapper.Map<CityDto>(city) : throw new Exception("City not updated from db");
        }
        public async Task Delete(long cityDtoId)
        {
            await _db.Database.ExecuteSqlRawAsync("CALL deleteCity({0})", cityDtoId);

            var city = await _db.Cities
                .FromSqlRaw("SELECT * FROM city WHERE ID = {0} LIMIT 1", cityDtoId)
                .FirstOrDefaultAsync();

            if (city != null)
            {
                throw new Exception("City was not deleted from the database.");
            }
        }


    }
}
