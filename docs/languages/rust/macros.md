# Macros

Fundamentally, **macros** are a way of *writing code that writes other code*, which is known as **metaprogramming**.

Metaprogramming is useful for reducing the amount of code to be written and maintained, which is also one of the roles of functions.  However, macros have some additional powers that functions don’t.

A function signature must declare the number and type of parameters the function has. Macros, on the other hand, can take a variable number of parameters. Also, macros are expanded before the compiler interprets the meaning of the code, so a macro can, for example, implement a trait on a given type. A function can’t, because it gets called at runtime and a trait needs to be implemented at compile time.

The downside to implementing a macro instead of a function is that macro definitions are more complex than function definitions because it's Rust code that writes Rust code. Due to this indirection, macro definitions are generally more difficult to read, understand, and maintain than function definitions.

> **Note**: macros need to be defined and brought into scope before they are usable in a file, as opposed to functions that can be defined anywhere and be called anywhere.

## Declarative Macros (Macro-by-Example)

At their core, **declarative macros** allow to write something similar to a Rust match expression.

Macros compare a value to patterns that are associated with particular code: in this situation, the value is the literal Rust source code passed to the macro; the patterns are compared with the structure of that source code; and the code associated with each pattern, when matched, replaces the code passed to the macro. This all happens during compilation.

Declarative macros are defined using the `macro_rules!` construct.

Each macro has a *name*, and *one or more rules*.

Each rule has two parts: a *matcher*, describing the syntax that it matches, and a *transcriber*, describing the syntax that will replace a successfully matched invocation. Both the matcher and the transcriber must be surrounded by delimiters.  
Macros can expand to expressions, statements, items (including traits, impls, and foreign items), types, or patterns.

```rs
#[macro_export]
macro_rules! <name> {
    ( <matcher> ) => {
        <transcriber>
    };
}
```

### Transcribing

When a macro is invoked, the macro expander looks up macro invocations by name, and tries each macro rule in turn. It transcribes the first successful match; if this results in an error, then future matches are not tried.

When matching, no lookahead is performed; if the compiler cannot unambiguously determine how to parse the macro invocation one token at a time, then it is an error.

In both the matcher and the transcriber, the `$` token is used to invoke special behaviours from the macro engine. Tokens that aren't part of such an invocation are matched and transcribed literally, with one exception.

The exception is that the outer delimiters for the matcher will match any pair of delimiters.  
Thus, for instance, the matcher (()) will match `{()}` but not `{{}}`.

> **Note**: The character `$` cannot be matched or transcribed literally.

When forwarding a matched fragment to another macro-by-example, matchers in the *second macro* will see an opaque AST of the fragment type. The second macro can't use literal tokens to match the fragments in the matcher, only a fragment specifier of the same type. The `ident`, `lifetime`, and `tt` fragment types are an exception, and can be matched by literal tokens.

```rs
macro_rules! foo {
    (3) => {}
}

macro_rules! bar {
    ($l:expr) => { foo!($l); }
    // ERROR:           ^^ no rules expected this token in macro call
}

macro_rules! baz {
    ($l:tt) => { foo!($l); }
}
```

### [Metavariables](https://doc.rust-lang.org/reference/macros-by-example.html#metavariables)

In the matcher, `$name:fragment` matches a Rust syntax fragment of the kind specified and binds it to the metavariable `$name`.

Valid fragment specifiers are:

- `item`: an [Item][item]
- `block`: a [BlockExpression][block_expression]
- `stmt`: a [Statement][statement] without the trailing semicolon (except for item statements that require semicolons)
- `pat`: a [Pattern][pattern]
- `expr`: an [Expression][expression]
- `ty`: a [Type][type]
- `ident`: an [IDENTIFIER_OR_KEYWORD][identifier] or [RAW_IDENTIFIER][identifier]
- `path`: a [TypePath][type_path] style path
- `tt`: a [TokenTree][token_tree] (a single token or tokens in matching delimiters `()`, `[]`, or `{}`)
- `meta`: an [Attr][attr], the contents of an attribute
- `lifetime`: a [LIFETIME_TOKEN][lifetime_token]
- `vis`: a possibly empty [Visibility][visibility] qualifier
- `literal`: matches [LiteralExpression][literal_expression]

In the transcriber, metavariables are referred to simply by `$name`, since the fragment kind is specified in the matcher. Metavariables are replaced with the syntax element that matched them.

The keyword metavariable `$crate` can be used to refer to the current crate. Metavariables can be transcribed more than once or not at all.

[item]: https://doc.rust-lang.org/reference/items.html
[block_expression]: https://doc.rust-lang.org/reference/expressions/block-expr.html
[statement]: https://doc.rust-lang.org/reference/statements.html
[expression]: https://doc.rust-lang.org/reference/expressions.html
[pattern]: https://doc.rust-lang.org/reference/patterns.html
[type]: https://doc.rust-lang.org/reference/types.html#type-expressions
[identifier]: https://doc.rust-lang.org/reference/identifiers.html
[type_path]: https://doc.rust-lang.org/reference/paths.html#paths-in-types
[token_tree]: https://doc.rust-lang.org/reference/macros.html#macro-invocation
[attr]: https://doc.rust-lang.org/reference/attributes.html
[lifetime_token]: https://doc.rust-lang.org/reference/visibility-and-privacy.html
[visibility]: https://doc.rust-lang.org/reference/visibility-and-privacy.html
[literal_expression]: https://doc.rust-lang.org/reference/expressions/literal-expr.html

