# CSS Cheat Sheet

## Applying CSS to HTML

### Inline CSS

```html
<tag style=”property:value”></tag>
```

Uses the HTML style attribute.  
Only applies to one element at a time.  
Not recommended except in cases where choices are constrained.

### Embedded CSS

```html
<head>
    <style>
        selector {
            property: value;
            /* box and display */
            /* alignement, position */
            /* margin, border, padding */
            /* max/min height-width*/

            /* colors */

            /* font */
            /* text alignement */
            }
    </style>
</head>
```

Inside `<head>` element.  
Uses `<style>` tag.  
Style not shared, only applies to one HTML file.  
Not Recommended, only use when the number of rules is small and there are constraints on using an external CSS file.

### External CSS

```html
<head>
    <link rel=”stylesheet” type=”text/css” href=”style.css”>
</head>
```

Shared resource, can be referenced from multiple pages.  
Can be cached, reduced HTML file size & bandwidth.  
Easier to maintain, especially in larger projects.

## Selectors

Tthe selector points to the html element to style.

```css
selector {property: value; property: value}

selector {
    property: value;
    property: value;
}
```

### Multiple Selectors

```css
selector1, selector2 {property: value;}
```

### Nested Selectors

Used to select tags nested inn other tags.

```css
outerSelector innerSelector {property: value;}
```

### ID Selector

Should apply to one element on a page.

```css
#selector {property: value;}    /* selects <tag id="selector"> */
```

### Class Selector

Many elements can have the same class, calsses are used to group HTML elements togheter.

```css
.selector {property: value;}    /* selects <tag class="selector"> */
```

### Universal Selector

```css
* {property: value;}    /* selects every HTML element */
```

## Relational Selector

A CSS selector  can contain more than one basic selector.  

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

### Direct child selector (>)

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

### General sibling selector (~)

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

### Adjacent sibling selector (+)

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

## Attribute Selector

Select elements based on whether an attribute is present and what it's value may contain.

`selector[attribute] { property: value; }`

### Attribute Present Selector

`a[target]{ property: value; }` will match

```html
<a href="#" target="_blank">click here</a>
```

### Attribute Equals Selector (=)

`a[href="https://google.com"] { property: value; }` will match

```html
<a href="http://google.com/">search on google</a>
```

### Attribute Contains Selector (*=)

`a[href*="login"] { property: value; }` will match

```html
<a href="/login.php">login page</a>
```

### Attribute Begins With Selector (^=)

`a[href^="Https://"] { property: value; }` will match

```html
<a href="https://www.bbc.com/">The BBC</a>
```

### Attribute Ends With Selector ($=)

`a[href$=".pdf"] { property: value; }`

```html
<!-- WILL match -->
<a href="/docs/menu.pdf">download menu</a>
<!-- Will NOT match -->
<a href="/audio/song.mp3">download song</a>
```

### Attribute Spaced Selector (~=)

`img[alt~="child"] { property: value; }`

```html
<!-- WILL match -->
<img src="child.jpg" alt='a small child'>
<!-- Will NOT match -->
<img src="child.jpg" alt='a-small-child'>
<!-- Will NOT match -->
<img src="child.jpg" alt='asmallchild'>
```

### Attribute Hyphenated Selector (|=)

`p[lang|="en"] { property: value; }`

```html
<!-- WILL match -->
<p lang="en">English</p>
<!-- WILL match -->
<p lang="en-US">American english</p>
<!-- Will NOT match -->
<p lang="fr">Français</p>
```

## [CSS Pseudo-Classes](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes)

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
`selector:focus {...}` selects an element whent the user focuses on it (e.g. tab w/ keyboard). Often used on links, inputs, textareas.

### User Interface State Pseudo-Classes

`input:enabled {...}` selects an input that is in the default state of enabled and aviable for use.  
`input:disabled {...}` selects an input that has the attibute.  
`input:checked {...}` selects checkboxes or radio buttons that are checked.  
`input:indeterminate {...}` selects checkboxes or radio button that has neither selected nor unselected.

