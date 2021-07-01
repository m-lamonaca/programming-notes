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

In `StartUp.cs`:

```cs
public void ConfigureServices(IServiceCollection services)
{
    // other services

    // let AutoMapper know in what assemblies are the profiles defined
    services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

    // or create a MapperConfiguration
    services.AddAutoMapper(cfg => {
        cfg.CreateMap<Foo, Bar>();
        cfg.AddProfile<FooProfile>();
    })
}
```

### Controller with DTOs

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
