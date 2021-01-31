# Net Module (Connection Oriented Networking - TCP/IP)

## Server (`net.Server`)

```js
const net = require('net');

const server = net.createServer((socket) => { /* connect listener */ });

server.on('error', (err) => {
    // handle error
});

server.listen(8124, () => { });  // listen for connection
```

## Sockets (`net.Socket`)

```js

const client = net.createConnection({ host: "127.0.0.1", port: 8124 }, () => {  /* 'connect' listener. */ });

socket.on("data", (buffer) => { /* operate on input buffer */ });
socket.on("error", (err) => { /* handle error */ });
socket.on("end", () => {}); // client disconnection
```
