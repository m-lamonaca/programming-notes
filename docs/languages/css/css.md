# CSS

## Applying CSS to HTML

### Inline CSS

The style only applies to one element at a time.

```html
<tag style="property:value"></tag>
```

### Embedded CSS

The style is not shared but only applies to one HTML file.

```html
<style>
    selector {
        property: value;
    }
</style>
```

### External CSS

- Shared resource, can be referenced from multiple pages.  
- Can be cached, reduced HTML file size & bandwidth.  

```html
<link rel="stylesheet" href="style.css">
```

## [CSS Selectors](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Selectors)

A CSS selector points to an html element to style.

```css
selector {
    property: value;
    property: value;
}
```

### Multiple Selectors

```css
selector1, selector2 { property: value; }
```

### Nested Selectors

Used to select tags nested in other tags.

```css
outerSelector innerSelector { property: value; }
```

### ID Selector

Can only apply to one element in a page.

```css
#selector { property: value; }    /* selects <tag id="selector"> */
```

### Class Selector

Many elements can have the same class, classes are used to group HTML elements together.

```css
.selector { property: value; }    /* selects <tag class="selector"> */
```

### Universal Selector

```css
* { property: value; }    /* selects every HTML element */
```

### Descendant selector (space)

Selects an element that resides anywhere within an identified ancestor element.

```css
article h2 { property: value; }
```

```html
<!-- Will NOT match -->
<h2>title</h2>
<article>
    <!-- WILL match -->
    <h2>subtitle</h2>
    <div>
        <!-- WILL match -->
        <h2>subtitle</h2>
    </div>
</article>
```

### Direct child selector (`>`)

Selects an elements that resides immediately inside an identified parent element.

```css
article > p { property: value; }
```

```html
<!-- Will NOT match -->
<p>Lorem ipsum dolor sit amet</p>
<article>
    <!-- WILL match -->
    <p>This paragraph will be selected</p>
    <div>
        <!-- Will NOT match -->
        <p>Lorem ipsum dolor sit amet</p>
    </div>
</article>
```

### General sibling selector (`~`)

Selects an element that follows anywhere after the prior element.  
Both elements share the same parent.

```css
h2 ~ p { property: value; }
```

```html
<section>
    <!-- Will NOT match -->
    <p>Lorem ipsum dolor sit amet</p>
    <h2>title</h2>
    <!-- WILL match -->
    <p>This paragraph will be selected</p>
    <div>
        <!-- Will NOT match -->
        <p>Lorem ipsum dolor sit amet</p>
    </div>
    <!-- WILL match -->
    <p>This paragraph will be selected</p>
</section>
<!-- Will NOT match -->
<p>Lorem ipsum dolor sit amet</p>
```

### Adjacent sibling selector (`+`)

Selects an element that follows directly after the prior element.  
Both elements share the same parent.

```css
h2 + p { property: value; }
```

```html
<section>
    <!-- Will NOT match -->
    <p>Lorem ipsum dolor sit amet</p>
    <h2>title</h2>
    <!-- WILL match -->
    <p>This paragraph will be selected</p>
    <div>
        <!-- Will NOT match -->
        <p>Lorem ipsum dolor sit amet</p>
    </div>
    <!-- Will NOT match -->
    <p>Lorem ipsum dolor sit amet</p>
</section>
<!-- Will NOT match -->
<p>Lorem ipsum dolor sit amet</p>
```

### Namespace Separator (`|`)

The **namespace** separator separates the selector from the namespace, identifying the namespace, or lack thereof, for a type selector.

```css
@namespace <namespace> url("<XML-namespace-URL>");

/* specific namespace */
namespace|selector { property: value; }

/* any namespace */
*|selector { property: value; }

/* no namespace */
|selector { property: value; }
```

```css
@namespace svg url('http://www.w3.org/2000/svg');

a {
  color: orangered;
  text-decoration: underline dashed;
  font-weight: bold;
}

svg|a {
  fill: blueviolet;
  text-decoration: underline solid;
  text-transform: uppercase;
}
```

