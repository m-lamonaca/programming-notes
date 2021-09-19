# ASP .NET REST API

## Data Transfer Objects (DTOs)

A **DTO** is an object that defines how the data will be sent and recieved over the network (usually as JSON).
Without a DTO the JSON response (or reqest) could contain irrilevant, wrong or unformatted data.
Moreover, by decoupling the JSON response from the actual data model, it's possible to change the latter without breaking the API.
DTOs must be mapped to the internal methods.

In `EntityDTO.cs`:

```cs
namespace <Namespace>.DTOs
{
    // define the data to be serialized in JSON (differs from model)
    public class EntityDTO
    {
        // only properties to be serialized
    }
}
```

### DTO mapping with Automapper

Required NuGet Packages:

- `AutoMapper`
- `AutoMapper.Extensions.Microsoft.DependencyInjection`

A good way to organize mapping configurations is with *profiles*.  

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

Uses [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) to recieve a suitable implementation of `IEntityRepo`,

### Service Lifetimes

- `AddSingleton`: same for every request
- `AddScoped`: created once per client
- `Transient`: new instance created every time

In `Startup.cs`:

```cs
// This method gets called by the runtime. Use this method to add services to the container.
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();
    services.AddScoped<IEntityRepo, EntityRepo>();  // map the interface to its implementation, needed for dependency injection
}
```

### Request Mappings

```cs
using <App>.Model;
using <App>.Repo;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace <App>.Controllers
{
    [Route("api/endpoint")]
    [ApiController]
    public class EntitiesController : ControllerBase  // MVC controller w/o view
    {
        // service or repo (DAL) injection
        
        private readonly IMapper _mapper;  // AutoMapper class

        [HttpGet]  // GET api/endpoint
        public ActionResult<EntityDTO> SelectAllEntities()
        {
            ...

            return Ok(_mapper.Map<EntityDTO>(entity));
        }
    }
}
```

## Simple API Controller

```cs
[Route("api/endpoint")]
[ApiController]
public class EntitiesController : ControllerBase
{
    // service or repo (DAL) injection

    [HttpGet]
    public ActionResult<TEntity> SelectAll()
    {
        ...
        return Ok(entity);
    }
}
```
