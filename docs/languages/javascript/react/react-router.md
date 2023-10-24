# [React Router](https://reactrouter.com)

Popular routing library. Allows to specify a route through React components, declaring which component is to be loaded for a given URL.

Key Components:

- **Router**: wrap the app entry-point, usually `BrowserRouter`
- **Route**: "Load this component for this URL"
- **Link**: react-managed anchors that won't post back to the browser

## Routers

Router Types:

- *HashRouter*: `#route`, adds hashes to the URLs
- *BrowserRouter*: `/route`, uses HTML5 history API to provide clean URLs
- *MemoryRouter*: no URL

```js linenums="1"
// index.js

//other imports ...

import { BrowserRouter as Router } from "react-router-dom";

React.render(
    <Router>
        <App />
    </Router>,
    document.getElementById("DomID");
)
```

```js linenums="1"
// Component.js
import { Route, Route } from "react-router-dom";

<div>
    {/* match route pattern exactly, all sub-routes will be matched otherwise */}
    <Route path="/" exact element={<Component props={props} />} /> 
    <Route path="/route" element={<Component props={props} />} />
    ...
</div>

// only one child can match, similar to Route-case
<Routes>
    <Route path="/" exact element={<Component props={props} />} />
    <Route path="/route" element={<Component props={props} />} />
    <Route component={PageNotFound} /> {/* matches all non-existent URLs */}
</Route>
```

### URL Parameters & Query String

```js linenums="1"
// Given
<Route path="/route/:placeholder" element={<Component props={props} />} />
// URL: app.com/route/sub-route?param=value

function Component(props) {
    props.match.params.placeholder;  // sub-route
    props.location.query;  // { param: value }
    props.location.pathname; // /route/sub-route?param=value
}
```

### Redirecting

```js linenums="1"
import { Navigate } from "react-router-dom";

// redirects to another URL on render, shouldn't be rendered on component mount but after an action
<Navigate to="/route" />
<Navigate from="/old-route" to="/new-route" />
{ condition &&  <Navigate to="/route" /> }  // redirect if condition is true

// or redirect manipulating the history (always in props)
props.history.push("/new-route");
```

### Prompts

```js linenums="1"
import { Prompt } from "react-router-dom";

// displays a prompt when the condition is true
<Prompt when={condition} message="prompt message" />
```

## Link

Clicks on a link created with React-Router will be captured by react an all the routing will happen client side.

```js linenums="1"
import { Link } from "react-router-dom";

// TARGET: <Route path="/route/:itemId" />
<Link to="/route/1">Text</Link>

// add styling attributes to the rendered element when it matches the current URL.
<NavLink to="/route" exact activeClassName="class">Text</NavLink>
<NavLink to="/route" activeStyle={ { cssProp: value } }>Text</NavLink>
```
