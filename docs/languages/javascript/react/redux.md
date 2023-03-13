# [Redux](https://redux.js.org/)

Redux is a pattern and library for managing and updating application state, using events called *actions*. It serves as a centralized store for state that needs to be used across the entire application, with rules ensuring that the state can only be updated in a predictable fashion.

## Actions, Store, Immutability & Reducers

### Actions & Action Creators

An **Action** is a plain JavaScript object that has a `type` field. An action object can have other fields with additional information about what happened.  
By convention, that information is stored in a field called `payload`.

**Action Creators** are functions that create and return action objects.

```js
function actionCreator(data)
{
    return { type: ACTION_TYPE, payload: data };  // action obj
}
```

### Store

The current Redux application state lives in an object called the **store**.  
The store is created by passing in a reducer, and has a method called `getState` that returns the current state value.

The Redux store has a method called `dispatch`. The only way to update the state is to call `store.dispatch()` and pass in an action object.  
The store will run its reducer function and save the new state value inside.

**Selectors** are functions that know how to extract specific pieces of information from a store state value.

In `initialState.js`;

```js
export default {
    // initial state here
}
```

In `configStore.js`:

```js
// configStore.js
import { createStore, applyMiddleware, compose } from "redux";

export function configStore(initialState) {
    const composeEnhancers =
        window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose; // support for redux devtools

    return  createStore(
        rootReducer, 
        initialState, 
        composeEnhancers(applyMiddleware(middleware, ...))
    );
}

// available functions & methods
replaceReducer(newReducer);  // replace an existing reducer, useful for Hot Reload
store.dispatch(action);  // trigger a state change based on an action
store.subscribe(listener);
store.getState();  // retrieve current state
```

### Reducers

**Reducers** are functions that receives the current state and an action, decide how to update the state if necessary, and return the new state.

Reducers must **always** follow some specific rules:

- They should only calculate the new state value based on the `state` and `action` arguments
- They are not allowed to modify the existing `state`.
  Instead, they must make *immutable updates*, by copying the existing `state` and making changes to the copied values.
- They must not do any asynchronous logic, calculate random values, or cause other "side effects"

```js
import initialState from "path/to/initialState";

function reducer(state = initialState, action) {
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
    entity: entityReducer.
    ...
});
```

> **Note**: multiple reducers can be triggered by the same action since each one operates on a different portion of the state.

## [React-Redux](https://react-redux.js.org/)

### Container vs Presentational Components

Container Components:

- Focus on how thing work
- Aware of Redux
- Subscribe to Redux State
- Dispatch Redux actions

Presentational Components:

- Focus on how things look
- Unaware of Redux
- Read data from props
- Invoke callbacks on props

### Provider Component & Connect

Used at the root component and wraps all the application.

```js
// index.js
import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import { configStore } from 'path/to/configStore';
import initialState from "path/to/initialState";
import App from './App';

const store = configStore(initialState);

const rootElement = document.getElementById('root');
ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  rootElement
);
```

```js
// Component.js
import { connect } from 'react-redux';
import { increment, decrement, reset } from './actionCreators';

// const Component = ...

// specifies which state is passed to the component (called on state change)
const mapStateToProps = (state, ownProps /* optional */) => {
    // structure of the props passed to the component
    return { propName: state.property };
};

// specifies the action passed to a component (the key is the name that the prop will have )
const mapDispatchToProps = { actionCreator: actionCreator };
// or
function mapDispatchToProps(dispatch) {
    return {
        // wrap action creators
        actionCreator: (args) => dispatch(actionCreator(args))
    };
}
// or
function mapDispatchToProps(dispatch) {
    return {
        actionCreator: bindActionCreators(actionCreator, dispatch),
        actions: bindActionCreators(allActionCreators, dispatch)
    };
}

// both args are optional
// if mapDispatch is missing the dispatch function is added to the props
export default connect(mapStateToProps, mapDispatchToProps)(Component);
```

## Async Operations with [Redux-Thunk](https://github.com/reduxjs/redux-thunk)

**Note**: Redux middleware runs *after* and action and *before* it's reducer.

Redux-Thunk allows to return functions instead of objects from action creators.  
A "thunk" is a function that wraps an expression to delay it's evaluation.

In `configStore.js`:

```js
import { createStore, applyMiddleware, compose } from "redux";
import thunk from "redux-thunk";

function configStore(initialState) {
    const composeEnhancers =
        window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose; // support for redux devtools

    return  createStore(
        rootReducer, 
        initialState, 
        composeEnhancers(applyMiddleware(thunk, ...))  // add thunks middleware
    );
}
```

```js
// usually action on async func success
function actionCreator(arg) {
    return { type: TYPE, data: arg };
}

export function thunk() {
    return function (dispatch) {  // redux-thunk injects dispatch as arg
        return asyncFunction().then((data) => {  // async function returns a promise
                dispatch(actionCreator(data));
            })
            .catch((error) => {
                throw error;
            });
    };
}

// or using async/await
export async function thunk() {
    return function (dispatch) {  // redux-thunk injects dispatch as arg
        try {
            let data = await asyncFunction();
            return dispatch(actionCreator(data));
        } catch(error) {
                throw error;
        }
    }
}
```

