# [Svelte](https://svelte.dev/docs)

```sh
npx degit sveltejs/template <project name>

# set project to use typescript
node scripts/setupTypeScript.js

# or using vite
npm init vite@latest
```

## App Entry-point

```js
import App from "./App.svelte"; // import the component

const app = new App({
  target: document.body,
  props: {
    // props passed to the App component
  },
});

export default app;
```

## Components (`.svelte`)

### Basic Structure

```html
<!-- code for the component -->
<script lang="ts">
  import { Component } from "Component.svelte";

  export let prop; // make a variable a prop
</script>

<!-- CSS for the component -->
<style>
  /* CSS rules */

  /* target elements outside of the current component */
  :global(selector) {
  }
</style>

<!-- html of the component  -->

<!-- dynamic expressions -->
<div>{variable}</div>

<!-- nested components -->
<Component prop="{value}" />
```

### If-Else

```js
{#if <condition>}
  // markup here
{:else if <condition>}
  // markup here
{:else}
  // markup here
{/if}
```

### Loops

```js
{#each array as item, index}  // index is optional
    // markup here
{/each}

{#each array as item (key)}  // use key to determine changes
    // markup here
{/each}
```

### Await Blocks

```js
{#await promise}
 <p>...waiting</p>
{:then number}
 <p>The number is {number}</p>
{:catch error}
 <p style="color: red">{error.message}</p>
{/await}
```

### Event Handling

The full list of modifiers:

- `preventDefault` — calls `event.preventDefault()` before running the handler. Useful for client-side form handling, for example.
- `stopPropagation` — calls `event.stopPropagation()`, preventing the event reaching the next element
- `passive` — improves scrolling performance on touch/wheel events (Svelte will add it automatically where it's safe to do so)
- `nonpassive` — explicitly set `passive: false`
- `capture` — fires the handler during the capture phase instead of the bubbling phase
- `once` — remove the handler after the first time it runs
- `self` — only trigger handler if `event.target` is the element itself

```js
<script>
  const eventHandler = () => {};
</script>

<button on:event={eventHandler}>
// or
<button on:event={() => eventHandler(args)}>

<button on:event|modifier={eventHandler}>
```

**NOTE**: It's possible to chain modifiers together, e.g. `on:click|once|capture={...}`.

## Binding

```html
<script>
  let name = "Foo";
</script>

<!-- modify value in real time -->
<input bind:value="{stringValue}" />
<input type="checkbox" bind:checked={boolean}/ >
<!-- ... -->
```

### Reactive declarations & Reactive Statements

Svelte automatically updates the DOM when the component's state changes.  
Often, some parts of a component's state need to be computed from other parts and recomputed whenever they change.

For these, Svelte has reactive declarations. They look like this:

```js
let count = 0;
$: double =  count * 2;  // recalculated when count changes
// or
$: { }
$: <expression>
```

## Routing

[Svelte Routing](https://github.com/EmilTholin/svelte-routing)

```js
<!-- App.svelte -->
<script>
  import { Router, Link, Route } from "svelte-routing";
  import Home from "./routes/Home.svelte";
  import About from "./routes/About.svelte";
  import Blog from "./routes/Blog.svelte";

  export let url = "";
</script>

<Router url="{url}">
  <nav>
    <Link to="/">Home</Link>
    <Link to="about">About</Link>
    <Link to="blog">Blog</Link>
  </nav>
  <div>
    <Route path="blog/:id" component="{BlogPost}" />
    <Route path="blog" component="{Blog}" />
    <Route path="about" component="{About}" />
    <Route path="/"><Home /></Route>
  </div>
</Router>
```

## Data Stores

```js
// stores.js
import { writable } from "svelte/store";

export const count = writable(0);
```

```html
<script>
  import { onDestroy } from "svelte";
  import { count } from ".path/to/stores.js";

  const unsubscriber = count.subscribe((value) => {
    // do stuff on load or value change
  });

  count.update((n) => n + 1);

  count.set(1);
  // or
  $count = 1;

  onDestroy(unsubscriber);
</script>

<!-- use $ to reference a store value -->
<p>{$count}</p>
```