```html
<p>This paragraph 
    <!-- will be colored orangered -->
    <a href="#">has a link</a>.
</p>

<svg width="400" viewBox="0 0 400 20">
  <!-- will be colored blueviolet -->
  <a href="#">
    <text x="0" y="15">Link created in SVG</text>
  </a>
</svg>
```

### Column Selector (`||`)

The column combinator (||) is placed between two CSS selectors. It matches only those elements matched by the second selector that belong to the column elements matched by the first.

```css
column-selector || cell-selector { property: value; }
```

### Attribute Present Selector (`tag[attr]`)

`a[target]{ property: value; }` will match

```html
<a href="#" target="_blank">click here</a>
```

### Attribute Equals Selector (`=`)

`a[href="https://google.com"] { property: value; }` will match

```html
<a href="http://google.com/">search on google</a>
```

### Attribute Contains Selector (`*=`)

`a[href*="login"] { property: value; }` will match

```html
<a href="/login.php">login page</a>
```

### Attribute Begins With Selector (`^=`)

`a[href^="Https://"] { property: value; }` will match

```html
<a href="https://www.bbc.com/">The BBC</a>
```

### Attribute Ends With Selector (`$=`)

`a[href$=".pdf"] { property: value; }`

```html
<!-- WILL match -->
<a href="/docs/menu.pdf">download menu</a>
<!-- Will NOT match -->
<a href="/audio/song.mp3">download song</a>
```

### Attribute Spaced Selector (`~=`)

`img[alt~="child"] { property: value; }`

```html
<!-- WILL match -->
<img src="child.jpg" alt='a small child'>
<!-- Will NOT match -->
<img src="child.jpg" alt='a-small-child'>
<!-- Will NOT match -->
<img src="child.jpg" alt='asmallchild'>
```

### Attribute Hyphenated Selector (`|=`)

`p[lang|="en"] { property: value; }`

```html
<!-- WILL match -->
<p lang="en">English</p>
<!-- WILL match -->
<p lang="en-US">American english</p>
<!-- Will NOT match -->
<p lang="fr">Français</p>
```

## [Pseudo-Classes](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes)

Pseudo-classes can style elements based on their current state. They must be specified after the base case.

```css
selector:pseudo-class { property: value; }
```

### Link Pseudo-Classes

`a:link {...}` selects only `<a>` tags that have `href` attribute, same as `a[href]`.  
`a:visited {...}` selects links that have already been visited by the current browser.

### User Action Pseudo-Classes

`a:hover {...}` selects a link when the mouse rolls over it (hover state).  
`a:active {...}` selects the link while it's being activated (clicked or otherwise).  
`selector:focus {...}` selects an element when the user focuses on it (e.g. tab w/ keyboard). Often used on links, inputs, text-areas.

### User Interface State Pseudo-Classes

`input:enabled {...}` selects an input that is in the default state of enabled and available for use.  
`input:disabled {...}` selects an input that has the attribute.  
`input:checked {...}` selects checkboxes or radio buttons that are checked.  
`input:indeterminate {...}` selects checkboxes or radio button that has neither selected nor unselected.

### Structural & Position Pseudo-Classes

`selector:first-child {...}` selects an element if it's the first child within its parent.  
`selector:last-child {...}` selects an element if it's the last element within its parent.  
`selector:only-child {...}` will select an element if it is the only element within a parent.  

`selector:first-of-type {...}` selects the first element of its type within a parent.  
`selector:last-of-type {...}` selects the last element of its type within a parent.  
`selector:only-of-type {...}` selects an element if it is the only of its type within a parent.

