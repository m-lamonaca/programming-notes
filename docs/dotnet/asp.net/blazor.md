# Blazor

Blazor apps are based on *components*. A **component** in Blazor is an element of UI, such as a page, dialog, or data entry form.

Components are .NET C# classes built into .NET assemblies that:

- Define flexible UI rendering logic.
- Handle user events.
- Can be nested and reused.
- Can be shared and distributed as Razor class libraries or NuGet packages.

![Blazor Server Architecture](../../img/dotnet_blazor-server.png)
![Blazor WASM Architecture](../../img/dotnet_blazor-webassembly.png)

The component class is usually written in the form of a Razor markup page with a `.razor` file extension. Components in Blazor are formally referred to as *Razor components*.

## Project Structure & Important Files

### Blazor Server Project Structure

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
|- Program.cs --> App entry-point
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
|- Program.cs --> App entry-point
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
@page "/route/{RouteParameter}"  // make component accessible from a URL
@page "/route/{RouteParameter?}"  // specify route parameter as optional
@page "/route/{RouteParameter:<type>}"  // specify route parameter type

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

## State Management

### Blazor WASM

```cs
// setup state singleton
builder.Services.AddSingleton<StateContainer>();
```

```cs
// StateContainer singleton
using System;

public class StateContainer
{
    private int _counter;

    public string Property
    {
        get => _counter;
        set
        {
            _counter = value;
            NotifyStateChanged();  // will trigger StateHasChanged(), causing a render 
        }
    }

    public event Action OnChange;

    private void NotifyStateChanged() => OnChange?.Invoke();
}
```

```cs
// component that changes the state
@inject StateContainer State

// Delegate event handlers automatically trigger a UI render
<button @onClick="@HandleClick">
    Change State
</button>

@code {
    private void HandleClick()
    {
        State.Property += 1;  // update state
    }
}
```

```cs
// component that should be update on state change
@implements IDisposable
@inject StateContainer State

<p>Property: <b>@State.Property</b></p>

@code {

    // StateHasChanged notifies the component that its state has changed. 
    // When applicable, calling StateHasChanged causes the component to be rerendered.

    protected override void OnInitialized()
    {
        State.OnChange += StateHasChanged;
    }

    public void Dispose()
    {
        State.OnChange -= StateHasChanged;
    }
}
```

## Data Binding & Events

```cs
<p>
    <button @on{DOM EVENT}="{DELEGATE}" />
    <button @on{DOM EVENT}="{DELEGATE}" @on{DOM EVENT}:preventDefault />  // prevent default action
    <button @on{DOM EVENT}="{DELEGATE}" @on{DOM EVENT}:preventDefault="{CONDITION}" />  // prevent default action if CONDITION is true

    <button @on{DOM EVENT}="{DELEGATE}" @on{DOM EVENT}:stopPropagation />
    <button @on{DOM EVENT}="{DELEGATE}" @on{DOM EVENT}:stopPropagation="{CONDITION}" />  // stop event propagation if CONDITION is true

    <button @on{DOM EVENT}="@(e => Property = value)" />  // change internal state w/ lambda
    <button @on{DOM EVENT}="@(e => DelegateAsync(e, value))" />  // invoke delegate w/ lambda

    <input @ref="elementReference" />

    <input @bind="{PROPERTY}" /> // updates variable on ONCHANGE event (focus loss)
    <input @bind="{PROPERTY}" @bind:event="{DOM EVENT}" />  // updates value on DOM EVENT
    <input @bind="{PROPERTY}" @bind:format="{FORMAT STRING}" />  // use FORMAT STRING to display value

    <ChildComponent @bind-{PROPERTY}="{PROPERTY}" @bind-{PROPERTY}:event="{EVENT}" />  // bind to child component {PROPERTY}
    <ChildComponent @bind-{PROPERTY}="{PROPERTY}" @bind-{PROPERTY}:event="{PROPERTY}Changed" />  // bind to child component {PROPERTY}, listen for custom event
</p>

@code {
    private ElementReference elementReference;

    public string Property { get; set; }

    public EventCallback<Type> PropertyChanged { get; set; }  // custom event {PROPERTY}Changed

    // invoke custom event
    public async Task DelegateAsync(EventArgs e, Type argument)
    {   
        /* ... */

        await PropertyChanged.InvokeAsync(e, argument);  // notify parent bound prop has changed
        await elementReference.FocusAsync();  // focus an element in code
    }
}
```

> **Note**: When a user provides an unparsable value to a data-bound element, the unparsable value is automatically reverted to its previous value when the bind event is triggered.

## Javascript/.NET Interop

[Call Javascript from .NET](https://docs.microsoft.com/en-us/aspnet/core/blazor/call-javascript-from-dotnet)  
[Call .NET from Javascript](https://docs.microsoft.com/en-us/aspnet/core/blazor/call-dotnet-from-javascript)

### Render Blazor components from JavaScript [C# 10]

To render a Blazor component from JavaScript, first register it as a root component for JavaScript rendering and assign it an identifier:

```cs
// Blazor Server
builder.Services.AddServerSideBlazor(options =>
{
    options.RootComponents.RegisterForJavaScript<Counter>(identifier: "counter");
});

// Blazor WebAssembly
builder.RootComponents.RegisterForJavaScript<Counter>(identifier: "counter");
```

Load Blazor into the JavaScript app (`blazor.server.js` or `blazor.webassembly.js`) and then render the component from JavaScript into a container element using the registered identifier, passing component parameters as needed:

```js
let containerElement = document.getElementById('my-counter');
await Blazor.rootComponents.add(containerElement, 'counter', { incrementAmount: 10 });
```

### Blazor custom elements [C# 10]

Experimental support is also now available for building custom elements with Blazor using the Microsoft.AspNetCore.Components.CustomElements NuGet package.  
Custom elements use standard HTML interfaces to implement custom HTML elements.

To create a custom element using Blazor, register a Blazor root component as custom elements like this:

```cs
options.RootComponents.RegisterAsCustomElement<Counter>("my-counter");
```
