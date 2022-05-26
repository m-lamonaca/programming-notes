# sqlite3 Module

## Connecting To The Database

To use the module, you must first create a Connection object that represents the database.

```python
import sqlite3
connection = sqlite3.connect("file.db")
```

Once you have a `Connection`, you can create a `Cursor` object and call its `execute()` method to perform SQL commands.

```python
cursor = connection.cursor()

cursor.execute(sql)
executemany(sql, seq_of_parameters)  # Executes an SQL command against all parameter sequences or mappings found in the sequence seq_of_parameters.

cursor.close()  # close the cursor now
# ProgrammingError exception will be raised if any operation is attempted with the cursor.
```

The data saved is persistent and is available in subsequent sessions.

### Query Construction

Usually your SQL operations will need to use values from Python variables.
You shouldn't assemble your query using Python's string operations because doing so is insecure:  
it makes your program vulnerable to an [SQL injection attack](https://en.wikipedia.org/wiki/SQL_injection)

Put `?` as a placeholder wherever you want to use a value, and then provide a _tuple of values_ as the second argument to the cursor's `execute()` method.

```python
# Never do this -- insecure!
c.execute("SELECT * FROM stocks WHERE symbol = value")

# Do this instead
t = ('RHAT',)
c.execute('SELECT * FROM stocks WHERE symbol=?', t)
print(c.fetchone())

# Larger example that inserts many records at a time
purchases = [('2006-03-28', 'BUY', 'IBM', 1000, 45.00),
             ('2006-04-05', 'BUY', 'MSFT', 1000, 72.00),
             ('2006-04-06', 'SELL', 'IBM', 500, 53.00),
            ]
c.executemany('INSERT INTO stocks VALUES (?,?,?,?,?)', purchases)
```

### Writing Operations to Disk

```python
cursor = connection.cursor()
cursor.execute("SQL")
connection.commit()
```

### Multiple SQL Instructions

```python
connection = sqlite3.connect("file.db")
cur = con.cursor()
cur.executescript("""
    QUERY_1;
    QUERY_2;
    ...
    QUERY_N;
    """)

con.close()
```

### Retrieving Records

```python
# Fetches the next row of a query result set, returning a single sequence.
# Returns None when no more data is available.
cursor.fetchone()  

# Fetches all (remaining) rows of a query result, returning a list.
# An empty list is returned when no rows are available.
cursor.fetchall()  

# Fetches the next set of rows of a query result, returning a list.
# An empty list is returned when no more rows are available.
fetchmany(size=cursor.arraysize)
```

The number of rows to fetch per call is specified by the `size` parameter. If it is not given, the cursor's `arraysize` determines the number of rows to be fetched.  
The method should try to fetch as many rows as indicated by the size parameter.  
If this is not possible due to the specified number of rows not being available, fewer rows may be returned.

Note there are performance considerations involved with the size parameter.  
For optimal performance, it is usually best to use the arraysize attribute.  
If the size parameter is used, then it is best for it to retain the same value from one `fetchmany()` call to the next.