### Repetitions

In both the matcher and transcriber, repetitions are indicated by placing the tokens to be repeated inside `$(…)`, followed by a repetition operator, optionally with a separator token between. The separator token can be any token other than a delimiter or one of the repetition operators, but `;` and `,` are the most common.

The repetition operators are:

- `*`: indicates any number of repetitions.
- `+`: indicates any number but at least one.
- `?`: indicates an optional fragment with zero or one occurrence.

> **Note**: Since `?` represents at most one occurrence, it cannot be used with a separator.

The repeated fragment both matches and transcribes to the specified number of the fragment, separated by the separator token. Metavariables are matched to every repetition of their corresponding fragment.

During transcription, additional restrictions apply to repetitions so that the compiler knows how to expand them properly:

1. A metavariable must appear in *exactly* the same number, kind, and nesting order of repetitions in the transcriber as it did in the matcher.
2. Each repetition in the transcriber must contain at least one metavariable to decide how many times to expand it. If multiple metavariables appear in the same repetition, they must be bound to the same number of fragments.

### Scoping, Exporting, and Importing

Macros have two forms of scope: *textual scope*, and *path-based scope*. Textual scope is based on the order that things appear in source files, or even across multiple files, and is the default scoping. Path-based scope works exactly the same way that item scoping does. The scoping, exporting, and importing of macros is controlled largely by attributes.

When a macro is invoked by an unqualified identifier (not part of a multi-part path), it is first looked up in textual scoping. If this does not yield any results, then it is looked up in path-based scoping. If the macro's name is qualified with a path, then it is only looked up in path-based scoping.

```rs
use lazy_static::lazy_static; // path-based import.

// local textual definition.
macro_rules! lazy_static {
    (lazy) => {};
}

lazy_static!{lazy} // textual lookup finds local macro first.
self::lazy_static!{} // path-based lookup ignores local macro, finds imported one.
```

> **Note**: It is not an error to define a macro multiple times; the most recent declaration will shadow the previous one unless it has gone out of scope.

### The `macro_use` attribute

The `macro_use` attribute has two purposes. First, it can be used to make a module's macro scope not end when the module is closed, by applying it to a module:

```rs
#[macro_use]
mod inner {
    macro_rules! m {
        () => {};
    }
}

m!();
```

Second, it can be used to import macros from another crate, by attaching it to an extern crate declaration appearing in the crate's root module. Macros imported this way are imported into the `macro_use` prelude, not textually, which means that they can be shadowed by any other name.

While macros imported by `#[macro_use]` can be used before the import statement, in case of a conflict, the last macro imported wins. Optionally, a list of macros to import can be specified using the [`MetaListIdents`][meta_list_idents] syntax; this is not supported when `#[macro_use]` is applied to a module.

```rs
# [macro_use(lazy_static)] // or #[macro_use] to import all macros.
extern crate lazy_static;

lazy_static!{}
self::lazy_static!{} // Error: lazy_static is not defined in `self`
```

> **Note**: Macros to be imported with `#[macro_use]` must be exported with `#[macro_export]`.

[meta_list_idents]: https://doc.rust-lang.org/reference/attributes.html#meta-item-attribute-syntax

### The `macro_export` attribute

By default, a macro has no path-based scope. However, if it has the `#[macro_export]` attribute, then it is declared in the crate root scope and can be referred to normally.

```rs
self::m!();
m!(); // OK: Path-based lookup finds m in the current module.

mod inner {
    super::m!();
    crate::m!();
}

mod mac {
    #[macro_export]
    macro_rules! m {
        () => {};
    }
}
```

> **Note**: Macros labeled with `#[macro_export]` are always pub and can be referred to by other crates, either by path or by `#[macro_use]`.

### [Follow-set Ambiguity Restrictions][macro_ambiguity]

The parser used by the macro system is reasonably powerful, but it is limited in order to prevent ambiguity in current or future versions of the language.

In particular, in addition to the rule about ambiguous expansions, a nonterminal matched by a metavariable must be followed by a token which has been decided can be safely used after that kind of match.

The specific rules are:

- `expr` and `stmt` may only be followed by one of: `=>`, `,`, or `;`.
- `pat` may only be followed by one of: `=>`, `,`, `=`, `if`, or `in`.
- `path` and `ty` may only be followed by one of: `=>`, `,`, `=`, `|`, `;`, `:`, `>`, `>>`, `[`, `{`, `as`, `where`, or a macro variable of block fragment specifier.
- `vis` may only be followed by one of: `,`, an identifier other than a non-raw priv, any token that can begin a type, or a metavariable with a `ident`, `ty`, or `path` fragment specifier.

All other fragment specifiers have no restrictions.

When repetitions are involved, then the rules apply to every possible number of expansions, taking separators into account. This means:

- If the repetition includes a separator, that separator must be able to follow the contents of the repetition.
- If the repetition can repeat multiple times (`*` or `+`), then the contents must be able to follow themselves.
- The contents of the repetition must be able to follow whatever comes before, and whatever comes after must be able to follow the contents of the repetition.
- If the repetition can match zero times (`*` or `?`), then whatever comes after must be able to follow whatever comes before.

[macro_ambiguity]: https://doc.rust-lang.org/reference/macro-ambiguity.html
