# AJAX

**AJAX**: Asynchronous JavaScript and XML

AJAX Interaction:

1. An event occurs in a web page (the page is loaded, a button is clicked)
2. 2.An `XMLHttpRequest` object is created by JavaScript
3. 3.The `XMLHttpRequest` object sends a request to a web server
4. 4.The server processes the request
5. 5.The server sends a response back to the web page
6. 6.The response is read by JavaScript
7. 7.Proper action (like page update) is performed by JavaScript

## XMLHttpRequest

```js linenums="1"
var request = new XMLHttpRequest();

request.addEventListener(event, function() {...});

request.open("HttpMethod", "path/to/api", true);  // third parameter is asynchronicity (true = asynchronous)
request.setRequestHeader(key, value)  // HTTP Request Headers
request.send()
```

To check the status use `XMLHttpRequest.status` and `XMLHttpRequest.statusText`.

### XMLHttpRequest Events

**loadstart**: fires when the process of loading data has begun. This event always fires first
**progress**: fires multiple times as data is being loaded, giving access to intermediate data
**error**: fires when loading has failed
**abort**: fires when data loading has been canceled by calling abort()
**load**: fires only when all data has been successfully read
**loadend**: fires when the object has finished transferring data always fires and will always fire after error, abort, or load
**timeout**: fires when progression is terminated due to preset time expiring
**readystatechange**: fires when the readyState attribute of a document has changed

**Alternative `XMLHttpRequest` using `onLoad`**:

```js linenums="1"
var request = new XMLHttpRequest();
request.open('GET', 'myservice/username?id=some-unique-id');
request.onload = function(){
    if(request.status ===200){
        console.log("User's name is "+ request.responseText);
    } else {
        console.log('Request failed.  Returned status of '+ request.status);
    }
};
request.send();
```

**Alternative `XMLHttpRequest` using `readyState`**:

```js linenums="1"
var request = new XMLHttpRequest(),  method ='GET',  url ='https://developer.mozilla.org/';

request.open(method, url, true);
request.onreadystatechange = function(){
    if(request.readyState === XMLHttpRequest.DONE && request.status === 200){
        console.log(request.responseText);
    }
};
request.send();
```

`XMLHttpRequest.readyState` values:
`0` `UNSENT`: Client has been created. `open()` not called yet.
`1` `OPENED`: `open()` has been called.
`2` `HEADERS_RECEIVED`: `send()` has been called, and headers and status are available.
`3` `LOADING`: Downloading; `responseText` holds partial data.
`4` `DONE`: The operation is complete.

### `XMLHttpRequest` Browser compatibility

Old versions of IE don't implement XMLHttpRequest. You must use the ActiveXObject if XMLHttpRequest is not available

```js linenums="1"
var request =window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');

// OR

var request;
if(window.XMLHttpRequest){
    // code for modern browsers  
    request = new XMLHttpRequest();
} else {
    // code for old IE browsers
    request = new ActiveXObject('Microsoft.XMLHTTP');
}
```

## Status & Error Handling

Always inform the user when something is loading. Check the status and give feedback (a loader or message)
Errors and responses need to be handled. There is no guarantee that HTTP requests will always succeed.

### Cross Domain Policy

Cross domain requests have restrictions.

Examples of outcome for requests originating from: `http://store.company.com/dir/page.htmlCross-origin`

| URL                                             | Outcome | Reason             |
|-------------------------------------------------|---------|--------------------|
| `http://store.company.com/dir2/other.html`      | success |
| `http://store.company.com/dir/inner/other.html` | success |
| `https://store.company.com/secure.html`         | failure | Different protocol |
| `http://store.company.com:81/dir/other.html`    | failure | Different port     |
| `http://news.company.com/dir/other.html`        | failure | Different host     |
