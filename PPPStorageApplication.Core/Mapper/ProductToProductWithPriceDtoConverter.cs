using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Persistance.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PPPStorageApplication.Core.Mapper
{
    public class ProductToProductWithPriceDtoConverter : ICustomMapper<Product, ProductWithPriceDto>
    {
        public ProductWithPriceDto convert(Product source)
        {
            //var amount = source.ProductPrices != null ? source.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null).Price.Amount : -1;
            //var currentProductPriceAmount = (source.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null) == null) ? source.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null).Price.Amount : -1;
            //var amount = source.ProductPrices != null ? source.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null).Price.Amount : -1;
            var productPrice = source.ProductPrices.FirstOrDefault(pp => pp.EndingDate == null);
            var amount = productPrice != null ? productPrice.Price.Amount : -1;

            var convertedObject = new ProductWithPriceDto();
            convertedObject.Id = source.Id;
            convertedObject.Name = source.Name;
            convertedObject.MeasurementUnit = source.MeasurementUnit;
            convertedObject.SupplierId = source.SupplierId;
            convertedObject.CategoryId = source.CategoryId;
            convertedObject.Price = amount;
            return convertedObject;
        }
    }
}
