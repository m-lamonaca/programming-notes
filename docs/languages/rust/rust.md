# Rust

## Basics

```rs linenums="1"
use <module>;  // bring a type into scope

fn main() {  //program entry point
    // code here
}
```

### Standard Output

```rs linenums="1"
// macro (func have no "!")
println!("Value: {}", value);  // {} is a placeholder for a value or variable
println!("Values: {1}, {0}", value1, value2);  // use index to print values

println!("Value {a}, {b}", a = value1, b = value2);  // named parameters
println!("Value {scoped_variable}");  // reference a variable in scope (must not have any parameters)

println!("Num: {:<total_digits>.<decimal_digits>}", number);
println!("Num: {:0<total>.<decimal>}", number);  // prefix number with zeroes

println!("{:b}", 0b11011);  // print as bits

print!();
```

### Standard Input

```rs linenums="1"
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

```rs linenums="1"
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

```rs linenums="1"
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

#### Explicit Mathematical Operations (Integers)

```rs linenums="1"
i32::MAX.checked_add(value);  // Option<i32> => None if overflow
i32::MAX.wrapping_add(value);  // i32 => Wrap around
i32::MAX.saturating_add(value);  //  i32 => MIN <= x <= MAX (Clamp)
i32::MAX.overflowing_add(value); // (i32, bool) => overflowed result and if overflowed
```

> **Note**: analogous method exist for other mathematical operation

### Floating-Point Types

Rust also has two primitive types for floating-point numbers, which are numbers with decimal points.  
Rust's floating-point types are `f32` and `f64`, which are 32 bits and 64 bits in size, respectively.  
The default type is `f64` because on modern CPUs it's roughly the same speed as `f32` but is capable of more precision.

### Numeric & Byte Literals

Numeric Base Prefix:

- `0x`: Hexadecimal Number
- `0o`: Octal Number
- `0b`: Binary Number

> **Note**: Number can have `_` interposed for legibility (E.g: `1_000_u64`)

Binary Literals:

- `b'\''`, `b'\1'`, `b'\n'`, `b'\r'`, `b'\t'`: Escaped characters
- `b'<C>'`: Byte whose value is the ASCII character `<C>`
- `b'\x<HH>'`: Byte whose value is the hexadecimal `<HH>`

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

```rs linenums="1"
let c: char = 'C';  // SINGLE QUOTES
let c: char = '\u{261D}';  // Unicode Code Point U+261D
let c: char = '\x2A';  // ASCII for *


'*'.is_alphabetic();  // false
'β'.is_alphabetic(); // true
'8'.to_digit(10);  // Some(8)
'\u{CA0}'.len_utf8();  // 3
std::char::from:digit(2, 10);  // Some(2)
```

### String Types

```rs linenums="1"
let s = String::new();  // create empty string
let s = String::from("string literal");  // construct string from literal

// string literals
let s = "a multiline
    string literal"; // includes whitespace and new lines

let s = "single line \
    string literal";  // the trailing \ avoids the new line & trailing/leading whitespace

// raw strings
let raw = r"\d+(\.\d+)*"  // backslash and whitespace included verbatim
let raw = r#"raw literal with explicit delimiters, allows double quotes (") inside"#;

// byte strings
let byte_string = b"some bite string"  // &[u8] => slice og u8, equal to &[b'E', b'q', ...]

s.push_str(""); // appending string literals
```

### Tuple Types

A tuple is a general way of grouping together a number of values with a variety of types into one compound type.  
Tuples have a *fixed length*: once declared, they cannot grow or shrink in size.

```rs linenums="1"
let tup: (i32, f64, u8) = (500, 6.4, 1);
let tup = (500, 6.4, 1);

let (x, y, z) = tup;  // tuple deconstruction (unpacking)

tup.0 = value;  // member access & update (mut be mutable)
```

### Array Types

Every element of an array must have the *same type*. Arrays in Rust have a fixed length, like tuples.  
An array isn't as flexible as the `vector` type, though. A vector is a similar collection type provided by the standard library that *is allowed to grow or shrink in size*.

```rs linenums="1"
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

### Slice Types (`&[T]`, `&mut [T]`)

Slices allows to reference a contiguous sequence of elements in a collection rather than the whole collection. **Slices don't take ownership**.

A *mutable* slice `&mut [T]` allows to read and modify elements, but can’t be shared;
a *shared* slice `&[T]` allows to share access among several readers, but doesn’t allow to modify elements.

`&String` can be used in place of a `&str` (string slice)  trough *String Coercion*. The `&String` gets converted to a `&str` that borrows the entire string.
The reverse is not possible since the slice lacks some information about the String.

> **Note**: When working with functions is easier to always expect a `&str` instead of a `&String`.

```rs linenums="1"
let s = String::from("string literal");
let slice: &str = &s[start..end];

let a = [0, 1, 2, 3, 4, 5];
let slice: &[i32] =  &a[start..end];

sequence[start..]  // slice to end of sequence
sequence[..end]  // slice from start to end (excluded)
```

