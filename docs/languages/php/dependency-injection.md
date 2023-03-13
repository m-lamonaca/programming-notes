# Dependency Injection

Explicit definition of a class dependencies with the injection through the constructor or *getters*/*setters*.

```php
class Foo
{
    public function __construct(PDO $pdo)  // depends on PDO
    {
        $this->pdo = $pdo;
    }
}
```

## Dependency Injection Container

The **Dependency Injection Container** (DIC) allow to archive all the dependencies in a single `Container` class. Some offer automatic resolution of the dependencies.

## [PHP-DI](https://php-di.org/)

The dependency injection container for humans. Installation: `composer require php-di/php-di`

- **Autowire** functionality: the ability of the container to create and inject the dependency automatically.
- Use of [Reflection](https://www.php.net/manual/en/intro.reflection.php)
- Configuration of the container through annotations & PHP code.

```php
class Foo
{
    private $bar;
    public function __construct(Bar $bar)  // depends on Bar
    {
        $this->bar = $bar;
    }
}

class Bar{}

$container = new DI\Container();  // DI Container
$foo = $container->get('Foo');  // get instance of Foo (automatic DI of Bar)
```

### DIC Configuration

```php
// Foo.php
class Foo
{
    public function __construct(PDO $pdo)  // depends on PDO
    {
        $this->pdo = $pdo;
    }
}
```

```php
// config.php
use Psr\Container\ContainerInterface;

// config "primitive" dependencies (dependency => construct & return)
return [
    'dsn' => 'sqlite:db.sq3',
    PDO::class => function(ContainerInterface $c) {
        return new PDO($c->get('dsn'));
    },

    ...
];
```

```php
$builder = new \DI\ContainerBuilder();
$builder->addDefinitions("config.php");  // load config
$container = $builder->build();  // construct container
$cart = $container->get(Foo::class);  // Instantiate & Inject
```

> **Note**: `get("className")` requires the explicit definition of `className` in the config file. `get(ClassName::class)` does not.
