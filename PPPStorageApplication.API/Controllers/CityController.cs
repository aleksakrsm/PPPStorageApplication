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
        
        [HttpGet]
        [Route("get/{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<CityDto>> GetById(int id)
        {
            try
            {
                var city = await _cityService.GetById(id);
                return Ok(city);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, $"Error: {ex.Message}");
            }
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<CityDto>> Add(CityDto cityDto)
        {
            return (await _cityService.Add(cityDto));
        }
        
        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task<ActionResult<CityDto>> Update(CityDto cityDto)
        {
            return (await _cityService.Update(cityDto));
        }
        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status500InternalServerError)]
        public async Task Delete(long cityDtoId)
        {
             await _cityService.Delete(cityDtoId);
        }


    }
}
