# [Filters](https://docs.microsoft.com/en-us/aspnet/core/mvc/controllers/filters)

**Filters** in ASP.NET Core allow code to be run _before_ or _after_ specific stages in the request processing pipeline.

Built-in filters handle tasks such as:

- Authorization (preventing access to resources a user isn't authorized for).
- Response caching (short-circuiting the request pipeline to return a cached response).

Custom filters can be created to handle cross-cutting concerns. Examples of cross-cutting concerns include error handling, caching, configuration, authorization, and logging. Filters avoid duplicating code.

## **How filters work**

Filters run within the _ASP.NET Core action invocation pipeline_, sometimes referred to as the _filter pipeline_. The filter pipeline runs after ASP.NET Core selects the action to execute.

![filter-pipeline-1](../../../img/dotnet_filter-pipeline-1.png)
![filter-pipeline-2](../../../img/dotnet_filter-pipeline-2.png)

## **Filter types**

Each filter type is executed at a different stage in the filter pipeline:

- **Authorization filters** run first and are used to determine whether the user is authorized for the request. Authorization filters short-circuit the pipeline if the request is not authorized.
- **Resource filters**:
  - Run after authorization.
  - `OnResourceExecuting` runs code before the rest of the filter pipeline. For example, `OnResourceExecuting` runs code before model binding.
  - `OnResourceExecuted` runs code after the rest of the pipeline has completed.
- **Action filters**:
  - Run code immediately before and after an action method is called.
  - Can change the arguments passed into an action.
  - Can change the result returned from the action.
  - Are **not** supported in Razor Pages.
- **Exception filters** apply global policies to unhandled exceptions that occur before the response body has been written to.
- **Result filters** run code immediately before and after the execution of action results. They run only when the action method has executed successfully. They are useful for logic that must surround view or formatter execution.

## **Implementation**

Filters support both synchronous and asynchronous implementations through different interface definitions.

For example, `OnActionExecuting` is called before the action method is called. `OnActionExecuted` is called after the action method returns.
Asynchronous filters define an `On-Stage-ExecutionAsync` method, for example `OnActionExecutionAsync`.

Interfaces for multiple filter stages can be implemented in a single class.

```cs
public class SampleActionFilter : IActionFilter
{
    public void OnActionExecuting(ActionExecutingContext context)
    {
        // Do something before the action executes.
    }

    public void OnActionExecuted(ActionExecutedContext context)
    {
        // Do something after the action executes.
    }
}


public class SampleAsyncActionFilter : IAsyncActionFilter
{
    public async Task OnActionExecutionAsync(
        ActionExecutingContext context, ActionExecutionDelegate next)
    {
        // Do something before the action executes.
        await next();
        // Do something after the action executes.
    }
}
```

## **Built-in filter attributes**

ASP.NET Core includes built-in _attribute-based_ filters that can be subclassed and customized.
Several of the filter interfaces have corresponding attributes that can be used as base classes for custom implementations.

Filter attributes:

- [ActionFilterAttribute](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.filters.actionfilterattribute)
- [ExceptionFilterAttribute](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.filters.exceptionfilterattribute)
- [ResultFilterAttribute](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.filters.resultfilterattribute)
- [FormatFilterAttribute](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.formatfilterattribute)
- [ServiceFilterAttribute](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.servicefilterattribute)
- [TypeFilterAttribute](https://docs.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.mvc.typefilterattribute)

## **Filter scopes**

A filter can be added to the pipeline at one of three *scopes*:

- Using an attribute on a controller action. Filter attributes cannot be applied to Razor Pages handler methods.

```cs
services.AddScoped<CustomActionFilterAttribute>();

[ServiceFilter(typeof(CustomActionFilterAttribute))]
public IActionResult Action()
{
    return Ok();
}
```

- Using an attribute on a controller or Razor Page.

```cs
services.AddControllersWithViews(options => { 
    options.Filters.Add(new CustomResponseFilterAttribute(args)); 
});


[CustomResponseFilterAttribute(args)]
public class SampleController : Controller
```

- Globally for all controllers, actions, and Razor Pages.

```cs
builder.Services.AddControllersWithViews(options =>
{
    options.Filters.Add(typeof(CustomActionFilter));
});
```

## Filter Order of Execution

When there are multiple filters for a particular stage of the pipeline, scope determines the default order of filter execution. Global filters surround class filters, which in turn surround method filters.

As a result of filter nesting, the *after* code of filters runs in the reverse order of the *before* code. The filter sequence:

- The *before* code of global filters.
  - The *before* code of controller and Razor Page filters.
    - The *before* code of action method filters.
    - The *after* code of action method filters.
  - The *after* code of controller and Razor Page filters.
- The *after* code of global filters.

### Cancellation and Short-Circuiting

The filter pipeline can be short-circuited by setting the `Result` property on the `ResourceExecutingContext` parameter provided to the filter method.

```cs
public class ShortCircuitingResourceFilterAttribute : Attribute, IResourceFilter
{
    public void OnResourceExecuting(ResourceExecutingContext context)
    {
        context.Result = new ContentResult()
        {
            Content = "Resource unavailable - header not set."
        };
    }

    public void OnResourceExecuted(ResourceExecutedContext context)
    {
    }
}
```

## Dependency Injection

Filters can be added _by type_ or _by instance_. If an instance is added, that instance is used for every request. If a type is added, it's type-activated. 

A type-activated filter means:

- An instance is created for each request.
- Any constructor dependencies are populated by dependency injection (DI).

Filters that are implemented as attributes and added directly to controller classes or action methods cannot have constructor dependencies provided by dependency injection (DI). Constructor dependencies cannot be provided by DI because attributes must have their constructor parameters supplied where they're applied.

The following filters support constructor dependencies provided from DI:

- ServiceFilterAttribute
- TypeFilterAttribute
- IFilterFactory implemented on the attribute.

### [`ServiceFilterAttribute`][service-filter-attribute]

```cs
builder.Services.AddScoped<CustomFilterFromDI>();

public class CustomFilterFromDI : IResultFilter
{
    private readonly ILogger _logger;

    public CustomFilterFromDI(ILogger logger) =>  _logger = logger;

    public void OnResultExecuting(ResultExecutingContext context)
    {
    }

    public void OnResultExecuted(ResultExecutedContext context)
    {
    }
}

[ServiceFilter(typeof(CustomFilterFromDI))]
public IActionResult Action() => OK();
```

<!--links -->
[service-filter-attribute]: https://learn.microsoft.com/en-us/aspnet/core/mvc/controllers/filters?view=aspnetcore-7.0#servicefilterattribute "ServiceFilterAttribute Docs"
