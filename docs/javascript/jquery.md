# jQuery Library

## Including jQuery

### Download and link the file

```html
<head>
    <script src="jquery-x.x.x.min.js"></script>
</head>
```

### Use a CDN

```html
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/x.x.x/jquery.min.js"></script>
</head>

<!-- OR -->

<head>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-x.x.x.min.js"></script>
</head>
```

### What is a CDN

A **content delivery network** or **content distribution network** (CDN) is a large distributed system of servers deployed in multiple data centers across the Internet.
The goal of a CDN is to serve content to end-users with high availability and high performance.
CDNs serve a large fraction of the Internet content today, including web objects (text, graphics and scripts), downloadable objects (media files, software, documents), applications (e-commerce, portals), live streaming media, on-demand streaming media, and social networks.

## HTML Manipulation

### [Finding DOM elements](https://api.jquery.com/category/selectors/)

```js
$('tag');
$("#id");
$(".class");
```

### Manipulating DOM elements

```js
$("p").addClass("special");
```

```html
<!-- before -->
<p>Welcome to jQuery<p>

<!-- after -->
<p class="special">Welcome to jQuery<p>
```

### Reading Elements

```html
<a id="yahoo" href="http://www.yahoo.com" style="font-size:20px;">Yahoo!</a>
```

```js
// find it & store it
var link = $('a#yahoo');

// get info about it
link.html(); // 'Yahoo!'
link.attr('href'); // 'http://www.yahoo.com'
link.css('font-size'); // '20px
```

### Modifying Elements

```js
// jQuery
$('a').html('Yahoo!');
$('a').attr('href', 'http://www.yahoo.com');
$('a').css({'color': 'purple'});
```

```html
<!-- before -->
<a href="http://www.google.com">Google</a>

<!-- after -->
<a href="http://www.yahoo.com" style="color:purple">Yahoo</a>
```

### Create, Store, Manipulate and inject

```js
let paragraph = $('<p class="intro">Welcome<p>');  // create and store element

paragraph.css('property', 'value');  // manipulate element

$("body").append(paragraph);  // inject in DOM
```

### Regular DOM Nodes to jQuery Objects

```js
var paragraphs = $('p'); // an array
var aParagraph = paragraphs[0]; // a regular DOM node
var $aParagraph = $(paragraphs[0]); // a jQuery Object

// can also use loops
for(var i = 0; i < paragraphs.length; i++) {
    var element = paragraphs[i];
    var paragraph = $(element);
    paragraph.html(paragraph.html() + ' WOW!');
}
```

## [Events](https://api.jquery.com/category/events/)

```js
var onButtonClick = function() {  
    console.log('clicked!');
}

// with named callback & .on
$('button').on('click', onButtonClick);

// with anonymous callback & .on
$('button').on('click', function(){
    console.log('clicked!');
});

// with .click & named callback
$('button').click(onButtonClick);
```

### Preventing Default Event

```js
$('selector').on('event', function(event) {
    event.preventDefault();
    // custom logic
});
```

## Plugins

In the HTML, add a `<script>` ag that hotlinks to the CDN or source file:

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"><script>
```

In the JavaScript call the jQuery plugin on the DOM:

```js
$("form").validate();
```

**NOTE**: always link to the [minified](https://developers.google.com/speed/docs/insights/MinifyResources) js files.

## More jQuery

### Patters & Anti-Patterns

```js
// Pattern: name variables with $var
$myVar =$('#myNode');

// Pattern: store references to callback functions
var callback = function(argument){
    // do something cool
};

$(document).on('click', 'p', myCallback);

// Anti-pattern: anonymous functions
$(document).on('click', 'p', function(argument){
    // do something anonymous
});
```

### Chaining

```js
banner.css('color', 'red');
banner.html('Welcome!');
banner.show();

// same as:
banner.css('color', 'red').html('Welcome!').show();

// same as:
banner.css('color', 'red')
    .html('Welcome!')
    .show();
```

### DOM Readiness

DOM manipulation and event binding doesn't work if the `<script>` is in the `<head>`

```js
$(document).ready(function() {
    // the DOM is fully loaded
});

$(window).on('load', function(){
    // the DOM and all assets (including images) are loaded
});
```

## AJAX (jQuery `1.5`+)

```js
$.ajax({
    method: 'POST',
    url: 'some.php',
    data: { name: 'John', location: 'Boston'}
})
.done(function(msg){alert('Data Saved: '+ msg);})
.fail(function(jqXHR, textStatus){alert('Request failed: '+ textStatus);});
```
