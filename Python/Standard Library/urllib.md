# Urllib Module Cheatsheet

## Module Structure

`urllib` is a package that collects several modules for working with URLs:

- `urllib.request` for opening and reading URLs
- `urllib.error` containing the exceptions raised by urllib.request
- `urllib.parse` for parsing URLs
- `urllib.robotparser` for parsing robots.txt files

## urllib.request

### Opening an URL

```python
import urllib.request

# HTTP request header are not returned
response = urllib.request.urlopen(url)
data = response.read().decode()
```

### Readign Headers

```python
response = urllib.request.urlopen(url)

headers = dict(response.getheaders())  # store headers as a dict
```

## urllib.parse

### URL Encoding

Encode a query in a URL

```python
url = "http://www.addres.x/_?"

# encode an url with passed key-value pairs
encoded = url + urllib.parse.encode( {"key": value} )
```