## [Redux-Toolkit](https://redux-toolkit.js.org/)

The Redux Toolkit package is intended to be the standard way to write Redux logic. It was originally created to help address three common concerns about Redux.

Redux Toolkit also includes a powerful data fetching and caching capability dubbed "RTK Query". It's included in the package as a separate set of entry points. It's optional, but can eliminate the need to hand-write data fetching logic yourself.

These tools should be beneficial to all Redux users. Whether you're a brand new Redux user setting up your first project, or an experienced user who wants to simplify an existing application, Redux Toolkit can help you make your Redux code better.
Installation​
Using Create React App​

The recommended way to start new apps with React and Redux is by using the official Redux+JS template or Redux+TS template for Create React App, which takes advantage of Redux Toolkit and React Redux's integration with React components.

```sh
# Redux + Plain JS template
npx create-react-app my-app --template redux

# Redux + TypeScript template
npx create-react-app my-app --template redux-typescript
```

Redux Toolkit includes these APIs:

- [`configureStore()`][cfg_store]: wraps `createStore` to provide simplified configuration options and good defaults.  
  It can automatically combines slice reducers, adds whatever Redux middleware supplied, includes redux-thunk by default, and enables use of the Redux DevTools Extension.

- [`createReducer()`][new_reducer]: that lets you supply a lookup table of action types to case reducer functions, rather than writing switch statements.
  In addition, it automatically uses the `immer` library to let you write simpler immutable updates with normal mutative code, like `state.todos[3].completed = true`.

- [`createAction()`][new_action]: generates an action creator function for the given action type string.
  The function itself has `toString()` defined, so that it can be used in place of the type constant.
- [`createSlice()`][new_slice]: accepts an object of reducer functions, a slice name, and an initial state value, and automatically generates a slice reducer with corresponding action creators and action types.
- [`createAsyncThunk`][new_async_thunk]: accepts an action type string and a function that returns a promise, and generates a thunk that dispatches pending/fulfilled/rejected action types based on that promise
- [`createEntityAdapter`][entity_adapt]: generates a set of reusable reducers and selectors to manage normalized data in the store
- The `createSelector` utility from the Reselect library, re-exported for ease of use.

[cfg_store]: https://redux-toolkit.js.org/api/configureStore
[new_reducer]: https://redux-toolkit.js.org/api/createReducer
[new_action]: https://redux-toolkit.js.org/api/createAction
[new_slice]: https://redux-toolkit.js.org/api/createSlice
[new_async_thunk]: https://redux-toolkit.js.org/api/createAsyncThunk
[entity_adapt]: https://redux-toolkit.js.org/api/createEntityAdapter

### [`configureStore`](https://redux-toolkit.js.org/api/configureStore)

Included Default Middleware​:

- Immutability check middleware: deeply compares state values for mutations. It can detect mutations in reducers during a dispatch, and also mutations that occur between dispatches.
  When a mutation is detected, it will throw an error and indicate the key path for where the mutated value was detected in the state tree. (Forked from `redux-immutable-state-invariant`.)

- Serializability check middleware: a custom middleware created specifically for use in Redux Toolkit
  Similar in concept to `immutable-state-invariant`, but deeply checks the state tree and the actions for non-serializable values such as functions, Promises, Symbols, and other non-plain-JS-data values
  When a non-serializable value is detected, a console error will be printed with the key path for where the non-serializable value was detected.

- In addition to these development tool middleware, it also adds `redux-thunk` by default, since thunks are the basic recommended side effects middleware for Redux.

Currently, the return value of `getDefaultMiddleware()` is:

```js
// development
const middleware = [thunk, immutableStateInvariant, serializableStateInvariant]

// production​
const middleware = [thunk]
```

```js

import { combineReducers } from 'redux'
import { configureStore } from '@reduxjs/toolkit'
import monitorReducersEnhancer from './enhancers/monitorReducers'
import loggerMiddleware from './middleware/logger'
import usersReducer from './usersReducer'
import postsReducer from './postsReducer'

const rootReducer = combineReducers({
  users: usersReducer,
  posts: postsReducer,
})

const store = configureStore({
  // reducers combined automatically
  reducer: rootReducer,
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(loggerMiddleware),
  enhancers: [monitorReducersEnhancer]
})

export default store
```

### [`createAction`](https://redux-toolkit.js.org/api/createAction)

```js
import { createAction } from '@reduxjs/toolkit';

const increment = createAction<number | undefined>('counter/increment');

const action = increment();  // { type: 'counter/increment' }
const action = increment(3);  // { type: 'counter/increment', payload: 3 }

increment.toString();  // 'counter/increment'
```

### [`createReducer`](https://redux-toolkit.js.org/api/createReducer)

