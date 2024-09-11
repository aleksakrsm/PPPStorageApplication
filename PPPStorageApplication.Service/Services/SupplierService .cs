using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MySqlConnector;
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
    public class SupplierService : ISupplierService
    {
        private readonly IMapper _mapper;
        private readonly MyDbContext _db;


        public SupplierService(IMapper mapper, MyDbContext db)
        {
            _mapper = mapper;
            _db = db;
        }
        public async Task<List<SupplierDto>> GetAll()
        {
            var suppliers = await _db.Suppliers
            .Include(s => s.LegalEntity)
            .ToListAsync();
            return suppliers != null ? suppliers.Select(x => _mapper.Map<SupplierDto>(x)).ToList() : new List<SupplierDto>(); 
        }

        public async Task<SupplierDto> GetById(long id)
        {
            var supplier = await _db.Suppliers
                .Include(s => s.LegalEntity)
                .FirstOrDefaultAsync(s => s.LegalEntityId == id);
            return supplier != null ? _mapper.Map<SupplierDto>(supplier) : throw new Exception("supplier does not exist");
        }


        public async Task<SupplierDto> Add(SupplierDto supplierDto)
        {
            using (var transaction = await _db.Database.BeginTransactionAsync()){
                try {
                    await _db.Database.ExecuteSqlRawAsync(
                        "CALL addSupplier(@Name, @CityId)",
                        new MySqlParameter("@Name", supplierDto.Name),
                        new MySqlParameter("@CityId", supplierDto.CityId));
                    var supplier = await _db.Suppliers.Include(s => s.LegalEntity)
                        .FirstOrDefaultAsync(b => b.LegalEntity.Name == supplierDto.Name);
                    await transaction.CommitAsync();
                    if (supplier == null){
                        throw new Exception("Supplier not added to DB");
                    }
                    return _mapper.Map<SupplierDto>(supplier);
                } catch {
                    await transaction.RollbackAsync();
                    throw;
                }
            }
        }
        public async Task<SupplierDto> Update(SupplierDto supplierDto)
        {
            using (var transaction = await _db.Database.BeginTransactionAsync())
            {
                try
                {
                    await _db.Database.ExecuteSqlRawAsync("CALL updateSupplier({0},{1},{2})", supplierDto.Id, supplierDto.Name, supplierDto.CityId);

                    var supplier = await _db.Buyers.Include(s => s.LegalEntity)
                                .FirstOrDefaultAsync(s => s.LegalEntity.Name == supplierDto.Name && s.LegalEntity.CityId == supplierDto.CityId);
                    return supplier != null ? _mapper.Map<SupplierDto>(supplier) : throw new Exception("supplier not updated in db");
                }
                catch
                {
                    await transaction.RollbackAsync();
                    throw;
                }
            }
            
        }
        //public async Task Delete(long supplierDtoId)
        //{
        //    await _db.Database.ExecuteSqlRawAsync("CALL deleteSupplier({0})", supplierDtoId);

        //    var buyer = await _db.Suppliers
        //        .FromSqlRaw("SELECT * FROM supplier WHERE ID = {0} LIMIT 1", supplierDtoId)
        //        .FirstOrDefaultAsync();

        //    if (supplier != null)
        //    {
        //        throw new Exception("supplier was not deleted from the database.");
        //    }
        //}


    }
}
