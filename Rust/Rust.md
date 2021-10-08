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

### Screen Output

```rs
// macro (funcs have no "!")
println!("Value: {}", value);  // {} is a placeholder for a value or variable
println!("Values: {1}, {0}", value1, value2);  // use index to print values
println!("Num: {:<total_digits>.<decimal_digits>}", 10);
println!("Num: {:0<total>.<decimal>}", 10);  // prefix num with zeroes

println!("{:b}", 0b11011);  // print as bits

print!();
```

### User Input

```rs
use io;

let mut string = String::new();  // create empty string var

let mut var: i32 = io:stdin().readline().trim().parse().expect("input must be a number");

io::stdin()  // read line from stdin
    .readline(&mut string)  // put in into a var (since var i mutable it has to be specified with &mut)
    .expect("Error Message");  // in case of errors return an error message (io::Result) -- NEEDED
```

The `::` syntax in the `::new` line indicates that `new` is an **associated function** of the `String` type.  
An associated function is implemented on a type rather than on a particular instance of the type. Some languages call this a `static method`.

The `&` indicates that this argument is a reference, which gives a way to let multiple parts of the code access one piece of data without needing to copy that data into memory multiple times.

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

### Numeric OPerators

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

let (x, y, z) = tup;  // tuple deconstruction (unpacking)

tup.0;  // member access
```

### Array Types

Every element of an array must have the *same type*. Arrays in Rust have a fixed length, like tuples.  
An array isn't as flexible as the `vector` type, though. A vector is a similar collection type provided by the standard library that *is allowed to grow or shrink in size*.

```rs
let array = [0, 1, 2, 3, 4];
let array: [Type; length] = [...];
let array: [value; length];  // same as python's [value] * length

array[index] = value;  // member access and update
```

### Slice Types

Slices allows to reference a contiguous sequence of elements in a collection rather than the whole collection. **Slices don't take ownership**.

```rs
let s = String::from("string literal");

let slice = &s[start..end];

let a = [0, 1, 2, 3, 4, 5];

let slice =  &a[start..end];
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
for item in sequence.iter() {
    // code here
}

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

### Ways Variables and Data Interact

A "shallow copy" of a variable allocated on the heap (C#'s reference value) the original variable goes out of scope and only the "copy" remains.  
A "deep copy" (`var.clone()`) makes a copy of the data in the new variable without make the original fall out of scope.

When a variable goes out of scope, Rust calls a special function for us. This function is called `drop`, and it's where the code to return the memory is located.

Rust has a special annotation called the `Copy` trait that we can place on types that are stored on the stack.  
If a type has the `Copy` trait, an older variable is still usable after assignment.

Rust won't let us annotate a type with the `Copy` trait if the type, or any of its parts, has implemented the `Drop` trait.  
If the type needs something special to happen when the value goes out of scope and we add the `Copy` annotation to that type, we'll get a compile-time error.

```rs
let s = String::new()
let t = s;  // shallow copy, s is now out of scope
let u = t.clone();  // deep copy, t is still valid
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

### Using Tuple Structs without Named Fields to Create Different Types

To define a **tuple struct**, start with the `struct` keyword and the struct name followed by the types in the tuple.

```rs
struct Point(i32, i32, i32);

let origin = Point(0, 0, 0);
```

### Struct Printing

```rs
#[derive(Debug)]  // inherit the debug traits
struct StructName
{
    field: value,
    ...
}

let s: Struct = { /* valorization */};
printl!("{:?}", s)  // debug output: { field: value, ... }
```

### Method Syntax

```rs
struct Struct
{
    field: value,
    ...
}

impl Struct
{
    fn method(&self, arg: Type) -> Type { }
}

let s: Struct = { /* valorization */};
s.method(arg);  // use struct method
```

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
let e: Enum = Enum::Variant2;
let e: Enum = Enum::Variant1(arg, ...);  // variant w/ data

// methods on enum
impl Enum
{
    fn method(&self, arg: Type) -> Type {}
}
```

### [Option enum](https://doc.rust-lang.org/std/option/enum.Option.htmls)

The `Option` type is used in many places because it encodes the very common scenario in which a value could be something or it could be nothing. Expressing this concept in terms of the type system means the compiler can check whether you've handled all the cases you should be handling; this functionality can prevent bugs that are extremely common in other programming languages.

he `Option<T>` enum is so useful that it's even included in the prelude; you don't need to bring it into scope explicitly.  
In addition, so are its variants: you can use `Some` and `None` directly without the `Option::` prefix.

```rs
// std implementation
enum Option<T> {
    Some(T),
    None
}
```

*NOTE*: When `None` is used the type of `Option<T>` must be specified, because the compiler can't infer the type that the `Some` variant will hold by looking only at a `None` value.

### Match Expression + Comparing

A **match expression** is made up of *arms*.  
An arm consists of a *pattern* and the code that should be run if the value given to the beginning of the match expression fits that arm's pattern.  
Rust takes the value given to match and looks through each arm's pattern in turn.

**NOTE**: `match` arms must be exhaustive for compilation.

```rs
enum Enum {
    Variant1,
    Variant2,
    Variant3(value),
    ...
}

// match expression on enum
fn match_variant(e: Enum) {
    match e {
        Enum::Variant1 => <expr>,
        Enum::Variant2 => { /* code block */ },
        Enum::Variant3(value) => state,
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

// element access
v.get(index);  // get method (returns Option<&T>)
&v[index];  // index syntax  (returns reference, panic on index out of bounds)

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
    Enum::Text("TEST")
];
```
