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
    public class CategoryService : ICategoryService
    {
        private readonly IMapper _mapper;
        private readonly MyDbContext _db;


        public CategoryService(IMapper mapper, MyDbContext db)
        {
            _mapper = mapper;
            _db = db;
        }
        public async Task<List<CategoryDto>> GetAll()
        {
            var categories = _db.Categories.FromSqlRaw("CALL getAllCategories").ToList();
            return categories != null ? categories.Select(x => _mapper.Map<CategoryDto>(x)).ToList() : new List<CategoryDto>(); 

        }

        public async Task<CategoryDto> GetById(int id)
        {
            var categories = _db.Categories.FromSqlRaw("CALL getCategoryById({0})", id).ToList();
            return categories.First() != null ? _mapper.Map<CategoryDto>(categories.First()): throw new Exception("category does not exist");
        }


        public async Task<CategoryDto> Add(CategoryDto categoryDto)
        {
            await _db.Database.ExecuteSqlRawAsync("CALL addCategory({0})", categoryDto.Name);

            var category = await _db.Categories
                .FromSqlRaw("SELECT * FROM category WHERE name = {0} LIMIT 1", categoryDto.Name)
                .FirstOrDefaultAsync();

            return category != null ? _mapper.Map<CategoryDto>(category) : throw new Exception("category not retrieved from db");
        }
        public async Task<CategoryDto> Update(CategoryDto categoryDto)
        {
            await _db.Database.ExecuteSqlRawAsync("CALL updateCategory({0},{1})", categoryDto.Name, categoryDto.Id);

            var category = await _db.Categories
                .FromSqlRaw("SELECT * FROM category WHERE name = {0} LIMIT 1", categoryDto.Name)
                .FirstOrDefaultAsync();

            return category != null ? _mapper.Map<CategoryDto>(category) : throw new Exception("category not updated in db");
        }
        public async Task Delete(long categoryDtoId)
        {
            await _db.Database.ExecuteSqlRawAsync("CALL deleteCategory({0})", categoryDtoId);

            var category = await _db.Categories
                .FromSqlRaw("SELECT * FROM category WHERE ID = {0} LIMIT 1", categoryDtoId)
                .FirstOrDefaultAsync();

            if (category != null)
            {
                throw new Exception("category was not deleted from the database.");
            }
        }


    }
}
