# Cluster Module

A single instance of Node.js runs in a single thread. To take advantage of multi-core systems, the user will sometimes want to launch a **cluster of Node.js processes** to handle the load.

The cluster module allows easy creation of child processes that all share server ports.

```js
const cluster = require('cluster');
const http = require('http');
const numCPUs = require('os').cpus().length;

if (cluster.isMaster) {
    console.log(`Master ${process.pid} is running`);

    // Fork workers. (Spawn a new worker process)
    for (let i = 0; i < numCPUs; i++) {
        cluster.fork();
    }

    cluster.on('exit', (worker, code, signal) => {
        console.log(`worker ${worker.process.pid} died`);
        cluster.fork();
    });

} else {
    // Workers can share any TCP connection
    // In this case it is an HTTP server
    http.createServer((req, res) => {
        res.writeHead(200);
        res.end('hello world\n');
    }).listen(8000);

    console.log(`Worker ${process.pid} started`);
}
```

## Cluster VS Worker Threads

Cluster (multi-processing):

- One process is launched on each CPU and can communicate via IPC.
- Each process has it's own memory with it's own Node (v8) instance. Creating tons of them may create memory issues.
- Great for spawning many HTTP servers that share the same port b/c the master main process will multiplex the requests to the child processes.

Worker Threads (multi-threading):

- One process total
- Creates multiple threads with each thread having one Node instance (one event loop, one JS engine). Most Node API's are available to each thread except a few. So essentially Node is embedding itself and creating a new thread.
- Shares memory with other threads (e.g. SharedArrayBuffer)
- Great for CPU intensive tasks like processing data or accessing the file system. Because NodeJS is single threaded, synchronous tasks can be made more efficient with workers
