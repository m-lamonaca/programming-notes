# HTML

## Terminology

**Web design**: The process of planning, structuring and creating a website.  
**Web development**: The process of programming dynamic web applications.  
**Front end**: The outwardly visible elements of a website or application.  
**Back end**: The inner workings and functionality of a website or application.

## Anatomy of an HTML Element

**Element**: Building blocks of web pages, an individual component of HTML.  
**Tag**: Opening tag marks the beginning of an element & closing tag marks the end.
Tags contain characters that indicate the tag's purpose content.

`<tagname> content </tagname>`  

**Container Element**: An element that can contain other elements or content.  
**Stand Alone Element**: An element that cannot contain anything else.  
**Attribute**: Provides additional information about the HTML element. Placed inside an opening tag, before the right angle bracket.  
**Value**: Value is the value assigned to a given attribute. Values must be contained inside quotation marks (“”).

## The Doctype

The first thing on an HTML page is the doctype, which tells the browser which version of the markup language the page is using.

### XHTML 1.0 Strict

```html linenums="1"
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
```

### HTML4 Transitional

```html linenums="1"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
 "http://www.w3.org/TR/html4/loose.dtd">
```

### HTML5

`<!doctype html>`

## The HTML Element

After `<doctype>`, the page content must be contained between tags.

```html linenums="1"
<!doctype html>
<html lang="en">
    <!-- page contents -->
</html>
```

### The HEAD Element

The head contains the title of the page & meta information about the page. Meta information is not visible to the user, but has many purposes, like providing information to search engines.  
UTF-8 is a character encoding capable of encoding all possible characters, or code points, defined by Unicode. The encoding is variable-length and uses 8-bit code units.

XHTML and HTML4: `<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>`

HTML5: `<meta charset="utf-8">`

### HTML Shiv (Polyfill)

Used to make old browsers understand newer HTML5 and newer components.

```html linenums="1"
<!--[if lt IE 9]>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
<![endif]-->
```

## The BODY Element

The body contains the actual content of the page. Everything that is contained in the body is visible to the user.

```html linenums="1"
<body>
    <!-- page contents -->
</body>
```

## JavaScript

XHTML and older: `<script src="js/scripts.js" type="text/javascript"></script>`  
HTML5: `<script src="js/scripts.js"></script>`  (HTML5 spec states that `type` attribute is redundant and should be omitted)  
The `<script>` tag is used to define a client-side script (JavaScript).  
The `<script>` element either contains scripting statements, or it points to an external script file through the src attribute.

### Local, Remote or Inline JavaScript

**Remote**: `<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>`  
**Local**: `<script src="js/main.js"></script>`  
**Inline**: `<script> javascript-code-here </script>`

## Forms

Forms allow to collect data from the user:

* signing up and logging in to websites
* entering personal information
* filtering content (using dropdowns, checkboxes)
* performing a search
* uploading files

Forms contain elements called controls (text inputs, checkboxes, radio buttons, submit buttons).  
When users complete a form the data is usually submitted to a web server for processing.  

### [Form Validation](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation)

Validation is a mechanism to ensure the correctness of user input.

Uses of Validation:

* Make sure that all required information has been entered
* Limit the information to certain types (e.g. only numbers)
* Make sure that the information follows a standard (e.g. email, credit card number)
* Limit the information to a certain length
* Other validation required by the application or the back-end services

#### Front-End Validation

The application should validate all information to make sure that it is complete, free of errors and conforms to the specifications required by the back-end.  
It should contain mechanisms to warn users if input is not complete or correct.  
It should avoid to send "bad" data to the back-end.  

### Back-End Validation

It should never trust that the front-end has done validation since some clever users can bypass the front-end mechanisms easily.  
Back-end services can receive data from other services, not necessarily front-end, that don't perform validation.  

#### Built-In Validation

Not all browsers validate in the same way and some follow the specs partially. Some browsers don't have validation at all (older desktop browsers, some mobile browsers).  
Apart from declaring validation intention with HTML5 developers don't have much control over what the browser actually does.  
Before using build-in validation make sure that it's supported by the target browsers.

#### Validation with JavaScript

* Gives the developer more control.
* The developer can make sure it works on all target browsers.
* Requires a lot of custom coding, or using a library (common practice).

---

## General structure of HTML page

```html linenums="1"
<!-- HTML Boilerplate -->
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- meta tag -->
        <meta charset="utf-8">
        <title></title>
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- adapt page dimensions to device -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- external style sheet here -->
        <link rel="stylesheet" href="path/style-sheet.css">

        <!-- script if necessary -->
        <script src="_.js" type="text/javascript"></script>

        <!-- script is executed only after the page finishes loading-->
        <script src="_.js" defer type="text/javascript"></script>
    </head>
    <body>

        <!-- end of body -->
        <script src="_.js" type="text/javascript"></script>
    </body>
</html>
```

Attributes describe additional characteristics of an HTML element.  
`<tagname attribute="value"> content </tagname>`

### Meta Tag Structure

`<meta name="info-name" content="info-content">`

### Paragraph

Paragraphs allow to format the content in a readable fashion.

