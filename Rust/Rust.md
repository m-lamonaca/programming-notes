# Rust

## Compiling and running

```ps1
rustc file.rs  # compilation
file.exe  # running
```

## Basics

```rs
use <module>;  // bring a type into scope

fn main() {  //program entry point
    // code here
}
```

### Result types

The `Result` types are **enumerations**, often referred to as *enums*. An enumeration is a type that can have a *fixed set of values*, and those values are called the enum's **variants**.

For `Result`, the variants are `Ok` or `Err`.  
The `Ok` variant indicates the operation was *successful*, and inside `Ok` is the successfully generated value.  
The `Err` variant means the operation failed, and `Err` contains information about how or why the operation failed.

The purpose of the `Result` types is to encode error-handling information.

Rust has a number of types named `Result` in its standard library: a generic `Result` as well as specific versions for submodules.

### Standard Output

```rs
// macro (func have no "!")
println!("Value: {}", value);  // {} is a placeholder for a value or variable
println!("Values: {1}, {0}", value1, value2);  // use index to print values
println!("Num: {:<total_digits>.<decimal_digits>}", 10);
println!("Num: {:0<total>.<decimal>}", 10);  // prefix num with zeroes

println!("{:b}", 0b11011);  // print as bits

print!();
```

### Standard Input

```rs
use io;

let mut buffer = String::new();

io::stdin()  // read line from stdin
    .read_line(&mut buffer)  // put in into the string variable
    .expect("Error Message");  // in case of errors return an error message

let var: i32 = buffer.trim().parse()  // returns a Result enum
let var = buffer.trim().parse::<i32>()  // returns a Result enum
```

The `::` syntax in the `::new` line indicates that `new` is an **associated function** of the `String` type.  
An associated function is implemented on a type rather than on a particular instance of the type. Some languages call this a `static method`.

## Variables & Mutability

By default variables are *immutable*.

```rs
let var1 = value;  // immutable var init
let var2: Type = value;  // explicit type annotation

let mut var3 = value;  // mutable var init
let mut var4: Type = value;  // explicit type annotation

const CONSTANT_NAME: type = value;  // constant must have the type annotation
```

### Shadowing

It's possible declare a new variable with the *same name* as a previous variable, and the new variable *shadows* the previous variable.  
By using let, it's possible to perform a few transformations on a value but have the variable be immutable after those transformations have been completed.

The other difference between *mut* and *shadowing* is that because we're effectively creating a new variable when we use the let keyword again,  
we can change the type of the value but reuse the same name.

```rs
let x: u32 = 10;
let x: i32 = 11;  // shadowing
```

## Data Types

### Integer Types

| Length       | Signed  | Unsigned |
|--------------|---------|----------|
| 8-bit        | `i8`    | `u8`     |
| 16-bit       | `i16`   | `u16`    |
| 32-bit       | `i32`   | `u32`    |
| 64-bit       | `i64`   | `u64`    |
| 128-bit      | `i128`  | `u128`   |
| architecture | `isize` | `usize`  |

### Floating-Point Types

Rust also has two primitive types for floating-point numbers, which are numbers with decimal points.  
Rust's floating-point types are `f32` and `f64`, which are 32 bits and 64 bits in size, respectively.  
The default type is `f64` because on modern CPUs it's roughly the same speed as `f32` but is capable of more precision.

### Numeric Operators

| Operator | Operation           |
|----------|---------------------|
| `>`      | Greater than        |
| `>=`     | Greater or Equal to |
| `<`      | Less than           |
| `<=`     | Less or Equal to    |
| `==`     | Equals              |
| `!=`     | Not Equals          |

### Comparison Operators

| Operator | Operation      |
|----------|----------------|
| `+`      | Addition       |
| `-`      | Subtraction    |
| `*`      | Multiplication |
| `/`      | Division       |
| `%`      | Modulo         |

### Boolean Types

