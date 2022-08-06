# Composer & Autoloading

## Autoloading

The function [spl_autoload_register()](https://www.php.net/manual/en/function.spl-autoload-register.php) allows to register a function that will be invoked when PHP needs to load a class/interface defined by the user.

In `autoload.php`:

```php
# custom function
function autoloader($class) {


    # __DIR__ -> path of calling file
    # $class -> className (hopefully same as file)
    # if class is in namespace $class -> Namespace\className (hopefully folders mirror Namespace)

    $class = str_replace("\\", DIRECTORY_SEPARATOR, $class);  # avoid linux path separator issues

    $fileName = sprintf("%s\\path\\%s.php", __DIR__, $class);  
    # or
    $filename = sprintf("%s\\%s.php", __DIR__, $class);  # if class is in namespace

    if (file_exists($fileName)) {
        include $fileName;
    }
}

spl_autoload_register('autoloader');  // register function
```

In `file.php`:

```php
require "autoload.php";

# other code
```

> **Note**: will fuck up if namespaces exists.

### Multiple Autoloading

It's possible to resister multiple autoloading functions by calling `spl_autoload_register()` multiple times.

```php
# prepend adds the function at the start of the queue
# throws selects if errors in loading throw exceptions
spl_autoload_register(callable $func, $throw=TRUE, $prepend=FALSE);

spl_autoload_functions()  # return a list of registered functions.
```

## [Composer](https://getcomposer.org/)

Open Source project for dependency management and autoloading of PHP libraries and classes.

Composer uses `composer.json` to define dependencies with third-party libraries.
Libraries are downloaded through [Packagist](https://packagist.org/) and [GitHub](https://github.com/).

In `composer.json`:

```json
{
    "require": {
        "php": ">=7.0",
        "monolog/monolog": "1.0.*"
    }
}
```

### Installing Dependencies

In the same folder of `composer.json` execute `composer install`.

Composer will create:

- `vendor`: folder containing all requested libraries
- `vendor\autoload.php`: file for class autoloading
- `composer.lock`

In alternative `composer require <lib>` will add the library to the project and create a `composer.json` if missing.

> **Note**: to ignore the php version use `composer <command> --ignore-platform-reqs`

### Updating Dependencies

To update dependencies use `composer update`. To update only the autoloading section use `composer dump-autoload`.

### [Autoloading Project Classes](https://getcomposer.org/doc/04-schema.md#autoload)

[PSR-4 Spec](https://www.php-fig.org/psr/psr-4/)

Composer can also autoload classes belonging to the current project. It's sufficient to add the `autoload` keyword in the JSON and specify the path and autoload mode.

```json
{
    "autoload": {
        "psr-4": {
            "RootNamespace": "src/",
            "Namespace\\": "src/Namespace/",
            },
        "file": [
            "path/to/file.php",
            ...
        ]
    }
}
```
