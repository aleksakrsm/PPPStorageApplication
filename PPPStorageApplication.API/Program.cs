using AutoMapper;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using PPPStorageApplication.Persistance;
using PPPStorageApplication.Core.Mapper;
using PPPStorageApplication.Service.Contracts;
using PPPStorageApplication.Service.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var mappingConfig = new MapperConfiguration(mc =>
{
    mc.AddProfile(new MapperProfiles());
});

IMapper mapper = mappingConfig.CreateMapper();
builder.Services.AddSingleton(mapper);

builder.Services.AddTransient<ICityService, CityService>();//svaki put pravi novu instancu
builder.Services.AddTransient<ICategoryService, CategoryService>();
builder.Services.AddTransient<IBuyerService, BuyerService>();
builder.Services.AddTransient<ISupplierService, SupplierService>();

builder.Services.AddDbContext<MyDbContext>(options =>
    options.UseMySql(builder.Configuration.GetSection("Database")
    .GetSection("ConnectionString").Value,
    ServerVersion.AutoDetect(builder.Configuration.GetSection("Database")
    .GetSection("ConnectionString").Value)));

builder.Services.AddControllers();

builder.Services.AddSwaggerGen(option => {
    option.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "PPPStorageApplication",
        Version = "v1"
    });
});

var app = builder.Build();
app.UseSwagger();
app.UseSwaggerUI();

// Configure the HTTP request pipeline.

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