Boolean types in Rust have two possible values: `true` and `false`.  
Booleans are one byte in size. The Boolean type in Rust is specified using `bool`.

### Bitwise Operators

| Operator | Operation         |
|----------|-------------------|
| `&`      | AND               |
| `|`      | OR                |
| `&&`     | SHORT-CIRCUIT AND |
| `||`     | SHORT-CIRCUIT OR  |
| `^`      | XOR               |
| `!`      | NOT               |
| `<<`     | LEFT SHIFT        |
| `>>`     | RIGHT SHIFT       |

### Character Types

Rust's `char` type is the language's most primitive alphabetic type.

Rust's `char` type is four bytes in size and represents a Unicode Scalar Value: range from `U+0000` to `U+D7FF` and `U+E000` to `U+10FFFF` inclusive.

```rs
let c: char = 'C';  // SINGLE QUOTES
let c: char = '\u{261D}';  // Unicode Code Point U+261D
```

### String Types

```rs
let s = String::new();  // create empty string
let s = String::from("string literal");  // construct string from literal

s.push_str(""); // appending string literals
```

### Tuple Types

A tuple is a general way of grouping together a number of values with a variety of types into one compound type.  
Tuples have a *fixed length*: once declared, they cannot grow or shrink in size.

```rs
let tup: (i32, f64, u8) = (500, 6.4, 1);
let tup = (500, 6.4, 1);

let (x, y, z) = tup;  // tuple deconstruction (unpacking)

tup.0 = value;  // member access & update (mut be mutable)
```

### Array Types

Every element of an array must have the *same type*. Arrays in Rust have a fixed length, like tuples.  
An array isn't as flexible as the `vector` type, though. A vector is a similar collection type provided by the standard library that *is allowed to grow or shrink in size*.

```rs
let array = [0, 1, 2, 3, 4];
let array: [Type; length] = [...];
let array: [value; length];  // repeat expression (same as python's [value] * length)

let index: usize = <index_value>;  // indexes and ranges must be of type usize
array[index] = value;  // member access and update (must be mutable)

let matrix = [
    [0 ,1, 2],
    [3, 4, 5]
]

let matrix: [[Type, length]; length]; = [[...], [...], ...]

matrix[row][column];
```

### Slice Types

Slices allows to reference a contiguous sequence of elements in a collection rather than the whole collection. **Slices don't take ownership**.

A string slice (`&str`) length is in bytes, can cause panic if it happens inside a character.
This can happen because Unicode characters can take up to 4 bytes.

`&String` can be used in place of a `&str` trough *String Coercion*. The `&String` gets converted to a `&str` that borrows the entire string.
The reverse is not possible since the slice lacks some information about the String.

**NOTE**: When working with functions is easier to always expect a `&str` instead of a `&String`.

```rs
let s = String::from("string literal");
let slice: &str = &s[start..end];

let a = [0, 1, 2, 3, 4, 5];
let slice: &[i32] =  &a[start..end];

sequence[start..]  // slice to end of sequence
sequence[..end]  // slice from start to end (excluded)
```

## Functions

Rust code uses *snake_case* as the conventional style for function and variable names.

Function definitions in Rust start with `fn` and have a set of parentheses after the function name.  
The curly brackets tell the compiler where the function body begins and ends.

Rust doesn't care where the functions are defined, only that they're defined somewhere.

```rs
fn func(param: Type) {  // parameters MUST have the Type annotation
    // code here
}

fn func() -> Type {  // -> specifies the return type
    // code here
}

fn func() {
    value  // returns value
}
// same as
fn func() {
    return value;
}

fn func() {
    return (value1, value2, ...);  // return multiple values with tuples
}
```

## Control Flow

### if - else if - else

```rs
if condition {
    // code here
} else if condition {
    // code here
} else {
    // code here
}
```

### let if

```rs
let var = if condition { value } else { value };  // returned types must be the same
```

