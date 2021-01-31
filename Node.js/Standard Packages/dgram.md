# UDP Module

```js
const socket = dgram.createSocket("udp4");  // connect to network interface

socket.on("error", (err) => { /* handle error */ });
socket.on("message", (msg, rinfo) => {});
socket.on("end", () => {});

socket.bind(port);  // listen to port
socket.on('listening', () => {});

socket.send(message, port, host, (err) => { /* handle error */ });
```

## Multicasting

```js
const socket = dgram.createSocket({ type: "udp4", reuseAddr: true });
// When reuseAddr is true socket.bind() will reuse the address, even if another process has already bound a socket on it. 

const multicastPort = 5555;
const multicastAddress = "239.255.255.255";  // whatever ip

socket.bind(multicastPort);

socket.on("listening", () => {
    socket.addMembership(multicastAddress);
})

socket.on("message", (msg, rinfo) => {
    console.log(`Got: "${msg.toString()}" from ${rinfo.address}`);
});
```