```js
import { createAction, createReducer } from '@reduxjs/toolkit'

interface CounterState {
  value: number
}

const increment = createAction('counter/increment')
const decrement = createAction('counter/decrement')
const incrementByAmount = createAction<number>('counter/incrementByAmount')

const initialState = { value: 0 } as CounterState

const counterReducer = createReducer(initialState, (builder) => {
  builder
    .addCase(increment, (state, action) => {
      state.value++
    })
    .addCase(decrement, (state, action) => {
      state.value--
    })
    .addCase(incrementByAmount, (state, action) => {
      state.value += action.payload
    })
})
```

### [`createSlice`](https://redux-toolkit.js.org/api/createSlice)

A function that accepts an initial state, an object of reducer functions, and a "slice name", and automatically generates action creators and action types that correspond to the reducers and state.

Internally, it uses `createAction` and `createReducer`, so it's possible to use Immer to write "mutating" immutable updates.

**Note**: action types will have the `<slice-name>/<reducer-name>` shape.

```js
import { createSlice, PayloadAction } from '@reduxjs/toolkit'

interface CounterState {
  value: number
}

const initialState = { value: 0 } as CounterState

const counterSlice = createSlice({
  name: 'counter',
  initialState,
  reducers: {
    increment(state) {
      state.value++
    },
    decrement(state) {
      state.value--
    },
    incrementByAmount(state, action: PayloadAction<number>) {
      state.value += action.payload
    },
  },
})

export const { increment, decrement, incrementByAmount } = counterSlice.actions
export default counterSlice.reducer
```

### [`createAsyncThunk`](https://redux-toolkit.js.org/api/createAsyncThunk)

The function `createAsyncThunk` returns a standard Redux thunk action creator.
The thunk action creator function will have plain action creators for the pending, fulfilled, and rejected cases attached as nested fields.

The `payloadCreator` function will be called with two arguments:

- `arg`: a single value, containing the first parameter that was passed to the thunk action creator when it was dispatched.
- `thunkAPI`: an object containing all of the parameters that are normally passed to a Redux thunk function, as well as additional options:
  - `dispatch`: the Redux store dispatch method
  - `getState`: the Redux store getState method
  - `extra`: the "extra argument" given to the thunk middleware on setup, if available
  - `requestId`: a unique string ID value that was automatically generated to identify this request sequence
  - `signal`: an `AbortController.signal` object that may be used to see if another part of the app logic has marked this request as needing cancellation.
  - [...]

The logic in the `payloadCreator` function may use any of these values as needed to calculate the result.

```js
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit'

const payloadCreator = async (arg, ThunkAPI): Promise<T> => { /* ... */ };
const thunk = createAsyncThunk("<action-type>", payloadCreator);

thunk.pending; // action creator that dispatches an '<action-type>/pending'
thunk.fulfilled; // action creator that dispatches an '<action-type>/fulfilled'
thunk.rejected; // action creator that dispatches an '<action-type>/rejected'

const slice = createSlice({
  name: '<action-name>',
  initialState,
  reducers: { /* standard reducer logic, with auto-generated action types per reducer */ },
  extraReducers: (builder) => {
    // Add reducers for additional action types here, and handle loading state as needed
    builder.addCase(thunk.fulfilled, (state, action) => { /* body of the reducer */ })
  },
})
```

## RTK Query​

RTK Query is provided as an optional addon within the `@reduxjs/toolkit` package.  
It is purpose-built to solve the use case of data fetching and caching, supplying a compact, but powerful toolset to define an API interface layer got the app.  
It is intended to simplify common cases for loading data in a web application, eliminating the need to hand-write data fetching & caching logic yourself.

RTK Query is included within the installation of the core Redux Toolkit package. It is available via either of the two entry points below:

```cs
import { createApi } from '@reduxjs/toolkit/query'

/* React-specific entry point that automatically generates hooks corresponding to the defined endpoints */
import { createApi } from '@reduxjs/toolkit/query/react'
```

RTK Query includes these APIs:

- [`createApi()`][new_api]: The core of RTK Query's functionality. It allows to define a set of endpoints describe how to retrieve data from a series of endpoints,
  including configuration of how to fetch and transform that data.
- [`fetchBaseQuery()`][fetch_query]: A small wrapper around fetch that aims to simplify requests. Intended as the recommended baseQuery to be used in createApi for the majority of users.
- [`<ApiProvider />`][api_provider]: Can be used as a Provider if you do not already have a Redux store.
- [`setupListeners()`][setup_listener]: A utility used to enable refetchOnMount and refetchOnReconnect behaviors.

[new_api]: https://redux-toolkit.js.org/rtk-query/api/createApi
[fetch_query]: https://redux-toolkit.js.org/rtk-query/api/fetchBaseQuery
[api_provider]: https://redux-toolkit.js.org/rtk-query/api/ApiProvider
[setup_listener]: https://redux-toolkit.js.org/rtk-query/api/setupListeners