### [if-let](https://doc.rust-lang.org/rust-by-example/flow_control/if_let.html)

```rs
if let <pattern> = <value> {
  /* do something */
}

// same as
let optional = Some(value);
match optional {
    Some(param) => { /* do something */ },
    _ => {},
};
```

### loop

```rs
loop {  // loop's forever if not explicitly stopped
    // code here

    if condition {
        break returned_value
    }
}
```

### while

```rs
while condition {  // runs while condition is true
    // code here
}
```

### for

```rs
for item in sequence.iter() { }
for item in sequence.iter_mut() { }  // iterate over mutable items

// item is a reference to the value in the sequence, use & and * to access the value or address

for i in (start..end) {  // (start..stop) is like python's range(start, stop)
    // code here
}
```

## Ownership

Ownership is Rust's most unique feature, and it enables Rust to make memory safety guarantees without needing a garbage collector.

All programs have to manage the way they use a computer's memory while running.  
Some languages have garbage collection that constantly looks for no longer used memory as the program runs; in other languages, the programmer must explicitly allocate and free the memory.  
Rust uses a third approach: memory is managed through a system of ownership with a set of rules that the compiler checks at compile time.  
None of the ownership features slow down your program while it's running.

### Stack & Heap

Both the stack and the heap are parts of memory that are available to your code to use at runtime, but they are structured in different ways.

The *stack* stores values in the order it gets them and removes the values in the opposite order. This is referred to as *last in, first out*.  
Adding data is called *pushing* onto the stack, and removing data is called *popping* off the stack.

All data stored on the stack must have a known, fixed size. Data with an unknown size at compile time or a size that might change must be stored on the heap instead.

The heap is less organized: when you put data on the heap, you request a certain amount of space. The memory allocator finds an empty spot in the heap that is big enough, marks it as being in use, and returns a **pointer**, which is the address of that location. This process is called *allocating on the heap* and is sometimes abbreviated as just *allocating*.

Pushing to the stack is faster than allocating on the heap because the allocator never has to search for a place to store new data; that location is always at the top of the stack.  
Comparatively, allocating space on the heap requires more work, because the allocator must first find a big enough space to hold the data and then perform bookkeeping to prepare for the next allocation.

Accessing data in the heap is slower than accessing data on the stack because you have to follow a pointer to get there. Contemporary processors are faster if they jump around less in memory.

Keeping track of what parts of code are using what data on the heap, minimizing the amount of duplicate data on the heap, and cleaning up unused data on the heap so you don't run out of space are all problems that ownership addresses.

### Ownership Rules

- Each *value* in Rust has a variable that's called its *owner*.
- There can only be one owner at a time.
- When the owner goes out of scope, the value will be dropped.

### Moving, Cloning & Copying data

A "shallow copy" of a variable allocated on the *heap* causes the original variable goes out of scope and only the "copy" remains (**MOVING**).  
A "deep copy" (`var.clone()`) makes a copy of the data in the new variable without make the original fall out of scope (**CLONING**).

When a variable goes out of scope, Rust calls the special function `drop`, where the code to return/free the memory is located.

Rust has a special annotation called the `Copy` trait that it's placeable on types that are stored on the stack.  
If a type has the `Copy` trait, an older variable is still usable after assignment.

Rust won't allow to annotate a type with the `Copy` trait if the type, or any of its parts, has implemented the `Drop` trait.  

```rs
let s = String::new()
let t = s;  // shallow copy, s is now out of scope
let u = t.clone();  // deep copy, t is still valid

let n: i32 = 1;
let x = n;  // x holds a COPY of the VALUE of n
```

### Ownership & Functions

The semantics for passing a value to a function are similar to those for assigning a value to a variable. Passing a variable to a function will move or copy, just as assignment does.

