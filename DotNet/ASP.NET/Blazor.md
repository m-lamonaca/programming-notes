# Blazor

Blazor apps are based on *components*. A **component** in Blazor is an element of UI, such as a page, dialog, or data entry form.

Components are .NET C# classes built into .NET assemblies that:

- Define flexible UI rendering logic.
- Handle user events.
- Can be nested and reused.
- Can be shared and distributed as Razor class libraries or NuGet packages.

![Blazor Server Architecture](../../.images/dotnet_blazor-server.png)
![Blazor WASM Architecture](../../.images/dotnet_blazor-webassembly.png)

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
| |- _Host.cshtml  --> fallback page
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

### Blazor PWA Project Structure

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
| |- manifest.json
| |- service-worker.js
| |- icon-512.png
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

### `manifest.json`, `service-worker.js` (Blazor PWA)

[PWA](https://web.dev/progressive-web-apps/)  
[PWA MDN Docs](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps)  
[PWA Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)  
[Service Worker API](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)

```json
// manifest.json
{
  "name": "<App Name>",
  "short_name": "<Short App Name>",
  "start_url": "./",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#03173d",
  "icons": [
    {
      "src": "icon-512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ]
}
```

## Common Blazor Files

### `App.razor`

```cs
<Router AppAssembly="@typeof(Program).Assembly" PreferExactMatches="@true">
    <Found Context="routeData">  // for component routing
        <RouteView RouteData="@routeData" DefaultLayout="@typeof(MainLayout)" />
    </Found>
    <NotFound>
        <LayoutView Layout="@typeof(MainLayout)">
            <p>Sorry, there's nothing at this address.</p>
        </LayoutView>
    </NotFound>
</Router>
```

### `MainLayout.razor` (Blazor Server/WASM)

```cs
@inherits LayoutComponentBase

<div class="page">
    <div class="sidebar">
        <NavMenu />  // NavMenu Component
    </div>

    <div class="main">
        <div class="top-row px-4">
        </div>

        <div class="content px-4">
            @Body
        </div>
    </div>
</div>
```

### `_Host.cshtml` (Blazor Server)

```html
@page "/"
@namespace BlazorServerDemo.Pages
@addTagHelper *, Microsoft.AspNetCore.Mvc.TagHelpers
@{
    Layout = null;
}

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BlazorServerDemo</title>
    <base href="~/" />
    <link rel="stylesheet" href="css/bootstrap/bootstrap.min.css" />
    <link href="css/site.css" rel="stylesheet" />
    <link href="BlazorServerDemo.styles.css" rel="stylesheet" />
</head>
<body>
    <component type="typeof(App)" render-mode="ServerPrerendered" />

    <div id="blazor-error-ui">
        <environment include="Staging,Production">
            An error has occurred. This application may no longer respond until reloaded.
        </environment>
        <environment include="Development">
            An unhandled exception has occurred. See browser dev tools for details.
        </environment>
        <a href="" class="reload">Reload</a>
        <a class="dismiss">🗙</a>
    </div>

    <script src="_framework/blazor.server.js"></script>
</body>
</html>
```

## Components (`.razor`)

[Blazor Components](https://docs.microsoft.com/en-us/aspnet/core/blazor/components/)

```cs
@page "/route/{RouteParameter?}"  // make component accessible from a URL (optional)

@namespace <Namespace>  // set the component namespace
@using <Namespace>  // using statement
@inherits BaseType  // inheritance
@attribute [Attribute]  // apply an attribute
@inject Type objectName  // dependency injection

// html of the page here

<Namespace.ComponentFolder.Component />  // access component w/o @using
<Component Property="value"/>  // insert component into page, passing attributes
<Component @onclick="@CallbackMethod">
    @ChildContent  // segment of UI content
</Component>

@code {
    // component model (Properties, Methods, ...)

    [Parameter]  // capture attribute 
    public Type Property { get; set; } = defaultValue;

    [Parameter]  // capture route parameters
    public type RouteParameter { get; set;}

    [Parameter] // segment of UI content
    public RenderFragment ChildContent { get; set;}

    private void CallbackMethod() { }
}
```

## Javascript/.NET Interop

[Call Javascript from .NET](https://docs.microsoft.com/en-us/aspnet/core/blazor/call-javascript-from-dotnet)  
[Call .NET from Javascript](https://docs.microsoft.com/en-us/aspnet/core/blazor/call-dotnet-from-javascript)
