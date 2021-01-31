# Swift / SwiftUI

- Statically Typed

[Building for Mac with VBox](https://medium.com/@twister.mr/installing-macos-to-virtualbox-1fcc5cf22801)

## Basics

### Macro

```swift
#if DEBUG

// contents compilde only if in DEBUG build

#endif
```

### Comments

```swift
// single line comment

/*  
multi line comment
*/
```

### Variables

```swift
var variable = value  // implicit variable init (auto-determine type)
var variable: Type = value  // explicit variable init
var variable: Type? = value  // explicit nullable variable init
```

### Constants

```swift
let CONSTANT = value  // constant init (value can be assigned at runtime)
```

### Console Output

```swift
print()  // empty line
print(variable)
print("string")
```

## Strings

```swift
var string "Text: \(<expr>)"  // string interpolation
var string = "Hello" + "There"  // string concatenation

var multilineString = """Use double quotes trice
to make a string span multiple lines"""
```

## Array

```swift
var array = ["firstItem", "secondItem", ...]
var array = [Type()]  // init empty homogeneous array

array[index]  // value acces
array[index] = value  // value update

array.append(item)  // add item to the end
array.contains(item)  // membership check
array.sort()  // in place sort


// Heterogeneous Array
var list: Any = ["string", 47, ...]  // cannot access with [index]
var list: Any = []  // init empty heterogeneous array
```

## Tuple

A **tuple** type is a comma-separated list of types, enclosed in parentheses.

It's possible to use a tuple type as the return type of a function to enable the function to return a single tuple containing multiple values.
It's possible to name the elements of a tuple type and use those names to refer to the values of the individual elements.
An element name consists of an identifier followed immediately by a colon (:).

```swift
var tuple: (Type, Type) = (value, value)  // explicit type
var tuple = (value, value)  // implicit type
tuple.0  // item access

// named elements
var tuple = (name1: value1, name2: value2, ...)  // tuple init
tuple = (value1, value2)  // names are inferred
tuple.name1  // item access
```

### Tuple Decomposition

```swift
var tuple = (value1, value2)
var (var1, var2) = tuple  // var1 = value1, var2 = value2
```

## Type Identifier

```swift
typealis Point = (Int, Int)
var origin: (0, 0)
```

## Dictionary

```swift
var dict = [
    "key": "value",
    ...
]

var dict = [Type: Type]()  // init empty dict

dict[key]  // value access
dict[key] = value // value update
```

## Expressions & Operators

### Primary Expressions

| Syntax              | Operation                                                           |
|---------------------|---------------------------------------------------------------------|
| x`.`m               | accest to member `m` of object `x` ("." --> member access operator) |
| x`(...)`            | method invocation ("()" --> method invocation operator)             |
| x`[...]`            | array access and indicizarion                                       |
| `new` T(...)        | object instantiation                                                |
| `x!`                | declare x as not nil                                                |

### Unary Operators

| Operator  | Operation       |
| --------- | --------------- |
| `+`x      | identity        |
| `-`x      | negation        |
| `!`x      | logic negation  |
| `~`x      | binary negation |
| `++`x     | pre-increment   |
| `--`x     | pre-decrement   |
| x`++`     | post-increment  |
| x`--`     | post decrement  |
| `(type)`x | explict casting |

### Methematical Operators

| Operator | Operation                                             |
| -------- | ----------------------------------------------------- |
| x `+` y  | addition, string concatenation                        |
| x `-` y  | subtraction                                           |
| x `*` y  | multiplication                                        |
| x `/` y  | integer division, **always** returns an `int`         |
| x `%` y  | modulo, remainder                                     |
| x `<<` y | left bit shift                                        |
| x `>>` y | rigth bit shift                                       |

### Relational Operators

| Operator | Operation                              |
|----------|----------------------------------------|
| x `<=` y | less or equal to                       |
| x `>` y  | greater than                           |
| x `>=` y | greater or equal to                    |
| x `is` T | `true` if `x` is an object of type `T` |
| x `==` y | equality                               |
| `!`x     | inequality                             |

### Logical Operators

| Operator     | Operation                                             | Name             |
|--------------|-------------------------------------------------------|------------------|
| `~`x         | bitwise NOT                                           |
| x `&` y      | bitwise AND                                           |
| x `^` y      | bitwise XOR                                           |
| x `|` y      | bitwise OR                                            |
| x `&&` y     | evaluate `y` only if `x` is `true`                    |
| x `||` y     | evaluate `y` only if `x` is `false`                   |
| x `??` y     | evaluates to `y` only if `x` is `nil`, `x` otherwise  | nil coalescing  |
| x`?.`y       | stop if `x == nil`, evaluate `x.y` otherwise          | nil conditional |

### Assignement

| Operator  | Operation              |
|-----------|------------------------|
| x `+=` y  | x = x + y              |
| x `-=` y  | x = x - y              |
| x `*=` y  | x = x * y              |
| x `/=` y  | x = x / y              |
| x `%=` y  | x = x % y              |
| x `<<=` y | x = x << y             |
| x `>>=` y | x = x >> y             |
| x `&=` y  | x = x & y              |
| x `|=` y  | x = x | y              |
| x `^=` y  | x = x ^ y              |
| x `??=` y | if (x == nil) {x = y} |

### Conditional Operator

`<condition> ? <return_if_condition_true> : <return_if_condition_false>;`

### Nil Checks

```swift
variable ?? value
// same as
if(variable == nil) { variable = value }
```

## If-Else

```swift
if condition {
    // code here
} else if condition {
    //code here
} else {
    // code here
}

if let var0 = var1 { /* statements */ }
// same as
let var0 = var1
if var0 != nil { /* statements */ }
```

### Switch

```swift
switch <value> {
    case <pattern/key>:
        // code here
        break  // can be implicit

    case key where <condition_on_key>:
        // code here
        break

    default:
        // code here
        break
}
```

## Loops

### For Loop

```swift
// range based for
for i in start...end { /* statements */ }  // end included
for i in start..<end { /* statements */ }  // end excluded
for _ in start...end

for item in sequence {
    // code here
}

for (key, value) in dict {
    // code here
}
```

### While Loop

```swift
while condition {
    // code here
}

// "do"..while
repeat {
    // code here
} while condition
```

## Functions

```swift
// "void function"
func funcName(param: Type, ...) {
    // code here
}

func funcName(param: Type = dafaultValue, ...) -> Type {
    //code here
    return <expression>
}

func funcName(param: Type) -> Type {
    <expression>  // implicit return
}

// func call MUST have parameter's names
funcName(param: value, ...)

// multiple return values
func funcMultipleParameters(param: Type) -> (retVal1: Type, retVal2: Type) {
    //code here

    return (<expression>, <expression>)
}

var result = funcMultipleReturns(param: value)
result.retVal1  // acces to tuple components

// argument labels (only first label can be omitted)
func funcWithLabels(_ param: Type, label param: Type, ...) -> Type { }
funcWithLabels(value, label: value, ...)
```

### Passing Functions as Parameters

```swift
func f(param: Type) -> Type {}
func g(f: (Type) -> Type) {}  // (Type) -> Type are the passed func input and output types
```

### Functions Returniing Functions

```swift
func f() -> ((Type) -> Type) {
    func g(param: Type) -> type {}

    return g
}
```

## [Closure](https://docs.swift.org/swift-book/LanguageGuide/Closures.html) (`{ .. }`)

**Closures** are self-contained blocks of functionality that can be passed around and used in code.
Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

```swift
{ (parameters: Type) -> Type in
    // statements
}

{ parameters in return <expression> }  // type inference from context
{ $0 > $1 }  // $<n> identifies the n-th argument, IN can be omitted if closure has only the body
```

## [Enums](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)

### Enum Definition

```swift
enum EnumName {
    case key1
    case key2
    case ...
}

EnumName.key1 // key1
```

### Enum with Raw Values

```swift
enum EnumName: Type {
    case key1 = value
    case key2 = value
    case ...
}

EnumName.key1.rawValue  // value

enum IntegerEnum: Int {
    // the value of each case is one more then the previous case
    case one = 1
    case two, three, four
    case ...
}
```

### Matching Enumeration Values with a Switch Statement

```swift
enum Rank: Int {
    case ace = 1, two, three, four, five, six, seven, eigth, nine, ten
    case jack, queen, king

    func getValue() -> String {
        switch self {

        case .jack:
            return "jack"

        case .queen:
            return "queen"

        case .king:
            return "king"

        default:
            return String(self.rawValue)
        }
    }
}

Rank.jack.getValue() // "jack"
Rank.jack.rawValue // 11
```

## Struct (Value Type)

```swift
struct StructName {
    var attribute = value  // instance variable
    private var _attribute: Type  // backing field for property

    var property: Type {
        get { return _attribute }

        set { _attribute = newValue }  // newValue contains the passed value
        // OR
        set(param) { _attribute = param }
    }

    // constructor
    init(param: Type) {
        self.attribute = param  // attribute valorization
    }

    // deinitializer (free memory containing obj?)
    deinit {
        // empty the arrtibutes
    }

    // overloading
    func method() -> Type { }
    func method(param: Type, ...) -> Type { }
}

var structure = StructName()  // struct instantiation
```

## Classes (Reference Type)

### Class Definition & Instantiation

```swift
class ClassName {
    var attribute = value  // instance variable
    private var _attribute: Type  // backing field for property

    var property: Type {
        get { return _attribute }

        set { _attribute = newValue }  // newValue contains the passed value
        // OR
        set(param) { _attribute = param }
    }

    // constructor
    init(param: Type) {
        self.attribute = param  // attribute valorization
    }

    // deinitializer (free memory containing obj?)
    deinit {
        // empty the arrtibutes
    }

    // overloading
    func method() -> Type { }
    func method(param: Type, ...) -> Type { }
}

var obj = ClassName()  // obj instantiation
```

### Property Observers `willSet` & `didSet`

Do actions before/after modifing a property value.

**NOTE**: `willSet` and `didSet` do not *set* the value of the property.

```swift
class ClassName {

    var _attribute: Type

    var property {
        get { return _attribute }
        set{ _attribute = newValue }

        willSet {
            // act before setting the property value
        }

        didSet {
            // act after setting the propery value
        }
    }
}
```

### Inheritance

```swift
class Derived: SuperClass {

    var attribute: Type

    init(param1: Type, param2: Type) {
        self.attribute = param1
        super.init(param: param2 )  // superclass init (NEEDED)
    }

    // overriding
    override func method() {}
}
```

### Exception Handling

```swift
guard let variable = <expression>
else {
    /* statements */
    // throw or return to exit code branch
}


do {
    try <throwing expression>
} catch <pattern> {
    // statements
}
```