`selector:nth-child() {...}` selects elements based on a simple provided algebraic expression (e.g. "2n" or "4n-1").
Can select even/odd elements, "every third", "the first five", etc.  
`selector:nth-of-type() {...}` works like `:nth-child` in places where the elements at the same level are of different types.  
`selector:nth-last-of-type() {...}` like `:nth-of-type` but counts up from the bottom instead of the top.  
`selector:nth-last-child() {...}` like `:nth-child` but counts up from the bottom instead of the top.

### Empty & Negation Pseudo-Classes

`selector:empty {...}` selects elements with no content (empty tags).  
`selector:not() {...}` selects elements that do not have a certain tag, attribute, class, ID, etc.

## [Pseudo-Elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements)

Dynamic elements that don't exist in the document tree.
When used within selectors allow unique parts of the page to be stylized. Only one pseudo-element may be used within a selector at a given time.

### Textual Pseudo-Elements

`selector::first-letter {...}` selects the first letter of the text within an element.  
`selector::first-line {...}` selects the first line of text within an element.

### Content Pseudo-Elements

`selector::before {...}` creates a pseudo-element before, or in front of, the selected element.  
`selector::after {...}` creates a pseudo-element after, or behind, the selected element.  
**These pseudo-elements appear nested within the selected element, not outside of it.**

```css
selector::<after|before> {
    property: value;
    content: " (" attr(attribute_name) ")";
    property: value;
}
```

### Fragment Pseudo-Elements

`selector::selection {...}` identifies part of the document that has been selected, or highlighted, by a user's actions.  

## CSS Cascading

The browser assigns different priorities to CSS depending on the type of selector.

1. Inline CSS (Most Important)
2. ID selector
3. Class selector
4. Element selector (Least Important)

The browser also assigns priority based on the specificity of the selection. More specific selectors have higher priority.  
Rules lower in the file overwrite higher rules in the file.

### Cascading Override With `!important`

The `!important` declaration overrides any other declaration.  
Using it is very bad practice because it makes debugging more difficult by breaking the natural cascading in stylesheets.

Only use `!important` when:

- overriding foreign CSS (e.g. from a library)
- overriding inline CSS

```css
selector[style*="property:value"] {
    property: value !important;
}
```

### Specificity

A weight is applied to a CSS declaration, determined by the number of each selector type:

- `1-0-0`: ID selector  
- `0-1-0`: Class selector, Attribute selector, Pseudo-class  
- `0-0-1`: Element Selector, Pseudo-element  
- `0-0-0`: Universal selector (`*`), combinators (`+`, `>`, `~`, `||`) and negation pseudo-class `:not()`  

> **Note**: The selectors declared inside `:not()` contribute to the weight.

## [Units](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units)

### Absolute Length units

| Unit   | Name                | Equivalent to        |
| ------ | ------------------- | -------------------- |
| `cm`   | centimeters         | 1cm = 38px = 25/64in |
| `mm`   | Millimeters         | 1mm = 1/10th of 1cm  |
| `Q`    | Quarter-millimeters | 1Q = 1/40th of 1cm   |
| `in`   | Inches              | 1in = 2.54cm = 96px  |
| `pc`   | Picas               | 1pc = 1/6th of 1in   |
| `pt`   | Points              | 1pt = 1/72th of 1in  |
| `px`   | Pixels              | 1px = 1/96th of 1in  |

### Relative Length Units

| Unit   | Relative to                                                         |
| ------ | ------------------------------------------------------------------- |
| `rem`  | Font size of the root element.                                      |
| `em`   | Font size of the parent or the element itself                       |
| `ex`   | x-height of the element's font.                                     |
| `ch`   | The advance measure (width) of the glyph "0" of the element's font. |
| `lh`   | Line height of the element.                                         |
| `vw`   | 1% of the viewport's width.                                         |
| `vh`   | 1% of the viewport's height.                                        |
| `vmin` | 1% of the viewport's smaller dimension.                             |
| `vmax` | 1% of the viewport's larger dimension.                              |
| `%`    | Relative to the parent element                                      |

## Common Element Properties

### Color

