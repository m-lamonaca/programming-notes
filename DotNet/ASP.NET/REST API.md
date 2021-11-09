# ASP .NET REST API

## Data Transfer Objects (DTOs)

A **DTO** is an object that defines how the data will be sent and received over the network (usually as JSON).
Without a DTO the JSON response (or request) could contain irrelevant, wrong or unformatted data.
Moreover, by decoupling the JSON response from the actual data model, it's possible to change the latter without breaking the API.
DTOs must be mapped to the internal methods.

Required NuGet Packages:

- AutoMapper.Extensions.Microsoft.DependencyInjection

In `StartUp.cs`:

```cs
using AutoMapper;

// ...

public void ConfigureServices(IServiceCollection services)
{
    // other services

    services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());  // set automapper service
}
```

In `EntityDTO.cs`:

```cs
namespace <Namespace>.DTOs
{
    // define the data to be serialized in JSON (can differ from model)
    public class EntityDTO
    {
        // only properties to be serialized
    }
}
```

In `EntitiesProfile.cs`:

```cs
using AutoMapper;
using <Namespace>.DTOs;
using <Namespace>.Model;

namespace <Namespace>.Profiles
{
    public class EntitiesProfile : Profile
    {
        public EntitiesProfile()
        {
            CreateMap<Entity, EntityDTO>();  // map entity to it's DTO
        }
    }
}
```

## Controller (No View)

```cs
[Route("api/endpoint")]
[ApiController]
public class EntitiesController : ControllerBase  // MVC controller w/o view
{
    private readonly ICommandRepo _repo;
    private readonly IMapper _mapper;  // AutoMapper class

    public EntitiesController(IEntityRepo repository, IMapper mapper)  
    {
        _repo = repository;
        _mapper = mapper
    }

    [HttpGet]  // GET api/endpoint
    public ActionResult<IEnumerable<EntityDTO>> SelectAllEntities()
    {
        var results = _repo.SelectAll();

        return Ok(_mapper.Map<EntityDTO>(results));
    }

    [HttpGet("{id}")]  // GET api/endpoint/{id}
    public ActionResult<EntityDTO> SelectOneEntityById(int id)
    {
        var result = _repo.SelectOneById(id);

        if(result != null)
        {
            // transform entity to it's DTO
            return Ok(_mapper.Map<EntityDTO>(result));
        }

        return NotFound();
    }
}
```

## Controller (With View)

```cs
[Route("api/endpoint")]
[ApiController]
public class EntitiesController : Controller
{
    private readonly AppDbContext _db;

    public EntitiesController(AppDbContext db)
    {
        _db = db;
    }

    [HttpGet]
    public IActionResult SelectAll()
    {
        return Json(new { data = _db.Entities.ToList() });  // json view
    }
}
```