### Type Aliases

```rs linenums="1"
type Alias = T;
```

## Functions

Rust code uses *snake_case* as the conventional style for function and variable names.

Function definitions in Rust start with `fn` and have a set of parentheses after the function name.  
The curly brackets tell the compiler where the function body begins and ends.

Rust doesn't care where the functions are defined, only that they're defined somewhere.

```rs linenums="1"
  // parameters MUST have the Type annotation
fn func(param: Type) {}

  // -> specifies the return type
fn func() -> Type {}

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

### if, else-if, else

```rs linenums="1"
if condition {
    // [...]
} else if condition {
    // [...]
} else {
    // [...]
}
```

### let if

```rs linenums="1"
let var = if condition { value } else { value };  // returned types must be the same
```

### if-let

```rs linenums="1"
if let <pattern> = <expr> {
    <block1>
} else {
    <block2>
}

// same as
match <expr> {
    <pattern> => { block1 }
    _ => { block2 }
}
```

### loop

```rs linenums="1"
// loop's forever if not explicitly stopped (return or break)
loop { }
```

### while, while-let

```rs linenums="1"
while condition { }

while let <pattern> {}
```

### for

```rs linenums="1"
for item in sequence.iter() { }
for item in sequence.iter_mut() { }  // iterate over mutable items

for item in sequence { }  // consumes the values (moved into item)
for item in &sequence { }  // doesn't consumes the values (item is a reference)
for item in &mut sequence { }

// for (i = start; i < end; i += 1)
for i in (start..end) { }
```

### Range

```rs linenums="1"
..  // RangeFull
a ..  // RangeFrom { start: a }
.. b  // RangeTo { end: b }
a .. b  // Range { start: a, end: b }
..= b  // RangeToInclusive { end: b }
a ..= b  // RangeInclusive::new(a, b)
```

### `break` & `continue`

```rs linenums="1"
while <condition> {
    // [...]

    continue;  // jump to condition evaluation
}

let loop_result = loop {
    // [...]

    break <loop-value>;
}

'outer: loop {
    // [...]
    loop {}

    break 'outer;  // break labeled loop
}

let loop_result = 'outer: loop {
    // [...]
    loop {}

    break 'outer <loop-value>; // break labeled loop and return value
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

Copies happen implicitly, for example as part of an assignment `y = x`. The behavior of `Copy` is not overloadable; it is always a simple bit-wise copy.  
Cloning is an explicit action, `x.clone()`. The implementation of Clone can provide any type-specific behavior necessary to duplicate values safely.

Rust won't allow to annotate a type with the `Copy` trait if the type, or any of its parts, has implemented the `Drop` trait.  

```rs linenums="1"
let s = String::new()
let t = s;  // MOVE, s is now uninitialized
let u = t.clone();  // deep copy, t is still valid

let n: i32 = 1;
let x = n;  // x holds a COPY of the VALUE of n
```

### Ownership & Functions

The semantics for passing a value to a function are similar to those for assigning a value to a variable. Passing a variable to a function will move or copy, just as assignment does.

```rs linenums="1"
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

```rs linenums="1"
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

### References, Raw Pointers & Borrowing

Reference types:

- `&T`: *immutable* (aka *shared*) reference, admits multiple references at the same time, (Read-Only, implements `Copy`)
- `&mut T`: *mutable* reference, there can be only one

Raw Pointers types:

- `*mut T`
- `* const T`

As long as there are *shared references* to a value, not even its owner can modify it, the value is locked down.  
Similarly, if there is a *mutable reference* to a value, it has exclusive access to the value;
it's not possible to use the owner at all, until the mutable reference goes away.

> **Note**: raw pointers can be used only in `unsafe` block. Rust doesn't track the pointed value

*Mutable references* have one big restriction: it's possible to have *only one* mutable reference to a particular piece of data in a particular scope.

The benefit of having this restriction is that Rust can prevent **data races** at compile time.  
A data race is similar to a race condition and happens when these three behaviors occur:

- Two or more pointers access the same data at the same time.  
- At least one of the pointers is being used to write to the data.  
- There's no mechanism being used to synchronize access to the data.

```rs linenums="1"
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

The `.` operator can **implicitly borrow or dereference** a reference

```rs linenums="1"
let struct = Struct { field: /* [...] */ }
let ref = &struct;

ref.field  // implicit deref
(*ref).field  // explicit deref

let mut vec = vec![/* */];

v.sort()  // implicit mutable borrow
(&mut vec).sort()  // explicit mutable borrow
```

> **Note**: arithmetic expressions can "see through" one level of references.  
> **Note**: comparison affect the final value of a reference chain. To compare references directly use `std::ptr::eq`

## Structs

A **struct**, or structure, is a custom data type that allows to name and package together multiple related values that make up a meaningful group.

To define a struct enter the keyword struct and name the entire struct.  
A struct's name should describe the significance of the pieces of data being grouped together.  
Then, inside curly brackets, define the names and types of the pieces of data, which we call *fields*.

```rs linenums="1"
struct Struct {
    field: Type,
    ...
}

