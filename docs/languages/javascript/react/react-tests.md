# Testing React

## [Jest](https://jestjs.io/)

### Jest Configuration

```js linenums="1"
// jest.config.js
module.exports = {
  testEnvironment: 'jsdom',
  moduleFileExtensions: ['js', 'jsx', 'ts', 'tsx', 'json', 'node'],
  setupFilesAfterEnv: ['@testing-library/jest-dom/extend-expect'],  // add testing-library methods to expect()
  transform: { '^.+\\.tsx?$': 'ts-jest'}  // use ts-jest fo ts files
}
```

### Jest Tests

[Expect docs](https://jestjs.io/docs/expect)

```js linenums="1"
// .spec.js or .test.js
it("test description", () => {
    // test body
    expect(expected).toEqual(actual);
});

// group related tests
describe("test group name", () => {
    it(/* ... */);
    it(/* ... */);
});
```

### Snapshots

In `Component.Snapshots.js`:

```js linenums="1"
import React from "react";
import renderer from "react-test-renderer";

import Component from "./path/to/Component";
// import mock data if necessary

it("test description", () => {
    // renders the DOM tree of the component
    const tree = renderer.create(<Component funcProp={jest.fn() /* mock function */} /* component props */ />);

    // save a snapshot of the component at this point in time ( in  __snapshots__ folder)
    // in future test it will be checked to avoid regressions
    // can be updated during jest --watch pressing "u"
    expect(tree).matchSnapshot();
});
```

---

## [Enzyme](https://enzymejs.github.io/enzyme/)

### Enzyme Configuration

```js linenums="1"
// testSetup.js
import { configure } from "enzyme";
import Adapter from "enzyme-adapter-react-<version>";

configure({ adapter: new Adapter() });
```

### Enzyme Tests

In `Component.test.js`:

```js linenums="1"
import React from "react";
import { shallow, mount } from "enzyme";
// eventual wrapper components (react-router, react-redux's provider, ...) for mount render

// shallow renders single component w/o children, no DOM generated
// mount renders component w/ it's children

import Component from "./path/to/Component";

// factory to setup shallow test easily
function testHelper(args) {
    const defaultProps = { /* default value for props in each test */ };

    const props = { ...defaultProps, ...args };
    return shallow(<Component {...props} />);
}

// shallow rendering test
it("test description", () => {
    const dom = testHelper(/* optional args */);
    // or
    const dom = shallow(<Component /* props */ />);

    // check a property of expected component
    // selector can be from raw JSX (name of a component)
    expect(dom.find("selector").property).toBe(expected);
});

// mount rendering test
if("test description" () => {
    const dom = mount(
        <WrapperComponent>
            <Component /* props *//>
        </WrapperComponent>
    );

    // selector has to be HTML selector since the component is rendered completely
    // possible to test child components
    expect(dom.find("selector").property).toBe(expected);
});
```

---

## [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)

Encourages to write test based on what the user sees. So components are always *mounted* and fully rendered.

### React Testing Library Tests

In `Components.test.js`:

```js linenums="1"
import React from "react";
import { cleanup, render } from "@testing-library/react";

import Component from "./path/to/Component";

afterEach(cleanup);

// factory to setup test easily
function testHelper(args) {
    const defaultProps = { /* default value for props in each test */ };

    const props = { ...defaultProps, ...args };
    return render(<Component {...props} />);
}

it("test description", () => {
    const { getByText } = testHelper();

    // react testing library func
    getByText("text");  // check if test is present in the rendered component
});
```