```rs
fn main() {
    let s = String::from("hello");  // s comes into scope

    takes_ownership(s);             // s's value moves into the function and so is no longer valid here

    let x = 5;                      // x comes into scope

    makes_copy(x);                  // x would move into the function, but i32 is Copy, so it's okay to still use x afterward

} // Here, x goes out of scope, then s. But because s's value was moved, nothing special happens.

fn takes_ownership(some_string: String) { // some_string comes into scope
    println!("{}", some_string);
} // Here, some_string goes out of scope and `drop` is called. The backing memory is freed.

fn makes_copy(some_integer: i32) { // some_integer comes into scope
    println!("{}", some_integer);
} // Here, some_integer goes out of scope. Nothing special happens.
```

### Return Values & Scope

Returning values can also transfer ownership.

```rs
fn main() {
    let s1 = gives_ownership();         // gives_ownership moves its return value into s1

    let s2 = String::from("hello");     // s2 comes into scope

    let s3 = takes_and_gives_back(s2);  // s2 is moved into takes_and_gives_back, which also moves its return value into s3
} // Here, s3 goes out of scope and is dropped. s2 goes out of scope but was moved, so nothing happens. s1 goes out of scope and is dropped.

fn gives_ownership() -> String {             // gives_ownership will move its return value into the function that calls it

    let some_string = String::from("hello"); // some_string comes into scope

    some_string                              // some_string is returned and moves out to the calling function
}

// takes_and_gives_back will take a String and return one
fn takes_and_gives_back(a_string: String) -> String { // a_string comes into scope

    a_string  // a_string is returned and moves out to the calling function
}
```

### References & Borrowing

*Mutable references* have one big restriction: you can have *only one* mutable reference to a particular piece of data in a particular scope.

The benefit of having this restriction is that Rust can prevent **data races** at compile time.  
A data race is similar to a race condition and happens when these three behaviors occur:

- Two or more pointers access the same data at the same time.  
- At least one of the pointers is being used to write to the data.  
- There's no mechanism being used to synchronize access to the data.

```rs
fn borrow(var: &Type) {  // &Type indicates that the var is a reference
    // here var cannot be modified
} // when var goes out of scope it doesn't get dropped because the scope didn't own it

borrow(&variable);  // &variable creates a reference to variable but does not take ownership

fn borrow2(var: &mut Type) {
    // here var can be modified
}

&variable;  // borrow a value from a variable (returns reference)
*variable;  // dereference value (access value pointed by the reference)
```

## Structs

A **struct**, or structure, is a custom data type that allows to name and package together multiple related values that make up a meaningful group.

To define a struct enter the keyword struct and name the entire struct.  
A struct's name should describe the significance of the pieces of data being grouped together.  
Then, inside curly brackets, define the names and types of the pieces of data, which we call *fields*.

```rs
struct Struct {
    field: Type,
    ...
}

{ x: Type, y: Type }  // anonymous struct
```

To use a struct after defining it, create an instance of that struct by specifying concrete values for each of the fields.

```rs
let mut var = Struct {
    field: value,
    ...
};

fn build_struct(param: Type, ...) -> Struct {
    // the constructed struct is returned since it's the last expression
    Struct {
        field: param,
        ...
    }
}
```

### Field Init Shorthand

```rs
fn build_struct(field: Type, ...) -> Struct {
    // the constructed struct is returned since it's the last expression
    Struct {
        field,  // shortened form since func param is named as the struct's field
        ...
    }
}

var.field = value;  // member access
```

**Note**: the entire instance must be mutable; Rust doesn't allow to mark only certain fields as mutable.

### Struct Update Syntax

```rs

let struct1 = Struct {
    field1: value,
    field2: value,
    ...
}
// same as
let struct2 = Struct {
    field1: other_value,
    ..struct1  // all remaining fields have the same values of struct1
}
```

### Tuple Structs

Use Tuple Structs to create different types easily.  
To define a **tuple struct**, start with the `struct` keyword and the struct name followed by the types in the tuple.

