# React Router

Popular routing library. Allows to specify a route through React components, declating which component is to be loaded for a given URL.

Key Components:

- **Router**: wrap the app entrypoint, usually `BrowserRouter`
- **Route**: "Load this component for this URL"
- **Link**: react-managed anchors that won't post back to the browser

## Routers

Router Types:

- *HashRouter*: `#route`, adds hashes to the URLs
- *BrowserRouter*: `/route`, uses HTML5 history API to provide clean URLs
- *MemoryRouter*: no URL

```js
// index.js

//other imports ...

import { BrowserRouter as Router } from "react-router-dom";

React.render(
    <Router>
        <App />
    </Router>,
    document.getElemendById("DomID");
)
```

```js
// Component.js
import { Route, Switch } from "react-router-dom";

<div>
    {/* match route pattern exactly, all subroutes will be matched otherwise */}
    <Route path="/" exact component={Component} /> 
    <Route path="/route" component={Component} />
    ...
</div>

// only one child can match, similar to switch-case
<Switch>
    <Route path="/" exact component={Component} />
    <Route path="/route" component={Component} />
    <Route component={PageNotFound} /> {/* matches all non-existent URLs */}
</Switch>
```

### URL Parameters & Query String

```js
// Given
<Route path="/route/:placeholder" component={Component} />
// URL: app.com/route/subroute?param=value

function Component(props) {
    props.match.params.placeholder;  // subroute
    props.location.query;  // { param: value }
    props.location.pathname; // /route/subroute?param=value
}
```

### Redirecting

```js
import { Redirect } from "react-router-dom";

// redirects to another URL, should'nt be rendered on component mount but after an action
<Redirect to="/route" />
<Redirect from="/old-route" to="/new-route" />
{ condition &&  <Redirect to="/route" /> }  // redirect if condition is true

// or redirect manipolating the history (always in props)
props.history.push("/new-route");  
```

### Prompts

```js
import { Prompt } from "react-router-dom";

// displayes a prompt when the condition is true
<Prompt when={condition} message="prompt message" />
```

## Link

Clicks on a link created with React-Router will be captured by ract an all the routing will happen client side.

```js
import { Link } from "react-router-dom";

// TARGET: <Route path="/route/:itemId" />
<Link to="/route/1">Text</Link>

// add styling attributes to the rendered element when it matches the current URL.
<NavLink to="/route" exact activeClassName="class">Text</NavLink>
<NavLink to="/route" activeStyle={ { cssProp: value } }>Text</NavLink>
```