### Structural & Position Pseudo-Classes

`selector:first-child {...}` selects an element if it’s the first child within its parent.  
`selector:last-child {...}` selects an element if it’s the last element within its parent.  
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

## Pseudo-Elements

Dynamic elements that don't exist in the document tree.
When used within selectors allow unique parts of the page to be stylized. Only one pseudo-element may be used within a selector at a given time.

### Textual Pseudo-Elements

`selector::first-letter {...}` select the first letter of the text within an element.  
`selector::first-line {...}` selects the first line of text within an element.

### Content Pseudo-Elements

`selector::before {...}` creates a pseudo-element before, or in front of, the selected element.  
`selector::after {...}` creates a pseudo-element after, or behind, the selected element.  
**These pseudo-elements appear nested within the selected element, not outside of it.**

```css
a::after/before {
    propery: value;
    content: " (" attr(attribute_name) ")";
    propery: value;
}
```

### Fragment Pseudo-Elements

`selector::selection {...}` identifies part of the document that has been selected, or highlighted, by a user’s actions.  
`selector::-moz-selection {...}` Mozilla prefixed fragment pseudo-element has been added to ensure the best support for all browser.

## Element Properties

### Color

The color property changes the color of the text,

```css
selector {
    color: color-name;
    color: #<hex-digits>;
    color: rgb();
    color: hsl();
}
```

### Background

- Allows to control the background of any element
- A shorthand property: allows to write multiple CSS properties in one
- All background definitions are optional, but at least one must be stated
- Default values are given to background if some are not defined

```css
selector {
    background:
         url('texture.jpg') /* image */
         top center / 200px 200px /* position / size */
         no-repeat /* repeat */
         fixed /* attachment */
         padding-box /* origin */
         content-box /* clip */
         red; /* color */
}

selector {
    background-color: color-name;
    background-color: #<hex-digits>;
    background-color: rgb();
    background-color: hsl();
}
```

It's possible to use any combination of properties in any order however the above order is recommended to avoid confusion.  
Anything not specified is automatically set to its default.

`background` is made up of eight properties:

- `background-image`
- `background-position`
- `background-size`
- `background-repeat`
- `background-attachment`
- `background-origin`
- `background-clip`
- `background-color`

**Background-image**  
The path to the image. Example: `url('../css/image.png')`

**Background-repeat**  
Whether the background repeats if the width exceeds the background size  
Possible values: `no-repeat`, `repeat`, `repeat-x` and `repeat-y`

**Background-position**  
Position of the background relative to the HTML element
Can accept two unit values: X (left offset) and Y (top offset)
Can also accept Keywords: `left`, `center`, `right` and `top`, `center`, `bottom`.

**Background-attachment**  
Specifies whether the background image should scroll with the page or be fixed

### Font Familty

The font family defines which font is used. When listing multiple fonts, always  list a generic name last.

```css
selector {
    /* specific font name */
    font-family: "Font Name";

    /* generic name */
    font-family: generic-name;

    /* comma separated list */
    font-family: "Font Name", generic-name;
}
```

### Google Fonts