struct UnitStruct;  // no field, useful in generics

{ x: Type, y: Type }  // anonymous struct
```

To use a struct after defining it, create an instance of that struct by specifying concrete values for each of the fields.

```rs linenums="1"
let mut var = Struct {
    field: value,
    ...
};
```

### Field Init Shorthand

```rs linenums="1"
let mut var = Struct {
    field,  // shortened form since func param is named as the struct's field
    ...
};

var.field = value;  // member access
```

**Note**: the entire instance must be mutable; Rust doesn't allow to mark only certain fields as mutable.

### Struct Update Syntax

```rs linenums="1"
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

```rs linenums="1"
struct Point(i32, i32, i32);
struct Color(i32, i32, i32);

let origin = Point(0, 0, 0);
```

### Struct Printing

```rs linenums="1"
#[derive(Debug)]  // inherit the debug trait
struct Struct { }

let s: Struct = { /* valorization */};
println!("{:?}", s)  // debug output: { field: value, ... }
```

### Associated Functions & Type-Associated Functions (aka Methods)

```rs linenums="1"
struct Struct { };
impl Struct
{
    fn associated_function(&self, arg: Type) -> Type { }
    fn associated_function(&mut self, arg: Type) -> Type { }  // able to modify instance
    fn type_associated_function(arg: Type) -> Type { }  // does not have self parameter
}

let s: Struct = { /* valorization */};
s.associated_function(arg);  // use struct method

Struct::type_associated_function(arg);
```

### Associated Consts

```rs linenums="1"
struct Struct {
    const ASSOCIATED_CONST: Type = <value>;
}

Struct::ASSOCIATED_CONST;
```

## Traits

A Trait is a collection of methods representing a set of behaviours necessary to accomplish some task.  
Traits can be used as generic types constraints and can be implemented by data types.

```rs linenums="1"
trait Trait {
    fn method_signature(&self, param: Type) -> Type;
    fn method_signature(&self, param: Type) -> Type {
        // default implementation
    }
}

trait SubTrait: Trait { }  // must have impl blocks for all super traits
//same as
trait SubTrait where Self: Trait

impl Trait for Struct {
    fn method_signature(&self, param: Type) -> Type {
        // specific implementation
    }
}
```

### Fully Qualified Method Calls

```rs linenums="1"
value.method();
Type::method(value);
Trait::method(value);
<Type as Trait>::method(value);
```

> **Note**: fully qualified method calls also works with associated functions

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

```rs linenums="1"
#[derive(Trait)]  // derive a trait for the struct
#[derive(Trait, Trait, ...)]  // derive multiple traits
struct Struct {
    // [...]
}
```

### Trait Bounds

Trait Bound are used to require a generic to implement specific traits and guarantee that a type will have the necessary behaviours.

```rs linenums="1"
fn generic_method<T: RequiredTrait>() {}
fn generic_method<T: RequiredTrait + RequiredTrait>() {}  // multiple bounds
// or
fn generic_method<T, U>() 
    where T: RequiredTrait + RequiredTrait,
          U: RequiredTrait + RequiredTrait
{
    // implementation
}

// returned must implement specified trait, retuned type can be only one
// useful for closures or iterators
fn generic_return() -> impl RequiredTrait { }

// trait as parameter or return (syntactic sugar for trait bounds)
fn method_signature(param: &impl Trait) -> Type {}
fn method_signature(param: &(impl TraitOne + TraitTwo)) -> Type {}
```

### Trait Extensions

```rs linenums="1"
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

Rust accomplishes this by performing *monomorphization* of the code that is using generics at compile time.  
Monomorphization is the process of turning generic code into specific code by filling in the concrete types that are used when compiled.
For this reason if a function as a trait as return type (trait bound), only a single type that implements the trait can be returned.

```rs linenums="1"
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

> **Note**: the calling code needs to import your new trait in addition to the external type

### Associated Types

*Associated types* connect a type placeholder with a trait such that the trait method definitions can use these placeholder types in their signatures.  
The implementor of a trait will specify the concrete type to be used instead of the placeholder type for the particular implementation.

```rs linenums="1"
trait Iterator {
    type Item;

    fn next(&mut self) -> Option<Self::Item>;
}
```

The type `Item` is a placeholder, and the next method’s definition shows that it will return values of type `Option<Self::Item>`. Implementors of the `Iterator` trait will specify the concrete type for `Item`, and the next method will return an `Option` containing a value of that concrete type.

> **Note**: if the type is *generic* then then they are called **generic associated types**

### Generic Traits vs Associated Types

The difference is that when a trait has a generic parameter, it can be implemented for a type multiple times, changing the concrete types of the generic type parameters each time.  
With associated types, it's not possible to implement the trait multiple times so annotations are not needed.

