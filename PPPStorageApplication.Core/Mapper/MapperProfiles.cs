using AutoMapper;
using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Persistance.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.Mapper
{
    public class MapperProfiles : Profile
    {
        public MapperProfiles()
        {
            CreateMap<City, CityDto>().ReverseMap();
        }
    }
}
