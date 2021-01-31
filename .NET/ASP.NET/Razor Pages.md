# Razor Pages

## Project Structure

```txt
Project
|-Properties
| |- launchSettings.json
|
|-wwwroot  --> static files
| |-css
| | |- site.css
| |
| |-js
| | |- site.js
| |
| |-lib
| | |- jquery
| | |- bootstrap
| | |- ...
| |
| |- favicon.ico
|
|-Pages
| |-Shared
| | |- _Layout.cshtml  --> reusable default page layout
| | |- _ValidationScriptsPartial  --> jquery validation script imports
| |
| |- _ViewImports.cshtml  --> shared imports and tag helpers for all views
| |- _ViewStart.cshtml  --> shared values for all views
| |- Index.cshtml
| |- Index.cshtml.cs
| |- ...
|
|- appsettings.json --> application settings
|- Program.cs  --> App entrypoint
|- Startup.cs
```

**Note**: `_` prefix indicates page to be imported

Razor Pages components:

- Razor Page (UI/View - `.cshtml`)
- Page Model (Handlers - `.cshtml.cs`)

in `Index.cshtml`:

```cs
@page  // mark as Razor Page
@model IndexModel  // Link Page Model

@{
    ViewData["Title"] = "Page Title"  // same as <title>Page Title</title>
}

// body contents
```

in `Page.cshtml.cs`:

```cs
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace App.Pages
{
    public class IndexModel : PageModel
    {
        // HTTP Method
        public void OnGet() { }

        // HTTP Method
        public void OnPost() { }
    }
}
```

## Important Files

### `Program.cs`

```cs
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace App
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();  // start and config ASP.NET App
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();  // config handled in Startup.cs
                });
    }
}
```

### `Startup.cs`

```cs
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace App
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
            // use Razor Pages
            // runtime compilation needs Microsoft.AspNetCore.Mvc.Razor.RuntimeCompilation pkg
            services.AddRazorPages().AddRazorRuntimeCompilation();

            // set db context for the app using the connection string
            services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("DefaultConnection")));

            // Captures synchronous and asynchronous Exception instances from the pipeline and generates HTML error responses.
            services.AddDatabaseDeveloperPageExceptionFilter();

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapRazorPages();
            });
        }
    }
}
```

### `appsettings.json`

Connection Strings & Secrets.

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*"
}
```

### `launchsettings.json`

Launch Settings & Deployement Settings.

```json
{
  "iisSettings": {
    "windowsAuthentication": false,
    "anonymousAuthentication": true,
    "iisExpress": {
      "applicationUrl": "http://localhost:51144",
      "sslPort": 44335
    }
  },
  "profiles": {
    "IIS Express": {
      "commandName": "IISExpress",
      "launchBrowser": true,
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    },
    "BookListRazor": {
      "commandName": "Project",
      "dotnetRunMessages": "true",
      "launchBrowser": true,
      "applicationUrl": "https://localhost:5001;http://localhost:5000",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}
```

## Razor Page

```cs
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace App.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ApplicationDbContext _db; // EF DB Context

        // Get DBContex through DI
        public IndexModel(ApplicationDbContext db)
        {
            _db = db;
        }

        [BindProperty]  // assumed to be recieved on POST
        public IEnumerable<Entity> Entities { get; set; }

        // HTTP Method Handler
        public aysnc Task OnGet()
        {   
            // get data from DB (example operation)
            Entities = await _db.Entities.ToListAsync();
        }

        // HTTP Method Handler
        public async Task<IActionResult> OnPost()
        {
            if (ModelState.IsValid)
            {
                // save to DB (example operation)
                await _db.Entities.AddAsync(Entity);
                await _db.SaveChangesAsync();

                return RedirectToPage("Index");
            }
            else
            {
                return Page();
            }
        }
    }
}
```

## Routing

Rules:

- URL maps to a physical file on disk
- Razor paged needs a root folder (Default "Pages")
- file extension not included in URL
- `Index.cshtml` is enrtypoint and default document (missing file in URL redirects to index)

| URL                    | Maps TO                                            |
|------------------------|----------------------------------------------------|
| www.domain.com         | /Pages/Index.cshtml                                |
| www.doamin.com/Index   | /Pages/Index.html                                  |
| www.domain.com/Account | /Pages/Account.cshtml, /Pages/Account/Index.cshtml |

## Data Validation

### Model Annotations

In `Entity.cs`:

```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace App.Models
{
    public class Entity
    {
        [DisplayName("Integer Number")]
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "Error Message")]
        public int IntProp { get; set; }
    }
}
```

### Tag Helpers & Client Side Validation

In `View.cshtml`;

```cs
<form method="post" asp-action="Create">
    <div asp-validation-summary="ModelOnly" class="text-danger"></div>

    <div class="form-group row">
        <div class="col-4">
            <label asp-for="IntProp"></label>
        </div>

        <div class="col-8">
            <input asp-for="IntProp" class="form-control"/>
            <span asp-validation-for="IntProp" class="text-danger"></span>  // error message displyed here
        </div>
    </div>
</form>

// client side validation
@section Scripts{ 
    @{ <partial name="_ValidationScriptsPartial" /> }
}
```

### Server Side Validation

```cs
using Microsoft.AspNetCore.Mvc;
using App.Models;
using System.Collections.Generic;

namespace App.Controllers
{
    public class IndexModel : PageModel
    {
        private readonly ApplicationDbContext _db;

        // get db context through dependency injection
        public IndexModel(AppDbContext db)
        {
            _db = db;
        }

        [BindProperty]
        public Entity Entity { get; set; }

        public async Task OnGet(int id)
        {
            Entity = await _db.Entities.FindAsync(id);
        }

        public async Task<IActionResult> OnPost()
        {
            if (ModelState.IsValid)
            {

                await _db.SaveChangesAsync();

                return RedirectToPage("Index");
            }
            else
            {
                return Page();
            }
        }
    }
}
```
