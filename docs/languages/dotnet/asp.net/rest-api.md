# ASP.NET REST API

```cs
[Route("api/endpoint")]
[ApiController]
public class EntitiesController : ControllerBase  // API controller
{
    private readonly IEntityService _service;

    public EntitiesController(IEntityService service, IMapper mapper)  
    {
        _service = service;
        _mapper = mapper
    }

    [HttpGet]  // GET api/endpoint
    public ActionResult<IEnumerable<EntityDTO>> GetEntities()
    {
        IEnumerable<EntityDTO> results = /* ...  */
        return Ok(results);
    }

    [HttpGet("{id}")]  // GET api/endpoint/{id}
    public ActionResult<EntityDTO> GetEntityById(int id)
    {
        var result = /* .. */;

        if(result != null)
        {
            return Ok(result);
        }

        return NotFound();
    }

    [HttpPost]  // POST api/endpoint
    public ActionResult<EntityDTO> CreateEntity([FromBody] EntityDTO entity)
    {
        // persist the entity

        var id = /* ID of the created entity */
        return Created(id, entity);
    }

    [HttpPut]  // PUT api/endpoint
    public ActionResult<EntityDTO> UpdateEntity([FromBody] EntityDTO entity)
    {
        // persist the updated entity

        return Created(uri, entity);
    }
}
```
