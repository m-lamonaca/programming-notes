# SignalR

The SignalR Hubs API enables to call methods on connected clients from the server. In the server code, define methods that are called by client. In the client code, define methods that are called from the server. SignalR takes care of everything behind the scenes that makes real-time client-to-server and server-to-client communications possible.

## Server-Side

### Configuration

In `Startup.cs`:

```cs linenums="1"
builder.Services.AddSignalR();

var app = builder.Build();

app.UseEndpoints(endpoints =>
{
    endpoints.MapHub("/hub/endpoint");
});
```

### Creating Hubs

```cs linenums="1"
public class CustomHub : Hub
{
    public task HubMethod(Type args)
    {
        // trigger function on all clients and pass args to it
        return Clients.All.SendAsync("CLientMethod", args);

        // trigger function on caller client and pass args to it
        return Clients.Caller.SendAsync("CLientMethod", args);

        // trigger function on clients of a group and pass args to it
        return Clients.Group("GroupName").SendAsync("CLientMethod", args);

        // other operations
    }
}
```

### Strongly Typed Hubs

A drawback of using `SendAsync` is that it relies on a magic string to specify the client method to be called. This leaves code open to runtime errors if the method name is misspelled or missing from the client.

An alternative to using SendAsync is to strongly type the Hub with `Hub<T>`.

```cs linenums="1"
public interface IHubClient
{
    // matches method to be called on the client
    Task ClientMethod(Type args);
}
```

```cs linenums="1"
public class CustomHub : Hub<IHubClient>
{
    public Task HubMethod(Type args)
    {
        return Clients.All.ClientMethod(args);
    }
}
```

Using `Hub<T>` enables compile-time checking of the client methods. This prevents issues caused by using magic strings, since `Hub<T>` can only provide access to the methods defined in the interface.

Using a strongly typed `Hub<T>` disables the ability to use `SendAsync`. Any methods defined on the interface can still be defined as asynchronous. In fact, each of these methods should return a `Task`. Since it's an interface, don't use the `async` keyword.

### Handling Connection Events

The SignalR Hubs API provides the OnConnectedAsync and OnDisconnectedAsync virtual methods to manage and track connections. Override the OnConnectedAsync virtual method to perform actions when a client connects to the Hub, such as adding it to a group.

```cs linenums="1"
public override async Task OnConnectedAsync()
{
    await Groups.AddToGroupAsync(Context.ConnectionId, "GroupName");
    await base.OnConnectedAsync();
}

public override async Task OnDisconnectedAsync(Exception exception)
{
    await Groups.RemoveFromGroupAsync(Context.ConnectionId, "GroupName");
    await base.OnDisconnectedAsync(exception);
}
```

Override the `OnDisconnectedAsync` virtual method to perform actions when a client disconnects.  
If the client disconnects intentionally (by calling `connection.stop()`, for example), the exception parameter will be null.  
However, if the client is disconnected due to an error (such as a network failure), the exception parameter will contain an exception describing the failure.

### Sending Errors to the client

Exceptions thrown in the hub methods are sent to the client that invoked the method. On the JavaScript client, the `invoke` method returns a JavaScript Promise. When the client receives an error with a handler attached to the promise using catch, it's invoked and passed as a JavaScript `Error` object.

If the Hub throws an exception, connections aren't closed. By default, SignalR returns a generic error message to the client.

If you have an exceptional condition you *do* want to propagate to the client, use the `HubException` class. If you throw a `HubException` from your hub method, SignalR will send the entire message to the client, unmodified.

```cs linenums="1"
public Task ThrowException()
{
    throw new HubException("This error will be sent to the client!");
}
```

### Client-Side (JavaScript)

### Installing the client package

```sh linenums="1"
npm init -y
npm install @microsoft/signalr
```

npm installs the package contents in the `node_modules\@microsoft\signalr\dist\browser` folder. Create a new folder named signalr under the `wwwroot\lib` folder. Copy the signalr.js file to the `wwwroot\lib\signalr` folder.

Reference the SignalR JavaScript client in the `<script>` element. For example:

```html linenums="1"
<script src="~/lib/signalr/signalr.js"></script>
```

### Connecting to a Hub

[Reconnect Clients Docs](https://docs.microsoft.com/en-us/aspnet/core/signalr/javascript-client#reconnect-clients)

```js linenums="1"
const connection = new signalR.HubConnectionBuilder()
    .withUrl("/hub/endpoint")
    .configureLogging(signalR.LogLevel.Information)
    .withAutomaticReconnect()  // optional
    .build();

// async/await connection start
async function connect() {
    try {
        await connection.start();
        console.log("SignalR Connected.");
    } catch (err) {
        console.error(err);
    }
};

// promise connection start
function connect() {
    connection.start()
    .then(() => {})
    .catch((err) => {console.error(err)});
}
```

### Call hub methods fom the client

JavaScript clients call public methods on hubs via the `invoke` method of the `HubConnection`. The `invoke` method accepts:

- The name of the hub method.
- Any arguments defined in the hub method.

```js linenums="1"
try {
    await connection.invoke("HubMethod", args);
} catch (err) {
    console.error(err);
}
```

The `invoke` method returns a JavaScript `Promise`. The `Promise` is resolved with the return value (if any) when the method on the server returns. If the method on the server throws an error, the `Promise` is rejected with the error message. Use `async` and `await` or the `Promise`'s then and catch methods to handle these cases.

JavaScript clients can also call public methods on hubs via the the `send` method of the `HubConnection`. Unlike the `invoke` method, the send method doesn't wait for a response from the server. The send method returns a JavaScript `Promise`. The `Promise` is resolved when the message has been sent to the server. If there is an error sending the message, the `Promise` is rejected with the error message. Use `async` and `await` or the `Promise`'s then and catch methods to handle these cases.

### Call client methods from the hub

To receive messages from the hub, define a method using the `on` method of the `HubConnection`. The `on` method accepts:

- The name of the JavaScript client method.
- Arguments the hub passes to the method.

```cs linenums="1"
connection.on("ClientMethod", (args) => { /* ... */});
```
