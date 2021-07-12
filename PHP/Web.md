# PHP for the Web

## PHP Internal Web Server

Command Line Web Server in PHP, useful in testing phase. Limited since handles only one request at a time. **Do not use in production**.

```ps1
PHP -S <ip:post>  # start web server
PHP -S <ip:post> -t /path/to/folder  # execute in specified folder at specified address
PHP -S <ip:post> file.php  # redirect requests to single file
```

## HTTP Methods

Handling of HTTP requests happend using the following global variables:

- `$_SERVER`: info on request headers, version, URL path and method (dict)
- `$_GET`: parameters of get request (dict)
- `$_POST`: parameters of post request (dict)
- `$_COOKIE`
- `$_FILES`: file to send to web app.

### `$_FILES`

```html
<!-- method MUST BE post -->
<!-- must have enctype="multipart/form-data" attribute -->
<form name="<name>" action="file.php" method="POST" enctype="multipart/form-data">
    <input type="file" name="photo" />
    <input type="submit" name="Send" />
</form>
```

Files in `$_FILES` are memorized in a system temp folder. They can be moved with `move_uploaded_file()`

```php
if (! isset($_FILES['photo']['error'])) {
    http_response_code(400);  # send a response code
    echo'<h1>No file has been sent</h1>';
    exit();
}

if ($_FILES['photo']['error'] != UPLOAD_ERR_OK) {
        http_response_code(400);
        echo'<h1>The sent file is invalid</h1>';
        exit();
}

$path = '/path/to/' . $_FILES['photo']['name'];

if (! move_uploaded_file($_FILES['photo']['tmp_name'], $path)) {
    http_response_code(400);
    echo'<h1>Error while writing the file</h1>';
    exit();
}

echo'<h1>File succesfully sent</h1>';
```

### `$_SERVER`

Request Header Access:

```php
$_SERVER["REQUEST_METHOD"];
$_SERVER["REQUEST_URI"];
$_SERVER["SERVER_PROTOCOL"];  // HTTP Versions
$_SERVER["HTTP_ACCEPT"];
$_SERVER["HTTP_ACCEPT_ENCODING"];
$_SERVER["HTTP_CONNECTION"];
$_SERVER["HTTP_HOST"];
$_SERVER["HTTP_USER_AGENT"];
// others
```

### `$_COOKIE`

[Cookie Laws](https://www.iubenda.com/it/cookie-solution)
[Garante Privacy 8/5/2014](http://www.privacy.it/archivio/garanteprovv201405081.html)

All sites **must** have a page for the consensus about using cookies.

**Cookies** are HTTP headers used to memorize key-value info *on the client*. They are sent from the server to the client to keep track of info on the user that is visting the website.  
When a client recieves a HTTP response that contains `Set-Cookie` headers it has to memorize that info and reuse them in future requests.

```http
Set-Cookie: <cookie-name>=<cookie-value>
Set-Cookie: <cookie-name>=<cookie-value>; Expires=<date>
Set-Cookie: <cookie-name>=<cookie-value>; Max-Age=<seconds>
Set-Cookie: <cookie-name>=<cookie-value>; Domain=<domain-value>
Set-Cookie: <cookie-name>=<cookie-value>; Path=<path-value>
Set-Cookie: <cookie-name>=<cookie-value>; Secure
Set-Cookie: <cookie-name>=<cookie-value>; HttpOnly
```

Anyone can modify the contents of a cookie; for this reason cookies **must not contain** *personal or sensible info*.

When a clien has memorized a cookie, it is sent in successive HTTP requests through the `Cookie` header.

```http
Cookie: <cookie-name>=<cookie-value>
```

[PHP setcookie docs](https://www.php.net/manual/en/function.setcookie.php)

```php
setcookie (
string $name,
[ string $value = "" ],
[ int $expire = 0 ],  // in seconds (time() + seconds)
[ string $path = "" ],
[ string $domain = "" ],
[ bool $secure = false ],  // use https
[ bool $httponly = false ]  // accessible only through http (no js, ...)
)

// examle: memorize user-id 112 with 24h expiry for site example.com
setcookie ("User-id", "112", time() + 3600*24, "/", "example.com");

// check if a cookie exists
if(isset($_COOKIE["cookie_name"])) {}
```

### [$_SESSION](https://www.php.net/manual/en/ref.session.php)

**Sessions** are info memorized *on the server* assoiciated to the client that makes an HTTP request.

PHP generates a cookie named `PHPSESSID` containing a *session identifier* and an *hash* generated from `IP + timestamp + pseudo-random number`.

To use the session it's necesary to recall the function `session_start()` at the beginning of a PHP script that deals with sessions.  
After starting the session information in be savend in the `$_SESSION` array.

```php
$_SESSION["key"] = value;  // save data in session file (serialized data)

unset($_SESSION["key"]);  // delete data from the session
session_unset();  # remove all session data
session_destroy();  # destroy all of the data associated with the current session.
# It does not unset any of the global variables associated with the session, or unset the session cookie.
```

Session data is be memorized in a file by *serializing* `$_SESSION`. Files are named as `sess_PHPSESSID` in a folder (`var/lib/php/sessions` in Linux).

It's possible to modify the memorization system of PHP serialization variables by:

- modifying `session.save_handler` in `php.ini`
- writing as personalized handler with the function `session_set_save_handler()` and/or the class `SessionHandler`

## PHP Web Instructions

`http_response_code()` is used to return an HTTP response code. If no code is specified `200 OK` is returned.
`header("Location: /route")` is used to make a redirect to another UTL.
