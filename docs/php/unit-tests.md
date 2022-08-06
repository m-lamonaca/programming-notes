# PHP Unit Test

## Installation & Configuration

### Dev-Only Installation

```ps1
composer require --dev phpunit/phpunit
```

```json
    "require-dev": {
        "phpunit/phpunit": "<version>"
    }
```

### Config

PHPUnit can be configured in a XML file called `phpunit.xml`:

```xml
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/autoload.php"
         colors="true">

    <testsuites>
        <testsuit name="App\\Tests">
            <directory>./test<directory>
        </testsuit>
    </testsuites>

    <filter>
        <whitelist processUncoveredFilesFromWhitelist="true">
            <directory suffix=".php">./src</directory>
        </whitelist>
    </filter>
</phpunit>
```

## Testing

### Test Structure

**PHPUnit** tests are grouped in classes suffixed with `Test`. Each class *extends* `PHPUnit\Framework\TestCase`.  
A test is a method of a *test class* prefixed with `test`.  
PHPUnit is executed from the command line with `vendor/bin/phpunit  --colors`.

```php
namespace App;

class Filter
{
    public function isEmail(string $email): bool
    {
        // @todo implement
    }
}
```

```php
namespace App\Test;
use PHPUnit\Framework\TestCase;
use App\Filter;

class FilterTest extends TestCase
{
    public function testValidMail()
    {
        $filter = new Filter();
        $this->assertTrue($filter->isEmail("foo@bar.com"));
    }

    public function testInvalidEmail()
    {
        $filter = new Filter();
        $this->assertFalse($filter->idEmail("foo"));
    }
}
```

### [PHPUnit Assertions](https://phpunit.readthedocs.io/en/9.3/assertions.html)

- `asseretTrue()`: verifies that the element is true
- `assertFalse()`: verifies that the element is false
- `assertEmpty()`: verifies that the element is empty
- `assertEquals()`: verifies that the two elements are equal
- `assertGreaterThan()`: verifies that the element is greater than ...
- `assertContains()`: verifies that the element is contained in an array
- `assertInstanceOf()`: verifies that the element is an instance of a specific class
- `assertArrayHasKey(mixed $key, array $array)`: verify that a specific key is in the array

### [PHPUnit Testing Exceptions](https://phpunit.readthedocs.io/en/9.3/writing-tests-for-phpunit.html#testing-exceptions)

```php
public function testAggiungiEsameException(string $esame)
{
    $this->expectException(Exception::class);
    $this->expectExceptionMessage("exception_message");

    // execute code that should throw an exception
}

// https://github.com/sebastianbergmann/phpunit/issues/2484#issuecomment-648822531
public function testExceptionNotThrown()
{
    $exceptionWasThrown = false;

    try
    {
        // code that should succeed
    }
    catch (EsameException $e)
    {
        $exceptionWasThrown = true;
    }

    $this->assertFalse($exceptionWasThrown);
}

// same as

/**
* @doesNotPerformAssertions
*/
public function testNoExceptions(string $esame)
{
    // code that should succeed (exceptions will make the test fail)
}
```

### Test Setup & Teardown (Example)

```php
class ClassTest extends TestCase
{
    // initialize the test
    public function setUp(): void
    {
        file_put_contents("/tmp/foo", "Test")
    }

    // reset the test
    public function tearDown(): void
    {
        unlink("/tmp/foo")
    }

    public function testFoo()
    {
        // use temp file
    }
}
```

> **Note**: `setUp()` and `tearDown()` are called *before* and *after* each test method.

### Data Provider

```php
class DataTest extends TestCase
{
    /**
    * @dataProvider provider
    */
    public function testAdd($a, $b, $expected)
    {
        $this->assertEquals($expected, $a + $b);
    }

    // test receives array contents as input
    public function provider()
    {
        // must return array of arrays
        return [
            [0, 0, 0],
            [0, 1, 1]
        ];
    }

    // test receives array of arrays as input
    public function provideArrayOfArrays()
    {
        return [
            [
                [
                    [0, 0, 0],
                    [0, 1, 1]
                ]
            ]
        ];
    }
}
```

### Mock Objects

```php
class UnitTest extends TestCase
{
    public function setUp()
    {
        // names of mock are independent from tested class variables
        $this->mock = $this->createMock(ClassName::class);  // create a mock object of a class
        $this->returned = $this->createMock(ClassName::class);  // mock of returned object

        $this->mock->method("methodName")  // simulate method on mock
            ->with($this->equalTo(param), ...)  // specify input params (one param per equalTo)
            ->willReturn($this->returned);  // specify return value
    }

    public function testMethod()
    {
        $this->mock
        ->method("methodName")
        ->with($this->equalTo($arg))  // arg passed to the method
        ->willReturn(value);  // actual return value for THIS case
        // or
        ->will($this->throwException(new Exception()));  // method will throw exception

        // assertions
    }
}
```

### Code Coverage (needs [XDebug](https://xdebug.org/))

```ps1
vendor/bin/phpunit --coverage-text  # code coverage analysis in the terminal
```
