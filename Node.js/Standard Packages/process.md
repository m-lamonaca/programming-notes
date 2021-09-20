# Process Module

Provides information about, and control over, the current Node.js process

## Properties

```js
process.argv  // string[] containing the command-line arguments passed when the Node.js process was launched
process.pid  // PID of the process
process.env  // list of ENV Variables
process.platform  // identifier of the OS
process.arch  // processor architecture
```

## Functions

```js
process.resourceUsage();  // resource usage for the current process
process.memoryUsage();  // memory usage of the Node.js process measured in bytes
process.exit(code);  // terminate the process synchronously with an exit status of code
```

## Events

```js
process.on("event", (code) => { });
```
