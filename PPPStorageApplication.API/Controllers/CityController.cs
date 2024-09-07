using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PPPStorageApplication.Core.DTO;
using PPPStorageApplication.Service.Contracts;

namespace PPPStorageApplication.API.Controllers
{
    [Route("api/city")]
    [ApiController]
    public class CityController : ControllerBase
    {
        private readonly ICityService _cityService;
        public CityController(ICityService cityService) {
            _cityService = cityService;
        }

        [HttpGet]
        [Route("get/all")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<List<CityDto>>> GetAll()
        {
            return (await _cityService.GetAll());
        }


    }
}
