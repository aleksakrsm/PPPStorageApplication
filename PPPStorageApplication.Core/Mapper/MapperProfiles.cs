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
            CreateMap<Price, PriceDto>().ReverseMap();
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
            
            CreateMap<Product, ProductDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
            .ForMember(dest => dest.MeasurementUnit, opt => opt.MapFrom(src => src.MeasurementUnit))
            .ForMember(dest => dest.SupplierId, opt => opt.MapFrom(src => src.SupplierId))
            .ForMember(dest => dest.CategoryId, opt => opt.MapFrom(src => src.CategoryId))
            .ReverseMap()
            .ForPath(src => src.Id, opt => opt.MapFrom(dest => dest.Id))
            .ForPath(src => src.Name, opt => opt.MapFrom(dest => dest.Name))
            .ForPath(src => src.SupplierId, opt => opt.MapFrom(dest => dest.SupplierId))
            .ForPath(src => src.CategoryId, opt => opt.MapFrom(dest => dest.CategoryId))
            .ForPath(src => src.MeasurementUnit, opt => opt.MapFrom(dest => dest.MeasurementUnit));

            CreateMap<Product, ProductWithPriceDto>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.Name, opt => opt.MapFrom(src => src.Name))
            .ForMember(dest => dest.MeasurementUnit, opt => opt.MapFrom(src => src.MeasurementUnit))
            .ForMember(dest => dest.SupplierId, opt => opt.MapFrom(src => src.SupplierId))
            .ForMember(dest => dest.CategoryId, opt => opt.MapFrom(src => src.CategoryId))
            .ForMember(dest => dest.Price,
            opt => opt.MapFrom(
                src => ((src.ProductPrices != null && src.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null) != null) 
                            ? (src.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null).Price.Amount) : -1))
            );

            CreateMap<Order, OrderDto>()
            .ForMember(dest => dest.BuyerName, opt => opt.MapFrom(src => src.Buyer.LegalEntity.Name))
            .ForMember(dest => dest.Items, opt => opt.MapFrom(src => src.OrderItems));

            CreateMap<OrderItem, AddOrderItemDto>()
                .ForMember(dest => dest.product_id, opt => opt.MapFrom(src => src.ProductId))
                .ForMember(dest => dest.quantity, opt => opt.MapFrom(src => src.Quantity));

            CreateMap<OrderItem, OrderItemDto>()
                .ForMember(dest => dest.ProductName, opt => opt.MapFrom(src => src.Product.Name))
                .ForMember(dest => dest.ProductMeasurementUnit, opt => opt.MapFrom(src => src.Product.MeasurementUnit))
                .ForMember(dest => dest.quantity, opt => opt.MapFrom(src => src.Quantity));

            CreateMap<Order, AddOrderDto>()
            .ForMember(dest => dest.BuyerId, opt => opt.MapFrom(src => src.Buyer.LegalEntityId))
            .ForMember(dest => dest.Items, opt => opt.MapFrom(src => src.OrderItems));
        }
    }
}
