# Databases in PHP

## PHP Data Objects ([PDO][pdo])

[pdo]: https://www.php.net/manual/en/book.pdo.php

PDO is the PHP extension for database access through a single API. It supports various databases: MySQL, SQLite, PostgreSQL, Oracle, SQL Server, etc.

### Database Connection

```php
$dsn = "mysql:dbname=<dbname>;host=<ip>";
$user="<db_user>";
$password="<db_password>";

try {
    $pdo = new PDO($dsn, $user, $password);  # connect, can throw PDOException
} catch (PDOException $e) {
    printf("Connection failed: %s\n", $e->getMessage());  # notify error
    exit(1);
}
```

### Queries

To execute a query it's necessary to "prepare it" with *parameters*.

```php
# literal string with markers
$sql = 'SELECT fields
FROM tables
WHERE field <operator> :marker'

$stmt = $pdo->prepare($sql, $options_array);  # returns PDOStatement, used to execute the query
$stmt->execute([ ':marker' => value ]);  # substitute marker with actual value

# fetchAll returns all matches
$result = $stmt->fetchAll();  # result as associative array AND numeric array (PDO::FETCH_BOTH)
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);  # result as associative array
$result = $stmt->fetchAll(PDO::FETCH_NUM);  # result as array
$result = $stmt->fetchAll(PDO::FETCH_OBJ);  # result as object of stdClass
$result = $stmt->fetchAll(PDO::FETCH_CLASS, ClassName::class);  # result as object of a specific class
```

### Parameter Binding

```php
# bindValue
$stmt = pdo->prepare(sql);
$stmt->bindValue(':marker', value, PDO::PARAM_<type>);
$stmt->execute();

# bindParam
$stmt = pdo->prepare(sql);
$variable = value;
$stmt->bindParam(':marker', $variable);  # type optional
$stmt->execute();
```

### PDO & Data Types

By default PDO converts all results into strings since it is a generic driver for multiple databases.
Its possible to disable this behaviour setting `PDO::ATTR_STRINGIFY_FETCHES` and `PDO::ATTR_EMULATE_PREPARES` as `false`.

**NOTE**: `FETCH_OBJ` abd `FETCH_CLASS` return classes and don't have this behaviour.

```php
pdo->setAttribute()

$pdo->setAttribute(PDO::ATTR_STRINGIFY_FETCHES, false);
$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

$stmt = $pdo->prepare($sql);
$stmt->execute([':marker' => value]);
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
```

### PDO Debug

```php
$stmt = $pdo->prepare($sql);
$stmt->execute([':marker' => value]);
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

$stmt->debugDumpParams();  # print the SQL query that has been sent to the database
```

## [SQLite3](https://www.php.net/manual/en/book.sqlite3.php)

```php
$db = SQLite3("db_file.sqlite3");  // connection

$stmt = $db->prepare("SELECT fields FROM tables WHERE field <operator> :marker");  // prepare query
$stmt->bindParam(":marker", $variable);  // param binding

$result = $stmt->execute();  // retrieve records
$result->finalize();  // close result set, recommended calling before another execute()

$records = $results->fetchArray(SQLITE3_ASSOC);  // extract records as array (false if no results)
```

**NOTE**: Result set objects retrieved by calling `SQLite3Stmt::execute()` on the same statement object are not independent, but rather share the same underlying structure. Therefore it is recommended to call `SQLite3Result::finalize()`, before calling `SQLite3Stmt::execute()` on the same statement object again.
