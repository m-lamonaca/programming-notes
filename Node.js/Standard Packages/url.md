# Url Module

`http://user:pass@sub.example.com:8080/p/a/t/h?query=string#hash`

![URI Syntax](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/URI_syntax_diagram.svg/1920px-URI_syntax_diagram.svg.png)

## Basics

```js

const url = new URL('/foo', 'https://example.org/');

URL.searchParams
URL.searchParams.get("queryparam");
URL.searchParams.has("queryparam");
```