```rs
struct Point(i32, i32, i32);
struct Color(i32, i32, i32);

let origin = Point(0, 0, 0);
```

### Struct Printing

```rs
#[derive(Debug)]  // inherit the debug trait
struct StructName
{
    field: value,
    ...
}

let s: Struct = { /* valorization */};
println!("{:?}", s)  // debug output: { field: value, ... }
```

### Methods & Associated Functions

```rs
struct Struct
{
    field: value,
    ...
}

impl Struct
{
    fn method(&self, arg: Type) -> Type { }
    fn method(&mut self, arg: Type) -> Type { }  // able to modify instance
    fn associated_func(arg: Type) -> Type { }  // "static" method
}

let s: Struct = { /* valorization */};
s.method(arg);  // use struct method

Struct::associated_func(arg);
```

## Traits

A Trait is a collection of methods representing a set of behaviours necessary to accomplish some task.  
Traits can be used as generic types constraints and can be implemented by data types.

```rs
trait Trait {
    fn method_signature(&self, param: Type) -> Type;
    fn method_signature(&self, param: Type) -> Type {
        // default implementation
    }
}

impl Trait for Struct {
    fn method_signature(&self, param: Type) -> Type {
        // specific implementation
    }
}

// trait as parameter or return
fn method_signature(param: &impl Trait) -> Type {}
fn method_signature(param: &(impl TraitOne + TraitTwo) -> Type {}

// method can only return a single type and that type must implement the trait,
// useful for closures or iterators
fn method_signature(param: Type) -> impl Trait {}
```

### Derive Traits

The Rust compiler is able to provide a basic implementation of a trait with the `derive` attribute.  

Derivable Traits:

- `Eq`
- `PartialEq`
- `Ord`
- `PartialOrd`
- `Clone`
- `Copy`
- `Hash`
- `Default`
- `Debug`

```rs
#[derive(Trait)]  // derive a trait for the struct
#[derive(Trait, Trait, ...)]  // derive multiple traits
struct Struct {
    /* ... */
}
```

### Trait Bounds

Trait Bound are used to require a generic to implement specific traits and guarantee that a type will have the necessary behaviours.

```rs
fn generic_method<T: RequiredTrait>() {}
fn generic_method<T: RequiredTrait + RequiredTrait>() {}  // multiple bounds
// or
fn generic_method<T, U>() 
    where T: RequiredTrait + RequiredTrait,
          U: RequiredTrait + RequiredTrait
{
    // implementation
}

// returned must implement specified trait
fn generic_return() -> impl RequiredTrait { }
```

### Trait Extensions

```rs
extern crate foo;
use foo::Foo;

// define the methods to be added to the existing type
trait FooExt {
    fn bar(&self);
}

// implement the extension methods
impl FooExt for Foo {
    fn bar(&self) { .. }
}
```

### Generic Structs & Methods

Generic Data Types are abstract stand-ind for concrete data types or other properties.  
They can be used with structs, functions, methods, etc.

```rs
struct GenericStruct<T, U> {
    T generic_field,
    U generic_field,
    ...
}

impl<T, U> GenericStruct<T, U> {
    fn generic_method<T>() -> Type { }
    fn generic_method<U>() -> Type { }
}

// implementation for specific types
impl GenericStruct<Type, Type> {
    fn method() -> Type { }
}

// implementation for specific traits 
impl<T: Trait, U> GenericStruct<T, U> {/* ...*/}

// implement a trait for all types with a specific trait (AKA blanket implementation)
impl<T: WantedTrait> ImplementedTrait for T {/* ...*/}

fn generic_func<T>() -> Type { }
fn generic_func<T>() -> &T { }  // T could be heap-based type, returning reference is always valid

fn generic<T: Trait>() -> Type { }  // use generic constraint
```

**NOTE**: the calling code needs to import your new trait in addition to the external type

## Lifetimes