Associated types also become part of the trait’s contract: implementors of the trait must provide a type to stand in for the associated type placeholder.  
Associated types often have a name that describes how the type will be used, and documenting the associated type in the API documentation is good practice.

### Trait Objects

A *reference* to a trait is called a **Trait Object**. Like any other reference, a trait object points to some value, it has a lifetime, and it can be either mut or shared.  
What makes a trait object different is that Rust usually doesn’t know the type of the referent at compile time.  
So a trait object includes a little extra information about the referent’s type.

In memory, a trait object is a fat pointer consisting of a pointer to the value, plus a pointer to a table representing that value’s type.  

> **Note**: Rust automatically converts ordinary references into trait objects when needed

```rs linenums="1"
let trait_object = &mut dyn Trait = &mut source;
let trait_object: Box<dyn Trait> = Box::new(source);  // same for Rc<T>, Arc<T>, ...
```

This works differently from defining a struct or function that uses a generic type parameter with trait bounds.  
A generic type parameter can only be substituted with *one concrete type* at a time, whereas trait objects allow for *multiple* concrete types to fill in for the trait object at runtime.

```rs linenums="1"
fn func() -> Box<dyn Trait> { }  // return something that implements the specified trait
```

If homogeneous collections are needed, using generics and trait bounds is preferable because the definitions will be monomorphized at compile time to use the concrete types.

The code that results from *monomorphization* uses **static dispatch**, which is when the compiler knows what method will be called at compile time.

This is opposed to **dynamic dispatch**, which is when the compiler can't tell at compile time which method will be called.  At runtime Rust uses the pointers inside the trait object to know which method to call.
There is a runtime cost when this lookup happens that doesn't occur with static dispatch.

Dynamic dispatch also prevents the compiler from choosing to inline a method's code, which in turn prevents some optimizations.

It's only possible to make *object-safe* traits into trait objects. A trait is object safe if all the methods defined in the trait have the following properties:

- The return type isn't `Self`.
- There are no generic type parameters.

## Lifetimes

Lifetime annotation indicates to the *borrow checker* that the lifetime of the returned value is as long as the lifetime of the referenced value.  
The annotation does not affect how long the references live.

In case of different lifetimes the complier will use the most restrictive.

```rs linenums="1"
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

```rs linenums="1"
// enum definition
enum Enum
{
    Variant1,
    Variant2(Type, ...),  // each variant can have different types (even structs and enums) and amounts of associated data
    Variant3 { x: u8, y: u8 }  // c-like struct
    ...
}

// value assignment
let e: Enum = Enum::Variant1;
let e: Enum = Enum::Variant2(arg, ...);  // variant w/ data
let e: Enum = Enum::Variant3 { x = 1, y = 0};

// methods on enum
impl Enum
{
    fn method(&self) -> Type {
        match self {
            Enum::Variant1 => <expr>
            Enum::Variant2(arg) => <expr>,
            Enum::Variant3 { x = 1, y = 0} => <expr>;
        }
    }
}
```

### Match Expressions

A *match expression* is made up of *arms*. An arm consists of a *pattern* and the code that should be run if the value given to the beginning of the match expression fits that arm's pattern. Rust takes the value given to match and looks through each arm's pattern in turn.

> **Note**: `match` arms must be exhaustive for compilation.

```rs linenums="1"
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

### Pattern Matching

| Pattern              | Example                    | Notes                                   |
|:--------------------:|:--------------------------:|:---------------------------------------:|
|Literal               | `100`                      | Match exact value or `const` name       |
|Range                 | `x..=y`                    | Match any value in range, including end |
|Wildcard              | `_`                        | Match any value and ignore it           |
|`ref` Variable        | `ref field`                | Borrow reference of matched variable    |
|Variable              | `count`                    | Match any value and copy it to variable |
|Bind with syb-pattern | `variable @ <pattern>`     | Match pattern and copy to variable      |
|Enum                  | `Some(value)`              |                                         |
|Tuple                 | `(key, value)`             |                                         |
|Array                 | `[first, second, third]`   |                                         |
|Slice                 | `[first, .., last]`        |                                         |
|Struct                | `Point { x, y, .. }`       |                                         |
|Reference             | `&value`                   |                                         |
|Multiple Patterns     | `'a' \| 'A'`               | `match, if let, while let` only         |
|Guard Expression      | `<pattern> if <condition>` | `match` only                            |

> **Note**: `..` in slices matches *any number* of elements. `..` in structs *ignores* all remaining fields

```rs linenums="1"
// unpack a struct into local variables
let Struct { local_1, local_2, local_3, .. } = source;

// ...unpack a function argument that's a tuple
fn distance_to((x, y): (f64, f64)) -> f64 { }

// iterate over keys and values of a HashMap
for (key, value) in &hash_map { }

// automatically dereference an argument to a closure
// (handy because sometimes other code passes you a reference
// when you'd rather have a copy)
let sum = numbers.fold(0, |a, &num| a + num);
```

