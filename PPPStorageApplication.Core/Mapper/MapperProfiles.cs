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
            CreateMap<Category, CategoryDto>().ReverseMap();
            CreateMap<Buyer, BuyerDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.LegalEntity.Id))
            .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.LegalEntity.Name))
            .ForMember(dest => dest.CityId, opt => opt.MapFrom(src => src.LegalEntity.CityId))
            .ReverseMap()
            .ForPath(src => src.LegalEntity.Id, opt => opt.MapFrom(dest => dest.Id))
            .ForPath(src => src.LegalEntity.Name, opt => opt.MapFrom(dest => dest.Name))
            .ForPath(src => src.LegalEntity.CityId, opt => opt.MapFrom(dest => dest.CityId));
            CreateMap<Supplier, SupplierDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.LegalEntity.Id))
            .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.LegalEntity.Name))
            .ForMember(dest => dest.CityId, opt => opt.MapFrom(src => src.LegalEntity.CityId))
            .ReverseMap()
            .ForPath(src => src.LegalEntity.Id, opt => opt.MapFrom(dest => dest.Id))
            .ForPath(src => src.LegalEntity.Name, opt => opt.MapFrom(dest => dest.Name))
            .ForPath(src => src.LegalEntity.CityId, opt => opt.MapFrom(dest => dest.CityId));

        }
    }
}
