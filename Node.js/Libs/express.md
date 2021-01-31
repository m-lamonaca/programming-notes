# [Express](https://expressjs.com/)

## Installation

```ps1
npm install express --save
```

## [Application](https://expressjs.com/en/4x/api.html#app)

```js
const express = require("express");

const app = express();
const PORT = 5555;

// correctly serve static contents
app.use(express.static("/route/for/static/files", "path/to/static/files/folder"));

// HTTP GET
app.get("/<route>:<param>", (req, res) => {
    console.log(`${req.connection.remoteAddress} requested ${req.url}`);
});

// HTTP POST
app.post("/<route>:<param>", (req, res) => {
    console.log(`${req.connection.remoteAddress} posted to ${req.url}`);
});

// responds to all HTTP verbs
app.all("/<route>:<param>", (req, res, next) => { 
    next();  // handle successive matching request (valid also on .get() & .post())
});

let server = app.listen(PORT, () => {
    console.log(`Express server listening at http://localhost:${PORT}`);
});

server.on("error", () => {
    server.close();
});
```

## [Response](https://expressjs.com/en/4x/api.html#res)

```js
Response.send([body]);  // Sends the HTTP response.
Response.sendFile(path);  // Transfers the file at the given path.
Response.json(body);  // Sends a JSON response.
Response.redirect([status,] path);  // Redirects to the URL derived from the specified path, with specified status
Response.end();  // Ends the response process
```

## [Request](https://expressjs.com/en/4x/api.html#req)

```js
Request.params.<param>  // query params obj (GET)
Request.body.<param>  // body params (POST)
```