```css
selector {
    color: color-name;
    color: #<hex-digits>;
    color: rgb();
    color: hsl();
}
```

### Background

```css
selector {
    background: <image> <position> / <size> <repeat> <attachment> <origin> <clip> <color>;

    background-image: <image-path>;

    background-position: <top|bottom|left|right|center>;
    background-position: <inherit|initial|revert|revert-layer|unset>;
    background-position: <x> <y>

    background-size: <size>;
    background-size: <width> <height>;
    background-size: <size>, <size>;  /* multiple background */


    background-repeat: <horizontal> <vertical>;
    background-repeat: <repeat|no-repeat|repeat-x|repeat-y|space|round>;

    background-attachment: <scroll|fixed|local>;

    background-origin: <border-box|padding-box|content-box>;
    background-clip: <border-box|padding-box|content-box|text>

    background-color: <color>;
    background-color: color-name;
    background-color: #<hex-digits>;
    background-color: rgb();
    background-color: hsl();
}
```

### Font

```css
selector {
    font: <style> <weight> <size> <family>;
    font-style: <style>;
    font-weight: <weight>;
    font-size: <size>;
    font-family: <family>;

    /* specific font name */
    font-family: "Font Name";

    /* generic name */
    font-family: generic-name;

    /* comma separated list */
    font-family: "Font Name", generic-name;
}
```

### Text Decoration & Aliment

```css
selector {
    text-decoration: <line> <color> <style> <thickness>;
    text-align: alignment;
}
```

`text-decoration` values:

- `text-decoration-line`: Sets the kind of decoration used, such as underline or line-through.
- `text-decoration-color`: Sets the color of the decoration.
- `text-decoration-style`: Sets the style of the line used for the decoration, such as solid, wavy, or dashed.
- `text-decoration-thickness`: Sets the thickness of the line used for the decoration.

`text-align` values:

- `start`: The same as left if direction is left-to-right and right if direction is right-to-left.
- `end`: The same as right if direction is left-to-right and left if direction is right-to-left.
- `left`: The inline contents are aligned to the left edge of the line box.
- `right`: The inline contents are aligned to the right edge of the line box.
- `center`: The inline contents are centered within the line box.
- `justify`: The inline contents are justified. Text should be spaced to line up its left and right edges to the left and right edges of the line box, except for the last line.
- `justify-all`: Same as justify, but also forces the last line to be justified.
- `match-parent`: Similar to inherit, but the values start and end are calculated according to the parent's direction and are replaced by the appropriate left or right value.

### Size

```css
selector {
    width: <size>;
    max-width: <size>;
    min-width: <size>;

    height: <size>;
    max-height: <size>;
    min-height: <size>;

    aspect-ratio: <width> / <height>;
}
```

> **Note**: `width` and `height` properties do not have effect on inline elements.

### Hiding Elements

There are several methods to 'hide' elements:

- `display: none` removes the element from the document flow
- `visibility: hidden` hides the element, but it still takes up space in the layout
- `opacity: 0` hides the element, still takes up space in the layout, events work

| Rule                 | Collapse | Events | Tab Order |
| -------------------- | -------- | ------ | --------- |
| `display: none`      | Yes      | No     | No        |
| `visibility: hidden` | No       | No     | No        |
| `opacity: 0`         | No       | Yes    | Yes       |

## [Box Model](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/The_box_model)

![Box Model](../../img/css_box-model.avif)

### Padding

Space between the border and the content.

It's possible to specify the padding for each side of the element:

```css
selector {
    padding-top: <size>;
    padding-right: <size>;
    padding-bottom: <size>;
    padding-left: <size>;

    padding: <top> <right> <bottom> <left>;  /* Four values (TRBL) */
    padding: <top> <right/left> <bottom>;  /* Three values (T/TL/B) */
    padding: <top/bottom> <right/left>;    /* Two values (TB/RL) */
    padding: <all>;    /* One value */
}
```

