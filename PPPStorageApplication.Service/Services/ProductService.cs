using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MySqlConnector;
using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Core.Mapper;
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
    public class ProductService : IProductService
    {
        private readonly IMapper _mapper;
        private readonly MyDbContext _db;
        private readonly ProductToProductWithPriceDtoConverter _productToProductWithPriceDtoConverter;


        public ProductService(IMapper mapper, MyDbContext db, ProductToProductWithPriceDtoConverter productToProductWithPriceDtoConverter)
        {
            _mapper = mapper;
            _db = db;
            _productToProductWithPriceDtoConverter = productToProductWithPriceDtoConverter;
        }
        public async Task<List<ProductWithPriceDto>> GetAll()
        {
            var products = await _db.Products.AsNoTracking()
            .Include(p => p.ProductPrices.Where(pp => pp.EndingDate == null))
            .ThenInclude(ppp => ppp.Price)
            .ToListAsync();
            return products != null ? products.Select(x => _mapper.Map<ProductWithPriceDto>(x)).ToList() : new List<ProductWithPriceDto>(); 
        }

        public async Task<ProductWithPriceDto> GetById(long id)
        {
            var product = await _db.Products
                .Include(pp => pp.ProductPrices)
                .ThenInclude(ppp => ppp.Price)
                .FirstOrDefaultAsync(p => p.Id == id);
            return product != null ? _mapper.Map<ProductWithPriceDto>(product) : throw new Exception("product does not exist");
        }


        public async Task<ProductWithPriceDto> Add(ProductWithPriceDto productWithPriceDto)
        {
                    await _db.Database.ExecuteSqlRawAsync(
                        "CALL addProductWithOrWithoutPrice(@Name, @MeasurementUnit, @CategoryId, @SupplierId, @PriceAmount)",
                        new MySqlParameter("@Name", productWithPriceDto.Name),
                        new MySqlParameter("@MeasurementUnit", productWithPriceDto.MeasurementUnit),
                        new MySqlParameter("@SupplierId", productWithPriceDto.SupplierId),
                        new MySqlParameter("@PriceAmount", productWithPriceDto.Price),
                        new MySqlParameter("@CategoryId", productWithPriceDto.CategoryId));
                    var product = await _db.Products
                .Include(pp => pp.ProductPrices)
                .ThenInclude(ppp => ppp.Price)
                .FirstOrDefaultAsync(p => p.Name == productWithPriceDto.Name);
                    if (product == null)
                    {
                        throw new Exception("Product not added to DB");
                    }
                    return _mapper.Map<ProductWithPriceDto>(product);
        }

        public async Task<ProductWithPriceDto> Update(ProductWithPriceDto productWithPriceDto)
        {
            using (var transaction = await _db.Database.BeginTransactionAsync())
            {
                try
                {
                    await _db.Database.ExecuteSqlRawAsync(
                        "CALL updateProductWithPrice(@Id, @Name, @MeasurementUnit, @CategoryId, @SupplierId, @PriceAmount)",
                        new MySqlParameter("@Id", productWithPriceDto.Id),
                        new MySqlParameter("@Name", productWithPriceDto.Name),
                        new MySqlParameter("@MeasurementUnit", productWithPriceDto.MeasurementUnit),
                        new MySqlParameter("@SupplierId", productWithPriceDto.SupplierId),
                        new MySqlParameter("@PriceAmount", productWithPriceDto.Price),
                        new MySqlParameter("@CategoryId", productWithPriceDto.CategoryId));

                    var product = await _db.Products
                    .Include(pp => pp.ProductPrices)
                    .ThenInclude(ppp => ppp.Price)
                    .FirstOrDefaultAsync(p => p.Name == productWithPriceDto.Name);

                    return product != null ? _mapper.Map<ProductWithPriceDto>(product) : throw new Exception("product not updated in db");
                }
                catch(Exception e)
                {
                    Console.Write(e.StackTrace);
                    await transaction.RollbackAsync();
                    throw;
                }
            }
        }

        //public async Task Delete(long buyerDtoId)
        //{
        //    await _db.Database.ExecuteSqlRawAsync("CALL deleteBuyer({0})", buyerDtoId);

        //    var buyer = await _db.Buyers
        //        .FromSqlRaw("SELECT * FROM buyer WHERE ID = {0} LIMIT 1", buyerDtoId)
        //        .FirstOrDefaultAsync();

        //    if (buyer != null)
        //    {
        //        throw new Exception("buyer was not deleted from the database.");
        //    }
        //}


    }
}
