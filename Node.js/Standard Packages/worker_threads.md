# Worker Threads Module

The `worker_threads` module enables the use of threads that execute JavaScript in parallel.

Workers (threads) are useful for performing CPU-intensive JavaScript operations. They do not help much with I/O-intensive work. The Node.js built-in asynchronous I/O operations are more efficient than Workers can be.

Unlike `child_process` or `cluster`, `worker_threads` can *share* memory. They do so by transferring `ArrayBuffer` instances or sharing `SharedArrayBuffer` instances.

```js
const { Worker, isMainThread } = require("worker_threads");

if(isMainThread){
    console.log("Main Thread");

    // start new inner thread executing this file
    new Worker(__filename);
}
else 
{
    // executed by inner threads
    console.log("Inner Thread Starting");
}
```

## Cluster VS Worker Threads

Cluster (**multi-processing**):

- One process is launched on each CPU and can communicate via IPC.
- Each process has it's own memory with it's own Node (v8) instance. Creating tons of them may create memory issues.
- Great for spawning many HTTP servers that share the same port b/c the master main process will multiplex the requests to the child processes.

Worker Threads (**multi-threading**):

- One process total
- Creates multiple threads with each thread having one Node instance (one event loop, one JS engine). Most Node API's are available to each thread except a few. So essentially Node is embedding itself and creating a new thread.
- Shares memory with other threads (e.g. SharedArrayBuffer)
- Great for CPU intensive tasks like processing data or accessing the file system. Because NodeJS is single threaded, synchronous tasks can be made more efficient with workerss
