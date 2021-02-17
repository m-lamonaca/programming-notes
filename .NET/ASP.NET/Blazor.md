# Blazor

Blazor apps are based on *components*. A **component** in Blazor is an element of UI, such as a page, dialog, or data entry form.

Components are .NET C# classes built into .NET assemblies that:

- Define flexible UI rendering logic.
- Handle user events.
- Can be nested and reused.
- Can be shared and distributed as Razor class libraries or NuGet packages.

![Blazor Server Architecture](https://docs.microsoft.com/en-us/aspnet/core/blazor/index/_static/blazor-server.png)
![Blazor WASM Architecture](https://docs.microsoft.com/en-us/aspnet/core/blazor/index/_static/blazor-webassembly.png)

The component class is usually written in the form of a Razor markup page with a `.razor` file extension. Components in Blazor are formally referred to as *Razor components*.

## Project Structure & Important Files

### Blazor Server Project Stucture

```txt
Project
|-Properties
| |- launchSettings.json
|
|-wwwroot --> static files
| |-css
| | |- site.css
| | |- bootstrap
| |
| |- favicon.ico
|
|-Pages
| |- Page.cshtml
| |- Page.cshtml.cs
| |- Component.razor
| |- Index.razor
| |- ...
|
|-Shared
| |- MainLayout.razor
| |- MainLayout.razor.css
| |- ...
|
|- _Imports.razor --> @using imports
|- App.razor --> component root of the app
|
|- appsettings.json --> application settings
|- Program.cs --> App entrypoint
|- Startup.cs --> services and middleware configs
```

### Blazor WASM Project Structure

```txt
Project
|-Properties
| |- launchSettings.json
|
|-wwwroot --> static files
| |-css
| | |- site.css
| | |- bootstrap
| |
| |- index.html
| |- favicon.ico
|
|-Pages
| |- Component.razor
| |- Index.razor
| |- ...
|
|-Shared
| |- MainLayout.razor
| |- MainLayout.razor.css
| |- ...
|
|- _Imports.razor --> @using imports
|- App.razor --> component root of the app
|
|- appsettings.json --> application settings
|- Program.cs --> App entrypoint
```

### `App.razor`

```cs
<Router AppAssembly="@typeof(Program).Assembly" PreferExactMatches="@true">
    <Found Context="routeData">
        <RouteView RouteData="@routeData" DefaultLayout="@typeof(MainLayout)" />
    </Found>
    <NotFound>
        <LayoutView Layout="@typeof(MainLayout)">
            <p>Sorry, there's nothing at this address.</p>
        </LayoutView>
    </NotFound>
</Router>
```

## Components (`.razor`)

```cs
@page "/route"

<!-- html of the page -->

<Component  Property="value"/>  // insert component into page

@code {
    // component model (Properties, Methods, ...)

    [Parameter]  // use prop as HTML attribute
    purblic Type Property { get; set; } = defaultValue;
}
```

<!-- ## Javascript/.NET Interop

[Call Javascript from .NET](https://docs.microsoft.com/en-us/aspnet/core/blazor/call-javascript-from-dotnet)  
[Call .NET from Javascript](https://docs.microsoft.com/en-us/aspnet/core/blazor/call-dotnet-from-javascript) -->
