# ASP .NET REST API

## Startup class

- Called by `Program.cs`

```cs
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace <Namespace>
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();  // controllers w/o views
            //or
            services.AddControllersWithViews();  // MVC Controllers
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
```

## DB Context (EF to access DB)

NuGet Packages to install:

- `Microsoft.EntityFrameworkCore`
- `Microsoft.EntityFrameworkCore.Tools`
- `Microsoft.EntityFrameworkCore.Design` *or* `Microsoft.EntityFrameworkCore.<db_provider>.Design`
- `Microsoft.EntityFrameworkCore.<db_provider>`

In `AppDbContext.cs`:

```cs
using <Namespace>.Model;
using Microsoft.EntityFrameworkCore;

namespace <Namespace>.Repo
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<ProjectContext> options) : base(options)
        {

        }
        //DBSet<TEntity> represents the collection of all entities in the context, or that can be queried from the database, of a given type
        public DbSet<Entity> entities { get; set; }
    }
}
```

In `appsettings.json`:

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
    "AllowedHosts": "*",
    "ConnectionStrings": {
        "CommanderConnection" :  "Server=<server>;Database=<database>;UID=<user>;Pwd=<password>"
    }
}
```

In `Startup.cs`:

```cs
// This method gets called by the runtime. Use this method to add services to the container.
public void ConfigureServices(IServiceCollection services)
{
    // SqlServer is the db used in this example
    services.AddDbContext<CommanderContext>(option => option.UseSqlServer(Configuration.GetConnectionString("CommanderConnection")));
    services.AddControllers();
}
```

### Migrations

- Mirroring of model in the DB.
- Will create & update DB Schema if necessary

In Package Manager Shell:

```ps1
add-migrations <migration_name>
update-database  # use the migrations to modify the db
```

## Repository

In `IEntityRepo`:

```cs
using <Namespace>.Model;
using System.Collections.Generic;

namespace <Namespace>.Repository
{
    public interface IEntityRepo
    {
        IEnumerable<Entity> SelectAll();
        Entity SelectOneById(int id);

        ...
    }
}
```

In `EntityRepo`:

```cs
using <Namespace>.Model;
using System.Collections.Generic;

namespace <Namespace>.Repo
{
    public class EntityRepo : IEntityRepo
    {
        private readonly AppDbContext _context;

        public  EntityRepo(AppDbContext context)
        {
            _context = context;
        }

        public IEnumerable<Entity> SelectAll()
        {
            return _context.Entities.ToList();  // linq query (ToList()) becomes sql query
        }

        public Entity SelectOneById(int id)
        {
            return _context.Entities.FirstOrDefault(p => p.Id == id);
        }

        ...
    }
}
```

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

In `Entity<CrudOperation>DTO.cs`:

```cs
namespace <Namespace>.DTOs
{
    // define the data to be serialized in JSON (can differ from model)
    public class EntityCrudOpDTO  // e.g: EntityReadDTO, ...
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
            CreateMap<Entity, EntityCrudOpDTO>();  // map entity to it's DTO
        }
    }
}
```

## Controller (No View)

Uses [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) to receive a suitable implementation of `IEntityRepo`,

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
        private readonly ICommandRepo _repo;
        private readonly IMapper _mapper;  // AutoMapper class

        public EntitiesController(IEntityRepo repository, IMapper mapper)  // injection og the dependency
        {
            _repo = repository;
            _mapper = mapper
        }

        [HttpGet]  // GET api/endpoint
        public ActionResult<IEnumerable<EntityCrudOpDTO>> SelectAllEntities()
        {
            var results = _repo.SelectAll();

            return Ok(_mapper.Map<EntityCrudOpDTO>(results));  // return an action result OK (200) with the results
        }

        // default binding source: [FromRoute]
        [HttpGet("{id}")]  // GET api/endpoint/{id}
        public ActionResult<EntityCrudOpDTO> SelectOneEntityById(int id)
        {
            var result = _repo.SelectOneById(id);

            if(result != null)
            {
                return Ok(_mapper.Map<EntityCrudOp>(result));  // transform entity to it's DTO
            }

            return NotFound();  // ActionResult NOT FOUND  (404)
        }
    }
}
```

## Controller (With View)

```cs
using <App>.Model;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace <App>.Controllers
{
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
}
```
