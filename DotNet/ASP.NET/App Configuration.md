# ASP.NET Configuration

## `.csproj`

```xml
<PropertyGroup>
  <!-- enable documentation comments (can be used for swagger) -->
  <GenerateDocumentationFile>true</GenerateDocumentationFile>

  <!-- do not warn public classes w/o documentation comments -->
  <NoWarn>$(NoWarn);1591</NoWarn>
</PropertyGroup>
```

## `Program.cs`

```cs
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

namespace App
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();  // start and config ASP.NET Core App

            // or start Blazor WASM Single Page App
            var builder = WebAssemblyHostBuilder.CreateDefault(args);
            builder.RootComponents.Add<App>("#app");

            builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });

            await builder.Build().RunAsync();
        }

        // for MVC, Razor Pages and Blazor Server
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();  // config handled in Startup.cs
                });
    }
}
```

## `Startup.cs`

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

        // This method gets called by the runtime. Use this method to add services to the DI container.
        public void ConfigureServices(IServiceCollection services)
        {
            // set db context for the app using the connection string
            services.AddDbContext<AppDbContext>(options => options.UseSqlServer(Configuration.GetConnectionString("DefaultConnection")));

            // Captures synchronous and asynchronous Exception instances from the pipeline and generates HTML error responses.
            services.AddDatabaseDeveloperPageExceptionFilter();

            // use Razor Pages, runtime compilation needs Microsoft.AspNetCore.Mvc.Razor.RuntimeCompilation pkg
            services.AddRazorPages().AddRazorRuntimeCompilation();
            // or
            services.AddControllers();  // controllers w/o views
            //or
            services.AddControllersWithViews();  // MVC Controllers
            //or
            services.AddServerSideBlazor();  // needs Razor Pages

            services.AddSignalR();

            // set dependency injection lifetimes
            services.AddSingleton<ITransientService, ServiceImplementation>();
            services.AddScoped<ITransientService, ServiceImplementation>();
            services.AddTransient<ITransientService, ServiceImplementation>();

            // add swagger
            services.AddSwaggerGen(options => {

                // OPTIONAL: use xml comments for swagger documentation
                var xmlFilename = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                options.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, xmlFilename));
            });

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

            app.UseSwagger();
            app.UseSwaggerUI();

            app.UseEndpoints(endpoints =>
            {
                // MVC routing
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}"
                );
                // or
                endpoints.MapControllers();  // map controllers w/o views
                // or
                endpoints.MapRazorPages();
                // or
                endpoints.MapBlazorHub();  // SignalR Hub for Blazor Server

                endpoints.MapHub("/hub/endpoint");  // SignalR Hub
                endpoints.MapFallbackToPage("/_Host");  // fallback for razor server
            });
        }
    }
}
```

## `appsettings.json`

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

## `launchsettings.json`

Launch Settings & Deployment Settings.

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
    "<project>": {
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
