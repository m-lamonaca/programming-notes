# Events & Animation

## Events

Event Types:

- **Mouse Events**: `mousedown`, `mouseup`, `click`, `dbclick`, `mousemove`, `mouseover`, `mousewheel`, `mouseout`, `contextmenu`, ...
- **Touch Events**: `touchstart`, `touchmove`, `touchend`, `touchcancel`, ...
- **Keyboard Events**: `keydown`, `keypress`, `keyup`, ...
- **Form Events**: `focus`, `blur`, `change`, `submit`, ...
- **Window Events**: `scroll`, `resize`, `hashchange`, `load`, `unload`, ...

### Managing Event Listeners

```js
var domNode = document.getElementById("id");

var onEvent = function(event) {  // parameter contains info on the triggered event
    // logic here
}

domNode.addEventListener(eventType, calledback);
domNode.renoveEventListener(eventType, callback);
```

### Bubbling & Capturing

Events in Javascript propagate through the DOM tree.

[Bubbling and Capturing](https://javascript.info/bubbling-and-capturing)
[What Is Event Bubbling in JavaScript? Event Propagation Explained](https://www.sitepoint.com/event-bubbling-javascript/)

### Dispatching Custom Events

Event Options:

- `bubbles` (bool): whether the event propagates through bubbling
- `cancellable` (bool): if `true` the "default action" may be prevented

```js
let event = new Event(type [,options]);  // create the event, type can be custom
domNode.dispatchEvent(event);  // launch the event
```

## Animation

The window object is the assumed global object on a page.

Animation in JavascriptThe standard way to animate in JS is to use window methods.
It's possible to animate CSS styles to change size, transparency, position, color, etc.

```js
//Calls a function once after a delay
window.setTimeout(callbackFunction, delayMilliseconds);

//Calls a function repeatedly, with specified interval between each call
window.setInterval(callbackFunction, delayMilliseconds);

//To stop an animation store the timer into a variable and clear it
window.clearTimeout(timer);
window.clearInterval(timer);
```

### Element Position & dimensions

[StackOverflow](https://stackoverflow.com/a/294273/8319610)
[Wrong dimensions at runtime](https://stackoverflow.com/a/46772849/8319610)

```js
> console.log(document.getElementById('id').getBoundingClientRect());
DOMRect {
    bottom: 177,
    height: 54.7,
    left: 278.5,​
    right: 909.5,
    top: 122.3,
    width: 631,
    x: 278.5,
    y: 122.3,
}
```
