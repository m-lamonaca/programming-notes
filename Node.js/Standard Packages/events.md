# Events Module

Much of the Node.js core API is built around an idiomatic *asynchronous event-driven architecture* in which certain kinds of objects (**emitters**) emit *named events* that cause `Function` objects (**listeners**) to be called.

All objects that emit events are instances of the `EventEmitter` class. These objects expose an `eventEmitter.on()` function that allows one or more functions to be attached to named events emitted by the object. Typically, event names are camel-cased strings but any valid JavaScript property key can be used.

When the EventEmitter object emits an event, all of the functions attached to that specific event are called *synchronously*. Any values returned by the called listeners are *ignored and discarded*.

```js
const EventEmitter = require("events");

class CustomEmitter extends EventEmitter {} ;

const customEmitterObj = new CustomEmitter();

// add event listener
customEmitterObj.on("event", (e) => {
    // e contains event object
})

// single-use event listener (execute and remove listener)
customEmitterObj.once("event", (e) => {
    // e contains event object
})

customEmitterObj.removeListener("event", callback);
customEmitterObj.removeAllListeners("event");

customEmitterObj.emit("event");
customEmitterObj.emit("event", { /* event object */ });

customEmitterObj.eventNames();  // string[] of the events it listens to
customEmitterObj.listenerCount("event");  // num of listeners for an event
customEmitterObj.listeners();  // Function[], handlers of the events
```