> **Note**: Padding adds to the total size of the box, unless `box-sizing: border-box;` is used.

### Border

Borders are specified as "size, style, color".

```css
selector {
    border: <size> <style> <color>;
    border-width: <size>;
    border-style: <style>;
    border-color: <color>;

    border-top: <size> <style> <color>;
    border-right: <size> <style> <color>;
    border-bottom: <size> <style> <color>;
    border-left: <size> <style> <color>;

    border-top-width: <size>;
    border-right-width: <size>;
    border-bottom-width: <size>;
    border-left-width: <size>;

    border-top-style: <size>;
    border-right-style: <size>;
    border-bottom-style: <size>;
    border-left-style: <size>;

    border-top-color: <size>;
    border-right-color: <size>;
    border-bottom-color: <size>;
    border-left-color: <size>;

    border-radius: <top-left> <top-right> <bottom-tight> <bottom-left>;
    border-radius: <top-left> <top-right/bottom-left> <bottom-right>;
    border-radius: <top-left/bottom-right> <top-right/bottom-left>;
    border-radius: <all>;

    border-top-left-radius: <size>;
    border-top-right-radius: <size>;
    border-bottom-right-radius: <size>;
    border-bottom-left-radius: <size>;
}
```

> **Note**: Border adds to the total size of the box, `unless box-sizing: border-box;` is used

### Box Sizing

Defines whether the width and height (and min/max) of an element should include padding and borders or not.

```css
selector {
    box-sizing: content-box;    /* Border and padding are not included */
    box-sizing: border-box;    /* Include the content, padding and border */
}
```

### Margin

Transparent area around the box that separates it from other elements.

It's possible to specify the margin for each side of the element.

```css
selector {
    margin-top: <size>;
    margin-right: <size>;
    margin-bottom: <size>;
    margin-left: <size>;

    margin: <top> <right> <bottom> <left>;  /* Four values (TRBL) */
    margin: <top> <right/left> <bottom>;  /* Three values (T/TL/B) */
    margin: <top/bottom> <right/left>;    /* Two values (TB/RL) */
    margin: <all>;    /* One value */
}
```

> **Note**: Top and bottom margins of near elements are collapsed into a single margin that is equal to the largest of the two margins.

## [Element Positioning](https://developer.mozilla.org/en-US/docs/Web/CSS/position)

### Static Positioning

All HTML elements are positioned static by default.  
Static elements are positioned in the normal flow of the page.  
Static elements ignore top, bottom, right, or left property specifications.

In normal flow block elements flow from top to bottom making a new line after every element.
In normal flow inline elements flow from left to right wrapping to next line when needed.

```css
selector {
    position: static;
}
```

### Relative positioning

Takes the element out of the normal flow, allowing it to be moved in relation to the top, bottom, right, or left but does not affect the elements surrounding it.  
Makes an element a "positioning context" in which to position other elements relative to it.  
The relative value will still put the element in the normal flow, but then offset it according to top, bottom, right and left properties.

```css
selector {
    position: relative;
}
```

### Absolute Positioning

Positions element outside of the normal flow and other elements act as if it's not there.  
An absolutely positioned element is offset from its container block, set with the properties top, bottom, right and left.  
Its container block is the first surrounding element that has any position other than static.  
If no such element is found, the container block is `<html>`.

```css
selector {
    position: absolute;
}
```

### Fixed Positioning

The fixed value takes an element out of the normal flow, it positions it relative to the viewport.  
Parent positioning will no longer affect fixed elements.

```css
selector {
    position: fixed;
}
```

### Sticky Positioning

Sticky positioning is a hybrid of relative and fixed positioning.  
The element is treated as relative positioned until it crosses a specified threshold, at which point it is treated as fixed positioned.

```css
selector {
    position: sticky;
}
```

`Note`: sticky is not supported by IE and still needs to be prefixed for webkit based browsers

### Z-Index

When elements overlap, the order of overlapping can be changed with z-index:

- The element with highest z-index goes on top
- Without z-index, elements stack in the order that they appear in the DOM
- Elements with non-static positioning will always appear on top of elements with default static positioning

**Nesting is important**: if element *B* is on top of element *A*, a child of element *A* can never be higher than element *B*.

```css
selector {
    z-index: <int>;
}
```

## [Layouts](https://developer.mozilla.org/en-US/docs/Web/CSS/display)

```css
div {
    display: inline; /* Default of all elements, unless UA (user agent) stylesheet overrides */
    display: block; /* block is default for elements like <div> and <section>*/
    display: inline-block; /* Characteristics of block, but sits on a line */
    display: flex;
    display: grid; /* divide page into major regions or define the relationship in terms of size */
    display: none; /* Hide */
}
```

### Inline

- The default value for elements (e.g. `<span>`, `<em>`, `<b>`, etc.)
- Doesn't break the flow of the text
- The element will accept margin and padding, but the element still sits inline
- Margin and padding will only push other elements horizontally, not vertically
- An inline element will not accept height and width.

### Block

- Some elements are set to block by the browser UA (user agent) stylesheet
- Container elements, like `<div>`, `<section>`, `<ul>`, etc.
- Text block elements like `<p>`, `<h1>`, `<h2>`, etc.
- Do not sit inline
- By default take up as much horizontal space as they can

### Inline Block

- Combines aspects of inline and block
- Very similar to inline in that it will sit inline with the natural flow of text
- Able to set a width and height

### None

- `display: none` removes the element from the document flow
- The element does not take up any space

### [Flex](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_flexible_box_layout)

```css
selector {
    display: "flex";
    flex-direction: <row|column>;
}
```

### [Grid](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)

```css
selector {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;  /* 3 equal columns */
    grid-template-rows: 1fr 1fr 1fr;  /* 3 equal rows */
}
```

## Variables

```css
:root {
    /* define variables on :root element */
    --variable: value;
}

selector {
    --variable: value;  /* overwrite value */
    prop: var(--variable);  /* use value of variable */
}
```

## Responsive Design

A **responsive** website or application automatically adjusts to the screen and adapts to any device.

### Viewport Meta-Tag

Is located in the `<head>` of the HTML document. It defines how a site should render in a web browser for mobile devices and makes media queries will work as intended.

```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

- `device-width`: indicates the width should match with the viewport of the device
- `initial-scale`: ensure the zoom will not be applied and the layout will always show on a `1:1` scale

### Media Queries

**Media queries** allow the customization of web pages for specific devices screen sizes.
A media query is a logical expression: true or false; if a media query is true, the related rules are applied to the target device.

```css
@media type operator (feature) {
    selector { property: value; }
}

/* AND logic: Both conditions must be true */
@media screen and (min-width: 400px) and (orientation: landscape) {
    selector { property: value; }
}
/* OR logic: At least one conditions should be true */
@media screen and (min-width: 400px), screen and (orientation: landscape) {
    selector { property: value; }
}

/* NOT logic: Negates the entire condition */
@media not all and (orientation: landscape) {
    selector { property: value; }
}
```

Types:

- `all`: all media type devices.
- `print`: printers.
- `screen`: computer screens, tablets, smart-phones, etc.
- `speech`: screen readers that "reads" the page out loud.

Features:

- `width`
- `min-width`
- `max-width`
- `height`
- `min-height`
- `max-height`
- `orientation`

It's possible to specify a media attribute in the link element. This applies a whole stylesheet when the condition is true:

```html
<link rel="stylesheet" media="screen and (min-width: 900px)" href="widescreen.css">
<link rel="stylesheet" media="screen and (max-width: 600px)" href="smallscreen.css">
```

It's also possible to have different stylesheets based on media type:

```html
<link rel="stylesheet" type="text/css" href="screen.css" media="screen">
<link rel="stylesheet" type="text/css" href="print.css" media="print">
```