Patterns that always match are special in Rust. They’re called **irrefutable patterns**, and they’re the only patterns allowed in `let`, in function arguments, after `for`, and in closure arguments.

A **refutable pattern** is one that might not match, like `Ok(x)`. Refutable patterns can be used in `match` arms, because match is designed for them: if one pattern fails to match, it’s clear what happens next.

Refutable patterns are also allowed in `if let` and `while let` expressions:

```rs linenums="1"
// handle just one enum variant specially
if let Enum::VariantX(_, _) = source { }

// run some code only if a table lookup succeeds
if let Some(value) = hash_map.get(&key) { }

// repeatedly try something until it succeeds
while let Err(err) = fallible_func() { }

// manually loop over an iterator
while let Some(_) = lines.peek() { }
```

## Error Handling

### Option & Result

The `Option` type is used in many places because it encodes the very common scenario in which a value could be something or it could be nothing. Expressing this concept in terms of the type system means the compiler can check whether you've handled all the cases you should be handling; this functionality can prevent bugs that are extremely common in other programming languages.

`Result<T, E>` is the type used for returning and propagating errors. It is an enum with the variants, `Ok(T)`, representing success and containing a value, and `Err(E)`, representing error and containing an error value.

```rs linenums="1"
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

option.is_some();
option.is_none();

option.unwrap();  // get value of Some or panic
option.unwrap_or(value);  // get value of Some or return a specified value
option.unwrap_or_default(fallback);  // get value of Some or return the default value of T

let result: Result<T, E> = /* */;

result.is_ok();
result.is_err();
result.as_ref();  // returns Result<&T, &E>
result.as_mut();  // returns Result<&mut T, &mut E>

// methods consuming the result
result.ok();  // returns Option<T>, discarding the error
result.err();  // returns Option<T>, discarding the error
result.unwrap();  // get value of Ok or panic if Err
result.unwrap_or(value);  // get value of OK or return a specified value
result.unwrap_or_default(fallback);  // get value of Ok or return the default value of T
result.unwrap_or_else(fallback_fn)
result.unwrap_err();  // get value of Err or panic if Ok
result.expect(message);  // write message to stderr if Err

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

> **Note**: When `None` is used the type of `Option<T>` must be specified, because the compiler can't infer the type that the `Some` variant will hold by looking only at a `None` value.
> **Note**: error values that have the `?` operator called on them go through the `from` function, defined in the `From` trait in the standard library, which is used to convert errors from one type into another

### Multiple Error Types

When working with multiple error types is useful to return a "generic error" type. All the standard library error types can be represented by `Box<dyn std::Error + Send + Sync + 'static>`.

```rs linenums="1"
// convenience type aliases for the generic error
type GenericError = Box<dyn std::Error + Send + Sync + 'static>;
type GenericResult<T> = Result<T; GenericError>;
```