Lifetime annotation indicates to the *borrow checker* that the lifetime of the returned value is as long as the lifetime of the referenced value.  
The annotation does not affect how long the references live.

In case of different lifetimes the complier will use the most restrictive.

```rs
// lifetime annotation syntax
fn func<'a>(x: &'a Type, y: &'a Type) -> &'a Type { }

// multiple lifetimes annotations
fn func<'a, 'b>(x: &'a Type, y: &'b Type) -> &'a Type { }

// struct lifetime annotation
struct Struct<'a> {
    name: &'a str  // is borrowed, needs lifetime
}

impl<'a> Struct<'a> { }
impl<'a, 'b> Struct<'a> { 
    fn method(&'a self, param: &'b Type) -> &'b Type {}
}

// static lifetime, same duration as entire program
// can be coerced to more restrictive lifetime
let string: &'static str = "...";
```

### Lifetime Elision Rules

The *Lifetime Elision Rules* are a set of rules for the compiler to analyze references lifetimes.  
They describe situations that do not require explicit lifetime annotations.  

- **Rule 1**: Each input parameter that is a reference is assigned it's own lifetime
- **Rule 2**: If there is exactly one input lifetime, assign it to all output lifetimes
- **Rule 3**: If there is a `&self` or `&mut self` input parameter, it's lifetime will be assigned to all output lifetimes

## Enums

```rs
// enum definition
enum Enum
{
    Variant1(Type, ...),  // each variant can have different types (even structs and enums) and amounts of associated data
    Variant2,
    ...
}

// value assignment
let e: Enum = Enum::Variant1;
let e: Enum = Enum::Variant2(arg, ...);  // variant w/ data

// methods on enum
impl Enum
{
    fn method(&self) -> Type {
        match self {
            Enum::Variant1 => <expr>
            Enum::Variant2(arg) => <expr>,
        }
    }
}
```

### Option & Result

The `Option` type is used in many places because it encodes the very common scenario in which a value could be something or it could be nothing. Expressing this concept in terms of the type system means the compiler can check whether you've handled all the cases you should be handling; this functionality can prevent bugs that are extremely common in other programming languages.

`Result<T, E>` is the type used for returning and propagating errors. It is an enum with the variants, `Ok(T)`, representing success and containing a value, and `Err(E)`, representing error and containing an error value.

```rs
// std implementation
enum Option<T> {
    Some(T),
    None
}

enum Result<T, E> {
    Ok(T),
    Err(E)
}

let option: Option<T> = /* */;

option.unwrap();  // get value of Some or panic
option.unwrap_or(value);  // get value of Some or return a specified value
option.unwrap_or_default();  // get value of Some or return the default value of T

let result: Result<T, E> = /* */;

result.unwrap();  // get value of Ok or panic if Err
result.unwrap_or(value);  // get value of OK or return a specified value
result.unwrap_or_default();  // get value of Ok or return the default value of T
result.unwrap_err();  // get value of Err or panic if Ok

result_or_option.expect("Error Message");  // if Err or None panics with a custom error message

fn returns_result() -> Result<T, E> { 
    let result = match may_return_err() {
        Ok(value) => value,
        Err(error) => return Err(error)  // return Err early
    };

    Ok(result)
}
// same as
fn returns_result() -> Result<T, E> { 
    let result = may_return_err()?;  // error propagation
    // result contains Err ot value of Ok

    Ok(result)
}
```

Ending an expression with `?` will result in the unwrapped success (`Ok`) value, unless the result is `Err`, in which case `Err` is returned early from the enclosing function.  
`?` can only be used in functions that return `Result` because of the early return of `Err` that it provides.

**NOTE**: When `None` is used the type of `Option<T>` must be specified, because the compiler can't infer the type that the `Some` variant will hold by looking only at a `None` value.
**NOTE**: error values that have the `?` operator called on them go through the `from` function, defined in the `From` trait in the standard library, which is used to convert errors from one type into another

