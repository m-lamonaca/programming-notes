# Redux Testing

## Tests for Connected Components

Connected components are wrapped in a call to `connect`. Way of solving the problem:

- Wrap component with `<Provider>`. Added benefit: new store dedicated to tests.
- Add named export for unconnected component.

In `Component.js`:

```js linenums="1"
export function Component(props) { /* ... */ }  // export unconnected component

export default connect(mapStateToProps, mapDispatchToProps)(Component)  // default export of connected component
```

In `Component.test.js`:

```js linenums="1"
import React from "react";
// import enzyme or react testing library

// import mock data
import { Component } from "path/to/Component";  // import unconnected component

// factory to setup test easily
function testHelper(args) {
    const defaultProps = { 
        /* default value for props in each test and required props */,
        history = {}  // normally injected by react-router, could also import the router
    };

    const props = { ...defaultProps, ...args };
    return mount(<Component {...props} />);  // or render if using react testing library
}

it("test description", () => {
    const dom = testHelper();

    // simulate page iteration
    dom.find("selector").simulate("<event>");

    // find changed component
    // test expected behaviour of component
});
```

## Tests for Action Creators

```js linenums="1"
import * as actions from "path/to/actionCreators";
// import eventual action types constants
// import mock data

it("test description", () => {
    const data = /* mock data */
    const expectedAction = { type: TYPE, /* ... */ };

    const actualAction = actions.actionCreator(data);

    expect(actualAction).toEqual(expectedAction);
});
```

## Tests for Reducers

```js linenums="1"
import reducer from "path/to/reducer";
import * as actions from "path/to/actionCreators";

it("test description", () => {
    const initialState = /* state before the action */;
    const finalState = /* expected state after the action */
    const data = /* data passed to the action creator */;

    const action = actions.actionCreator(data);
    const newState = reducer(initialState, action);

    expect(newState).toEqual(finalState);
});
```

## Tests for the Store

```js linenums="1"
import { createStore } from "redux";

import rootReducer from "path/to/rootReducer";
import initialState from "path/to/initialState";
import * as actions from "path/to/actionCreators";

it("test description", () => {
    const store = createStore(storeReducer, initialState);

    const expectedState = /* state after the update */

    const data = /* action creator input */;
    const action = actions.actionCreator(data);
    store.dispatch(action);

    const state = store.getState();
    expect(state).toEqual(expectedState);
});
```

## Tests for Thunks

Thunk testing requires the mocking of:

- store (using `redux-mock-store`)
- HTTP calls (using `fetch-mock`)

```js linenums="1"
import thunk from "redux-thunk";
import fetchMock from "fetch-mock";
import configureMockStore from "redux-mock-store";

// needed for testing async thunks
const middleware = [thunk];  // mock middlewares
const mockStore = configureMockStore(middleware);  // mock the store

import * as actions from "path/to/actionCreators";
// import eventual action types constants
// import mock data

describe("Async Actions", () => {
    afterEach(() => {
        fetchMock.restore();  // init fetch mock for each test
    });

    it("test description", () => {
        // mimic API call
        fetchMock.mock(
            "*",  // capture any fetch call
            {
                body: /* body contents */,
                headers: { "content-type": "application/json" }
            }
        );

        // expected action fired from the thunk
        const expectedActions = [
            { type: TYPE, /* ... */ },
            { type: TYPE, /* ... */ }
        ];

        const store = mockStore({ data: value, ... });  // init mock store

        return store.dispatch(actions.actionCreator())  // act
            .then(() => {
                expect(store.getActions()).toEqual(expectedActions);  // assert
            });
    });
});
```