```html linenums="1"
<p> paragraph-content </p>
<p> paragraph-content </p>
```

### Headings

Heading numbers indicates hierarchy, not size.

```html linenums="1"
<h1> Heading 1 </h1>
<h2> Heading 2 </h2>
```

### Formatted Text

With semantic value:

* Emphasized text (default cursive): `<em></em>`  
* Important text (default bold): `<strong></strong>`  

Without semantic value, used as last resort:

* Italic text: `<i></i>`  
* Bold text: `<b></b>`

## Elements

`<br/>`: Line break (carriage return). It's not good practice to put line breaks inside paragraphs.  

`<hr>`: horizontal rule (line). Used to define a thematic change in the content.

### Links/Anchor

Surround content to turn into links.

```html linenums="1"
<!-- Link to absolute URL -->
<a href="uri/url" title="content-title" target="_self"> text/image </a>

<!-- links to relative URL -->
<a href="//example.com">Scheme-relative URL</a>
<a href="/en-US/docs/Web/HTML">Origin-relative URL</a>
<a href="./file">Directory-relative URL</a>

<!-- Link to element on the same page -->
<a href="#element-id"></a>

<!-- Link to top of page -->
<a href="#top"> Back to Top </a>

<!-- link to email -->
<a href="mailto:address@domain">address@domain</a>

<!-- link to telephone number -->
<a href="tel:+39(111)2223334">+39 111 2223334</a>

<!-- download link -->
<a href="./folder/filename" download>Download</a>
```

`target`:

* `_blank`: opens linked document in a new window or *tab*
* `_self`: opens linked document in the same frame as it was clicked (DEFAULT)
* `_parent`: opens the linked document in the parent frame
* `_top`: opens linked document in the full body of the window
* `frame-name`: opens the linked document in the specified frame

### Images

```html linenums="1"
<img src="image-location" alt="brief-description"/>    <!-- image element -->
<!-- alt should be always be populated for accessibility and SEO purposes -->
```

```html linenums="1"
<!-- supported by modern browsers -->
<figure>
    <img src="img-location" alt="description">
    <figcaption> caption of the figure </figcaption>
</figure>
```

### Unordered list (bullet list)

```html linenums="1"
<ul>
    <li></li>    <!-- list element -->
    <li></li>
</ul>
```

### Ordered list (numbered list)

```html linenums="1"
<ol>
    <li></li>
    <li></li>
</ol>
```

### Description list (list of terms and descriptions)

```html linenums="1"
<dl>
    <dt>term</dt>    <!-- define term/name -->
    <dd>definition</dd> <!-- describe term/name -->
    <dt>term</dt>
    <dd>definition</dd>
</dl>
```

### Tables

```html linenums="1"
<table>
    <thead>    <!-- table head row -->
        <th></th> <!-- table head, one for each column-->
        <th></th>
    </thead>
    <tbody>    <!-- table content (body) -->
        <tr> <!-- table row -->
            <td></td> <!-- table cell -->
            <td></td>
        </tr>
    </tbody>
</table>
```

### Character Codes

Code     | Character
---------|-----------------
`&copy;` | Copyright
`&lt;`   | less than (`<`)
`&gt;`   | greater than (`>`)
`&amp;`  | ampersand (`&`)

### Block Element

Used to group elements together into sections, eventually to style them differently.

```html linenums="1"
<div>
    <!-- content here -->
</div>
```

### Inline Element

Used to apply a specific style inline.

```html linenums="1"
<p> non-styled content <span class="..."> styled content </span> non-styled content </p>
```

### HTML5 new tags

```html linenums="1"
<header></header>
<nav></nav>
<main></main>
<section></section>
<article></article>
<aside></aside>
<footer></footer>
```

## HTML Forms & Inputs

```html linenums="1"
<form action="data-receiver" target="" method="http-method">
    <!-- ALL form elements go here -->
</form>
```

Target:

* `_blank`: submitted result will open in a new browser tab
* `_self`: submitted result will open in the same page (*default*)

Method:

* `get`: data sent via get method is visible in the browser's address bar
* `post`: data sent via post in not visible to the user

PROs & CONs of `GET` method:

* Data sent by the GET method is displayed in the URL
* It is possible to bookmark the page with specific query string values
* Not suitable for passing sensitive information such as the username and password
* The length of the URL is limited

PROs & CONs of `POST` method:

* More secure than GET; information is never visible in the URL query string or in the server logs
* Has a much larger limit on the amount of data that can be sent
* Can send text data as well as binary data (uploading a file)
* Not possible to bookmark the page with the query

### Basic Form Elements

```html linenums="1"
<form action="" method="">
    <label for="target-identifier">label-here</label>
    <input type="input-type" name="input-name" value="value-sent" id="target-identifier">
</form>

<!-- SAME AS -->

<form>
    <label>Label:
        <input type="input-type" name="input-name" value="value-sent" id="target-identifier">
    </label>
</form>
```

> **Note**: The `<label>` tag is used to define the labels for `<input>` elements.

Input Attributes:

* `name`: assigns a name to the form control (used by JavaScript and queries)
* `value`: value to be sent to the server when the option is selected
* `id`: identifier for CSS and linking tags
* `checked`: initially selected or not (radiobutton, checkboxes, ...)
* `selected`: default selection of a dropdown

### Text Field

One line areas that allow the user to input text.  

```html linenums="1"
<input type="text" placeholder="placeholder-text" spellcheck="true" pattern="\regex\">
```

> **Note**: Text inputs can display a placeholder text that will disappear as soon as some text is entered

### Password Field

```html linenums="1"
<input type="password">
```

### Radio Buttons

```html linenums="1"
<input type="radio" value="value">
<input type="radio" value="value" checked>
```

### Checkboxes

```html linenums="1"
<input type="checkbox">
<input type="checkbox" checked>
```

### Dropdown Menus

```html linenums="1"
<select multiple>
    <option value="value">Value</option>
    <option value="value">Value</option>
    <option value="value" selected>Value</option>
</select>
```

Use `<select>` rather than radio buttons when the number of options to choose from is large
`selected` is used rather than checked.  
Provides the ability to select multiple options.  
Conceptually, `<select>` becomes more similar to checkboxes.

### File Select

Upload a local file as an attachment. The `accept` attribute value is a string that defines the file types the file input should accept.  
This string is a comma-separated list of [unique file type specifiers][file_type_specifiers_docs].

```html linenums="1"
<input type="file" value="filename" accept=".txt,application/json,audio/*">
```

[file_type_specifiers_docs]: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file#unique_file_type_specifiers

### Text Area

Multi line text input.

```html linenums="1"
<textarea rows="row-number" cols="column-number" >pre-existing editable test</textarea>
```

### Submit & Reset

```html linenums="1"
<input type="submit" value="label">
<input type="reset" value="label">
<!-- OR -->
<button type="submit" value="label">
<button type="reset" value="label">
```

`submit`: sends the form data to the location specified in the action attribute.  
`reset`: resets all forms controls to the default values.

### Button

```html linenums="1"
<button type="button/reset/submit" value="label"/>

<!-- can contain HTML -->
<button type="button/reset/submit" value="lebel"></button>
```

### Fieldset

Group controls into categories. Particularly important for screen readers.

```html linenums="1"
<fieldset>
    <legend>Color</legend>
    <input type="radio" name="colour" value="red" id="colour_red">
    <label for="colour_red">Red</label>
    <input type="radio" name="colour" value="green" id="colour_green">
    <label for="colour_green">Green</label>
    <input type="radio" name="colour" value="blue" id="colour_blue">
    <label for="colour_blue">Red</label>
</fieldset>
```

### Email Field

Used to receive a valid e-mail address from the user. Most browsers can validate this without needing javascript.
Older browsers don't support this input type.

```html linenums="1"
<form>
    <label for="user-email">Email:</label>
    <input type="email" name="user-email" id="form-email">
    <button type="submit">Send</button>
</form>
```

### Progress Bar

```html linenums="1"
<progress max="100" value="70"> 70% </progress>
```

### Slider

```html linenums="1"
<input type="range" min="0" max="20">
```

### Meter

The `<meter>` HTML element represents either a scalar value within a known range or a fractional value.

```html linenums="1"
<meter min="0" max="100" low="33" high="66" optimum="80" value="50">current value</meter>
```

### Datalist (Autocomplete)

The `datalist` HTML element can provide suggestions to an input that targets it's `id` with the `list` attribute.

```html
<input list="items">

<datalist id="items">
    <option value="value-1">
    <option value="value-2">
    <option value="value-3">
</datalist>
```

### More Input Types

```html linenums="1"
<input type="email" id="email" name="email" />
<input type="url" id="url" name="url" />
<input type="number" name="" id="identifier" min="min-value" max="max-value" step="" />
<input type="search" id="identifier" name="">
<input type="color" />
```

### [Using Built-In Form Validation](https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation)

One of the most significant features of HTML5 form controls is the ability to validate most user data without relying on JavaScript.  
This is done by using validation attributes on form elements.

* `required`: Specifies whether a form field needs to be filled in before the form can be submitted.
* `minlength`, `maxlength`: Specifies the minimum and maximum length of textual data (strings)
* `min`, `max`: Specifies the minimum and maximum values of numerical input types
* `type`: Specifies whether the data needs to be a number, an email address, or some other specific preset type.
* `pattern`: Specifies a regular expression that defines a pattern the entered data needs to follow.

If the data entered in an form field follows all of the rules specified by the above attributes, it is considered valid. If not, it is considered invalid.

When an element is valid, the following things are true:

* The element matches the `:valid` CSS *pseudo-class*, which lets you apply a specific style to valid elements.
* If the user tries to send the data, the browser will submit the form, provided there is nothing else stopping it from doing so (e.g. JavaScript).

When an element is invalid, the following things are true:

* The element matches the `:invalid` CSS *pseudo-class*, and sometimes other UI *pseudo-classes* (e.g. `:out-of-range`) depending on the error, which lets you apply a specific style to invalid elements.
* If the user tries to send the data, the browser will block the form and display an error message.
