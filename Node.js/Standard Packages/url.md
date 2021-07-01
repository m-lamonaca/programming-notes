# Url Module

`http://user:pass@sub.example.com:8080/p/a/t/h?query=string#hash`

![URI Syntax](../../.images/node_url-structure.png)

## Basics

```js

const url = new URL('/foo', 'https://example.org/');

URL.searchParams
URL.searchParams.get("queryparam");
URL.searchParams.has("queryparam");
```
