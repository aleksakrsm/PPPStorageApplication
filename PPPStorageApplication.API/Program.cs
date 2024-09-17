using AutoMapper;
using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using PPPStorageApplication.Persistance;
using PPPStorageApplication.Core.Mapper;
using PPPStorageApplication.Service.Contracts;
using PPPStorageApplication.Service.Services;

var builder = WebApplication.CreateBuilder(args);


builder.Logging.ClearProviders();
builder.Logging.AddConsole();

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
builder.Services.AddTransient<IProductService, ProductService>();
builder.Services.AddTransient<IOrderService, OrderService>();
builder.Services.AddTransient<ProductToProductWithPriceDtoConverter, ProductToProductWithPriceDtoConverter>();

builder.Services.AddDbContext<MyDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetSection("Database").GetValue<string>("ConnectionString"),
        ServerVersion.AutoDetect(builder.Configuration.GetSection("Database").GetValue<string>("ConnectionString"))
    ));

//builder.Services.AddDbContext<MyDbContext>(options =>
    //options.UseMySql("server=localhost;port=3306;database=ppp_skladiste;uid=root;password=krs3414ale.;SslMode=Preferred",
    //ServerVersion.AutoDetect("server=localhost;port=3306;database=ppp_skladiste;uid=root;password=krs3414ale.;SslMode=Preferred")));

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
