# [Web Components][web-components-mdn]

## [Custom Elements][using-cusotom-elements-mdn]

A set of JavaScript APIs that allow you to define custom elements and their behavior, which can then be used as desired in your user interface.

### Types of Custom Elements

There are two types of custom element:

- **Customized built-in elements** inherit from standard HTML elements such as `HTMLImageElement` or `HTMLParagraphElement`. Their implementation customizes the behavior of the standard element.
- **Autonomous custom elements** inherit from the HTML element base class `HTMLElement`. Need to implement their behavior from scratch.

A custom element is implemented as a class which extends `HTMLElement` (in the case of autonomous elements) or the interface to be customized customized (in the case of customized built-in elements).

```js
class CustomParagraph extends HTMLParagraphElement {
  constructor() {
// self is reference to this element
    self = super();
  }
}

class CustomElement extends HTMLElement {
  constructor() {
    super();
  }
}
```

### Registering & Using Custom Elements

To make a custom element available in a page, call the `define()` method of `Window.customElements`.

The `define()` method takes the following arguments:

- `name`: The name of the element. This must start with a lowercase letter, contain a hyphen, and satisfy certain other rules listed in the specification's definition of a valid name.
- `constructor`: The custom element's constructor function.
- `options`: Only included for customized built-in elements, this is an object containing a single property extends, which is a string naming the built-in element to extend.

```js
// register a customized element
window.customElements.define("custom-paragraph", CustomParagraph, { extends: "p" });

// register a fully custom element
window.customElements.define("custom-element", CustomElement);
```

```html
<!-- need to specify customized name -->
<p is="custom-paragraph"></p>

<!-- cannot be used as self-closing tag -->
<custom-element>
    <!-- content of the element -->
</custom-element>
```

### Custom Elements Lifecycle Callbacks

Once the custom element is _registered_, the browser will call certain methods of the class when code in the page interacts with the custom element.  
By providing an implementation of these methods, which the specification calls lifecycle callbacks, it's possible to run code in response to these events.

Custom element lifecycle callbacks include:

- `connectedCallback()`: called each time the element is added to the document. The specification recommends that, as far as possible, developers should implement custom element setup in this callback rather than the constructor.
- `disconnectedCallback()`: called each time the element is removed from the document.
- `adoptedCallback()`: called each time the element is moved to a new document.
- `attributeChangedCallback(name, oldValue, newValue)`: called when attributes are changed, added, removed, or replaced.

```js
class CustomElement extends HTMLElement {

  // array containing the names of all attributes for which the element needs change notifications
  static observedAttributes = ["size"];

  constructor() {
    super();
  }

  connectedCallback() {
    console.log("Custom element added to page.");
  }

  disconnectedCallback() {
    console.log("Custom element removed from page.");
  }

  adoptedCallback() {
    console.log("Custom element moved to new page.");
  }


  attributeChangedCallback(name, oldValue, newValue) {
    // name is one of observedAttributes
    console.log(`Attribute ${name} has changed.`);
  }
}
```

<!-- links -->
[web-components-mdn]: https://developer.mozilla.org/en-US/docs/Web/API/Web_Components "Web Components Docs"
[using-cusotom-elements-mdn]: https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements "Using Custom Elements"