### Match Expressions

A *match expression* is made up of *arms*. An arm consists of a *pattern* and the code that should be run if the value given to the beginning of the match expression fits that arm's pattern. Rust takes the value given to match and looks through each arm's pattern in turn.

**NOTE**: `match` arms must be exhaustive for compilation.

```rs
enum Enum {
    Variant1,
    Variant2,
    Variant3(Type),
    ...
}

// match expression on enum
fn match_variant(e: Enum) {
    match e {
        Enum::Variant1 => <expr>,
        Enum::Variant2 => { /* code block */ },
        Enum::Variant3(parm_name) => <expr>,
        _ => ()  // () is unit value
    }
}
```

## Collections

### Vector

Vectors allow to store more than one value in a single data structure that puts all the values next to each other in memory. Vectors can only store values of the *same type*.  
Like any other struct, a vector is freed when it goes out of scope. When the vector gets dropped, all of its contents are also dropped.

```rs
let v: Vec<Type> = Vec<Type>::new();  // empty vec init
let mut v: vec![item1, item2, ...];  // vec init (type inferred)

v.push(item);  // add elements to vector
v.pop();  // last item as Option<T> (vector must be mutable)

// element access
let value = v.get(index);  // get method (returns Option<&T>)
let value = &v[index];  // index syntax  (returns reference, panic on index out of bounds)

// iterate over mutable references to each element in a mutable vector in order to make changes to all the elements
for i in mut &v {
    *i = value;  // dereference and modify value
}
```

A vector can hold different types if those type are variants of the same enum. It's also possible to use trait objects.

```rs
enum Enum {
    Int(i32),
    Float(f64),
    Text(String)
}

let v = vec![
    Enum::Int(2),
    Enum::Float(3.14),
    Enum::Text(String::from("text"))
];
```

### HashMap

Stores data in key-value pairs.

```rs
use std::collections::HashMap;

let map: HashMap<K, V> = HashMap::new();

let value = map.get(key); // returns Option<&V>
map.inset(key, value);  // insert or override value
map.entry(key).or_insert(value); // insert if not existing
map.entry(key).and_modify(|value| { *value = <expr> });  // modify item based on current value
```

## Files

### Reading Files

```rs
use std::fs;

let contents: Vec<u8> = fs::read("path/to/file").unwrap_or_default();
let contents: String = fs::read_to_string("path/to/file").unwrap_or_default();

contents.lines(); // iterator over text lines
```

### Writing Files

```rs
use std::fs;
use std::io::Write;  // write trait
// or
use std::io::prelude::*;

let contents: [u8] = /* */;
let contents = String::from(/* */);

fs::write("path/to/file", contents);

let mut file = fs::OpenOptions::new().append(true).open("path/to/file").unwrap();
file.write(b"appended text");  // write wants an [u8]
```

## External Code

The extern keyword is used in two places in Rust:

- in conjunction with the crate keyword to make Rust code aware of other Rust crates in the project
- in foreign function interfaces (FFI).

`extern` is used in two different contexts within FFI. The first is in the form of external blocks, for declaring function interfaces that Rust code can call foreign code by.

```rs
#[link(name = "my_c_library")]
extern "C" {
    fn my_c_function(x: i32) -> bool;
}
```

This code would attempt to link with `libmy_c_library.so` on unix-like systems and `my_c_library.dll` on Windows at runtime, and panic if it can't find something to link to.  
Rust code could then use my_c_function as if it were any other unsafe Rust function.  
Working with non-Rust languages and FFI is inherently unsafe, so wrappers are usually built around C APIs.

The mirror use case of FFI is also done via the extern keyword:

```rs
#[no_mangle]
pub extern "C" fn callable_from_c(x: i32) -> bool {
    x % 3 == 0
}
```

If compiled as a dylib, the resulting `.so` could then be linked to from a C library, and the function could be used as if it was from any other library
