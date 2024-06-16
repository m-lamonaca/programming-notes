# Templates with Plates

## Template

To separate HTML code and PHP code it's possible to use **templates** with markers for variable substitution.
Variables are created in the PHP code and are passed to the template in the **rendering** phase.
The server transmits only the `index.php` file to the user. The php file renders the templates as needed.

```html
<html>
    <head>
        <title><?= $this->e($title)?></title>
    </head>

    <body>
        <?= $this->section('content')?>
    </body>
</html>
```

## [Plates](https://platesphp.com/)

Plates is a template engine for PHP. A template engine permits to separate the PHP code (business logic) from the HTML pages.

Installation through composer: `composer require league/plates`.

```php
# index.php
require "vendor/autoload.php";

use League\Plates\Engine;

$templates = new Engine("path\\to\\templates");

echo $templates->render("template_name", [
    "key_1" => "value_1",
    "key_2" => "value_2"
]);
```

```php
# template.php
<html>
    <head>
        <title><?= $key_1?></title>
    </head>

    <body>
        <h1>Hello <?= $key_2 ?></h1>
    </body>
</html>
```

Variables in the template are created through an associative array `key => value`. The key (`"key"`) becomes a variable (`$key`) in the template.

### Layout

It's possible to create a layout (a model) for a group of pages to make that identical save for the contents.
In a layout it's possible to create a section called **content** that identifies content that can be specified at runtime.

> **Note**: Since only the template has the data passed eventual loops have to be done there.

```php
# index.php
require 'vendor/autoload.php';
use League\Plates\Engine;
$template = new Engine('/path/to/templates');
echo $template->render('template_name', [ "marker" => value, ... ]);
```

```php
# template.php

# set the layout used for this template
<?php $this->layout("layout_name", ["marker" => value, ...]) ?>  # pass values to the layout

# section contents
<p> <?= $this->e($marker) ?> </p>
```

```php
# layout.php
<html>
    <head>
        <title><?= $marker ?></title>
    </head>
    <body>
        <?= $this->section('content')?>  # insert the section
    </body>
</html>
```

### Escape

It's necessary to verify that the output is in the necessary format.

Plates offers `$this->escape()` or `$this->e()` to validate the output.
In general the output validation allows to prevent [Cross-Site Scripting][owasp-xss] (XSS).

[owasp-xss]: https://owasp.org/www-community/attacks/xss/

### Folders

```php
# index.php
$templates->addFolder("alias", "path/to/template/folder");  # add a template folder
echo $templates->render("folder::template");  # use a template in a specific folder
```

### Insert

It's possible to inject templates in a layout or template. It is done by using the `insert()` function.

```php
# layout.php
<html>
    <head>
        <title><?=$this->e($title)?></title>
    </head>
    <body>
        <?php $this->insert('template::header') ?>  # insert template

        <?= $this->section('content')?>  # page contents

        <?php $this->insert('template::footer') ?>  # insert template
    </body>
</html>
```

### Sections

It's possible to insert page contest from another template with the `section()` function.
The content to be inserted must be surrounded with by the `start()` and `stop()` functions.

```php
# template.php

<?php $this->start("section_name") ?>  # start section
#  section contents (HTML)
<?php $this->stop() ?>  # stop section

# append to section is existing, create if not
<?php $this->push("section_name") ?>
#  section contents (HTML)
<?php $this->end() ?>
```
