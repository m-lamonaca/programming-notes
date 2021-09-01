# Minimal API

**NOTE**: Requires .NET 6+

## REST API

```cs
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddSingleton<IService, Service>();
builder.Services.AddScoped<IService, Service>();
builder.Services.AddTransient<IService, Service>();

var app = builder.Build();

app.MapGet("/route/{id}", (IService service, int id) => {
    // code to get entity from db here
    return entity is not null ? Results.Ok(entity) : Results.NotFound();
});

app.MapPost("/route", (IService service, Entity entity) => {
    // code to add entity to db here
    return Results.Created($"/route/{entity.Id}", obj);
});

app.Run();
//or
app.RunAsync();

public class Entity(int Id, string Name);
```

### Swagger

```cs
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

app.UseSwagger();
app.MapGet("/", () => "Hello World!");
app.UseSwaggerUI();
app.Run();
```

### MVC

```cs
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
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

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
```
