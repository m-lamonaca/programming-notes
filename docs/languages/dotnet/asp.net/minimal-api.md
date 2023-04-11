# Minimal API

> **Note**: Requires .NET 6+

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

### Route Groups

The `MapGroup()` extension method, which helps organize groups of endpoints with a common prefix.  
It allows for customizing entire groups of endpoints with a singe call to methods like `RequireAuthorization()` and `WithMetadata()`.

```cs
var group = app.MapGroup("<route-prefix>");

group.MapGet("/", GetAllTodos);  // route: /<route-prefix>
group.MapGet("/{id}", GetTodo);  // route: /<route-prefix>/{id}

// [...]
```

### `TypedResults`

The `Microsoft.AspNetCore.Http.TypedResults` static class is the “typed” equivalent of the existing `Microsoft.AspNetCore.Http.Results` class.  
It's possible to use `TypedResults` in minimal APIs to create instances of the in-framework `IResult`-implementing types and preserve the concrete type information.

```cs
public static async Task<IResult> GetAllTodos(TodoDb db)
{
    return TypedResults.Ok(await db.Todos.ToArrayAsync());
}
```

```cs
[Fact]
public async Task GetAllTodos_ReturnsOkOfObjectResult()
{
    // Arrange
    var db = CreateDbContext();

    // Act
    var result = await TodosApi.GetAllTodos(db);

    // Assert: Check the returned result type is correct
    Assert.IsType<Ok<Todo[]>>(result);
}
```

### Multiple Result Types

The `Results<TResult1, TResult2, TResultN>` generic union types, along with the `TypesResults` class, can be used to declare that a route handler returns multiple `IResult`-implementing concrete types.

```cs
// Declare that the lambda returns multiple IResult types
app.MapGet("/todos/{id}", async Results<Ok<Todo>, NotFound> (int id, TodoDb db)
{
    return await db.Todos.FindAsync(id) is Todo todo
        ? TypedResults.Ok(todo)
        : TypedResults.NotFound();
});
```

## Filters

```cs
public class ExampleFilter : IRouteHandlerFilter
{
    public async ValueTask<object?> InvokeAsync(RouteHandlerInvocationContext context, RouteHandlerFilterDelegate next)
    {
        // before endpoint call
        var result = next(context);
        /// after endpoint call
        return result;
    }
}
```

```cs
app.MapPost("/route", Handler).AddFilter<ExampleFilter>();
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

## OpenAPI

The `Microsoft.AspNetCore.OpenApi` package exposes a `WithOpenApi` extension method that generates an `OpenApiOperation` derived from a given endpoint’s route handler and metadata.

```cs
app.MapGet("/todos/{id}", (int id) => ...)
    .WithOpenApi();

app.MapGet("/todos/{id}", (int id) => ...)
    .WithOpenApi(operation => {
        operation.Summary = "Retrieve a Todo given its ID";
        operation.Parameters[0].AllowEmptyValue = false;
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
// or
builder.Authentication.AddJwtBearer();  // will automatically add required middlewares

// [...]

app.UseAuthentication();
app.UseAuthorization(); // must come before routes

// [...]

app.MapGet("/alcohol", () => Results.Ok()).RequireAuthorization("<policy>");  // on specific endpoints
app.MapGet("/free-for-all", () => Results.Ok()).AllowAnonymous();
app.MapGet("/special-secret", () => "This is a special secret!")
    .RequireAuthorization(p => p.RequireClaim("scope", "myapi:secrets"));
```

### Local JWT Tokens

The `user-jwts` tool is similar in concept to the existing `user-secrets` tools, in that it can be used to manage values for the app that are only valid for the current user (the developer) on the current machine.  
In fact, the `user-jwts` tool utilizes the `user-secrets` infrastructure to manage the key that the JWTs will be signed with, ensuring it’s stored safely in the user profile.

```sh
dotnet user-jwts create  # configure a dev JWT fot the current user
```

## Output Caching

```cs
builder.Services.AddOutputCaching();  // no special options
builder.Services.AddOutputCaching(options => 
{
    options => options.AddBasePolicy(x => x.NoCache())  // no cache policy

    Func<OutputCacheContext, bool> predicate = /* discriminate requests */
    options.AddBasePolicy(x => x.With(predicate).CachePolicy());
    options.AddBasePolicy("<policy-name>", x => x.CachePolicy());  // named policy
});

// [...]

app.UseOutputCaching();  // following middlewares can use output cache

// [...]

app.MapGet("/<route>", RouteHandler).CacheOutput();  // cache forever
app.MapGet("/<route>", RouteHandler).CacheOutput().Expire(timespan);

app.MapGet("/<route>", RouteHandler).CacheOutput(x => x.CachePolicy());
app.MapGet("/<route>", RouteHandler).CacheOutput("<policy-name>");

app.MapGet("/<route>", RouteHandler).CacheOutput(x => x.VaryByHeader(/* headers list */));
app.MapGet("/<route>", RouteHandler).CacheOutput(x => x.VaryByQuery(/* query key */));
app.MapGet("/<route>", RouteHandler).CacheOutput(x => x.VaryByValue());

app.MapGet("/<route>", [OutputCache(/* options */)]RouteHandler);
```

### Cache Eviction

```cs

app.MapGet("/<route-one>", RouteHandler).CacheOutput(x => x.Tag("<tag>"));  // tag cache portion

app.MapGet("/<route-two>", (IOutputCacheStore cache, CancellationToken token) => 
{
    await cache.EvictByTag("<tag>", token);  // invalidate a portion of the cache
});
```

### Custom Cache Policy

```cs
app.MapGet("/<route-one>", RouteHandler).CacheOutput(x => x.AddCachePolicy<CustomCachePolicy>());
```

```cs
class CustomCachePolicy : IOutputCachePolicy
{
    public ValueTask CacheRequestAsync(OutputCacheContext context, CancellationToken cancellationToken) { }

    public ValueTask ServeFromCacheAsync(OutputCacheContext context, CancellationToken cancellationToken) { }

    public ValueTask ServeResponseAsync(OutputCacheContext context, CancellationToken cancellationToken) { }
}
```

### Native AOT
