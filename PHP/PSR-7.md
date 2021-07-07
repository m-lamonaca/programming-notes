# PSR-7

## [PSR-7](https://www.php-fig.org/psr/psr-7/)

Standard of the PHP Framework Interop Group that defines common interafces for handling HTTP messages.

- `Psr\Http\Message\MessageInterface`
- `Psr\Http\Message\RequestInterface`
- `Psr\Http\Message\ResponseInterface`
- `Psr\Http\Message\ServerRequestInterface`
- `Psr\Http\Message\StreamInterface`
- `Psr\Http\Message\UploadedFileInterface`
- `Psr\Http\Message\UriInterface`

Example:

```php
// empty array if not found
$header = $request->getHeader('Accept');

// empty string if not found
$header = $request->getHeaderLine('Accept');

// check the presence of a header
if (! $request->hasHeader('Accept')) {}

// returns the parameters in a query string
$query = $request->getQueryParams();
```

### Immutability

PSR-7 requests are *immutable* objects; a change in the data will return a new instance of the object.
The stream objects of PSR-7 are *not immutable*.