> **Note**: the [`anyhow`](https://crates.io/crates/anyhow) crate provides error and result types like `GenericError` with additional features

### Custom Error Types

```rs linenums="1"
use thiserror::Error;  // utility crate for custom errors

#[derive(Error, Debug)]
#[error("{message:} ({line:}, {column})")]
pub struct JsonError {
    message: String,
    line: usize,
    column: usize,
}
```

> **Note**: the [`thiserror`](https://crates.io/crates/thiserror) crate provides utilities to create custom error types

## Collections

### Vector

Vectors allow to store more than one value in a single data structure that puts all the values next to each other in memory. Vectors can only store values of the *same type*.  
Like any other struct, a vector is freed when it goes out of scope. When the vector gets dropped, all of its contents are also dropped.

```rs linenums="1"
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

```rs linenums="1"
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

```rs linenums="1"
use std::collections::HashMap;

let map: HashMap<K, V> = HashMap::new();

let value = map.get(key); // returns Option<&V>
map.inset(key, value);  // insert or override value
map.entry(key).or_insert(value); // insert if not existing
map.entry(key).and_modify(|value| { *value = <expr> });  // modify item based on current value
```

## Closures

Rust's closures are anonymous functions that can be saved in a variable or passed as arguments to other functions.  
Unlike functions, closures can capture values from the scope in which they're defined.

Closures are usually short and relevant only within a narrow context rather than in any arbitrary scenario.  
Within these limited contexts, the compiler is reliably able to infer the types of the parameters and the return type, similar to how it's able to infer the types of most variables.

The first time a closure is called with an argument, the compiler infers the type of the parameter and the return type of the closure.  
Those types are then locked into the closure and a type error is returned if a different type is used with the same closure.

```rs linenums="1"
// closure definition
let closure = |param1, param2| <expr>;
let closure = |param1, param2| {/* multiple lines of code */};
let closure = |num: i32| = <expr>;

// closure usage
let result = closure(arg1, arg2);
```

### Storing Closures Using Generic Parameters and the Fn Traits

To make a struct that holds a closure, the type of the closure must be specified, because a struct definition needs to know the types of each of its fields.  
Each closure instance has its own unique anonymous type: that is, even if two closures have the same signature, their types are still considered different.  
To define structs, enums, or function parameters that use closures generics and trait bounds are used.

The `Fn` traits are provided by the standard library. All closures implement at least one of the traits: `Fn`, `FnMut`, or `FnOnce`.

```rs linenums="1"
struct ClosureStruct<T> where T: Fn(u32) -> u32 {
    closure: T,
}
```

### Capturing the Environment with Closures

When a closure captures a value from its environment, it uses memory to store the values for use in the closure body.  
Because functions are never allowed to capture their environment, defining and using functions will never incur this overhead.

Closures can capture values from their environment in three ways, which directly map to the three ways a function can take a parameter:

- taking ownership
- borrowing mutably
- and borrowing immutably.

These are encoded in the three `Fn` traits as follows:

- `FnOnce` consumes the variables it captures from its enclosing scope. The closure takes ownership of these variables and move them into the closure when it is defined.
- `FnMut` can change the environment because it mutably borrows values.
- `Fn` borrows values from the environment immutably.

When a closure is created, Rust infers which trait to use based on how the closure uses the values from the environment.  
All closures implement `FnOnce` because they can all be called at least once. Closures that don't move the captured variables also implement `FnMut`, and closures that don't need mutable access to the captured variables also implement `Fn`.

To force the closure to take ownership of the values it uses in the environment, use the `move` keyword before the parameter list.  
This technique is mostly useful when passing a closure to a new thread to move the data so it's owned by the new thread.

```rs linenums="1"
let closure = move |param| <expr>;
```

## Iterators

The *iterator pattern* allows to perform some task on a sequence of items in turn. An iterator is responsible for the logic of iterating over each item and determining when the sequence has finished.

In Rust, iterators are *lazy*, meaning they have no effect until a call to methods that consume the iterator to use it up.

```rs linenums="1"
// iterator trait
pub trait Iterator {
    type Item;

    fn next(&mut self) -> Option<Self::Item>;

    // methods with default implementations elided
}
```

Calling the `next` method on an iterator changes internal state that the iterator uses to keep track of where it is in the sequence.  
In other words, this code consumes, or uses up, the iterator. Each call to next eats up an item from the iterator.

Methods that call next are called `consuming adaptors`, because calling them uses up the iterator.

Other methods defined on the `Iterator` trait, known as *iterator adaptors*, allow to change iterators into different kinds of iterators.  
It's possible to chain multiple calls to iterator adaptors to perform complex actions in a readable way.  
But because all iterators are lazy, a call one of the consuming adaptor methods is needed to get the results.

```rs linenums="1"
let iterator: = vec![1, 2, 3];
iterator
    .map(|x| x + 1)  // iterator adapter
    .filter(|x| x % 2 == 0)  // iterator adapter
    .collect();  // consuming adapter
```

### Custom Iterators

```rs linenums="1"
struct Counter {
    count: u32,
}

impl Counter {
    fn new() -> Counter {
        Counter { count: 0 }
    }
}

impl Iterator for Counter {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {
        if self.count < 5 {
            self.count += 1;
            Some(self.count)
        } else {
            None
        }
    }
}
```

## Smart Pointers

A **pointer** is a general concept for a variable that contains an address in memory. This address refers to, or "points at" some other data.  
The most common kind of pointer in Rust is a *reference*, which you learned about in Chapter 4. References are indicated by the `&` symbol and borrow the value they point to.  
They don't have any special capabilities other than referring to data. Also, they don`t have any overhead and are the kind of pointer used most often.

**Smart pointers**, on the other hand, are *data structures* that not only act like a pointer but also have additional metadata and capabilities.  
The different smart pointers defined in the standard library provide functionality beyond that provided by references.

In Rust, which uses the concept of ownership and borrowing, an additional difference between references and smart pointers is that references are pointers that only borrow data;  
in contrast, in many cases, smart pointers *own* the data they point to.

Smart pointers are usually implemented using structs. The characteristic distinguishing a smart pointer from a struct is that smart pointers implement the `Deref` and `Drop` traits.  
The `Deref` trait allows an instance of the smart pointer struct to behave like a reference so it's possible to write code that works with either references or smart pointers.  
The `Drop` trait allows to customize the code that is run when an instance of the smart pointer goes out of scope.

The most common smart pointers in the standard library are:

- `Box<T>`: for allocating values on the heap
- `Rc<T>`: a reference counting type that enables multiple ownership
- `Ref<T>` and `RefMut<T>`, accessed through `RefCell<T>`: a type that enforces the borrowing rules at runtime instead of compile time

### Using `Box<T>` to Point to Data on the Heap

The most straightforward smart pointer is `Box<T>`. Boxes allow to store data on the heap rather than the stack. What remains on the stack is the pointer to the heap data.  
Boxes don't have performance overhead, other than storing their data on the heap instead of on the stack. But they don't have many extra capabilities either.

`Box<T>` use cases:

- Using a type whose size can't be known at compile time in a context that requires an exact size
- Transferring ownership of a large amount of data but ensuring the data won't be copied when you do so
- Owning a value and which implements a particular trait rather than being of a specific type

```rs linenums="1"
let _box = Box::new(pointed_value);
```

### `Deref` Trait & Deref Coercion

Implementing the `Deref` trait allows to customize the behavior of the dereference operator, `*`.
By implementing `Deref` in such a way that a smart pointer can be treated like a regular reference.

```rs linenums="1"
struct CustomSmartPointer<T>(T);

impl<T> CustomSmartPointer<T> {
    fn new(x: T) {
        CustomSmartPointer(x)
    }
}

impl<T> Deref for CustomSmartPointer<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        // return reference to value
    }
}

let s = CustomSmartPointer::new(value);
let v = *s;
// same as
let v = *(s.deref());
```

*Deref coercion* is a convenience that Rust performs on arguments to functions and methods.
It works only on types that implement the `Deref` trait and converts such a type into a reference to another type.  
Deref coercion was added to Rust so that programmers writing function and method calls don't need to add as many explicit references and dereferences with `&` and `*`.

```rs linenums="1"
fn hello(name: &str) {
    println!("Hello {}", name);
}

fn main() {
    let name = Box::new(String::from("Rust"));
    hello(&name);  // Box<string> coerced to &str (Box -> String -> &str)
}
```

When the `Deref` trait is defined for the types involved, Rust will analyze the types and use `Deref::deref` as many times as necessary to get a reference to match the parameter's type.

Similar to the `Deref` trait to override the `*` operator on *immutable references*, it's possible to use the `DerefMut` trait to override the `*` operator on *mutable references*.

Rust does *deref coercion* when it finds types and trait implementations in three cases:

- From `&T` to `&U` when `T: Deref<Target=U>`
- From `&mut T` to `&mut U` when `T: DerefMut<Target=U>`
- From `&mut T` to `&U` when `T: Deref<Target=U>`

### `Drop` Trait

`Drop` allows to customize what happens when a value is about to go out of scope. It-s possible to provide an implementation for the `Drop` trait on any type.

```rs linenums="1"
struct CustomSmartPointer<T>(T);

impl<T> Drop for CustomSmartPointer<T> {
    fn drop(&mut self) {
        // clean up memory
    }
}

fn main() {
    let var1 = CustomSmartPointer(value);  // dropped when var1 goes out of scope
    let var2 = CustomSmartPointer(value);
    drop(var2);  // dropped early by using std::mem::drop
}
```

Rust automatically calls `drop` when the instances went go of scope. Variables are dropped in the reverse order of their creation.

### `Rc<T>`, `Arc<T>` & Multiple Ownership

Rust provides the *reference-counted* pointer types `Rc<T>` and `Arc<T>`.  
The `Rc<T>` and `Arc<T>` types are very similar; the only difference between them is that an `Arc<T>` is safe to share between
threads directly (the name Arc is short for *atomic* reference count) whereas a plain `Rc<T>` uses faster non-thread-safe code to update its reference count.

```rs linenums="1"
use std::rc::Rc;

let s: Rc<String> = Rc::new("some string".to_string());
let t: Rc<String> = s.clone();  // contains a new pointer to the value held by s
let u: Rc<String> = s.clone();  // contains a new pointer to the value held by s
```

Each of the `Rc<T>` pointers is referring to the same block of memory, which holds a reference count and space for the value.  
The usual ownership rules apply to the `Rc<T>` pointers themselves, and when the last extant `Rc<T>` is dropped, Rust drops the value as well.

> **Note**: A value owned by an `Rc<T>` pointer is immutable.

### `RefCell<T>` & Interior Mutability Pattern

*Interior mutability* is a design pattern in Rust that allows to mutate data even when there are immutable references to that data;  
normally, this action is disallowed by the borrowing rules.  
To mutate data, the pattern uses unsafe code inside a data structure to bend Rust's usual rules that govern mutation and borrowing.

With references and `Box<T>`, the borrowing rules' invariants are enforced at compile time. With `RefCell<T>`, these invariants are enforced at runtime.  
With references, if these rules are broken, a compiler error is thrown. With `RefCell<T>` the program will panic and exit.

The advantages of checking the borrowing rules at compile time are that errors will be caught sooner in the development process, and there is no impact on runtime performance because all the analysis is completed beforehand.  
For those reasons, checking the borrowing rules at compile time is the best choice in the majority of cases, which is why this is Rust's default.

The advantage of checking the borrowing rules at runtime instead is that certain memory-safe scenarios are then allowed, whereas they are disallowed by the compile-time checks.  
Static analysis, like the Rust compiler, is inherently conservative.

> **Note**: `RefCell<T>` is only for use in single-threaded scenarios and will cause a compile-time error if used it in a multithreaded context.

When creating immutable and mutable references, the `&` and `&mut` syntax is used, respectively.  
With `RefCell<T>`, the `borrow` and `borrow_mut` methods are ued, which are part of the safe API that belongs to `RefCell<T>`.  
The `borrow` method returns the smart pointer type `Ref<T>`, and `borrow_mut` returns the smart pointer type `RefMut<T>`.  
Both types implement `Deref`, so can be treated like regular references.

The `RefCell<T>` keeps track of how many `Ref<T>` and `RefMut<T>` smart pointers are currently active.  
Every time `borrow` is called, the `RefCell<T>` increases its count of how many immutable borrows are active.  
When a `Ref<T>` value goes out of scope, the count of immutable borrows goes down by one.  
Just like the compile-time borrowing rules, `RefCell<T>` allows to have many immutable borrows or one mutable borrow at any point in time.

A common way to use `RefCell<T>` is in combination with `Rc<T>`. `Rc<T>` allows to have multiple owners of some data, but it only gives immutable access to that data.  
By having a `Rc<T>` that holds a `RefCell<T>`, its' possible to get a value that can have multiple owners and that can mutate.

The standard library has other types that provide interior mutability:

- `Cell<T>` which is similar except that instead of giving references to the inner value, the value is copied in and out of the `Cell<T>`.
- `Mutex<T>` which offers interior mutability that's safe to use across threads;

### Reference Cycles Can Leak Memory

Rust's memory safety guarantees make it difficult, but not impossible, to accidentally create memory that is never cleaned up (known as a memory leak).  
Rust allows memory leaks by using `Rc<T>` and `RefCell<T>`: it's possible to create references where items refer to each other in a cycle.  
This creates memory leaks because the reference count of each item in the cycle will never reach 0, and the values will never be dropped.

## Concurrency

### Creating Threads

The `thread::spawn` function creates a new tread that will execute the passed closure. Any data captured by the closure is *moved* to the capturing thread.  
The thread's **handle** can be used to wait for completion and retieve the computation result or errors if any.

```rs linenums="1"
// if no data is captured the move keyword can be removed
let handle = std::thread::spawn(move || { /* ... */ });

handle.join().unwrap();
```

> **Note**: a thread's execution can be termiated early if it's not joined and the main process terminates before the thread had completed it's work.  
> **Note**: if a thread panics the handle will return the panic message so that it can be handled.

### Channels

To accomplish message-sending concurrently Rust's standard library provides an implementation of *channels*.  
A **channel** is a general programming concept by which data is sent from one thread to another.

```rs linenums="1"
let (sender, receiver) = std::sync::mpsc::channel();  // the sender can be cloned to create multiple transmitters

let sender_1 = sender.clone();
std::thread::spawn(move || {
    // send takes ownership of the message (moved to receiver scope)
    sender_1.send("hello".to_owned()).unwrap();
});

let sender_2 = sender.clone();
std::thread::spawn(move || {
    sender_2.send("hello".to_owned()).unwrap();
    sender_2.send("world".to_owned()).unwrap();
    sender_2.send("from".to_owned()).unwrap();
    sender_2.send("thread".to_owned()).unwrap();
});

let message = receiver.recv().unwrap();  // receive a single value
// or
for message in receiver { } // receive multiple values (iteration stops when channel closes)
```

### `Send` & `Sync`

The `Send` marker trait indicates that ownership of values of the type implementing `Send` can be transferred between threads. Any type composed entirely of `Send` types is automatically marked as `Send`.  Almost all primitive types are `Send`, aside from raw pointers.

The `Sync` marker trait indicates that it is safe for the type implementing `Sync` to be referenced from multiple threads. In other words, any type `T` is `Sync` if `&T` (an immutable reference to `T`) is `Send`, meaning the reference can be sent safely to another thread. Similar to `Send`, primitive types are `Sync`, and types composed entirely of types that are `Sync`are also `Sync`.

## Files

### Reading Files

```rs linenums="1"
use std::fs;

let contents: Vec<u8> = fs::read("path/to/file").unwrap_or_default();
let contents: String = fs::read_to_string("path/to/file").unwrap_or_default();

contents.lines(); // iterator over text lines
```

### Writing Files

```rs linenums="1"
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

```rs linenums="1"
#[link(name = "my_c_library")]
extern "C" {
    fn my_c_function(x: i32) -> bool;
}
```

This code would attempt to link with `libmy_c_library.so` on unix-like systems and `my_c_library.dll` on Windows at runtime, and panic if it can't find something to link to.  
Rust code could then use my_c_function as if it were any other unsafe Rust function.  
Working with non-Rust languages and FFI is inherently unsafe, so wrappers are usually built around C APIs.

The mirror use case of FFI is also done via the extern keyword:

```rs linenums="1"
#[no_mangle]
pub extern "C" fn callable_from_c(x: i32) -> bool {
    x % 3 == 0
}
```

If compiled as a dylib, the resulting `.so` could then be linked to from a C library, and the function could be used as if it was from any other library
