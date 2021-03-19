# React

## Components

Thera are two types of react componets:

- Function Components
- Class Components

Both types can be stateful and have side effects or be purely presentational.

```jsx
// functional component
const Component = (props) => {
    return (
        <domElementOrComponent... />
    );
}

// class component
class Component extends React.Component {
    return (
        <domElementOrComponent... />
    );
}
```

*NOTE*: a component name *must* start with an uppercase letter.

Every components has two inputs: *props* and *state*. The props input is explicit while the state is implicit. State is used to determine the chages. Within the component state can be changed while the props object represent fixed values.

JSX syntax can resable HTML bat gets converted to pure JavaScript before being sent to the browser:

```js
// JSX
const element = (
  <h1 className="greeting">Hello, world!</h1>
);

// compiled JS shipped to browser
const element = React.createElement(
  'h1',  // HTML tag name
  {className: 'greeting'},  // attrs as JSON
  'Hello, world!'  // tag content (can be nested component)
);
```

### App Entrypoint

```js
ReactDOM.render(
    <RootComponent />,
    // same as
    React.createElement(RootComponent, null);

    document.getElementById("RootNode_parentId")  // add to DOM
);
```

### Dynamic Expressions

```js
<tag>{expression}</tag>  // expression is evalueted an it's result is displayed
<tag onEvent={funcReference}>{expression}</tag>
<tag onEvent={() => func(args)}>{expression}</tag>
```

### Props

```js
<Component propName={value} />  // pass a value the component
<Component propName={funcreference} />  // pass a function to the component

function Component(props) {
    // use props with {props.propName}
}

class Component extends React.Component{
    // use props with {this.props.propName}
    render()
}
```

### Simple Function Component

```js
// Button.js
import { useState } from "react";

function Button() {
    const [count, setCount] = useState(0);  // hook

    const handleCLick = () => setCount(count + 1);  // logic

    // JSX
    return (
        <button onClick={handleCLick}>
            {count}
        </button>
    );
}

export default Button;
```

### Simple Class Component

```js
class Button extends React.Component {

    state = {count: 0};
    //or
    constructor(props) {
        super(props);
        this.state = {count: 0};
    }

    componentDidMount() {}  // called on successful component mount
    
    handleClick = () => {
        this.setState({ count: this.state.count + 1 });
    }
    // or
    handleClick = () => {
        this.setState((state, props) => ({ count: state.count + props.increment }) );
    }

    render(){
        return (
        <button onClick={this.handleClick}>
            {this.state.count}
        </button>
        );
    }
}
```

### Nesting Compnents

```js
import { useState } from "react";

function Button(props) {
  return (
      <button onClick={props.onClickFunc}>
          +1
      </button>
  );
}

function Display (props) {
  return (
      <div>{props.message}</div>
  );
}

function App() {

    // state must be declare in the outer component it can be passed to each children
    const [count, setCount] = useState(0);
    const incrementCounter = () => setCount(count + 1);

    return (
        <div className="App">
            <Button onClickFunc={incrementCounter}/>
            <Display message={count}/>
        </div>
    );
}

export default App;
```

### User Input (Forms)

```js
function Form() {
    const [userName, setUserName] = useState("");

    handleSubmit = (event) => {
        event.preventDefault();
        // ...
    }

    return(
        <form onSubmit={handleSubmit}>
            <input
                type="text"
                value={userName}  // controlled component
                onChange={(event) => setUserName(event.target.value)}  // needed to update UI on dom change
                required
            />
            <button></button>
        </form>
    );
}
```

### Lists of Components

```js
// ...
    <div>
        {array.map(item => <Component key={uniqueID}>)}
    </div>
// ...
```

**NOTE**: The `key` attribute of the component is needed to identify a particular item. It's most useful if the list has to be sorted.

## Hooks

### `useState`

Hook used to create a state object.

`useState()` results:

- state object (getter)
- updater function (setter)

```js
const [state, setState] = useState(default);
```

### `useEffect`

Hook used to trigger an action on each reder of the component or when one of the watched items changes.

```js

useEffect(() => {
    // "side effects" operations

    return () => {/* clean up side effect */}  // optional
}, [/* list of watched items, empty triggers once */]);
```

### Custom Hooks

```js
// hook definitions
const useCutomHook = () => {
    // eventual state definitions

    // eventual function definitions

    // ...
    
    return { obj1, obj2, ... };
}

const Component(){
    // retrieve elements from the hook
    const {
        obj1,
        obj2,
        ...
    } = useCustomHook();
}
```
