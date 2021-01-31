# [SimpleMVC](https://github.com/ezimuel/simplemvc) Mini-Framework

Mini framework MVC per scopi didattici basato su Dependency Injection ([PHP-DI][php-di]), Routing ([FastRoute][fastroute]), PSR-7 ([nyholm/psr7][psr7]) e Templates ([Plates][plates])

[php-di]: https://php-di.org/
[fastroute]: https://github.com/nikic/FastRoute
[psr7]:https://github.com/Nyholm/psr7
[plates]: https://platesphp.com/

## Installation

```ps1
composer create-project ezimuel/simple-mvc
```

## Structure

```txt
|- config
|  |- container.php --> DI Container Config (PHP-DI)
|  |- route.php --> routing
|- public
|  |- img
|  |- index.php  --> app entrypoint
|- src
|  |- Model
|  |- View  --> Plates views
|  |- Controller  --> ControllerInterface.php
|- test
|  |- Model
|  |- Controller
```

### `indedx.php`

```php
<?php
declare(strict_types=1);

chdir(dirname(__DIR__));
require 'vendor/autoload.php';

use DI\ContainerBuilder;
use FastRoute\Dispatcher;
use FastRoute\RouteCollector;
use Nyholm\Psr7\Factory\Psr17Factory;
use Nyholm\Psr7Server\ServerRequestCreator;
use SimpleMVC\Controller\Error404;
use SimpleMVC\Controller\Error405;

$builder = new ContainerBuilder();
$builder->addDefinitions('config/container.php');
$container = $builder->build();

// Routing
$dispatcher = FastRoute\simpleDispatcher(function(RouteCollector $r) {
    $routes = require 'config/route.php';
    foreach ($routes as $route) {
        $r->addRoute($route[0], $route[1], $route[2]);
    }
});

// Build the PSR-7 server request
$psr17Factory = new Psr17Factory();
$creator = new ServerRequestCreator(
    $psr17Factory, // ServerRequestFactory
    $psr17Factory, // UriFactory
    $psr17Factory, // UploadedFileFactory
    $psr17Factory  // StreamFactory
);
$request = $creator->fromGlobals();

// Dispatch 
$routeInfo = $dispatcher->dispatch(
    $request->getMethod(), 
    $request->getUri()->getPath()
);
switch ($routeInfo[0]) {
    case Dispatcher::NOT_FOUND:
        $controllerName = Error404::class;
        break;
    case Dispatcher::METHOD_NOT_ALLOWED:
        $controllerName = Error405::class;
        break;
    case Dispatcher::FOUND:
        $controllerName = $routeInfo[1];
        if (isset($routeInfo[2])) {
            foreach ($routeInfo[2] as $name => $value) {
                $request = $request->withAttribute($name, $value);
            }
        }
        break;
}
$controller = $container->get($controllerName);
$controller->execute($request);
```

### `route.php`

```php
<?php
use SimpleMVC\Controller;

return [
    [ 'GET', '/', Controller\Home::class ],
    [ 'GET', '/hello[/{name}]', Controller\Hello::class ],
    [ "HTTP Verb", "/route[/optional]", Controller\EndpointController::class ]
];
```

### `container.php`

```php
<?php
use League\Plates\Engine;
use Psr\Container\ContainerInterface;

return [
    'view_path' => 'src/View',
    Engine::class => function(ContainerInterface $c) {
        return new Engine($c->get('view_path'));
    }

    // PHP-DI configs
];
```

### `ControllerInterface.php`

Each controller *must* implement this interface.

```php
<?php
declare(strict_types=1);

namespace SimpleMVC\Controller;

use Psr\Http\Message\ServerRequestInterface;

interface ControllerInterface
{
    public function execute(ServerRequestInterface $request);
}
```
