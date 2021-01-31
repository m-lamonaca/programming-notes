# Document Object Model (DOM)

The **Document Object Model** is a *map* of the HTML document. Elements in an HTML document can be accessed, changed, deleted, or added using the DOM.
The document object is *globally available* in the browser. It allows to access and manipulate the DOM of the current web page.

## DOM Access

### Selecting Nodes from the DOM

`getElementById()` and `querySelector()` return a single element.
`getElementsByClassName()`, `getElementsByTagName()`, and `querySelectorAll()` return a collection of elements.

```js
Javascript
// By Id
var node = document.getElementById('id');

// By Tag Name
var node = document.getElementsByTagName('tag');

// By Class Name
var node = document.getElementsByClassName('class');

// By CSS Query
var node = document.querySelector('css-selector');
var node = document.querySelectorAll('css-selector');
```

## Manupulating the DOM

### Manipulating a node's attributes

It's possible access and change the attributes of a DOM node using the *dot notation*.

```js
// Changing the src of an image:
var image = document.getElementById('id');
var oldImageSource = image.src;
image.src = 'image-url';

//Changing the className of a DOM node:
var node = document.getElementById('id');
node.className = 'new-class';
```

### Manipulating a node’s style

It's possible to access and change the styles of a DOM nodes via the **style** property.
CSS property names with a `-` must be **camelCased** and number properties must have a unit.

```css
body {
    color: red;
    background-color: pink;
    padding-top: 10px;
}
```

```js
var pageNode = document.body;
pageNode.style.color = 'red';
pageNode.style.backgroundColor = 'pink';
pageNode.style.paddingTop = '10px';
```

### Manipulating a node’s contents

Each DOM node has an `innerHTML` attribute. It contains the HTML of all its children.

```js
var pageNode = document.body;
console.log(pageNode.innerHTML);

// Set innerHTML to replace the contents of the node:
pageNode.innerHTML = "<h1>Oh, no! Everything is gone!</h1>";

// Or add to innerHTML instead:
pageNode.innerHTML += "P.S. Please do write back.";
```

To change the actual text of a node, `textContent` may be a better choice:

`innerHTML`:

- Works in older browsers
- **More powerful**: can change code
- **Less secure**: allows cross-site scripting (XSS)

`textContent`:

- Doesn't work in IE8 and below
- **Faster**: the browser doesn't have to parse HTML
- **More secure**: won't execute code

### Reading Inputs From A Form

In `page.html`:

```html
<input type="" id="identifier" value="">
```

In `script.js`:

```js
var formNode = document.getEleementById("Identifier");
var value = formNode.value;
```

## Creating & Removing DOM Nodes

The document object also allows to create new nodes from scratch.

```js
// create node
document.createElement('tagName');
document.createTextNode('text');

domNode.appendChild(childToAppend);  // insert childTaAppend after domNode

// insert node before domNode
domNode.insertBEfore(childToInsert, domnode);
domNode.parentNode.insertBefore(childToInsert, nodeAfterChild);

// remove a node
domnNod.removeChild(childToRemove);
node.parentNode.removeChild(node);
```

Example:

```js
var body = document.body;

var newImg = document.createElement('img');
newImg.src = 'http://placekitten.com/400/300';
newImg.style.border = '1px solid black';

body.appendChild(newImg);

var newParagraph = document.createElement('p');
var newText = document.createTextNode('Squee!');

newParagraph.appendChild(newText);

body.appendChild(newParagraph);
```

### Creating DOM Nodes with Constructor Functions

```js
function Node(params) {
    this.node = document.createElement("tag");

    this.node.attrubute = value;

    // operations on the node

    return this.node;
}

var node = Node(params);
domElement.appendChild(node);
```
