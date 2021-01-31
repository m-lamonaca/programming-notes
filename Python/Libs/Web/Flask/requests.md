# Flask Requests

Specify allowed HTTP methods in `file.py`:  
`@app.route("/page/", methods=["allowed methods"])`

## Forms

in `file.py`:

```py
from flask import Flask, render_template
from flask.globals import request

@app.route("/login/", methods=["GET", "POST"])
def login():
    if request.method == "POST":    # if POST then form has been filled
        data = request.form["field name"]    # store the form's data in variable
        # manipulate form data

        req_args = request.args  # request args

    else:    # if GET then is asking for form page
        return render_template("login.html")
```

In `login.html`:

```html
<html>
    <!-- action="#" goes to page itsef but with # at the end of the URL -->
    <form action="#" method="post">
    <input type="text" name="field name">
</html>
```