[Documentation](https://developers.google.com/fonts/docs/getting_started)

In `page.html`:

```html
<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=FontFamily&display=swap">
```

In `style.css`:

```css
selector {
    font-family: 'Font Name';
}
```

### Font Size

```css
selector {
    font-size: 11px;  /* pixels */
    font-size: 1.5em;
    font-size: 100%;  /* percentage */
}
```

### Fonts (shorthand)

```css
selector {
    font-style: italic;
    font-weight: bold;
    font-size: 11px;
    font-family: sans-serif;
}


selector {
    font: italic bold 11px sans-serif;
}
```

### Text Decoration & Text Align

```css
selector {
    text-decoration: line color style thickness;
    text-align: alignement;
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

### Width

Sets the width of a block-level element or img; does not work for inline elements (unless their display property is changed).  
Accepts a veriety of length units.

```css
selector {
    width: 200px;
    width: 20em ;   /* relative to font size */
    width: 20%;    /* relative to containing element width */
    width: 20vw;    /*relative to window width: 1vw = 1% window width */
}
```

### Height

Sets the height of a block-level element or img; does not work for inline elements (unless their display property is changed).  
Accepts a veriety of length units.

```css
selector {
    height: 200px;
    height: 20em ;    /* relative to font size */
    height: 20%;    /* relative to containing element height */
    height: 20vw;    /*relative to window height: 1vw = 1% window height */
}
```

### Aspect Ratio

The aspect-ratio  CSS property sets a preferred aspect ratio for the box, which will be used in the calculation of auto sizes and some other layout functions.

```css
selector {
    aspect-ratio: <width> / <height>;
}
```

### Min-Max Width/Height

Set upper or lower limits to the size of elements.  
An element cannot be smaller than its `min-width` or `min-height`.  
An element cannot be larger than its `max-width` or `max-height`.

```css
selector {
    max-width: 100%;    /* may be no wider than the containing element */
    width: 30%;    /* will be 30% of the width of the containing element */
    min-width: 200px;    /* but will stop shrinking with its parent at 200px */
}
```

## CSS Units

### Absolute Lengths

Symbol | Unit
-------|-----------------------------
`cm`   | centimeters
`mm`   | millimeters
`in`   | inch (1 in = 96px = 2.54 cm)
`px`   | pixel (1 px = 1/96 of 1 in)
`pt`   | points (1 pt = 1/72 of 1 in)
`pc`   | picas (1 pc = 12 pt)

### Relative Lengths

Symbol | Unit
-------|------------------------------------------------------------------------------------------
`em`   | Relative to the font-size of the element (2em means 2 times the size of the current font)
`ex`   | Relative to the x-height of the current font (rarely used)
`ch`   | Relative to width of the "0" (zero)
`rem`  | Relative to font-size of the root element
`vw`   | Relative to 1% of the width of the viewport*
`vh`   | Relative to 1% of the height of the viewport*
`vmin` | Relative to 1% of viewport's* smaller dimension
`vmax` | Relative to 1% of viewport's* larger dimension
`%`    | Relative to the parent element

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

### CSS Reset & Normalize

Each browser varies in how it displays web pages.

CSS reset sheets are used to normalize the default CSS across browsers.  
CSS Reset removes every default style and all built-in browser styling.  
The developer is supposed to add any styling from scratch.

The CSS Normalize aims to make built-in browser styling consistent across browsers.  
The developer is supposed to add additional styling where required.

## Specificity

A weight is applied to a CSS declaration, determined by the number of each selector type.
1-0-0: ID selector
0-1-0: Class selector, Attribute selector, Pseudo-class
0-0-1: Element Selector, Pseudo-element
0-0-0: Universal selector (*), combinators (+, >, ~, ' ', ||) and negation pseudo-class :not()

**Note**: The selectors declared inside :not() contribute to the weight.  
Specificity is usually the reason why CSS-rules don't apply to some elements when think you they should

## Box Model

![Box Model](https://hackernoon.com/hn-images/1*2jZwpWH9XO_QllhEpyGqMA.png)

### Padding

Space between the border and the content.

It's possible to specify the padding for each side of the element:

```css
selector {
    padding-top: 15px;
    padding-right: 10%;
    padding-bottom: 10em;
    padding-left: 50vw;
}
```

#### Padding shortcuts

```css
selectopr {
    padding: top right bottom left;  /* Four values (TRBL) */
    padding: top right/left bottom;  /* Three values (T/TL/B) */
    padding: top/bottom right/left;    /* Two values (TB/RL) */
    padding: all;    /* One value */
}
```  

**Note**: Padding adds to the total size of the box, unless `box-sizing: border-box;` is used.

### Border

Borders are specified as "thickness, style, color".

```css
selector {
    border-width: 10px;
    border-style: dashed;
    border-color: #666666;

    border-radius: 5px;    /* Rounded borders */
}
```

#### Border shortcuts

```css
selector {
    border: thickness style color;
}
```

**Note**: Border adds to the total size of the box, `unless box-sizing: border-box;` is used

### Box Sizing

Defines whether the width and height (and min/max) of an element should include padding and borders or not.

```css
selecot {
    box-sizinbg: content-box;    /* Border and padding are not included */
    box-sizinbg: border-box;    /* Include the content, padding and border */
}
```

#### Box Sizing Reset

Universal Box Sizing with Inheritance

```css
html {
    box-sizing: border-box;
}

*, *:before, *:after {
    box-sizing: inherit;
}

```

### Margin

Transparent area around the box that separates it from other elements.

It's possible to specify the margin for each side of the element:

```css
selector {
    padding-top: 15px;
    padding-right: 10%;
    padding-bottom: 10em;
    padding-left: 50vw;
}
```

#### Margin shortcuts

```css
selector {
    margin: top right bottom left;  /* Four values (TRBL) */
    margin: top right/left bottom;  /* Three values (T/TL/B) */
    margin: top/bottom right/left;    /* Two values (TB/RL) */
    margin: all;    /* One value */
}
```

**Note**: Margins use the same syntax as padding.

#### Auto Margin

If a margin is set to auto on a box that has width it will take up as much space as possible.

```css
selector {
    /* Centered */
    margin: 0 auto;
    width: 300px;
}

selector {
    /* Align box to the right */
    margin-left: auto;
    margin-right: 5px;
    width: 300px;
}
```

### Collapsing Margins

Top and bottom margins of near elements are collapsed into a single margin that is equal to the largest of the two margins.

## Layout

### Display Property

```css
div {
    display: inline; /* Default of all elements, unless UA (user agent) stylesheet overrides */
    display: block; /* block is default for elements like <div> and <section>*/
    display: inline-block; /* Characteristics of block, but sits on a line */
    display: grid; /* divide page into major regions or define the relationship in terms of size */
    display: none; /* Hide */
}
```

Inline:

- The default value for elements (e.g. `<span>`, `<em>`, `<b>`, etc.)
- Doesn't break the flow of the text
- The element will accept margin and padding, but the element still sits inline
- Margin and padding will only push other elements horizontally, not vertically
- An inline element will not accept height and width.

Block

- Some elements are set to block by the browser UA (user agent) stylesheet
- Container elements, like `<div>`, `<section>`, `<ul>`, etc.
- Text block elements like `<p>`, `<h1>`, `<h2>`, etc.
- Do not sit inline
- By default take up as much horizontal space as they can

Inline Block

- Combines aspects of inline and block
- Very similar to inline in that it will sit inline with the natural flow of text
- Able to set a width and height

None

- `display: none` removes the element from the document flow
- The element does not take up any space

### Hiding elements

There are several methods to 'hide' elements:

`display: none` removes the element from the document flow
`visibility: hidden` hides the element, but it still takes up space in the layout
`opacity: 0` hides the element, still takes up space in the layout, events work

| Rule                 | Collapse | Events | Tab Order |
|----------------------|----------|--------|-----------|
| `display: none`      | Yes      | No     | No        |
| `visibility: hidden` | No       | No     | No        |
| `opacity: 0`         | No       | Yes    | Yes       |

### Float

Floating an element moves it as far to the left or right of its containing element as possible.  
Other elements, e.g. paragraphs or lists, will wrap around the floated element.  
Floated elements without a width will take up the whole width of the container and not appear floated.  
It's possible to specify whether an element is floated or not and which side it floats on.

**Note**: floated elements will fill the space from left to right and go to a new line based on remaining space.

To place two block level elements to be side by side float both elements, one left and one right.

```css
.float-child-left {
    float: left;
    width: 200px;
    background: #4fc3f7;
}

.float-child-right {
    float: right;
    width: 150px;
    background: #ffa726;
}
```

### Clear

Clearing tells the element on which side (right, left, both) other elements cannot
appear.  

Clearing both ensures the element doesn't wrap next to floats on either side.

```css
selector {
    clear: right;
    clear: left;
    clear: both;
}
```

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
    position: -webkit-sticky;
}
```

`Note`: sticky is not supported by IE and still needs to be prefixed for webkit based browsers

### Z-Index

When elements overlap, the order of overlapping can be changed with z-index:

- The element with highest z-index goes on top
- Without z-index, elements stack in the order that they appear in the DOM
- Elements with non-static positioning will always appear on top of elements with default static positioning

**Nesting is importan**t: if element *B* is on top of element *A*, a child of element *A* can never be higher than element *B*.

```css
selector {
    z-index: <int>;
}
```

### [Grid](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)

```css
selector {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;  /* 3 equl columns */
    grid-template-rows: 1fr 1fr 1fr;  /* 3 equal rows */
}
```

## Functions

### Clamp

The `clamp()` CSS function clamps a value between an upper and lower bound. It takes three parameters: a minimum value, a preferred value, and a maximum allowed value.  
The `clamp()` function can be used anywhere a `<length>`, `<frequency>`, `<angle>`, `<time>`, `<percentage>`, `<number>`, or `<integer>` is allowed.

clamp(MIN, VAL, MAX) is resolved as max(MIN, min(VAL, MAX))

```css
selector {
    length: clamp(MIN, VAL, MAX)  /* is resolved as max(MIN, min(VAL, MAX)) */
}
```

### Var & Variables

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

---

## Content First

Content is the reason users visit websites, download apps, provides email addresses.
Content encompasses a variety of media:

- Graphics, video, audio,
- Social media communication
- Anything used to tell a story or communicate an idea

A user-friendly digital framework enables users to make a series of choices that helps them tell their story.

A non content design approach risks creating useless templates. It requires more reworks and increases project costs.
Risks miscommunications with clients and impacts the User Experience (UX).

### How To Work Content First

1. **Prefect the user experience**:
    Think about the whole user experience rather than content in terms of individual pages.
    Considering the content early the process can yield a better experience.

2. **Consider all channels upfront**:
    Aim to have unified and consistent content across all channels devices
    Helps to spot opportunities and problems early on

3. **Use content to define the layout and design**:
    Understand how content can inform design
    Don't spend time creating templates you won’t use
    Focus on problem-solving for your users

4. **Use proto-content**:
    Focus on getting the writing done
    Work with a prototype
    Use proto-content instead of non-contextual placeholders such as Lorem Ipsum
    Use existing content, draft content, or sample content

5. **Understand content and technological requirements early**:
    Start discussions early across different disciplines: content, UX, design and development
    Have discussions around the required technology to deliver content
    Modify the development platform to accommodate the content rr design the content with the limitations of the development platform in mind

## Mobile First

Mobile phones are an integral part of our lives. More than 50% of all global web traffic comes from mobile phones.  
Google looks at the mobile version before the desktop when ranking a site. Users have a higher trust in websites that are have an excellent mobile UX. Easier to progress from more straightforward outline and functionality to complex solutions.

### How To Work Mobile First

- Mobile-first coding:
  - If you use a framework, make sure it's mobile-first
  - If you write custom code, always prioritize mobile
  - Code elements as mobile-first
- Intuitive and user-friendly interactions
  - Clear CTAs (Call to Action)
  - Super quick loading
- Optimise your content (mobile first usually implies content-first)
  - Relevant, easy to read quickly content (divide long text)
  - Scroll rather than click
  - Help users find what they are looking for quickly
  - Use fonts that display well on mobile

## Responsive Design And Development

A **responsive** website or application automatically adjusts to the screen and adapts to any device.

Responsiveness is a feature of a web page: Is an outcome of specific web development techniques and usually implies mobile-first but does not require it.
Is achieved by deploying media queries that change the default CSS styles and/or modify the layout

*Designers*:

- Used to start from the desktop version
- The mobile version was an afterthought
- Today it's common to design for mobile-first
- Design the desktop version by scaling up and adding features

*Developers*:

- Used to develop for the desktop first
- Mobile development is more painful and requires more knowledge, more testing and more creativity in problem solving

*Teams*:

- More collaboration between multiple disciplines: Copy, UI, UX, developers
- More coordination, adaptation and iteration

### Breakpoints

Breakpoints are often defined in collaboration with UI/UX designers.
There are no defined standard for widths to target in media queries so any reasonable set of increments is enough to target most devices.
The aim is to have sufficient breakpoints to target smartphones, tablets, laptops, and desktops.

Some of the most common widths used:

- `320px`
- `480px`
- `576px`
- `768px`
- `992px`
- `1024px`
- `1200px`

Example of *Bootstrap* (front-end framework) breakpoints:

```css
/* Extra small devices (portrait phones, less than 576px) */
/* No media query for `xs` since this is the default in Bootstrap */
/* Small devices (landscape phones, 576px and up) */
@media (min-width: 576px) {}

/* Medium devices (tablets, 768px and up) */
@media (min-width: 768px) {}

/* Large devices (desktops, 992px and up) */
@media (min-width: 992px) {}

/* Extra large devices (large desktops, 1200px and up) */
@media (min-width: 1200px) {}
```

### Viewport Metatag

Is located in the `<head>` of the HTML document. It defines how a site should render in a web browser for mobile devices and makes media queries will work as intended.

`<meta name="viewport" content="width=device-width, initial-scale=1">`

`device-width`: indicates the width should match with the viewport of the device
`initial-scale`: ensure the zoom will not be applied and the layout will always show on a *1:1* scale
Other settings can be used in the viewport tag but it is not recommended to change them.

### Media Queries

**Media queries** allow the customization of web pages for specific devices (mobile phones, tablets, desktops, etc).
The HTML code is not changed, only the CSS style.
A media query is a logical expression: true or false; if a media query is true, the related rules are applied to the target device.

| Type     | Used For                                     |
|----------|----------------------------------------------|
| `all`    | all media type devices                       |
| `print`  | printers                                     |
| `screen` | computer screens, tablets, smart-phones, etc |
| `speech` | screenreaders that "reads" the page out loud |

```css
@media type operator (feature) {
    selector {
        /* css rule */
    }
}

/* AND logic: Both conditions must be true */
@media screen and (min-width: 400px) and (orientation: landscape) {
    body {
        color: #31c78d;
    }
}
/* OR logic: At least one conditions should be true */
@media screen and (min-width: 400px), screen and (orientation: landscape) {
    body {
        color: #00c3ff;
    }
}

/* NOT logic: Negates the entire condition */
@media not all and (orientation: landscape) {
    body {
        color: #dab928;
    }
}

```

**Media type**: all, screen, print, speech
**Media features**: width, min-width, max-width, orientation, height, min-height, max-height, etc
**Logical operators**: Logically represent `and`, `or`, `not`. The `or` logic is represented by a comma (just like in CSS selectors)

It's possible to specify a media attribute in the link element. This applies a whole stylesheet when the condition is true. Possible to do but preferable to specify a single stylesheet with individual media queries.

```html
<link rel="stylesheet" media="screen and (min-width: 900px)" href="widescreen.css">
<link rel="stylesheet" media="screen and (max-width: 600px)" href="smallscreen.css">
```

It's also possible to have different stylesheets based on media type. This might make sense for some use cases.

```html
<link rel="stylesheet" type="text/css" href="screen.css" media="screen">
<link rel="stylesheet" type="text/css" href="print.css" media="print">
```
