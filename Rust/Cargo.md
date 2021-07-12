# Cargo build system and package manager

## Creating a project

```ps1
cargo new project_name  # creates project folder and basic files
cargo new --vcs=git project_name  # init project as git repo
```

## Building, Runnning & Checking a project

Inside the project directory:

```ps1
cargo build  # build progect and download eventual needed dependencies
cargo build --release  # build project for realease (build + optimisations)
cargo run  # executes the built executable
cargo check  # verifies buildability without producing an executable
```

## Dependecies

In `Cargo.toml`:

```toml
[dependencies]
crate_name = "<version_number>"
```

## Code Organization

Rust has a number of features that allow to manage the code’s organization, including which details are exposed, which details are private, and what names are in each scope in the programs.

These features, sometimes collectively referred to as the module system, include:

- **Packages**: A Cargo feature that allows to build, test, and share crates
- **Crates**: A tree of modules that produces a library or executable
- **Modules** and `use`: Allow to control the organization, scope, and privacy of paths
- **Paths**: A way of naming an item, such as a struct, function, or module

### Packages & Crates

A crate is a binary or library. The crate root is a source file that the Rust compiler starts from and makes up the root module of he crate.
A package is one or more crates that provide a set of functionality. A package contains a `Cargo.toml` file that describes how to build those crates.

Several rules determine what a package can contain. A package must contain `zero` or `one` **library crates** (`lib` ?), and no more.
It can contain as many `binary` crates as you’d like, but it must contain at least one crate (either library or binary).

If a package contains `src/main.rs` and `src/lib.rs`, it has two crates: a library and a binary, both with the same name as the package.
A package can have multiple binary crates by placing files in the `src/bin` directory: each file will be a separate binary crate.

A crate will group related functionality together in a scope so the functionality is easy to share between multiple projects.

Cargo follows a convention that `src/main.rs` is the crate root of a binary crate with the same name as the package.
Likewise, Cargo knows that if the package directory contains `src/lib.rs`, the package contains a library crate with the same name as the package, and `src/lib.rs` is its crate root.

### Modules

Modules allow to organize code within a crate into groups for readability and easy reuse. Modules also control the privacy of items, which is whether an item can be used by outside code (*public*) or is an internal implementation detail and not available for outside use (*private*).

Define a module by starting with the `mod` keyword and then specify the name of the moduleand place curly brackets around the body of the module.
Inside modules, it's possible to have other modules. Modules can also hold definitions for other items, such as structs, enums, constants, traits, or functions.

### Paths

A path can take two forms:

- An **absolute path** starts from a crate root by using a crate name or a literal crate.
- A **relative path** starts from the current module and uses self, super, or an identifier in the current module.

Both absolute and relative paths are followed by one or more identifiers separated by double colons (`::`).

```rs
module::function();  // rel path (same crate)
super::function();;  // rel path starting in outer module (same crate)

crate::module::function();  // abs path (same crate)
<crate_name>::module::function();  // abs path (other crate)
```

### Public vs Private

Modules aren’t useful only for organizing the code. They also define Rust’s privacy boundary: the line that encapsulates the implementation details external code isn’t allowed to know about, call, or rely on. So, to make an item like a function or struct private, put it in a module.

The way privacy works in Rust is that all items (functions, methods, structs, enums, modules, and constants) are *private by default*.
Items in a parent module can’t use the private items inside child modules, but items in child modules can use the items in their ancestor modules.
The reason is that child modules wrap and hide their implementation details, but the child modules can see the context in which they’re defined.

```rs
mod module {
    fn func() {}
}

// for a function to be accessible both module and function must be public
pub mod public_module {
    pub fn public_func() {}
}

mod file_level_module;  // define a module for the whole file (same name as file)
```

It's possible to use `pub` to designate *structs* and *enums* as public, but there are a few extra details.
If `pub` is used before a struct definition, this makes the struct public, but the struct’s fields will still be private. It's possible make each field public or not on a case-by-case basis.

In contrast, if an enum is made public, all of its variants are then public.

### `use`

```rs
use <crate_name>::module;  // import module (abs path, other crate)
use crate::module;  // s (abs path, same crate)
use self::module;  // // import module (rel path, same crate)

use <crate_name>::module as alias;  // import module w/ aliass
pub use <crate_name>::module;  // re-exporting (import and make available to others)

use <crate_name>::module::{self, Item}; // import multiple paths
pub use <crate_name>::module::*; // import all public items (Glob operator)

module::function();  // use func w/ shorter path
```

## Separating into multiple files

```txt
src
|_main.rs  --> app entrypoint
|_lib.rs  --> export module-folders
|__module
|  |_mod.rs --> export module-files
|  |_file.rs
```
