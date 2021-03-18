# [Redux](https://redux.js.org/)

Redux is a pattern and library for managing and updating application state, using events called *actions*. It serves as a centralized store for state that needs to be used across the entire application, with rules ensuring that the state can only be updated in a predictable fashion.

## Actions, Store, Immutability & Reducers

### Actions & Action Creators

An **Action** is a plain JavaScript object that has a `type` field. An action object can have other fields with additional information about what happened.  
By convention, that information is stored in a field called `payload`.

**Action Creators** are functions that creates and return an action object.

```js
function actionCreator(data)
{
    return { type: ACTION_TYPE, payload: data }  // action obj
}
```

### Store

The current Redux application state lives in an object called the **store**.  
The store is created by passing in a reducer, and has a method called `getState` that returns the current state value.

The Redux store has a method called `dispatch`. The only way to update the state is to call `store.dispatch()` and pass in an action object.  
The store will run its reducer function and save the new state value inside.

**Selectors** are functions that know how to extract specific pieces of information from a store state value.

```js
function configStore(initialState) {
    return createStore(rootReducer, initialState);
}

replaceReducer(newReducer);  // replace an existing reducer, useful for Hot Reload

store.dispatch(action);  // trigger a state change based on an action
store.subscribe(listener);
store.getState();  // retireve current state
```

### Reducers

**Reducers** are functions that receives the current state and an action, decide how to update the state if necessary, and return the new state.

Reducers must **always** follow some specific rules:

- They should only calculate the new state value based on the `state` and `action` arguments
- They are not allowed to modify the existing `state`.
Instead, they must make *immutable updates*, by copying the existing `state` and making changes to the copied values.
- They must not do any asynchronous logic, calculate random values, or cause other "side effects"

```js
function reducer(state, action) {
    switch(action.type){
        case "ACTION_TYPE":
            return { ...state, prop: value };  // return modified copy of state (using spread operator)
            break;

        default:
            return state;  // return unchanged state (NEEDED)
    }
}

// combining reducers
import { combineReducers } from "redux";

const rootReducer = combineReducers({
    entity: entityReducer
});
```

## [React-Redux](https://react-redux.js.org/)

### Container vs Presentational Components

Container Components:

- Focus on how thing work
- Aware of Redux
- Subscribe to Redux State
- Dispatch Redux actions

Presentaional Components:

- Focus on how things look
- Unaware of Redux
- Read data from props
- Invoke callbacks on props

### Provider Component & Connect

Used at the root component and wraps all the application.

```js
// index.js
import React from 'react'
import ReactDOM from 'react-dom'

import { Provider } from 'react-redux'
import store from './store'

import App from './App'

const rootElement = document.getElementById('root')
ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  rootElement
)
```

```js
// Component.js
import { connect } from 'react-redux'
import { increment, decrement, reset } from './actionCreators'

// const Component = ...

// specifies which state is passed to the component (called on satte change)
const mapStateToProps = (state, ownProps /* optional */) => {
    // structure of the props passsed to the component
    return { propName: state.property }
}

// specifies the action passed to a component (the key is the name that the prop will have )
const mapDispatchToProps = { actionCreator: actionCreator }
// or
function mapDispathToProps(dispatch) {
    return {
        // wrap action creators
        actionCreator: (args) => dispatch(actionCreator(args))
    }
}
// or
function mapDispathToProps(dispatch) {
    return {
        actionCreator: bindActionCreators(actionCreator, dispatch),
        actions: bindActionCreators(allActionCreators, dispatch)
    };
}

// both args ar optional
// if mapDispatch is missing the dispatch function is added to the props
export default connect(mapStateToProps, mapDispatchToProps)(Component)
```
