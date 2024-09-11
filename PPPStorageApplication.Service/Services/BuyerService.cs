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
    public class BuyerService : IBuyerService
    {
        private readonly IMapper _mapper;
        private readonly MyDbContext _db;


        public BuyerService(IMapper mapper, MyDbContext db)
        {
            _mapper = mapper;
            _db = db;
        }
        public async Task<List<BuyerDto>> GetAll()
        {
            var buyers = await _db.Buyers
            .Include(b => b.LegalEntity)
            .ThenInclude(le => le.City) // dodao sam siti kao pokazni primer za dibager
            .ToListAsync();
            return buyers != null ? buyers.Select(x => _mapper.Map<BuyerDto>(x)).ToList() : new List<BuyerDto>(); 
        }

        public async Task<BuyerDto> GetById(long id)
        {
            var buyer = await _db.Buyers
                .Include(b => b.LegalEntity)
                .FirstOrDefaultAsync(b => b.LegalEntityId == id);
            return buyer != null ? _mapper.Map<BuyerDto>(buyer) : throw new Exception("buyer does not exist");
        }


        public async Task<BuyerDto> Add(BuyerDto buyerDto)
        {
            using (var transaction = await _db.Database.BeginTransactionAsync()){
                try {
                    await _db.Database.ExecuteSqlRawAsync(
                        "CALL addBuyer(@Name, @CityId)",
                        new MySqlParameter("@Name", buyerDto.Name),
                        new MySqlParameter("@CityId", buyerDto.CityId));
                    var buyer = await _db.Buyers.Include(b => b.LegalEntity)
                        .FirstOrDefaultAsync(b => b.LegalEntity.Name == buyerDto.Name);
                    await transaction.CommitAsync();
                    if (buyer == null){
                        throw new Exception("Buyer not added to DB");
                    }
                    return _mapper.Map<BuyerDto>(buyer);
                } catch {
                    await transaction.RollbackAsync();
                    throw;
                }
            }
        }
        public async Task<BuyerDto> Update(BuyerDto buyerDto)
        {
            using (var transaction = await _db.Database.BeginTransactionAsync())
            {
                try
                {
                    await _db.Database.ExecuteSqlRawAsync("CALL updateBuyer({0},{1},{2})", buyerDto.Id, buyerDto.Name, buyerDto.CityId);

                    var buyer = await _db.Buyers.Include(b => b.LegalEntity)
                                .FirstOrDefaultAsync(b => b.LegalEntity.Name == buyerDto.Name && b.LegalEntity.CityId == buyerDto.CityId);
                    return buyer != null ? _mapper.Map<BuyerDto>(buyer) : throw new Exception("buyer not updated in db");
                }
                catch
                {
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
