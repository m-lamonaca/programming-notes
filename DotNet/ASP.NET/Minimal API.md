# Minimal API

**NOTE**: Requires .NET 6+

```cs
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<IService, Service>();
builder.Services.AddScoped<IService, Service>();
builder.Services.AddTransient<IService, Service>();

var app = builder.Build();

// [...]

app.Run();
//or
app.RunAsync();
```

## Swagger

```cs
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// [...]

app.UseSwagger();
app.UseSwaggerUI();

// add returned content metadata to Swagger
app.MapGet("/route", Handler).Produces<Type>(statusCode);

// add request body contents metadata to Swagger
app.MapPost("/route", Handler).Accepts<Type>(contentType);
```

## MVC

```cs
builder.Services.AddControllersWithViews();
//or
builder.Services.AddControllers();

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
```

## Routing, Handlers & Results

To define routes and handlers using Minimal APIs, use the `Map(Get|Post|Put|Delete)` methods.

```cs
// the dependencies are passed as parameters in the handler delegate
app.MapGet("/route/{id}", (IService service, int id) => {
    
    return entity is not null ? Results.Ok(entity) : Results.NotFound();
});

// pass delegate to use default values
app.MapGet("/search/{id}", Search);
IResult Search(int id, int? page = 1, int? pageSize = 10) { /* ... */ }
```

## Context

With Minimal APIs it's possible to access the contextual information by passing one of the following types as a parameter to your handler delegate:

- `HttpContext`
- `HttpRequest`
- `HttpResponse`
- `ClaimsPrincipal`
- `CancellationToken` (RequestAborted)

```cs
app.MapGet("/hello", (ClaimsPrincipal user) => {
    return "Hello " + user.FindFirstValue("sub");
});
```

## Validation

Using [Minimal Validation](https://github.com/DamianEdwards/MinimalValidation) by Damian Edwards.  
Alternatively it's possible to use [Fluent Validation](https://fluentvalidation.net/).

```cs
app.MapPost("/widgets", (Widget widget) => {
    var isValid = MinimalValidation.TryValidate(widget, out var errors);

    if(isValid)
    {
        return Results.Created($"/widgets/{widget.Name}", widget);
    }

    return Results.BadRequest(errors);
});

class Widget
{
    [Required, MinLength(3)]
    public string? Name { get; set; }

    public override string? ToString() => Name;
}
```

## JSON Serialization

```cs
// Microsoft.AspNetCore.Http.Json.JsonOptions
builder.Services.Configure<JsonOptions>(opt =>
{
    opt.SerializerOptions.PropertyNamingPolicy = new SnakeCaseNamingPolicy();
});
```

## Authorization

```cs
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer();

builder.Services.AddAuthorization();
// or
builder.Services.AddAuthorization(options =>
{
    // for all endpoints
    options.FallbackPolicy = new AuthorizationPolicyBuilder()
      .AddAuthenticationSchemes(JwtBearerDefaults.AuthenticationScheme)
      .RequireAuthenticatedUser();
})

// [...]

app.UseAuthentication();
app.UseAuthorization(); // must come before routes

// [...]

app.MapGet("/alcohol", () => Results.Ok()).RequireAuthorization("<policy>");  // on specific endpoints
app.MapGet("/free-for-all", () => Results.Ok()).AllowAnonymous();
```
