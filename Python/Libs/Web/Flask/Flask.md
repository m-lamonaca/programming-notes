# Flask

```python
from flask import Flask, render_template

app = Flask(__name__, template_folder="path_to_folder")    # create app

# template folder contains html pages
@app.route("/")    # define URLs
def index():

    return render_template("index.html")    # parse HTML page and return it


if __name__ == "__main__":
    # run server if server is single file
    app.run(debug=True, host="0.0.0.0")
```

`@app.route("/page/")` enables to access the page with `url/page` and `url/page/`. The same is possible using `app.add_url_rule("/", "page", function)`.

## Variable Rules

You can add variable sections to a URL by marking sections with `<variable_name>`.  
Your function then receives the `<variable_name>` as a keyword argument.  
Optionally, you can use a converter to specify the type of the argument like `<converter:variable_name>`.

Converter Type | Accepts
---------------|------------------------------
`string`       | any text without a slash (default option)
`int`          | positive integers
`float`        | positive floating point values
`path`         | strings with slashes
`uuid`         | UUID strings

```python
@app.route("/user/<string:username>")    # hanle URL at runtime
def profile(username):
    return f"{escape(username)}'s profile'"
```

## Redirection

`url_for(endpoint, **values)` is used to redirect passing keyeworderd arguments. It can be used in combination with `@app.route("/<value>")` to accept the paassed arguments.

```py
from flask import Flask, redirect, url_for

@app.route("/url")
def func():

    return redirect(url_for("html_file/function"))    # redirect to other page
```

## Jinja Template Rendering (Parsing Python Code in HTML, CSS)

* `{% ... %}` for **Statements**
* `{{ ... }}` for **Expressions** to print to the template output
* `{# ... #}` for **Comments** not included in the template output
* `#  ... ##` for **Line Statements**

Use `{% block block_code %}` to put a line python code inside HTML.
Use `{% end<block> %}` to end a block of code.

In `page.html`;

```py
<html>
    {% for item in content %}
        <p>{{item}}</p>
    {% endfor %}
</html>
```

In `file.py`:

```py
@app.route("/page/)
def func():
    return render_template("page.html", content=["A", "B", "C"])
```

### Hyperlinks

In `file.py`:

```py
@app.route('/linked_page/')
def cool_form():
    return render_template('linked_page.html')
```

In `page.html`:

```html
<!doctype html>
<html>
  <head>
  </head>

  <body>
    <a href="{{ url_for('linked_page') }}">link text</a>
  </body>
</html>
```

### CSS

Put `style.css` inside `/static/style`.  

In `page.html`:

```html
<!doctype html>
<html>
  <head>
  </head>
    <link rel="stylesheet" href="{{ url_for('static', filename='style/style.css') }}">
  <body>

  </body>
</html>
```

## Template Inheritance

In `parent_template.html`:

```html
<html>
    <!-- html content -->
    {% block block_name %}
    {% endblock %}
    <!-- html content -->
</html>
```

The content of the block will be filled by the child class.

In `child_template.hmtl`:

```html
{% extends "parent_template.html" %}
{% block block_name}
    {{ super() }}  <!-- use parent's contents -->
    <!-- block content -->
{% endblock %}
```
