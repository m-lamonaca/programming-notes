# PHP CheatSheet

[PHP Docs](https://www.php.net/docs.php)

```php
declare(strict_types=1);  # activates variable type checking on function arguments
# single line comment
//single line comment
/* multi line comment */
```

## Include, Require

```php
include "path\\file.php";  # import an external php file, E_WARNING if fails
include_once "path\\file.php";  # imports only if not already loaded

require "path\\file.php";  # import an external php file, E_COMPILE_ERROR if fails
require_once "path\\file.php";  # imports only if not already loaded
```

### Import configs from a file with `include`

In `config.php`:

```php
//config.php

//store configuration options in associative array
return [
    setting => value,
    setting = value,
]
```

```php
$config = include "config.php";  // retrieve config and store into variable
```

## Namespace

[PSR-4 Spec](https://www.php-fig.org/psr/psr-4/)

```php
namespace Foo\Bar\Baz;   # set namespace for all file contents, \ for nested namespaces

use <PHP_Class>  # using a namespace hides standard php classes (WHY?!?)

# namespace for only a block of code
namespace Foo\Bar\Baz {
    function func() {
        # coded here
    }
};


Foo\Bar\Baz\func();  # use function from Foo\Bar\Baz without USE instruction

use Foo\Bar\Baz\func; # import namespace
func(); # use function from Foo\Bar\Baz

use Foo\Bar\Baz\func as f;  # use function with an alias
f();  # use function from Foo\Bar\Baz

use Foo\Bar\Baz as fbb  # use namespace with alias
fnn\func();  # use function from Foo\Bar\Baz
```

## Basics

```php
declare(strict_types=1);  # activates type checking
# single line comment
//single line comment
/* multi line comment */
```

### Screen Output

```php
echo "string";  # string output
echo 'string\n';  # raw string output
printf("format", $variables);  # formatted output of strings and variables
sprintf("format", $variables);  # return formatted string
```

### User Input

```php
$var = readline("prompt");

# if readline is not installed
if (!function_exists('readline')) {
    function readline($prompt)
    {
        $fh = fopen('php://stdin', 'r');
        echo $prompt;
        $userInput = trim(fgets($fh));
        fclose($fh);

        return $userInput;
    }
}
```

## Variables

```php
$variableName = value;  # weakly typed
echo gettype(&variable);  # output type of variable

var_dump($var);  # prints info of variable (bit dimension, type & value)
```

### Integers

```php
&max = PHP_INT_MAX;  # max value for int type -> 9223372036854775807
&min = PHP_INT_MIN;  # min value for int type -> -9223372036854775808
&bytes = PHP_INT_SIZE;  # bytes for int type -> 8

&num = 255;  # decimal
&num = 0b11111111;  # binary
&num = 0377;  # octal
&num = 0xff;  # hexadecimal
```

### Double

```php
$a = 1.234; // 1.234
$b = 1.2e3; // 1200
$c = 7E-10; // 0.0000000007
```

### Mathematical Operators

| Operator | Operation      |
| -------- | -------------- |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `%`      | Modulo         |
| `**`     | Exponentiation |
| `var++`  | Post Increment |
| `++var`  | Pre Increment  |
| `var--`  | Post Decrement |
| `--var`  | Pre Decrement  |

### Mathematical Functions

- `sqrt($x)`
- `sin($x)`
- `cos($x)`
- `log($x)`
- `round($x)`
- `floor($x)`
- `ceil($x)`

## Strings

A string is a sequence of ASCII characters. In PHP a string is an array of characters.

### String Concatenation

```php
$string1 . $string2; # method 1
$string1 .= $string2;  # method 2
```

### String Functions

```php
strlen($string);  # returns the string length
strpos($string, 'substring');  # position of substring in string
substr($string, start, len);  # extract substring of len from position start
strtoupper($string);  # transform to uppercase
strtolower($string);  # transform to lowercase

explode(delimiter, string);  # return array of substrings

$var = sprintf("format", $variables)  # construct and return a formatted string
```

## Constants

```php
define ('CONSTANT_NAME', 'value')
```

### Magic Constants `__NAME__`

- `__FILE__`: script path + script filename
- `__DIR__`: file directory
- `__LINE__`: current line number
- `__FUNCTION__`: the function name, or {closure} for anonymous functions.
- `__CLASS__`: name of the class
- `__NAMESPACE__`: the name of the current namespace.

## Array

Heterogeneous sequence of values.

```php
$array = (sequence_of_items);  # array declaration and valorization
$array = [sequence_of_items];  # array declaration and valorization

# index < 0 selects items starting from the last
$array[index];  # access to the items
$array[index] = value;   # array valorization (can add items)

$array[] = value;  # value appending
```

### Multi Dimensional Array (Matrix)

Array of array. Can have arbitrary number of nested array

```php
$matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];
```

### Array Printing

Single instruction to print whole array is ``

```php
$array = [1, 2, 3];
print_r($array);  # print all the array values
```

### Array Functions

```php
count($array);  # returns number of items in the array
array_sum($array)  # sum of the array value
sort($array);  # quick sort
in_array($item, $array);  // check if item is in the array
array_push($array, $item);  // append item to the array
unset($array[index]);  # item (or variable) deletion

# array navigation
current();
key();
next();
prev();
reset();
end();

# sorting
sort($array, $sort_flags="SORT_REGULAR");

array_values($array);   # regenerates the array fixing the indexes

list($array1 [, $array2, ...]) = $data;  # Python-like tuple unpacking
```

### Associative Arrays

Associative arrays have a value as an index. Alternative names are _hash tables_ or _dictionaries_.

```php
$italianDay = [
    'Mon' => 'Lunedì',
    'Tue' => 'Martedì',
    'Wed' => 'Mercoledì',
    'Thu' => 'Giovedì',
    'Fri' => 'Venerdì',
    'Sat' => 'Sabato',
    'Sun' => 'Domenica'
];

$italianDay["Mon"];  # evaluates to Lunedì
```

## Conditional Instructions

### Conditional Operators

| Operator    | Operation                |
| ----------- | ------------------------ |
| $a `==` $b  | value equality           |
| $a `===` $b | value & type equality    |
| $a `!=` $b  | value inequality         |
| $a `<>` $b  | value inequality         |
| $a `!==` $b | value or type inequality |
| $a `<` $b   | less than                |
| $a `>` $b   | greater than             |
| $a `<=` $b  | less or equal to         |
| $a `>=` $b  | greater or equal to      |
| $a `<=>` $b | spaceship operator       |

With `==` a string evaluates to `0`.

### Logical Operators

| Operator | Example     | Result                                               |
| -------- | ----------- | ---------------------------------------------------- |
| `and`    | `$a and $b` | TRUE if both `$a` and `$b` are TRUE.                 |
| `or`     | `$a or $b`  | TRUE if either `$a` or `$b` is TRUE.                 |
| `xor`    | `$a xor $b` | TRUE if either `$a` or `$b` is TRUE, but _not both_. |
| `not`    | `!$a`       | TRUE if `$a` is _not_ TRUE.                          |
| `and`    | `$a && $b`  | TRUE if both `$a` and `$b` are TRUE.                 |
| `or`     | `$a || $b`  | TRUE if either `$a` or `$b` is TRUE.                 |

### Ternary Operator

```php
condition ? result_if_true : result_if_false;
condition ?: result_if_false;
```

### NULL Coalesce

```php
$var1 = $var2 ?? value;  # if variable == NULL assign value, otherwise return value of $var2

# equivalent to
$var1 = isset($var2) ? $var2 : value
```

### Spaceship Operator

```php
$a <=> $b;

# equivalent to
if $a > $b
    return 1;
if $a == $b
    return 0;
if $a < $b
    return -1;
```

### `If` - `Elseif` - `Else`

```php
if (condition) {
  # code here
} elseif (condition) {
  # code here
} else {
    # code here
}

if (condition) :
    # code here
elseif (condition):
    # code here
else:
    # code here
endif;
```

### Switch Case

```php
# weak comparison
switch ($var) {
    case value:
        # code here
        break;

    default:
        # code here
}

# strong comparison
switch (true) {
    case $var === value:
        # code here
        break;

    default:
        # code here
}
```

### Match Expression (PHP 8)

`match` can return values, doesn't require break statements, can combine conditions, uses strict type comparisons and doesn't do any type coercion.

```php
$result = match($input) {
    0 => "hello",
    '1', '2', '3' => "world",
};
```

## Loops

### For, Foreach

```php
for (init, condition, increment){
    # code here
}

for (init, condition, increment):
    # code here
endfor;

foreach($sequence as $item) {
    # code here
}

foreach($sequence as $item):
    # code here
endforeach;

# foreach on dicts
foreach($sequence as $key => $value) {
    # code here
}
```

### While, Do-While

```php
while (condition) {
    # code here
}

while (condition):
    # code here
endwhile;

do {
    # code here
} while (condition);
```

### Break, Continue, exit()

`break` stops the iteration.  
`continue` skips one cycle of the iteration.
`exit()` terminates the execution of any PHP code.

## Functions

[Function Docstring](https://make.wordpress.org/core/handbook/best-practices/inline-documentation-standards/php/)

Parameters with default values are optional in the function call and must be the last ones in the function declaration. Return type is optional if type checking is disabled.

```php
declare(strict_types=1);  # activates type checking

/**
 * Summary.
 *
 * Description.
 *
 * @since x.x.x
 *
 * @see Function/method/class relied on
 * @link URL
 * @global type $varname Description.
 * @global type $varname Description.
 *
 * @param type $var Description.
 * @param type $var Optional. Description. Default.
 * @return type Description.
 */
function functionName (type $parameter, $parameter = default_value): Type
{
    # code here
    return <expression>;
}
```

### Void function

```php
function functionName (type $parameter, $parameter = default_value): Void
{
    # code here
}
```

### Passing a parameter by reference (`&$`)

```php
function functionName (type &$parameter): Type
{
    # code here
    return <expression>;
}
```

### Variable number of parameters, variadic operator (`...`)

```php
function functionName (type $parameter, ...$args): Type
function functionName (type $parameter, type ...$args): Type
{
    # code here
    return <expression>;
}
```

### Nullable parameters

```php
function functionName (?type $parameter): ?Type
{
    # code here
    return <expression>;
}
```

## Anonymous Functions (Closure)

```php
# declaration and assignment to variable
$var = function (type $parameter) {
    # code here
};

$var($arg);
```

### Use Operator

```php
# use imports a variable into the closure
$foo = function (type $parameter) use ($average) {
    # code here
}
```

### Union Types (PHP 8)

**Union types** are a collection of two or more types which indicate that _either_ one of those _can be used_.

```php
public function foo(Foo|Bar $input): int|float;
```

### Named Arguments (PHP 8)

Named arguments allow to pass in values to a function, by specifying the value name, to avoid taking their order into consideration.
It's also possible to skip optional parameters.

```php
function foo(string $a, string $b, ?string $c = null, ?string $d = null) { /* … */ }

foo(
    b: 'value b',
    a: 'value a',
    d: 'value d',
);
```

## Object Oriented Programming

### Scope & Visibility

`public` methods and attributes are visible to anyone (_default_).
`private` methods and attributes are visible only inside the class in which are declared.
`protected` methods and attributes are visible only to child classes.

`final` classes cannot be extended.

### Class Declaration & Instantiation

```php
# case insensitive
class ClassName
{

    const CONSTANT = value;  # public by default

    public $attribute;  # null by default if not assigned
    public Type $attribute;  # specifying the type is optional, it will be enforced if present

    # class constructor
    public function __construct(value)
    {
        $this->attribute =  value
    }

    public getAttribute(): Type
    {
        return $this->attribute;
    }

    public function func(): Type
    {
        # code here
    }
}

$object = new ClassName;  # case insensitive (CLASSNAME, ClassName, classname)
$object->attribute = value;
$object->func();
$object::CONSTANT;

$var = $object;  # copy by reference
$var = clone $object  # copy by value

$object instanceof ClassName  // check type of the object
```

### Static classes, attributes & methods

Inside static methods it's impossible to use `$this`.
A static variable is unique for the class and all instances.

```php
class ClassName {

    public static $var;

    public static function func(){
        //code here
    }

    public static function other_func(){
        //code here
        self::func();
    }
}

ClassName::func();  // use static function

$obj = new ClassName();
$obj::$var;  // access to the static variable
```

### [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection)

Parameters of the dependency can be modified before passing the required class to the constructor.

```php
class ClassName
{
    private $dependency;

    public function __construct(ClassName requiredClass)
    {
        $this->dependency = requiredClass;  # necessary class is passed to the constructor
    }
}
```

### Inheritance

If a class is defined `final` it can't be extended.
If a function is declared `final` it can't be overridden.

```php
class Child extends Parent
{
    public __construct() {
        parent::__construct();  # call parent's method
    }
}
```

### Abstract Class

Abstract classes cannot be instantiated;

```php
abstract class ClassName
{
    # code here
}
```

### Interface

An interface is a "contract" that defines what methods the implementing classes **must** have and implement.

A class can implement multiple interfaces but there must be no methods in common between interface to avoid ambiguity.

```php
interface InterfaceName {

    // it is possible to define __construct

    // function has no body; must be implements in the class that uses the interface
    public function functionName (parameters) : Type;  // MUST be public
}


class ClassName implements InterfaceName {
    public function functionName(parameters) : Type {
        //implementation here
    }
}
```

### Traits

`Traits` allows the reutilization of code inside different classes without links of inheritance.
It can be used to mitigate the problem of _multiple inheritance_, which is absent in PHP.

In case of functions name conflict it's possible to use `insteadof` to specify which function to use. It's also possible to use an _alias_ to resolve the conflicts.

```php
trait TraitName {
    // code here
}

class ClassName {
    use TraitName, {TraitName::func() insteadof OtherTrait}, { func() as alias };  # can use multiple traits
    # code here
}
```

### Anonymous Classes

```php
$obj = new ClassName;

$obj->method(new class implements Interface {
    public function InterfaceFunc() {
        // code here
    }
});
```

## Serialization & JSON

```php
$serialized = serialize($obj);  # serialization
$obj = unserialize($serialized);  # de-serialization

$var = json_decode(string $json, bool $associative);  # Takes a JSON encoded string and converts it into a PHP variable.ù
$json = json_encode($value);  # Returns a string containing the JSON representation of the supplied value.
```

## Files

### Read/Write on Files

```php
file(filename);  // return file lines in an array

// problematic with large files (allocates memory to read all file, can fill RAM)
file_put_contents(filename, data);  // write whole file
file_get_contents(filename);  // read whole file
```

## Regular Expressions

```php
preg_match('/PATTERN/', string $subject, array $matches);  # returns 1 if the pattern matches given subject, 0 if it does not, or FALSE if an error occurred
# $matches[0] = whole matched string
# $matches[i] = i-th group of the regex
```

## Hashing

Supported hashing algrithms:

- `md2`, `md4`, `md5`
- `sha1`, `sha224`, `sha256`, `sha384`, `sha512/224`, `sha512/256`, `sha512`
- `sha3-224`, `sha3-256`, `sha3-384`, `sha3-512`
- `ripemd128`, `ripemd160`, `ripemd256`, `ripemd320`
- `whirlpool`
- `tiger128,3`, `tiger160,3`, `tiger192,3`, `tiger128,4`, `tiger160,4`, `tiger192,4`
- `snefru`, `snefru256`
- `gost`, `gost-crypto`
- `adler32`
- `crc32`, `crc32b`, `crc32c`
- `fnv132`, `fnv1a32`, `fnv164`, `fnv1a64`
- `joaat`
- `haval128,3`, `haval160,3`, `haval192,3`, `haval224,3`, `haval256,3`, `haval128,4`, `haval160,4`, `haval192,4`, `haval224,4`, `haval256,4`, `haval128,5`, `haval160,5`, `haval192,5`, `haval224,5`, `haval256,5`

```php
hash($algorithm, $data);
```

### Password Hashes

`password_hash()` is compatible with `crypt()`. Therefore, password hashes created by `crypt()` can be used with `password_hash()`.

Algorithms currently supported:

- **PASSWORD_DEFAULT** - Use the _bcrypt_ algorithm (default as of PHP 5.5.0). Note that this constant is designed to change over time as new and stronger algorithms are added to PHP.
- **PASSWORD_BCRYPT** - Use the **CRYPT_BLOWFISH** algorithm to create the hash. This will produce a standard `crypt()` compatible hash using the "$2y$" identifier. The result will always be a 60 character string, or FALSE on failure.
- **PASSWORD_ARGON2I** - Use the **Argon2i** hashing algorithm to create the hash. This algorithm is only available if PHP has been compiled with Argon2 support.
- **PASSWORD_ARGON2ID** - Use the **Argon2id** hashing algorithm to create the hash. This algorithm is only available if PHP has been compiled with Argon2 support.

**Supported options for PASSWORD_BCRYPT**:

- **salt** (string) - to manually provide a salt to use when hashing the password. Note that this will override and prevent a salt from being automatically generated.
  If omitted, a random salt will be generated by password_hash() for each password hashed. This is the intended mode of operation.
  **Warning**: The salt option has been deprecated as of PHP 7.0.0. It is now preferred to simply use the salt that is generated by default.

- **cost** (integer) - which denotes the algorithmic cost that should be used. Examples of these values can be found on the crypt() page.
  If omitted, a default value of 10 will be used. This is a good baseline cost, but you may want to consider increasing it depending on your hardware.

**Supported options for PASSWORD_ARGON2I and PASSWORD_ARGON2ID**:

- **memory_cost** (integer) - Maximum memory (in kibibytes) that may be used to compute the Argon2 hash. Defaults to PASSWORD_ARGON2_DEFAULT_MEMORY_COST.
- **time_cost** (integer) - Maximum amount of time it may take to compute the Argon2 hash. Defaults to PASSWORD_ARGON2_DEFAULT_TIME_COST.
- **threads** (integer) - Number of threads to use for computing the Argon2 hash. Defaults to PASSWORD_ARGON2_DEFAULT_THREADS.

```php
password_hash($password, $algorithm);  # create a new password hash using a strong one-way hashing algorithm.
password_verify($password, $hash);  # Verifies that a password matches a hash
```

## Errors

Types of PHP errors:

- **Fatal Error**: stop the execution of the program.
- **Warning**: generated at runtime, does not stop the execution (non-blocking).
- **Notice**: informative errors or messages, non-blocking.

```php
$a = new StdClass()
$a->foo();  // PHP Fatal Error: foo() does not exist
```

```php
$a = 0;
echo 1/$a;  // PHP Warning: Division by zero
```

```php
echo $a;  // PHP Notice: $a undefined
```

### Error Reporting

[PHP Error Constants](https://www.php.net/manual/en/errorfunc.constants.php)

Its possible to configure PHP to signal only some type of errors. Errors below a certain levels are ignored.

```php
error_reporting(E_<type>);  // set error report threshold (for log file)
// does not disable PARSER ERROR

ini_set("display_errors", 0);  // don't display any errors on stderr
ini_set("error_log", "path\\error.log");  // set log file
```

### Triggering Errors

```php
// generate E_USER_ errors
trigger_error("message");  // default type: E_USER_NOTICE
trigger_error("message", E_USER_<Type>);

trigger_error("Deprecated Function", E_USER_DEPRECATED);
```

### [Writing in the Log File](https://www.php.net/manual/en/function.error-log.php)

It's possible to use log files unrelated to the php log file.

```php
error_log("message", 3, "path\\log.log");  // write log message to a specified file

//example
error_log(sprintf("[%s] Error: _", date("Y-m-d h:i:s")), 3, "path\\log.log")
```

## Exception Handling

PHP offers the possibility to handle errors with the _exception model_.

```php
try {
    // dangerous code
} catch(ExceptionType1 | ExceptionType2 $e) {
    printf("Errore: %s", $e->getMessage());
} catch(Exception $e) {
    // handle or report exception
}

throw new ExceptionType("message");  // throw an exception
```

All exceptions in PHP implement the interface `Throwable`.

```php
Interface Throwable {
    abstract public string getMessage ( void )
    abstract public int getCode ( void )
    abstract public string getFile ( void )
    abstract public int getLine ( void )
    abstract public array getTrace ( void )
    abstract public string getTraceAsString ( void )
    abstract public Throwable getPrevious ( void )
    abstract public string __toString ( void )
}
```

### Custom Exceptions

```php
/**
 * Define a custom exception class
 */
class CustomException extends Exception
{
    // Redefine the exception so message isn't optional
    public function __construct($message, $code = 0, Exception $previous = null) {
        // some code

        // make sure everything is assigned properly
        parent::__construct($message, $code, $previous);
    }

    // custom string representation of object
    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

    public function customFunction() {
        echo "A custom function for this type of exception\n";
    }
}
```
