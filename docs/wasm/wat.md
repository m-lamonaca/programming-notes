# Web Assembly Text Format (`.wat`)

## S-expressions

In both the binary and textual formats, the fundamental unit of code in WebAssembly is a module.

In the text format, a module is represented as one big _S-expression_.  
S-expressions are a very simple textual format for representing trees, and thus a module can be thought as a tree of nodes that describe the module's structure and its code.  
Unlike the Abstract Syntax Tree of a programming language, though, WebAssembly's tree is pretty flat, mostly consisting of lists of instructions.

Each node in the tree goes inside a pair of parentheses `( ... )`. The first label inside the parenthesis describes what type of node it is, and after that there is a space-separated list of either attributes or child nodes.

```lisp
(defun sum (x) (y)
    (+ x y))
```

## Functions

### Function Signature

All code in a webassembly module is grouped into functions, which have the following pseudocode structure:

```wat
(func <signature> <locals> <body>)
```

- The **signature** declares what the function takes (_parameters_) and returns (_return values_).
- The **locals** are variables with explicit types declared.
- The **body** is just a linear list of low-level instructions.

> **Note**: The absence of a `(result)` means that the function doesn't return anything.

A single parameter is written `(param <type>)` and the return type is written `(result <type>)`.

After the signature, locals are listed with their type as `(local <type>)`. Parameters are basically just locals that are initialized with the value of the corresponding argument passed by the caller.

### Getting and Setting locals and parameters

Locals/parameters can be read and written by the body of the function with the `local.get` and `local.set` instructions.

The `local.get`/`local.set` commands refer to the item to be got/set by its numeric index: parameters are referred to first, in order of their declaration, followed by locals in order of their declaration.

```wat
(func (param <type>) (param <type>) (local <type>)
    local.get 0
    local.get 1
    local.get 2)
```

Using numeric indices to refer to items can be confusing and annoying, so the text format allows to name parameters, locals, and most other items by including a name prefixed by a dollar symbol (`$`) just before the type declaration.

```wat
(func (param $first <type>) (param $second <type>) (local $loc <type>) 
    local.get $first
    local.get $second
    local.get $loc)
```

## Stack-based Virtual Machine

WASM execution is defined in terms of a **stack machine** where the basic idea is that every type of instruction _pushes_ and/or _pops_ a certain value to/from a **stack**.

When a function is called, it starts with an _empty_ stack which is gradually filled up and emptied as the body's instructions are executed. The return value of a function is just the final value left on the stack.

The WebAssembly validation rules ensure the stack matches exactly: if a result is declared then the stack must contain _exactly_ one value at the end. If there is no result type, the stack must be _empty_.
