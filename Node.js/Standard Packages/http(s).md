# HTTP(S) Module

## HTTPS(S) IncomingMessage (request)

### Making a request

```js
https.request(
    {
        host: "www.website.com",
        method: "GET",  // POST, ...
        path: "/page/?param=value"
    }, 
    (response) => {  // response is IncomingMessage
        // do stuff
    }
).end();
```

### Request Methods & Properties

```js
IncomingMessage.headers
IncomingMessage.statusCode
IncomingMessage.statusMessage
IncomingMessage.url
```

## HTTPS(S) ServerResponse (response)

### Response Methods & Properties

```js
ServerResponse.writeHead(statusCode[, statusMessage][, headers]);
```

## HTTP(S) Server

### Creating a server

```js
const PORT = 8123;

// req is IncomingMessage
// res is ServerResponse
const server = http.createServer((req, res) => {

    let body = "<html></html>"

    res.writeHead(200, {
        "Content-Length": Buffer.byteLength(body),
        "Content-Type": "text/html; charset=utf8"
    });
    
    res.end(body);

});

server.listen(PORT);
```

### Reading a request search params

```js
const http = require("http");
const url = require("url");

const PORT = 8123;

const server = http.createServer((req, res) => {
    let url = new URL(req.url, "http://" + req.headers.host);
    let params = url.searchParams;

    // ...

});

console.log("Listening on port: " + PORT);
server.listen(PORT);
```
