# `C#`

**.NET** Core is a development platform that includes a **Common Language Runtime** (**CoreCLR**), which manages the execution of code, and a **Base Class Library** (**BCL**), which provides a rich library of classes to build applications from.

The C# compiler (named **Roslyn**) used by the dotnet CLI tool converts C# source code into **intermediate language** (**IL**) code and stores the IL in an _assembly_ (a DLL or EXE file).  
IL code statements are like assembly language instructions, which are executed by .NET Core's virtual machine, known as **CoreCLR**.

At runtime, CoreCLR loads the IL code from the assembly, the **just-in-time** (JIT) compiler compiles it into native CPU instructions, and then it is executed by the CPU on your machine.  
The benefit of this three-step compilation process is that Microsoft's able to create CLRs for Linux and macOS, as well as for Windows.  
The same IL code runs everywhere because of the second compilation process, which generates code for the native operating system and CPU instruction set.  
Regardless of which language the source code is written in, for example, C#, Visual Basic or F#, all .NET applications use IL code for their instructions stored in an assembly.

Another .NET initiative is called _.NET Native_. This compiles C# code to native CPU instructions **ahead of time** (**AoT**), rather than using the CLR to compile IL code JIT
to native code later.  
.NET Native improves execution speed and reduces the memory footprint for applications because the native code is generated at build time and then deployed instead of the IL code.

## Basics

### Comments

```cs
// comment
/* multi line comment */
/// single line xml comment (docstring)
/** multi line xml string (docstring) */
```

### Docstring Structure

`/** <tag> content </tag> **/`

### Naming Convention

| Element                  | Case       |
| ------------------------ | ---------- |
| Namespace                | PascalCase |
| Class, Interface         | PascalCase |
| Method                   | PascalCase |
| Field, Property          | PascalCase |
| Event, Enum, Enum Value, | PascalCase |
| Variables, Parameters    | camelCase  |

### Namespaces & Imports

Hierarchic organization of programs an libraries.

```cs
using System;  // import the System Namespace
using Alias = Namespace;  // set an alias for a specific namespace
using static System.Console;  // statically import a class to use its static methods w/o qualification

// global using [C# 10], should be in dedicated file
global using <namespace>;

namespace Namespace;  // [C# 10]
//or
namespace Namespace  // namespace declaration
{
    // class here
}
```

To enable .NET 6/C# 10 **implicit namespace imports**:

```xml
<ImplicitUsings>enable</ImplicitUsings>
```

### Top Level Statements/Programs (C# 9)

```cs
// imports

// code here, no main, no namespace
```

### Main Method

```cs
public static void Main(string[] args)
{
    // code here
}
```

### Constant Declaration

```cs
const type CONSTANT_NAME = value;
```

### Assignment Operation

`type variable1 = value1, variable2 = value2, ...;`

If a variable has not been assigned it assumes the `default` value.

### Input

```cs
// input is a string, convert before saving in a non String variable
Console.ReadLines();    // read util <Return>  is pressed
Console.Read();    // read until space

// reading non string input
<SystemType/Type>.Parse(Console.ReadLines());    // convert string to numerical data type (can cause exception at runtime)
Convert.To<SystemType>(Console.ReadLines());    // proper conversion and round-up of values (no truncation of values), NULL returns 0 (zero)

// integers numeric base conversion
Convert.ToString(num, <base>);  //  to specified numeric base
Convert.ToInt32(string, <base>);  // parse from numeric base

Console.ReadKey();    // read a key from keyboard and display pressed kay immediately
```

### Screen Output

```cs
Console.WriteLine();    // single line output
```

### String Formatting

`{index[,alignment][:<formatString><num_decimal_digits>]}`

```cs
Console.WriteLine("Name is {0}, Marks are {1}", name, marks);    // string composite formatting
Console.WriteLine($"Name is {name}, Marks are {marks}");    // string interpolation

Console.WriteLine(
    format: "{0} {1}"  // format can be omitted and passed as first argument of WriteLine/Write
    arg0: "String Literal",
    arg1: string_variable,
    ...
);
```

### Number Format String

[Numeric Format Strings Docs](https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-numeric-format-strings)
[CultureInfo Docs](https://docs.microsoft.com/en-us/dotnet/api/system.globalization.cultureinfo)

`{index[,alignment][:<formatString><num_decimal_digits>]}`

`$"{number:C}"` formats the number as a _currency_. Currency symbol & symbol position are determined by `CultureInfo`.  
`$"{number:D}"` formats the number with decimal digits.  
`$"{number:F}"` formats the number with a fixed number of decimal digits.  
`$"{number:E}"` formats the number in _scientific notation_.  
`$"{number:E}"` formats the number in the more compact of either fixed-point or scientific notation.  
`$"{number:N}"` formats the number as a _measure_. Digits separators are determined by `CultureInfo`.  
`$"{number:P}"` formats the number as a _percentage_.  
`$"{number:X}"` formats the number as a _hexadecimal_.

## Variable Types

### Value Type

A value type variable will store its values directly in an area of storage called the _STACK_.  
The stack is memory allocated to the code that is currently running on the CPU.  
When the stack frame has finished executing, the values in the stack are removed.

### Reference Type

A reference type variable will store its values in a separate memory region called the _HEAP_.  
The heap is a memory area that is shared across many applications running on the operating system at the same time.  
The .NET Runtime communicates with the operating system to determine what memory addresses are available, and requests an address where it can store the value.  
The .NET Runtime stores the value, then returns the memory address to the variable.  
When your code uses the variable, the .NET Runtime seamlessly looks up the address stored in the variable and retrieves the value that's stored there.

### Integral Numeric Types

| Keyword  |   System Type    | Example | Bit/Byte | Min Value                  | Max Value                  |
| :------: | :--------------: | :-----: | :------: | -------------------------- | -------------------------- |
| `sbyte`  |  `System.SByte`  |         |  8 bit   | -128                       | 127                        |
|  `byte`  |  `System.Byte`   |         |  8 bit   | 0                          | 255                        |
| `short`  |  `System.Int16`  |         |  16 bit  | -32'786                    | 32'767                     |
| `ushort` | `System.UInt16`  |         |  16 bit  | 0                          | 65'535                     |
|  `int`   |  `System.Int32`  |   123   |  32 bit  | -2'47'483'648              | 2'147'483'647              |
|  `uint`  | `System.UInt32`  |  123u   |  32 bit  | 0                          | 4'294'967'296              |
|  `nint`  | `System.IntPtr`  |         |   Arch   | 0                          | 18'446'744'073'709'551'615 |
| `nuint`  | `System.UIntPtr` |         |   Arch   | -9'223'372'036'854'775'808 | 9'223'372'036'854'775'807  |
|  `long`  |  `System.Int64`  |  123l   |  64 bit  | -9'223'372'036'854'775'808 | 9'223'372'036'854'775'807  |
| `ulong`  | `System.UInt64`  |  123ul  |  64 bit  | 0                          | 18'446'744'073'709'551'615 |

### Floating-Point Numeric Types

|  Keyword  |   System Types   | Example | Bit/Byte | Digits | Min Value                               | Max Value                              |
| :-------: | :--------------: | :-----: | :------: | :----: | --------------------------------------- | -------------------------------------- |
|  `float`  | `System.Single`  |  3.14f  |  4 byte  |  6-9   | -3.402823 E+38                          | 3.402823 E+38                          |
| `double`  | `System.Double`  |  3.14   |  8 byte  | 15-17  | -1.79769313486232 E+308                 | 1.79769313486232 E+308                 |
| `decimal` | `System.Decimal` |  3.14m  | 16 byte  | 28-29  | -79'228'162'514'264'337'593'543'950'335 | 79'228'162'514'264'337'593'543'950'335 |

The static fields and methods of the `MathF` class correspond to those of the `Math` class, except that their parameters are of type `Single` rather than `Double`, and they return `Single` rather than `Double` values.

### BigInteger

`BigInteger` represents an integer that will grow as large as is necessary to accommodate values.  
Unlike the builtin numeric types, it has no theoretical limit on its range.

```cs
using System;
using System.Numerics;

BigInteger bi;
```

### Binary & Hexadecimal Numbers

Binary literal: `0b<digits>`
Hexadecimal literal: `0x<digits>`

```cs
// three variables that store the number 2 million
int decimalNotation = 2_000_000;
int binaryNotation = 0b_0001_1110_1000_0100_1000_0000;
int hexadecimalNotation = 0x_001E_8480;
```

### Boolean Type (`System.Boolean`)

`bool`: `true` or `false`

### Text Type (`System.Char` & `System.String`)

`char`: single unicode character  
`string`: multiple Unicode characters

### Implicit Type

The compiler determines the required type based on the assigned value.

```cs
var variable = value;  // Inferred tipe cant change after first assignment
```

### Dynamic Type

```cs
dynamic variable = value;
```

### Anonymous types (Reference Type)

```cs
// cannot be used as return types
var x = new { Key = value, ...};  // read only properties
x.Key;  // member access

var y = x with { Key = value };  // with expression [C# 10]
```

### Index & Range Types (Structs)

[System.Index][index_type]: Represents a type that can be used to index a collection either from the start or the end.  
[System.Range][range_type]: Represents a range that has start and end indexes.

[index_type]: https://docs.microsoft.com/en-us/dotnet/api/system.index
[range_type]: https://docs.microsoft.com/en-us/dotnet/api/system.range

```cs
Index i = position;
Index i = new Index(position, IsFromEnd: false);  // start-relative index

Index e = ^position;  // end-elative index
Index e = new Index(position, IsFromEnd: true);  // end-elative index
array[^n];  // n-th last item
array[array.Length - n];  // n-th last item

// range syntax (supported by System.Range struct)
Range all = 0..^0;
Range all = 0..;
Range all = ..^0;
Range all = ..;
var all = Range.All;

// slicing
array[start..end];  // select elements between start index and end index (non inclusive)
array[start..^n];  // select elements between start index and n-th last item (non inclusive)
```

## Tuples (Value Type)

Tuples are designed as a convenient way to package together a few values in cases where defining a whole new type wouldn't really be justified.

Tuples support comparison, so it's possible to use the `==` and `!=` relational operators.  
To be considered equal, two tuples must have the same shape and each value in the first tuple must be equal to its counterpart in the second tuple.

```cs
(Type Var1, Type Var2, ...) variable = (value1, value2, ...);
var variable = (Var1: value1, Var2: value2, ...);  // if name are not supplied they default to Item1, Item2, ...
var variable = (var1, var2);  // constructed w/ pre-existing values, tuple attributes named after the variables
```

Since the names of the attributes of a tuple do not matter (a tuple is an instance of `ValueTuple<Type, Type, ...>`) it's possible to assign any tuple to another tuple with the same structure.

```cs
(int X, Int Y) a = (1 , 0);
(int Width, int Height) b = a;
```

### Tuple Deconstruction

```cs
(int X, int Y) point = (10, 35);
(int a, int b) = point;  // extract data based on position into two variables
```

## Records

I'ts possible to create record types with immutable properties by using standard property syntax or positional parameters:

```cs
public record Person
{
    public string FirstName { get; init; } = default!;
    public string LastName { get; init; } = default!;
};
// same as
public record Person(string FirstName, string LastName);

public record struct Point
{
    public double X {  get; init; }
    public double Y {  get; init; }
    public double Z {  get; init; }
}
// same as
public readonly record struct Point(double X, double Y, double Z);
```

it's also possible to create record types with mutable properties and fields:

```cs
// mutable record
public record Person
{
    public string FirstName { get; set; } = default!;
    public string LastName { get; set; } = default!;
};

// mutable record struct
public readonly record struct Point(double X, double Y, double Z);
```

While records can be mutable, they're primarily intended for supporting immutable data models. The record type offers the following features:

- Concise syntax for creating a reference type with immutable properties
- Built-in behavior useful for a data-centric reference type:
  - Value equality
  - Concise syntax for nondestructive mutation
  - Built-in formatting for display
- Support for inheritance hierarchies

> **Note**: A _positional record_ and a _positional readonly record struct_ declare init-only properties. A _positional record struct_ declares read-write properties.

### `with`-expressions

When working with immutable data, a common pattern is to create new values from existing ones to represent a new state.  
To help with this style of programming, records allow for a new kind of expression; the with-expression.

```cs
var newRecord = oldRecord with { Property = value };
```

With-expressions use object initializer syntax to state what's different in the new object from the old object. it's possible to specify multiple properties.  
A record implicitly defines a protected "copy constructor", a constructor that takes an existing record object and copies it field by field to the new one.  
The `with` expression causes the copy constructor to get called, and then applies the object initializer on top to change the properties accordingly.

```cs
protected Record(Record original) { /* copy all the fields */ } // generated
```

> **Note**: it's possible to define a custom copy constructor tha will be picked up by the `with` expression.

### `with`-expressions & Inheritance

Records have a hidden virtual method that is entrusted with "cloning" the whole object.  
Every derived record type overrides this method to call the copy constructor of that type, and the copy constructor of a derived record chains to the copy constructor of the base record.  
A with-expression simply calls the hidden "clone" method and applies the object initializer to the result.

```cs
public record Base{ Type Prop1, Type Prop2 };
public record Derived : Base { Type Prop3 };

Base @base  = new Derived { Prop1 = value1, Prop2 =  value2, Prop3 = value3 };
var newBase = @base with { Prop2 = value };  // new Derived record even if type of _base is Base since _base contains a Derived record
```

### Value-based Equality & Inheritance

Records have a virtual protected property called `EqualityContract`.  
Every derived record overrides it, and in order to compare equal, the two objects musts have the same `EqualityContract`.

```cs
public record Base{ Type Prop1, Type Prop2 };
public record Derived : Base { Type Prop3 };

Base rec1 = new Base { Prop1 = value1, Prop2 = value2 };
Base rec2 = new Derived { Prop1 = value1, Prop2 =  value2, Prop3 = value3 };
// will result not equal even if container is of same type
```

## Strings

.NET strings are _immutable_. The downside of immutability is that string processing can be inefficient.  
If a work performs a series of modifications to a string it will end up allocating a lot of memory, because it will return a separate string for each modification.  
This creates a lot of extra work for .NET's garbage collector, causing the program to use more CPU time than necessary.

In these situations, it's possible to can use a type called `StringBuilder`. This is conceptually similar to a string but it is modifiable.

```cs
"string contents here"    // string literal
@"string contents here"    // verbatim string, escape characters printed as-is (raw string literal)
$"{variable} contents here"    // string interpolation
$@"{variable} \n contents here"    // verbatim string interpolation
string stringa_1 = stringa_2 + "string contents here";    // string concatenation
String.Length    // returns the length of the string
```

### String Methods (Not In-Place)

```cs
string_.IndexOf(<character/string>, startIndex, endIndex);    // index of first occurrence of character/string, -1 otherwise
string_.LastIndexOf(<character/string>, startIndex, endIndex);    // index last occurrence of character/string, -1 otherwise
string_.IndexOfAny(char_array, startIndex, endIndex);    // index of any of the characters in the supplied array
string_.Substring(startIndex, length);    // extract substring
string_.Substring(startIndex);    // return every character after startIndex
string_.Replace(oldString, newString);    // returns string_ with oldString replaced with newString
string_.Insert(startIndex, substring);    // return string_ inserting substring at position startIndex
string_.Remove(startIndex, length);    // return string_ removing a substring of length length at position startIndex
string_.ToUpper();    // transforms all string in uppercase characters
string_.ToLower();    // transforms all string to lowercase characters
string_.Contains(target);    // returns True if string contains the target, False otherwise
string_.StartsWith(substring);    // Determines whether the start of the string matches the substring.
string_.EndsWith(substring);    // Determines whether the end of the string matches the substring.
string_.PadLeft(n, 'character');    // insert character n times as left padding. In-place operation
string_.PadRight(n, 'character');    // insert character n times as right padding. In-place operation
string_.TrimStart();    // trim leading spaces before text
string_.TrimEnd();    // trim following spaces after text
string_.Trim();    // trim spaces around text
string_.GetHashCode()
string_.Spit('<separator>');    // returns an array separating the string at the occurrences of <separator> (<separator> MUST BE char)

String.Join('<separator>', (object) iterable);    // returns a string from iterable. values separated by <separator> (<separator> MUST BE char)
String.Format($"{variable}"); // string interpolation outside of a Write/WriteLine

String.Empty;  // value of an empty string, used for string init
```

---

## Nullable Types

### [Nullable value types](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/nullable-value-types)

A **nullable value type** `T?` represents all values of its underlying value type `T` and an additional `null` value.

Any nullable value type is an instance of the generic `System.Nullable<T>` structure.  
Refer to a nullable value type with an underlying type `T` in any of the following interchangeable forms: `Nullable<T>` or `T?`.

**Note**: Nullable Value Types default to `null`.

When a nullable type is boxed, the common language runtime automatically boxes the underlying value of the `Nullable<T>` object, not the `Nullable<T>` object itself. That is, if the HasValue property is true, the contents of the `Value` property is boxed. When the underlying value of a nullable type is unboxed, the common language runtime creates a new `Nullable<T>` structure initialized to the underlying value.

If the `HasValue` property of a nullable type is `false`, the result of a boxing operation is `null`. Consequently, if a boxed nullable type is passed to a method that expects an object argument, that method must be prepared to handle the case where the argument is `null`. When `null` is unboxed into a nullable type, the common language runtime creates a new `Nullable<T>` structure and initializes its `HasValue` property to `false`.

```cs
Type? nullableValueType = default;  // assigns null

nullableValueType.HasValue  // boolean, use for null check
nullableValueType.Value  // underlying value type contents
```

### [Nullable reference types](https://docs.microsoft.com/en-us/dotnet/csharp/nullable-references)

C# 8.0 introduces nullable reference types and non-nullable reference types that enable to make important statements about the properties for reference type variables:

- **A reference isn't supposed to be null**. When variables aren't supposed to be null, the compiler enforces rules that ensure it's safe to dereference these variables without first checking that it isn't null:

  - The variable must be initialized to a non-null value.
  - The variable can never be assigned the value null.

- **A reference may be null**. When variables may be null, the compiler enforces different rules to ensure that you've correctly checked for a null reference:
  - The variable may only be dereferenced when the compiler can guarantee that the value isn't null.
  - These variables may be initialized with the default null value and may be assigned the value null in other code.

The `?` character appended to a reference type declares a nullable reference type.
The **null-forgiving operator** `!` may be appended to an expression to declare that the expression isn't null.
Any variable where the `?` isn't appended to the type name is a non-nullable reference type.

#### Nullability of types

Any reference type can have one of four _nullabilities_, which describes when warnings are generated:

- _Nonnullable_: Null can't be assigned to variables of this type. Variables of this type don't need to be null-checked before dereferencing.
- _Nullable_: Null can be assigned to variables of this type. Dereferencing variables of this type without first checking for null causes a warning.
- _Oblivious_: Oblivious is the pre-C# 8.0 state. Variables of this type can be dereferenced or assigned without warnings.
- _Unknown_: Unknown is generally for type parameters where constraints don't tell the compiler that the type must be nullable or nonnullable.

The nullability of a type in a variable declaration is controlled by the nullable context in which the variable is declared.

#### Nullable Context

Nullable contexts enable fine-grained control for how the compiler interprets reference type variables.

Valid settings are:

- _enable_: The nullable annotation context is _enabled_. The nullable warning context is _enabled_.
  Variables of a reference type are non-nullable, all nullability warnings are enabled.
- _warnings_: The nullable annotation context is _disabled_. The nullable warning context is _enabled_.
  Variables of a reference type are oblivious; all nullability warnings are enabled.
- _annotations_: The nullable annotation context is _enabled_. The nullable warning context is _disabled_.
  Variables of a reference type are non-nullable; all nullability warnings are disabled.
- _disable_: The nullable annotation context is _disabled_. The nullable warning context is _disabled_.
  Variables of a reference type are oblivious, just like earlier versions of C#; all nullability warnings are disabled.

In `Project.csproj`:

```xml
<Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>...</TargetFramework>

        <!-- set nullabilty context at project level -->
        <Nullable>enable | warning | annotations | disable</Nullable>
    </PropertyGroup>
</Project>
```

In `Program.cs`:

```cs
#nullable enable  // Sets the nullable annotation context and nullable warning context to enabled.
#nullable disable  // Sets the nullable annotation context and nullable warning context to disabled.
#nullable restore  // Restores the nullable annotation context and nullable warning context to the project settings.
#nullable disable warnings  // Set the nullable warning context to disabled.
#nullable enable warnings  // Set the nullable warning context to enabled.
#nullable restore warnings  // Restores the nullable warning context to the project settings.
#nullable disable annotations  // Set the nullable annotation context to disabled.
#nullable enable annotations  // Set the nullable annotation context to enabled.
#nullable restore annotations  // Restores the annotation warning context to the project settings.
```

### Null Conditional, Null Coalescing, Null Forgiving Operator, Null Checks

```cs
Type? variable = null;  // the variable can also contain the NULL value (nullable type)

<expr>!  // declare explicitly that the expression is not null (null forgiving operator)

(variable == null ? null : variable.property)
// same as
variable?.property  // if variable != null access it's property (null conditional), return null otherwise

if (variable != null)
{
    return variable;
}
else
{
    return value;
}
// same as
var variable = var ?? value  // return var if var != null, return value otherwise

variable = variable?.property ?? value  // if (variable == null) -> variable = value -- null coalescing
// same as
variable ??= value;  // if (variable == null) -> variable = value -- null coalescing

// null checks through patter matching
variable is null
variable is not null

// null parameter checking [C# 10]
ArgumentNullException.ThrowIfNull(obj);
```

### Nullable Attributes

It's possible to apply a number of attributes that provide information to the compiler about the semantics of APIs.
That information helps the compiler perform static analysis and determine when a variable is not null.

- `AllowNull`: A non-nullable input argument may be null.
- `DisallowNull`: A nullable input argument should never be null.
- `MaybeNull`: A non-nullable return value may be null.
- `NotNull`: A nullable return value will never be null.
- `MaybeNullWhen`: A non-nullable input argument may be null when the method returns the specified bool value.
- `NotNullWhen`: A nullable input argument will not be null when the method returns the specified bool value.
- `NotNullIfNotNull`: A return value isn't null if the argument for the specified parameter isn't null.
- `DoesNotReturn`: A method never returns. In other words, it always throws an exception.
- `DoesNotReturnIf`: This method never returns if the associated bool parameter has the specified value.

---

## Type Conversion

```cs
variable.GetType();  // System type of variable

(type) variable  // explicit conversion
numericalType.ToSting();     // convert numerical value to a string
numericalType variable = <SystemType/Type>.Parse();    // convert string to numerical data type (can cause exception at runtime)

<SystemType/Type>.TryParse(value, out variable);    // improved version of Parse()
/* attempts to parse a string into the given numeric data type.
If successful, it will store the converted value in an OUT PARAMETER.
It returns a bool to indicate if it was successful or not */

Convert.To<SystemType>(variable);    // proper conversion and round-up of values (no truncation of values)
```

### Converting from any type to a string

The `ToString` method converts the current value of any variable into a textual representation. Some types can't be sensibly represented as text, so they return their namespace and type name.

### Number Downcasting

The rule for rounding (in explicit casting) in C# is subtly different from the primary school rule:

- It always rounds _down_ if the decimal part is less than the midpoint `.5`.
- It always rounds _up_ if the decimal part is more than the midpoint `.5`.
- It will round _up_ if the decimal part is the midpoint `.5` and the non-decimal part is odd, but it will round _down_ if the non-decimal part is even.

This rule is known as **Banker's Rounding**, and it is preferred because it reduces bias by alternating when it rounds up or down.

### Converting from a binary object to a string

The safest thing to do is to convert the binary object into a string of safe characters. Programmers call this **Base64 encoding**.  
The `Convert` type has a pair of methods, `ToBase64String` and `FromBase64String`, that perform this conversion.

### Parsing from strings to numbers or dates and times

The second most common conversion is from strings to numbers or date and time values.  
The opposite of `ToString` is `Parse`. Only a few types have a `Parse` method, including all the number types and `DateTime`.

---

## Preprocessor Directives

C# offers a `#define` directive that lets you define a compilation symbol.  
These symbols are commonly used in conjunction with the `#if` directive to compile code in different ways for different situations.  
It's common to define compilation symbols through the _compiler build settings_: open up the `.csproj` file and define the values you want in a `<DefineConstants>` element of any `<PropertyGroup>`.

Compilation symbols are typically used in conjunction with the `#if`, `#else`, `#elif`, and `#endif` directives (`#if false` also exists).

The _.NET SDK_ defines certain symbols by default. It supports two configurations: **Debug** and **Release**.  
It defines a `DEBUG` compilation symbol in the Debug configuration, whereas Release will define `RELEASE` instead.  
It defines a symbol called `TRACE` in both configurations.

```cs
#if DEBUG
    // instructions
#endif
```

C# provides a more subtle mechanism to support this sort of thing, called a _conditional method_.  
The compiler recognizes an attribute defined by the .NET class libraries, called `ConditionalAttribute`, for which it provides special compile time behavior.  
Method annotated with this attribute will not be present in a non-Debug release.

```cs
[System.Diagnostics.Conditional("DEBUG")]
Type Method() { ... }
```

### `#error` and `#warning`

C# allows choose to generate _compiler errors_ or warnings with the `#error` and `#warning` directives. These are typically used inside conditional regions.

```cs
#if NETSTANDARD
    #error .NET Standard is not a supported target for this source file
#endif
```

### `#pragma`

The `#pragma` directive provides two features: it can be used to disable selected compiler warnings, and it can also be used to override the checksum values the compiler puts into the `.pdb` file it generates containing debug information.  
Both of these are designed primarily for code generation scenarios, although they can occasionally be useful to disable warnings in ordinary code.

```cs
#pragma warning disable CS<number>
```

---

## Expressions & Operators

### Primary Expressions

| Syntax              | Operation                                                           |
| ------------------- | ------------------------------------------------------------------- |
| x`.`m               | access to member `m` of object `x` ("." --> member access operator) |
| x`(...)`            | method invocation ("()" --> method invocation operator)             |
| x`[...]`            | array access                                                        |
| `new` T(...)        | object instantiation                                                |
| `new` T(...)`{...}` | object instantiation with initial values                            |
| `new` T[...]        | array creation                                                      |
| `typeof(T)`         | System.Type of object x                                             |
| `nameof(x)`         | name of variable x                                                  |
| `sizeof(x)`         | size of variable x                                                  |
| `default(T)`        | default value of `T`                                                |
| `x!`                | declare x as not null                                               |

### Unary Operators

| Operator  | Operation        |
| --------- | ---------------- |
| `+`x      | identity         |
| `-`x      | negation         |
| `!`x      | logic negation   |
| `~`x      | binary negation  |
| `++`x     | pre-increment    |
| `--`x     | pre-decrement    |
| x`++`     | post-increment   |
| x`--`     | post decrement   |
| `(type)`x | explicit casting |

### Mathematical Operators

| Operator | Operation                      |
| -------- | ------------------------------ |
| x `+` y  | addition, string concatenation |
| x `-` y  | subtraction                    |
| x `*` y  | multiplication                 |
| x `/` y  | integer division,              |
| x `%` y  | modulo, remainder              |
| x `<<` y | left bit shift                 |
| x `>>` y | right bit shift                |

### Relational Operators

| Operator | Operation                              |
| -------- | -------------------------------------- |
| x `<` y  | less than                              |
| x `<=` y | less or equal to                       |
| x `>` y  | greater than                           |
| x `>=` y | greater or equal to                    |
| x `is` T | `true` if `x` is an object of type `T` |
| x `==` y | equality                               |
| x `!=` y | inequality                             |

### Logical Operators

| Operator | Operation                                             | Name             |
| -------- | ----------------------------------------------------- | ---------------- |
| `~`x     | bitwise NOT                                           |                  |
| x `&` y  | bitwise AND                                           |                  |
| x `^` y  | bitwise XOR                                           |                  |
| x `|` y  | bitwise OR                                            |                  |
| x `&&` y | evaluate `y` only if `x` is `true`                    |                  |
| x `||` y | evaluate `y` only if `x` is `false`                   |                  |
| x `??` y | evaluates to `y` only if `x` is `null`, `x` otherwise | Null coalescing  |
| x`?.`y   | stop if `x == null`, evaluate `x.y` otherwise         | Null conditional |

### Assignment

| Operator  | Operation              |
| --------- | ---------------------- |
| x `+=` y  | x = x + y              |
| x `-=` y  | x = x - y              |
| x `*=` y  | x = x \* y             |
| x `/=` y  | x = x / y              |
| x `%=` y  | x = x % y              |
| x `<<=` y | x = x << y             |
| x `>>=` y | x = x >> y             |
| x `&=` y  | x = x & y              |
| x `|=` y  | x = x | y              |
| x `^=` y  | x = x ^ y              |
| x `??=` y | if (x == null) {x = y} |

### Conditional Operator

`<condition> ? <return_if_condition_true> : <return_if_condition_false>;`

## Decision Statements

### `If`-`Else If`-`Else`

```cs
Object o;

if (condition)
{
    // code here
}
else if (o is Type t)  // test variable to determine if matches a type
{
    // t gets the value of o if the test succeeds
}
else
{
    // code here
}
```

### Pattern Matching

[Pattern Matching](https://docs.microsoft.com/en-us/dotnet/csharp/pattern-matching)

A pattern describes one or more criteria that a value can be tested against. It's usable in switch statements, switch expressions and if statements.

```cs
<expr> is Type t  // type pattern
<expr> is (Type X, Type Y):  // positional pattern
<expr> is (Type X, _):  // positional pattern + discard pattern
<expr> is Type {Property: value}:  // property patten (check Type and that the property has a certain value)
<expr> is Type {Property: value} p:  // property patten with output (variable p is usable in the block)

// constant pattern
<expr> is literalValue  // e.g. 1, 'c', "literal"
<expr> is CONSTANT
<expr> is Enum.Value

// C# 9+
<expr> is pattern and pattern
<expr> is pattern or pattern
<expr> is not pattern
<expr> is { Property: > value }  // works with all comparison operators
<expr> is > value  // works with all comparison operators

// C# 10+
<expr> is { Property.InnerProperty: value }  // match in nested properties
```

### Switch

The `when` keyword can be used to specify a filter condition that causes its associated case label to be true only if the filter condition is also true.

[Switch Expressions](https://dotnetcoretutorials.com/2019/06/25/switch-expressions-in-c-8/)

```cs
switch (expr)
{
    // multiple labels for same block
    case key_0:
    case key_1:
        // code here
        break;  // or return or goto

    case key_2:
        // code here
        goto case key_2;  // explicit fall-through (omitting break is not possible in c#)

    case key_3 when (when-condition):
        // code here
        break;

    // cases using pattern matching

    default:
        // code here
        break;
}

// return a value based on the value of an input variable or tuple
variable switch
{
    key_1 => value,
    key_2 => value,
    // cases using pattern matching
    ...
    _ => default_value  // underscore (_) discard pattern as default case
};
```

## Loop Statements

### `While` Loop

```cs
while (condition)
{
    // code here
}
```

## `Do`-`While` Loop

Executes at least one time.

```cs
do
{
    // code here
}
while (condition);
```

### `For` Loop

```cs
for (initializer; condition; iterator)
{
    // code here
}
```

### `Foreach` Loop

Technically, the `foreach` statement will work on any type that follows these rules:

1. The type must have a method named `GetEnumerator` that returns an object.
2. The returned object must have a property named `Current` and a method named `MoveNext`.
3. The `MoveNext` method must return _true_ if there are more items to enumerate through or _false_ if there are no more items.

There are interfaces named `IEnumerable` and `IEnumerable<T>` that formally define these rules but technically the compiler does not require the type to implement these interfaces.

```cs
foreach (type item in iterabile)
{
    // code here
}
```

> **Note**: Due to the use of an _iterator_, the variable declared in a foreach statement cannot be used to modify the value of the current item.  
> **Note**: From C# 9 it's possible to implement `GetEnumerator()` as an _extension method_ making enumerable an class that normally isn't.

Example:

```cs
// make integers enumerable
public static IEnumerator<int> GetEnumerator(this int source)
{
    for(int i = 0; i < number; i++)
    {
        yield return i;
    }
}
```

### `Break`, `Continue`

`break;` interrupts and exits the loop.  
`continue;` restarts the loop cycle without evaluating the instructions.

### Yield Statement

```cs
yield return <expression>;    // returns the results one at a time.
yield break;    // concludes the iteration
```

### Context Statement & Using Declarations

```cs
using (Type obj = new Type())  // obj disposed at the end of the using block
{
    // code here
}

// or (C# 8+)
{
    // inside a code block (if, loop, function)
    using Type obj = new Type();  // disposed at the end of the block

}
```

### `Checked`/`Unchecked` Statements

In checked code block ore expression the mathematic overflow causes an `OverflowException`.  
In unchecked code block the mathematic overflow is _ignored_ end the result is _truncated_.

It's possible configure the C# compiler to put everything into a checked context by default, so that only explicitly unchecked expressions and statements will be able to overflow silently.  
It is done by editing the `.csproj` file, adding `<CheckForOverflowUnderflow>true</CheckForOverflowUnderflow>` inside a `<PropertyGroup>`.

> **Note**: checking can make individual integer operations several times slower.

```cs
checked
{
    // code here
}

checked(<expr>);

unchecked
{
    // code here
}

unchecked(<expr>);
```

---

## Exception Handling

[Exception Object](https://docs.microsoft.com/en-us/dotnet/api/system.exception)

```cs
try
{
    // "dangerous" code
}
catch (SpecificException e)
{
}
catch (SpecificException e) when (condition)  // exception filter
{
}
catch (Exception e)
{
    // code executed if Exception happens
    e.Message  // exception message
    e.InnerException  // Exception instance that caused the current exception
    e.Source  // Get or set the name of the application or the object that causes the error
}
finally
{
    // code executed anyway
}
```

### Throwing Exceptions

```cs
throw new ExceptionClass();
throw new ExceptionClass("message");

// RE-THROWING EXCEPTIONS
try
{
    // dangerous code
}
catch (SpecificException e)
{
    // log error
    throw;  // rethrow exception w/o loosing StackTrace & TargetSite information (usable only inside catch)
}

// Immediately terminate a process after writing a message to the Windows Application event log, and then include the message and optional exception information in error reporting to Microsoft.
Environment.FailFast(causeOfFailure);
```

### Custom Exceptions

```cs
public class CustomException : Exception  // must derive from Exception (either directly or indirectly)
{
    public CustomException()
    {
    }

    public CustomException(string message)
        : base(message)
    {
    }

    public CustomException(string message, Exception inner)
        : base(message, inner)
    {
    }
}
```

---

## Enums

An enumeration type (or enum type) is a value type defined by a set of **named constants** of the underlying _integral numeric_ type (`int`, `long`, `byte`, ...).  
Consecutive names increase the value by one.

```cs
[Flags]  // indicate that the flag can be combined (best if values are binary) as a bit mask
enum EnumType : IntegralNumericType // named values MUST match IntegerNumericType allowed values
{
    None = 0,            // if uninitiated value is zero
    Const = 2,     // value is 2
    Const2,          // value is Const + 1
    ...
}

(Type) EnumType.Const;  // extract the value, will return the name otherwise
(EnumType) value;  // convert from associated value to enum

Enum.IsDefined(typeof(EnumType), value);  // whether a given integral value, or its name as a string, exists in a specified enumeration.
enumObj.HasValue(enumType.Const)  // test whether a flag is set in a numeric value

EnumType instance = (EnumType) EnumType.ToObject(typeof(EnumType), value);  // convert a value of any integral type to an enumeration value

// Converts the string representation of the name or numeric value of one or more enumerated constants to an equivalent enumerated object
Enum.Parse(typeof(EnumType), value);
Enum.TryParse<EnumType>(string, out EnumType enumObj);

// retrieve a string array containing the names of the enumeration members
string[] enumNames = Enum.GetNames(typeof(EnumType));
```

---

## Methods

The method signature is the number & type of the input parameters defined for the method.

C# makes the fairly common distinction between _parameters_ and _arguments_: a method defines a list of the inputs it expects (the parameters) and the code inside the method refers to these parameters by name.  
The values seen by the code could be different each time the method is invoked, and the term argument refers to the specific value supplied for a parameter in a particular invocation.

```cs
type MethodName (type parameter, ...)
{
    // code here
    return <expression>;
}

void MethodName (type parameter, ...) {
    // code here
    return;  // if type is void return can be used to force early termination or can be omitted
}
```

### Expression Body Definition

```cs
type MethodName() => <expression>;    // expression result type MUST match method type
```

### Arbitrary Number Of Parameter In Methods

```cs
// params keyword must be last parameter and must be an array
type MethodName (type parameter, params type[] args)
{
    // code here
}
```

### [Named Arguments](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/named-and-optional-arguments#named-arguments)

```cs
type MethodName (type param1, type param2, ...) { }

MethodName(param1: value, param2: value);
MethodName(param2: value, param1: value);  // order can be any

// Named arguments, when used with positional arguments, are valid as long as they're not followed by any positional arguments, or they're used in the correct position.
MethodName(value, param2: value);
```

### [Optional Arguments](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/named-and-optional-arguments#optional-arguments)

The definition of a method, constructor, indexer, or delegate can specify that its parameters are required or that they are optional.  
Any call must provide arguments for all required parameters, but can omit arguments for optional parameters.

Each optional parameter has a default value as part of its definition. If no argument is sent for that parameter, the default value is used.  
Optional parameters are defined at the end of the parameter list, after any required parameters.

A default value must be one of the following types of expressions:

- a constant expression;
- an expression of the form new ValType(), where ValType is a value type, such as an enum or a struct;
- an expression of the form default(ValType), where ValType is a value type.

```cs
type MethodName (type required, type firstOptional = default_value, type secondOptional = default_value, ...) { }
MethodName(value1);  // use defaults for optional arguments
MethodName(required: value, secondOptional: value);  // use default for first optional but pass second optional
```

> **Note**: If the caller provides an argument for any one of a succession of optional parameters, it must provide arguments for all preceding optional parameters. Comma-separated gaps in the argument list are not supported.

### Passing Values By Reference (`ref`, `out`, `in`)

[Ref Docs][ref], [Out Docs][out], [In Docs][in]

[in]: https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/in-parameter-modifier
[ref]: https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/ref
[out]: https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/out-parameter-modifier

The `out`, `in`, `ref` keywords cause arguments to be _passed by reference_. It makes the _formal parameter_ an alias for the argument, which must be a variable.  
In other words, any operation on the parameter is made _on the argument_. This behaviour is the same for classes and structs.

An argument that is passed to a `ref` or `in` parameter **must be initialized** before it is passed. However `in` arguments _cannot be modified_ by the called method.  
Variables passed as `out` arguments do not have to be initialized before being passed in a method call. However, the called method is **required to assign a value** before the method returns.

Use cases:

- `out`: return multiple values from a method (move data into method)
- `ref`: move data bidirectionally between method and call scope
- `in`: pass large value type (e,g, struct) as a reference avoiding copying large amounts of data (must be readonly, copied regardless otherwise)

> **Note**: use `in` only with readonly value types, because mutable value types can undo the performance benefits. (Mutable value types are typically a bad idea in any case.)

While the method can use members of the passed reference type, it can't normally replace it with a different object.  
But if a reference type argument is marked with ref, the method has access to the variable, so it could replace it with a reference to a completely different object.

```cs
// method declaration
type MethodName (type param1,  ref type param2, out type param3, in type param4, ...)
{
    // code here
}

// method call needs REF & OUT keywords, IN keyword is optional (pass by reference regardless)
MethodName(arg1, ref arg2, out arg3, in arg4);
MethodName(arg1, ref arg2, out arg3, arg4);

type OutMethod(type param1, out type param2){}
OutMethod(arg1, out var arg2);  // create out variable on the fly
```

### Returning Multiple Values with Tuples

**Must** be C# 7+.  
The retuned tuple MUST match the tuple-type in the instantiation

```cs
(type returnedVar1, type returnedVar2, ...) MethodName (type parameter, ...)
{
   // code here
   return (expression, expression, ...)
}
```

### Returning Multiple Values W/ Structs (Return Struct Variable)

```cs
StructName MethodName (args)
{
   // code here
   var variable = new StructName     {
       // code here
   }

   return variable;
}
```

### Local Functions

```cs
type OuterMethod(...)
{
    var foo = InnerMethod();

    type InnerMethod(...) { }
}
```

### Extension Methods

Extension methods allow their usage applied to the extended type as if their declaration was inside the object's class.  
Extension methods are not really members of the class for which they are defined.  
It's just an illusion maintained by the C# compiler, one that it keeps up even in situations where method invocation happens implicitly.

> **Note**: Extension Method can be declared only inside static classes. Extension methods are available only if their namespace is imported with the `using` keyword.

```cs
public static class ExtensionMethods
{
    type ExtensionMethod(this type param)
    {
        // code here
    }
}

type var = value;
var.ExtensionMethod();  // use the method on a object as if the method belongs to the object
```

---

## [Iterators](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/iterators)

An iterator can be used to step through collections such as lists and arrays.

An iterator method or `get` accessor performs a custom iteration over a collection. An iterator method uses the `yield return` statement to return each element one at a time.  
When a `yield return` statement is reached, the current location in code is remembered. Execution is restarted from that location the next time the iterator function is called.

It's possible to use a `yield break` statement or exception to end the iteration.

> **Note**: Since an iterator returns an `IEnumerable<T>` is can be used to implement a `GetEnumerator()`.

```cs
// simple iterator
public static System.Collections.IEnumerable<int> IterateRange(int start = 0, int end)
{
    for(int i = start; i < end; i++){
        yield return i;
    }
}
```

---

## Structs (Custom Value Types) & Classes (Custom Reference Types)

![reference-vs-value](../../img/dotnet_pass-by-reference-vs-pass-by-value-animation.gif)

**Structure** types have _value semantics_. That is, a variable of a structure type contains an _instance_ of the type.

**Class** types have _reference semantics_. That is, a variable of a class type contains a _reference to an instance_ of the type, not the instance itself.

Typically, you use structure types to design small data-centric types that provide little or no behavior. If you're focused on the behavior of a type, consider defining a class.  
Because structure types have value semantics, we recommend you to define immutable structure types.

Creating a new instance of a value type doesn't necessarily mean allocating more memory, whereas with reference types, a new instance means anew heap block.  
This is why it's OK for each operation performed with a value type to produce a new instance.

The most important question is : does the identity of an instance matter? In other words, is the distinction between one object and another object important?

An important and related question is: does an instance of the type contain state that changes over time?  
Modifiable value types tend to be problematic, because it's all too easy to end up working with some copy of a value, and not the correct instance.  
So it's usually a good idea for value types to be immutable. This doesn't mean that variables of these types cannot be modified;  
it just means that to modify the variable, its contents must be replaced entirely with a different value.

```cs
public struct Point
{
    public Point(double x, double y)
    {
        X = x;
        Y = y;
    }

    public double X { get; set; }
    public double Y { get; set; }

    public override string ToString() => $"({X}, {Y})";

}
```

> **Note**: From C# 10 is possible to have a parameterless constructor and make a new struct using a `with` statement.

The only way to affect a struct variable both inside a method and outside is to use the `ref` keyword;

### Modifiers (Methods & Variables)

A locally scoped variable is only accessible inside of the code block in which it's defined.  
If you attempt to access the variable outside of the code block, you'll get a compiler error.

[Access Modifiers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers)

```cs
// ACCESS MODIFIERS
public    // visible from everywhere
private    // not visible outside of the class (default for members)
protected    // visible only to the same class and extending classes
internal  // available for use only within the assembly (default for classes)
protected internal  // can be accessed by any code in the assembly in which it's declared, or from within a derived class in another assembly
private protected  // can be accessed only within its declaring assembly, by code in the same class or in a type that is derived from that class

readonly  // value can be read but not modified
static  // not of the instance of a class
sealed  // cannot be inherited or overridden (default case), sealing a virtual class/method prevents further modifications (on methods sealed must always be used with override)
abstract  // derived classes MUST implement this
virtual  // can be overridden by derived classes (applicable to Properties)
new  // hide base's (parent's) method

async  // method, lambda expression, or anonymous method is asynchronous
volatile // field might be modified by multiple threads that are executing at the same time
unsafe // unsafe context, required for any operation involving pointers
extern // method is implemented externally
```

`partial` indicates that other parts of the class, struct, or interface can be defined in the namespace.  
All the parts must use the partial keyword.  
All the parts must be available at compile time to form the final type.  
All the parts must have the same accessibility.

If any part is declared abstract, then the whole type is considered abstract.  
If any part is declared sealed, then the whole type is considered sealed.  
If any part declares a base type, then the whole type inherits that class.

### Class Declaration

A _field_ is a variable of any type that is declared directly in a class or struct. Fields are members of their containing type.  
A _property_ is a member that provides a flexible mechanism to read, write, or compute the value of a private field.

The `static` keyword declares that a member is not associated with any particular instance of the class.

```cs
class Class
{
    // if static contractor exists the initializer is runned immediately before the static constructor,
    // otherwise is will run no later than the first access to one on the type's fields or methods
    public static type Field = value;    // static (non-instance) public field  w/ initializer

    // runs before instance's constructor
    private type _field = value;    // private instance field w/ initializer

    private type _field;  // private instance field, initialized by constructor

    // static constructor, not called explicitly, has no arguments
    // triggered by one of two events, whichever occurs first: creating an instance, or accessing any static member of the class.
    // since it's static and takes no arguments there can be at most one for each class
    static Class() {
        // place to init static fields
    }

    public Class() { /* ... */}  // parameterless constructor

    // class constructor
    public Class(type parameter) {
        _field = parameter;
    }

    // extends an existing constructor adding parameters to the existing ones
    public Class(type anotherParameter, type parameter) : this(parameter)
    {
        this._anotherField = anotherParameter;
    }

    // called by Console.WriteLine(obj)
    public override string ToString(){
        return <string>
    }

    static type Method(arguments) {}    // static method, can operate on STATIC VARIABLES

    type Method(arguments) {}    // instance method, can ONLY operate on INSTANCE VARIABLES
}
```

### Properties

[Properties Docs](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties)

```cs
class Class
{
    private type _backingField;

    // PROPERTY
    public type Property
    {
        get { return _backingField }
        set { _backingField = value; }
    }

    // PROPERTY WITH EXPRESSION BODY DEFINITIONS
    public type Property
    {
        get => _backingField;
        set => _backingField = value;
    }

    // access backing field with the field keyword [C# 11?]
    public Type Property { get => field; set => field = value; }

    // required property [C# 11?], prop must be set at obj init (in constructor or initializer)
    public required Type Property { get; set; }

    // EXPRESSION-BODIED READ-ONLY PROPERTY
    public type Property => <expr>;

    // AUTO-PROPERTIES
    public Property { get; set; }
    public Property { get; private set; }  // settable only inside class
    public Property { get; init; } // settable only in constructor, initializer, keyword with
    public Property { get; }  // can only be setted by constructor

    // MIXED
    public type Property
    {
        get => _backingField;
        set => { ... }
    }

    Property = value;  // set
    Property;  // get
}
```

> **Note**: The `init` accessor is a variant of the `set` accessor which can only be called during object initialization.  
Because `init` accessors can only be called during initialization, they are allowed to _mutate_ `readonly` fields of the enclosing class, just like in a constructor.

> **Note**: creating at least one constructor hides the one provided by default (w/ zero parameters).

### [Object and Collection Initializers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/object-and-collection-initializers)

**Object initializers** allow to assign values to any accessible fields or properties of an object at creation time without having to invoke a constructor followed by lines of assignment statements.  
The object initializer syntax enables to specify arguments for a constructor or omit the arguments (and parentheses syntax).

```cs
public class Class
{
    // Auto-implemented properties.
    public Type Prop1 { get; set; }
    public Type Prop2 { get; set; }

    public Class()
    {
    }

    public Class(Type arg)
    {
        Prop1 = arg;
    }
}

// standard way
Class obj = new Class(arg1)
obj.Prop2 = arg2;

// known target type
Class obj = new(arg1, ...)

// object initializers
Class obj = new Class { Prop2 = arg2, Prop1 = arg1 };  // w/o constructor
Class obj = new Class(arg1) { Prop2 = arg2 };  // w/ constructor

// with keyword
var copy = original with { Prop = newValue };  // other props are copies of the original
```

```cs
public class Matrix
{
    private double[,] matrix = new double[3, 3];

    public double this[int row, int column]
    {
        // The embedded array will throw out of range exceptions as appropriate.
        get { return matrix[row, column]; }
        set { matrix[row, column] = value; }
    }
}

// collection initializer
var identity = new Matrix
{
    [0, 0] = 1.0,
    [0, 1] = 0.0,
    [0, 2] = 0.0,

    [1, 0] = 0.0,
    [1, 1] = 1.0,
    [1, 2] = 0.0,

    [2, 0] = 0.0,
    [2, 1] = 0.0,
    [2, 2] = 1.0,
};

List<int> digits = new List<int> { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
```

### `Static` Class

Static classes **can't** instantiate objects and all their methods **must** be static.

```cs
static class Class
{
    static type variable = value;

    static type method (type parameter, ...)
    {
    }
}
```

### Class Members Init Order

**Static Field or Method Usage**:

1. Static field initializers in order of apparition
2. Static Constructor

**Class Instantiation (`new` operator)**:

1. Instance field initializers in order of apparition
2. Instance Constructor

**Object Creation**: `Class object = new Class(arguments);`
**Instance Method Usage**: `object.method(arguments);`
**Static Method Usage**: `Class.method(arguments);`

### Indexers

An **indexer** is a property that takes one or more arguments, and is accessed with the same syntax as is used for arrays.  
This is useful when writing a class that contains a collection of objects.

```cs
public class Class<T>
{
    public T this[int i]
    {
        get => ...;  // return the i-th element in the collection
    }
}

// null conditional index access
Class? c = objWithIndexer?[index];
// same as
Class? c = objWithIndexer == null ? null : objWithIndexer[index];
```

### Abstract Classes

The `abstract` modifier indicates that the thing being modified has a missing or incomplete implementation.  
The `abstract` modifier can be used with classes, methods, properties, indexers, and events.  
Use the `abstract` modifier in a class declaration to indicate that a class is intended only to be a base class of other classes, not instantiated on its own.  
Members marked as `abstract` must be implemented by non-abstract classes that derive from the abstract class.

`abstract` classes have the following features:

- An `abstract` class cannot be instantiated.
- An `abstract` class may contain `abstract` methods and accessors.
- It is not possible to modify an `abstract` class with the `sealed` modifier because the two modifiers have opposite meanings.
  The `sealed` modifier prevents a class from being inherited and the `abstract` modifier requires a class to be inherited.
- A _non-abstract_ class derived from an `abstract` class must include actual implementations of all inherited `abstract` methods and accessors.

> **Note**: Use the `abstract` modifier in a method or property declaration to indicate that the method or property does not contain implementation.

`abstract` methods have the following features:

- An `abstract` method is implicitly a `virtual` method.
- `abstract` method declarations are only permitted in `abstract` classes.

- Because an `abstract` method declaration provides no actual implementation, there is no method body; the method declaration simply ends with a semicolon and there are no curly braces following the signature.
- The implementation is provided by a method _override_, which is a member of a non-abstract class.
- It is an error to use the `static` or `virtual` modifiers in an `abstract` method declaration.

`abstract` properties behave like `abstract` methods, except for the differences in declaration and invocation syntax.

- It is an error to use the `abstract` modifier on a `static` property.
- An `abstract` inherited property can be overridden in a derived class by including a property declaration that uses the `override` modifier.

```cs
public abstract class Abstract : Interface
{
    public abstract Type Property { get; set; }

    // interface methods can be mapped to abstract methods
    public abstract Type Method();
    public abstract override Type Method();  // force overriding (derived classes must provide new implementation)
}

public class Derived : Abstract
{
    public override Type Property
    {
        // new behaviour
        get => <expr>;
        set => <expr>;
    }

    public override Type Method() { /* statements */ }  // implementation of abstract method
}
```

### Cloning

```cs
Class obj = new Class()

Object.MemberwiseClone();  // Returns shallow copy of the object
IClonable.Clone();  //  Creates a new object that is a copy of the current instance.
```

### Deconstruction

Deconstruction is not limited to tuples. By providing a `Deconstruct(...)` method(s) C# allows to use the same syntax with the users types.

> **Note**: Types with a deconstructor can also use _positional pattern matching_.

```cs
public readonly struct Size
{
    public Size(double w, double h)
    {
        W = w;
        H = h;
    }

    public void Deconstruct(out double w, out double h)
    {
        w = W;
        h = H;
    }

    public double W { get; }
    public double H { get; }
}

// deconstruction
var s = new Size(1 , 2);
(double w, double h) = s;  // w = 1, h = 2


// positional patter matching
s switch
{
    (0, 0) => "Empty",
    (0, _) => "Extremely narrow",
    (double w, 0) => $"Extremely short, and this wide: {w}",
    Size _ => "Normal",
    _ => "Not a shape"
};

// Assignment & Declaration
int height = 0;
(int width, height) = size;
```

---

## Operator Overloading

A user-defined type can overload a predefined C# operator. That is, a type can provide the custom implementation of an operation in case one or both of the operands are of that type.

Use the operator keyword to declare an operator. An operator declaration must satisfy the following rules:

- It includes both a public and a static modifier.
- A unary operator has one input parameter. A binary operator has two input parameters.
  In each case, at least one parameter must have type `T` or `T?` where `T` is the type that contains the operator declaration.

[Overloadable operators](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/operator-overloading#overloadable-operators)

```cs
using System;

public readonly struct Fraction
{
    private readonly int num;
    private readonly int den;

    public Fraction(int numerator, int denominator)
    {
        if (denominator == 0)
        {
            throw new ArgumentException("Denominator cannot be zero.", nameof(denominator));
        }
        num = numerator;
        den = denominator;
    }

    // unary arithmetic operators overloading
    public static Fraction operator +(Fraction a) => a;
    public static Fraction operator -(Fraction a) => new Fraction(-a.num, a.den);

    // binary arithmetic operators overloading
    public static Fraction operator +(Fraction a, Fraction b)
        => new Fraction(a.num * b.den + b.num * a.den, a.den * b.den);

    public static Fraction operator -(Fraction a, Fraction b)
        => a + (-b);

    public static Fraction operator *(Fraction a, Fraction b)
        => new Fraction(a.num * b.num, a.den * b.den);

    public static Fraction operator /(Fraction a, Fraction b)
    {
        if (b.num == 0)
        {
            throw new DivideByZeroException();
        }
        return new Fraction(a.num * b.den, a.den * b.num);
    }

    // conversion operator overloading
    public static implicit operator float(Fraction f) => f.num / f.den;
    public static explicit operator Fraction(int i) => new Fraction(i, 1);

    // true & false operator overloading (truthiness and falseness more than exact boolean value)
    public static bool operator true(Fraction f) => f != 0;
    public static bool operator false(Fraction f) => f == 0;
    // if &, |, true, false are overloaded than && and || will work

    // comparison operators overloading
    public static bool operator ==(Fraction f1, Fraction f2) => f1.num == f2.num && f1.den == f2.den;
    public static bool operator !=(Fraction f1, Fraction f2) => f1.num != f2.num || f1.den != f2.den;
    public static bool operator >(Fraction f1, Fraction f2) => ...;
    public static bool operator >=(Fraction f1, Fraction f2) => ...;
    public static bool operator <(Fraction f1, Fraction f2) => ...;
    public static bool operator <=(Fraction f1, Fraction f2) => ...;

    public override bool Equals(object obj)
    {
        return obj is Fraction f && this.num == f.num && this.den == f.den;  // same type + same values
    }

    // required if Equals has been implemented
    public override int GetHashCode()
    {
        return (num, den).GetHashCode();
    }

    public override string ToString() => $"{num} / {den}";
}
```

### Nested Types

A type defined at _global scope_ can be only `public`or `internal`.
private wouldn't make sense since that makes something accessible only from within its containing type, and there is no containing type at global scope.  
But a nested type does have a containing type, so if a nested type is `private`, that type can be used only from inside the type within which it is nested.

> **Note**: Code in a nested type is allowed to use nonpublic members of its containing type. However, an instance of a nested type does not automatically get a reference to an instance of its containing type.

---

## Interfaces

An interface declares methods, properties, and events, but it doesn't have to define their bodies.  
An interface is effectively a list of the members that a type will need to provide if it wants to implement the interface.

C# 8.0 adds the ability to define default implementations for some or all methods, and also to define nested types and static fields.

```cs
// can only be public or internal if not nested, any accessibility otherwise
public interface IContract
{
    // properties and fields
    Type Property { get; set; }

    // un-implemented methods (only signature)
    Type Method(Type param, ...);

    // DEFAULT INTERFACE IMPLEMENTATIONS
    // (method has body), if not implemented in inheriting class the implementation will be this
    Type Method(Type param, ...) => <expr>;

    public const Type CONSTANT = value;  // accessibility needed

    static Type Static Property { get; set; }  // [C#]
    static Type StaticMethod(Type param, ...);  // [C# 10]
    static operator +(Type param, ...);  // [C# 10]

    // nested types are valid, accessibility is needed
}

public interface IContract<T> {}  // interfaces can be generic
```

> **Note**: Interfaces are reference types. Despite this, it's possible tp implement interfaces on both classes and structs.  
However, be careful when doing so with a struct, because when getting hold of an interface-typed reference to a struct, it will be a reference to a _box_,  
which is effectively an object that holds a copy of a struct in a way that can be referred to via a reference.

---

## Generics

[Generics Docs](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/)
[Generic Methods Docs](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/generic-methods)

```cs
// type parameter T in angle brackets
// WARNING: T is not instantiable, new t(), new t[] are INVALID
public class GenericClass<T> {

    // constructors
    public GenericClass() { }

    public GenericClass(T data){
        Generic = data;
    }

    public T Generic { get; set; }  // generic type auto-property

    void GenericMethodName(T t) { }  // same generic as class
    void GenericMethodName<S>(S s) { }  // new generic type
}

GenericClass<Type> obj = new GenericClass<>();
GenericClass<Type>[] obj = new GenericClass<>[];  // invalid

obj.GenericMethodName<Type>();  // generic method call
obj.GenericMethodName(Type param);  // type deduced by input, input type and generic method type must match
```

### Multiple Generics

```cs
public class GenericClass<T1, T2, ...> { }  // number of generic types is not limited
```

### Parameters Constraints

Specify an interface or class that the generic type must implement/inherit.

C# supports only six kinds of constraints on a type argument:

- type constraint
- reference type constraint
- value type constraint
- `notnull`
- `unmanaged`
- `new()`

```cs
// type constraints
public class GenericClass<T> where T : Interface { }
public class GenericClass<T> where T: GenericClass { }

// Enums and Delegates (type constraints)
public class GenericClass<T> where T : Enum { }
public class GenericClass<T> where T : Delegate { }

// reference type constraints (cannot be primitives or structs) --> can test nullability, can use AS operator
public class GenericClass<T> where T : class { }  // T must be not nullable reference type
public class GenericClass<T> where T : class? { }  // T can be (not)nullable reference type

// value type constraint
public class GenericClass<T> where T : struct { }  // T must be a struct or a primitive type
public class GenericClass<T> where T : unmanaged { }  // T must be a value type and its contents can only be value types, recursively

// no nulls
public class GenericClass<T> where T : notnull { }  // T must be a value type or a not nullable reference type

public class GenericClass<T> where T : new() { }  // T must provide a parameterless constructor, cannot be abstract

// multiple constraints
public class GenericClass<T1, T2>
    where T1: Interface
    where T2: Interface1, Interface2
{ }

// generic methods constraints
public T GenericMethod<T>() where T : class?
{
    // code here
    return <expr>;
}
```

---

## Inheritance

Classes support only single inheritance. Interfaces offer a form of multiple inheritance. Value types do not support inheritance at all.  
One reason for this is that value types are not normally used by reference, which removes one of the main benefits of inheritance: runtime polymorphism.

Since a derived class inherits everything the base class has—all its fields, methods, and other members,  
both public and private—an instance of the derived class can do anything an instance of the base could do.

> **Note**: When deriving from a class, it's not possible to make the derived class more visible than its base. This restriction does not apply to interfaces.  
A `public` class is free to implement `internal` or `private` interfaces. However, it does apply to an interface's bases: a `public` interface cannot derive from an `internal` interface.

```cs
class BaseClass
{
    public virtual Property { get; set; }

    // to be overridden method must be ABSTRACT or VIRTUAL
    public virtual Type Method() { }
}

// the base class is ALWAYS the first after the colons
class ChildClass : BaseClass, Interface, Interface<Type>
{
    public override Type Method() { }  // override base's method (same signature)
    public override DerivedType Method() { }  // override base's method, can return more specific type (covariant return type, C# 9)
    public new Type Method() {}  // hide base's method and prevent name conflict warning (hiding method can change signature)

    base.Method();  // call base method
    type Interface.Method() { }  // explicit implementation of an interface member (resolve name conflict between interfaces)
}
```

### Downcasting

Downcasting is the conversion from a base class type to one of it's derived types.

```cs
Base b;
var d = (Derived) b;  // explicit casting (if conversion fails throws InvalidCastException)
var d = b as Derived;  // as operator (if conversion fails AS will return NULL)
if(b is Derived d) {}  // type pattern, d contains converted obj (if conversion fails IS returns FALSE)
if(b is Derived) {}  // simple type pattern (if conversion fails IS returns FALSE)
```

### Inheritance & Constructors

All of a base class's constructors are available to a derived type, but they can be invoked only by constructors in the derived class.  
All constructors are required to invoke a constructor on their base class, and if it's not specified which to invoke, the compiler invokes the base's zero-argument constructor.  
If the base has not a zero-argument constructor the compilation will cause an error. It's possible to invoke a base constructor explicitly to avoid this error.

Initialization order:

1. Derived class field initializers
2. Base class field initializers
3. Base class constructor
4. Derived class constructor

```cs
public class Base
{
    public Base(Type param) {}
}

public class Derived
{
    public Derived() : base(value) {}  // invoke base constructor explicitly passing a fixed value (base has no zero-arg constructor)
    public Derived(Type param) : base(param) {}  // invoke base constructor explicitly
}
```

### Generics Inheritance

If you derive from a generic class, you must supply the type arguments it requires.  
You must provide concrete types unless your derived type is generic, in which case it can use its own type parameters as arguments.

```cs
public class GenericBase1<T>
{
    public T Item { get; set; }
}

public class GenericBase2<TKey, TValue>
{
    public TKey Key { get; set; }
    public TValue Value { get; set; }
}

public class NonGenericDerived : GenericBase1<Type> {}  // derived is not generic, must use concrete type for base class
public class GenericDerived<T> : GenericBase1<T> {}  // derived is generic, can use it's generic type
public class MixedDerived<T> : GenericBase2<T, Type>  // derived is generic but base has two types, can use it's generic type but
```

It's allowed to use derived type as a type argument to the base class. And it's also possible to specify a constraint on a type argument requiring it to derive from the derived type.

```cs
public class Derived : base<Derived> {}
public class Derived<T> where T : Derived<T>
```

### Covariance & Contravariance (only for interfaces)

[The theory behind covariance and contravariance in C#](http://tomasp.net/blog/variance-explained.aspx/)

**Covariance** and **Contravariance** are terms that refer to the ability to use a more derived type (more specific) or a less derived type (less specific) than originally specified.  
Generic type parameters support covariance and contravariance to provide greater flexibility in assigning and using generic types.

- **Covariance**: Enables to use a more derived type than originally specified.
- **Contravariance**: Enables to use a more generic (less derived) type than originally specified.
- **Invariance**: it's possible to use _only_ the type originally specified; so an invariant generic type parameter is neither covariant nor contravariant.

![covariance-vs-contravariance](../../img/dotnet_covariant_contravariant.png)

> **Note**: annotate generic type parameters with `out` and `in` annotations to specify whether they should behave covariantly or contravariantly.

```cs
public class Base {};
public class Derived : Base {}

// COVARIANCE (supply more specific type)
// method is "read only" since it does not modify its argument
// IEnumerable is covariant (has out parameter) since only "provides" objects
void PrintBase(IEnumerable<Base> bases)
{
    foreach(Base base in bases)
    {
        Console.WritLine(base);
    }
}

IEnumerable<Derived> derivedItems = new Derived[] {...};  // array is enumerable of Derived objects
Method(derivedItems);  // valid since Derived objects are also Base objects and operation is read only


// CONTRAVARIANCE (supply less specific type)
// IComparer is contravariant (has in parameter) since "takes in" objects
void CompareDerived(IComparer<Derived> comparer)
{
    var d1 = new Derived();
    var d2 = new Derived();
    if(comparer.Compare(d1, d2)) { /* some action */ }
}

IComparator<Base> baseComparator = new BaseComparator();
CompareDerived(baseComparator);  // valid since baseComparator can compare Base objects and thus can compare Derived objects
```

---

## Delegates

A **delegate** is a type that represents a _reference to a method_ with a particular parameter list and return type. Delegates are used to pass methods as arguments to other methods.  
This ability to refer to a method as a parameter makes delegates ideal for defining callback methods.

Any method from any accessible class or struct that matches the delegate type can be assigned to the delegate. The method can be either static or an instance method.  
This makes it possible to programmatically change method calls, and also plug new code into existing classes.

```cs
// delegate definition
public delegate Type Delegate(Type param, ...);  // can take any method with specified type params and return type
public delegate Type Delegate<T>(T param);  // generic delegate

// delegate creation
var delegate = new Delegate<Type>(Method);  // explicit creation, useful when compiler cannot infer delegate type
Delegate<Type> delegate = Method;  // implicit creation
```

### [Multicast Delegates](https://docs.microsoft.com/en-us/dotnet/api/system.multicastdelegate)

**Multicast Delegates** are delegates that can have more than one element in their invocation list.

```cs
Delegate<Type> multicastDelegate = Method1 + Method2 + ...;  // multicast delegate creation
multicastDelegate += Method;  // add method to delegate
multicastDelegate -= Method;  // remove method from delegate
```

> **Note**: Delegate removal behaves in a potentially surprising way if the delegate removed refers to multiple methods.  
Subtraction of a multicast delegate succeeds only if the delegate from which subtract contains all of the methods in the delegate being subtracted _sequentially and in the same order_.

### Delegate Invocation

Invoking a delegate with a single target method works as though the code had called the target method in the conventional way.  
Invoking a multicast delegate is just like calling each of its target methods in turn.

```cs
Delegate<Type> delegate = Method;

delegate(args);  // use delegate as standard method
delegate.DynamicInvoke(argsArray); // Dynamically invokes the method represented by the current delegate.

multicastDelegate.GetInvocationList();  // list of methods called by the delegate
```

### Common Delegate Types

> **Note**: Each delegate has an overload taking from zero to 16 arguments;

```cs
public delegate void Action<in T1, ...>(T1 arg1, ...);
public delegate TResult Func<in T1, ..., out TResult>(T1 arg1, ...);
public delegate bool Predicate<in T1, ...>(T1 arg1, ...);
```

### Type Compatibility

Delegate types do not derive from one another. Any delegate type defined in C# will derive directly from `MulticastDelegate`.  
However, the type system supports certain implicit reference conversions for generic delegate types through covariance and contravariance. The rules are very similar to those for interfaces.

## Anonymous Functions (Lambda Expressions)

Delegates without explicit separated method.

```cs
// lambda variations
Delegate<Type> lambda = () => <expr>;
Delegate<Type> lambda = input => <expr>;
Delegate<Type> lambda = (input) => <expr>;
Delegate<Type> lambda = (Type input) => <expr>;
Delegate<Type> lambda = input => { return <expr>; };
Delegate<Type> lambda = (input) => { return <expr>; };
Delegate<Type> lambda = (Type input) => { return <expr>; };

// static modifier prevents unintentional capture of local variables or instance state by the lambda
Delegate<Type> lambda = (static Type input) => <expr>;

Type variable = delegate { <expression>; };  // ignore arguments of the method passed to the delegate

// lambda type inference [C# 10]
var f = Console.WriteLine;
var f = x => x;  // inferring the return type
var f = (string x) => x;  // inferring the signature
var f = [Required] x => x;  // adding attributes on parameters
var f = [Required] (int x) => x;
var f = [return: Required] static x => x;  // adding attribute for a return type
var f = Type () => default;  // explicit return type
var f = ref int (ref int x) => ref x;  // using ref on structs
var f = int (x) => x;  // explicitly specifying the return type of an implicit input
var f = static void (_) => Console.Write("Help");
```

---

## [Events](https://www.tutorialsteacher.com/csharp/csharp-event)

Structs and classes can declare events. This kind of member enables a type to provide notifications when interesting things happen, using a subscription-based model.

The class who raises events is called _Publisher_, and the class who receives the notification is called _Subscriber_. There can be multiple subscribers of a single event.  
Typically, a publisher raises an event when some action occurred. The subscribers, who are interested in getting a notification when an action occurred, should register with an event and handle it.

```cs
public delegate void EventDelegate(object sender, CustomEventArgs args);  // called on event trigger

public class Publisher
{
    public event EventDelegate Event;

    // A derived class should always call the On<EventName> method of the base class to ensure that registered delegates receive the event.
    public virtual void OnEvent(Type param)
    {
        Event?.Invoke(param);
    }
}
```

### Registering Event Handlers

```cs
public class Subscriber
{
    Publisher publisher = new Publisher();

    public Subscriber()
    {
        publisher.OnEvent += Handler;  // register handler (+= syntax)
    }

    // event handler, matches the signature of the Event delegate.
    public Type Handler() { /* act */ }
}
```

### Built-In EventHandler Delegate

.NET includes built-in delegate types `EventHandler` and `EventHandler<TEventArgs>` for the most common events.  
Typically, any event should include two parameters: the _source_ of the event and event _data_.  
The `EventHandler` delegate is used for all events that do not include event data, the `EventHandler<TEventArgs>` delegate is used for events that include data to be sent to handlers.

```cs
public class Publisher
{
    public event EventHandler Event;

    public virtual void OnEvent(EventArgs e)
    {
        Event?.Invoke(this, e);
    }
}

public class Subscriber
{
    Publisher publisher = new Publisher();

    public Subscriber()
    {
        publisher.OnEvent += Handler;  // register handler (+= syntax)
    }

    public Type Handler(object sender, EventArgs e) { /* act */ }
}
```

### Custom Event Args

```cs
public class CustomEventArgs : EventArgs { }

public class Publisher
{
    public event EventHandler<CustomEventArgs> Event;

    public virtual void OnEvent(CustomEventArgs e)
    {
        Event?.Invoke(this, e);
    }
}

public class Subscriber
{
    Publisher publisher = new Publisher();

    public Subscriber()
    {
        publisher.OnEvent += Handler;  // register handler (+= syntax)
    }

    public Type Handler(object sender, CustomEventArgs e) { /* act */ }
}
```

---

## Assemblies

In .NET the proper term for a software component is an **assembly**, and it is typically a `.dll` or `.exe` file.  
Occasionally, an assembly will be split into multiple files, but even then it is an indivisible unit of deployment: it has to be wholly available to the runtime, or not at all.

Assemblies are an important aspect of the type system, because each type is identified not just by its _name_ and _namespace_, but also by its containing _assembly_.  
Assemblies provide a kind of encapsulation that operates at a larger scale than individual types, thanks to the `internal` accessibility specifier, which works at the assembly level.

The runtime provides an _assembly loader_, which automatically finds and loads the assemblies a program needs.  
To ensure that the loader can find the right components, assemblies have structured names that include version information, and they can optionally contain a globally unique element to prevent ambiguity.

### Anatomy of an Assembly

Assemblies use the **Win32 Portable Executable** (PE) file format, the same format that executables (EXEs) and dynamic link libraries (DLLs) have always used in "modern" (since NT) versions of Windows.

The C# compiler produces an assembly as its output, with an extension of either `.dll` or `.exe`.  
Tools that understand the PE file format will recognize a .NET assembly as a valid, but rather dull, PE file.  
The CLR essentially uses PE files as containers for a .NET-specific data format, so to classic Win32 tools, a C# DLL will not appear to export any APIs.

With .NET Core 3.0 or later, .NET assemblies won't be built with an extension of `.exe`.  
Even project types that produce directly runnable outputs (such as console or WPF applications) produce a `.dll` as their primary output.  
They also generate an executable file too, but it's not a .NET assembly. It's just a bootstrapper that starts the runtime and then loads and executes your application's main assembly.

> **Note**: C# compiles to a binary intermediate language (IL), which is not directly executable.  
The normal Windows mechanisms for loading and running the code in an executable or DLL won't work with IL, because that can run only with the help of the CLR.

### .NET MEtadata

As well as containing the compiled IL, an assembly contains metadata, which provides a full description of all of the types it defines, whether `public` or `private`.  
The CLR needs to have complete knowledge of all the types that the code uses to be able to make sense of the IL and turn it into running code, the binary format for IL frequently refers to the containing assembly's metadata and is meaningless without it.

### Resources

It's possible to embed binary resources in a DLL alongside the code and metadata. To embed a file select "Embedded Resource" as it's _Build Action_ in the file properties.  
This compiles a copy of the file into the assembly.

To extract the resource at runtime use the `Assembly` class's `GetManifestResourceStream` method which is par of the **Reflection API**.

### Multifile Assembly

.NET Framework allowed an assembly to span multiple files.  
It was possible to split the code and metadata across multiple modules, and it was also possible for some binary streams that are logically embedded in an assembly to be put in separate files.  
This feature was rarely used, and .NET Core does not support it. However, it's necessary to know about it because some of its consequences persist.  
In particular, parts of the design of the Reflection API make no sense unless this feature is known.

With a multifile assembly, there's always one master file that represents the assembly. This will be a PE file, and it contains a particular element of the metadata called the **assembly manifest**.  
This is not to be confused with the Win32-style manifest that most executables contain.  
The assembly manifest is just a description of what's in the assembly, including a list of any external modules or other external files; in a multimodule assembly, the manifest describes which types are defined in which files.

### Assembly Resolution

When the runtime needs to load an assembly, it goes through a process called _assembly resolution_.

.NET Core supports two deployment options for applications:

- **self-contained**
- **framework-dependent**

### Self-Contained Deployment

When publishing a self-contained application, it includes a complete copy of .NET Core, the whole of the CLR and all the built-in assemblies.  
When building this way, assembly resolution is pretty straightforward because everything ends up in one folder.

There are two main advantages to self-contained deployment:

- there is no need to install .NET on target machines
- it's known exactly what version of .NET and which versions of all DLLs are running

With self-contained deployment, unless the application directs the CLR to look elsewhere everything will load from the application folder, including all assemblies built into .NET.

#### Framework-Dependent Deployment

The default build behavior for applications is to create a framework-dependent executable. In this case, the code relies on a suitable version of .NET Core already being installed on the machine.  
Framework-dependent applications necessarily use a more complex resolution mechanism than self-contained ones.

When such an application starts up it will first determine exactly which version of .NET Core to run.  
The chosen runtime version selects not just the CLR, but also the assemblies making up the parts of the class library built into .NET.

### Assembly Names

Assembly names are structured. They always include a **simple name**, which is the name by which normally refer to the DLL.  
This is usually the same as the filename but without the extension. It doesn't technically have to be but the assembly resolution mechanism assumes that it is.

Assembly names always include a **version number**. There are also some optional components, including **the public key token**, a string of _hexadecimal digits_, which is required to have a unique name.

#### Strong Names

If an assembly's name includes a public key token, it is said to be a **strong name**. Microsoft advises that any .NET component that is published for shared use (e.g: made available via NuGet) should have a strong name.

As the terminology suggests, an assembly name's public key token has a connection with cryptography. It is the hexadecimal representation of a 64-bit hash of a public key.  
Strongly named assemblies are required to contain a copy of the full public key from which the hash was generated.  
The assembly file format also provides space fora digital signature, generated with the corresponding private key.

The uniqueness of a strong name relies on the fact that key generation systems use cryptographically secure random-number generators, and the chances of two people generating two key pairs with the same public key token are vanishingly small.  
The assurance that the assembly has ot been tampered with comes from the fact that a strongly named assembly must be signed, and only someone in possession of the private key can generate a valid signature. Any attempt to modify the assembly after signing it will invalidate the signature.

#### Version

All assembly names include a four-part version number: `major.minor.build.revision`. However, there's no particular significance to any of these.  
The binary format that IL uses for assembly names and references limits the range of these numbers, each part must fit in a 16-bit unsigned integer (a `ushort`), and the highest allowable value in a version part is actually one less than the maximum value that would fit, making the highest legal version number `65534.65534.65534.65534`.

As far as the CLR is concerned, there's really only one interesting thing you can do with a version number, which is to compare it with some other version number, either they match or one is higher than the other.

The build system tells the compiler which version number to use for the assembly name via an assembly-level attribute.

> **Note**: NuGet packages also have version numbers, and these do not need to be connected in any way to assembly versions. NuGet does treat the components of a package version number as having particular significance: it has adopted the widely used _semantic versioning_ rules.

#### Culture

All assembly names include a **culture** component.  
This is not optional, although the most common value for this is the default `neutral`, indicating that the assembly contains no culture-specific code or data.

The culture is usually set to something else only on assemblies that contain culture-specific resources. The culture of an assembly's name is designed to support localization of resources such as images and strings.

---

## Reflection

The CLR knows a great deal about the types the programs define and use. It requires all assemblies to provide detailed metadata, describing each member of every type, including private implementation details.  
It relies on this information to perform critical functions, such as JIT compilation and garbage collection. However, it does not keep this knowledge to itself.

The **reflection API** grants access to this detailed type information, so the code can discover everything that the runtime can see.

Reflection is particularly useful in extensible frameworks, because they can use it to adapt their behavior at runtime based on the structure of the code.

The reflection API defines various classes in the `System.Reflection` namespace. These classes have a structural relationship that mirrors the way that assemblies and the type system work.

### Assembly

The `Assembly` class defines three context-sensitive static methods that each return an `Assembly`.  
The `GetEntryAssembly` method returns the object representing the EXE file containing the program's `Main` method.  
The `GetExecutingAssembly` method returns the assembly that contains the method from which it has been called it.  
`GetCallingAssembly` walks up the stack by one level, and returns the assembly containing the code that called the method that called `GetCallingAssembly`.

To inspect an assembly info use the `ReflectionOnlyLoadFrom` (or `ReflectionOnlyLoad`) method of the `Assembly` class.  
This loads the assembly in such a way that it's possible to inspect its type information, but no code in the assembly will execute, nor will any assemblies it depends on be loaded automatically.

---

## Attributes

In .NET, it's possible to _annotate_ components, types, and their members with attributes.  
An attribute's purpose is to control or modify the behavior of a framework, a tool, the compiler, or the CLR.

Attributes are passive containers of information that do nothing on their own.

### Applying Attributes

To avoid having to introduce an extra set of concepts into the type system, .NET models attributes as instances of .NET types.  
To be used as an attribute, a type must derive from the `System.Attribute` class, but it can otherwise be entirely ordinary.

It's possible to pass arguments to the attribute _constructor_ in the annotation.

```cs
[AttName]  // simple attribute

[AttName(value)]  // valorize private fields (through the constructor)
[AttrName(Name = value)]  // valorize public properties or fields (no constructor needed)
```

> **Note**: The real name of an attribute ends with "Attribute" (`[AttrName]` refers to the `AttrNameAttribute` class)

### Multiple Attributes

```cs
[Attribute1]
[Attribute2]

[Attribute1, Attribute2]
```

### Defining Custom Attribute Types

```cs
// specify what the attribute can be applied to (enforced by c# compiler)
[AttributeUsage(AttributeTargets.<TargetType>)]
public class CustomAttribute : Attribute
{
    // properties to hold information

    // constructor (used to valorize private fields)
}
```

### Retrieving Attributes

It's possible to discover which attributes have been applied through the reflection API.  
The various targets of attribute have a reflection type representing them (`MethodInfo`, `PropertyInfo`, ...) which all implement the interface `ICustomAttributeProvider`.

```cs
public interface ICustomAttributeProvider
{
    object[] GetCustomAttributes(bool inherit);
    object[] GetCustomAttributes(Type attributeType, bool inherit);
    bool IsDefined(Type attribueType, bool inherit);
}
```

---

## Files & Streams

A .NET **stream** is simply a _sequence of bytes_. That makes a stream a useful abstraction for many commonly encountered features such as a file on disk, or the body of an HTTP response.  
A console application uses streams to represent its input and output.

The `Stream` class is defined in the `System.IO` namespace.  
It is an abstract base class, with concrete derived types such as `FileStream` or `GZipStream` representing particular kinds of streams.

```cs
// The most important members of Stream
public abstract int Read(byte[] buffer, int offset, int count);
public abstract void Write(byte[] buffer, int offset, int count);
public abstract long Position { get; set; }
```

Some streams are _read-only_. For example, if input stream for a console app represents the keyboard or the output of some other program, there's no meaningful way for the program to write to that stream.  
Some streams are _write-only_, such as the output stream of a console application.  
If `Read` is called on a write-only stream or `Write` on a read-only one, these methods throw a `NotSupportedException`.

Both `Read` and `Write` take a `byte[]` array as their first argument, and these methods copy data into or out of that array, respectively.  
The `offset` and `count` arguments that follow indicate the array element at which to start, and the number of bytes to read or write.  
There are no arguments to specify the _offset_ within the stream at which to read or write. This is managed by the `Position` property.  
This starts at zero, but at each read or write, the position advances by the number of bytes processed.

The `Read` method returns an `int`. This tells how many bytes were read from the stream, the method _does not guarantee_ to provide the amount of data requested.  
The reason `Read` is slightly tricky is that some streams are live, representing a source of information that produces data gradually as the program runs.

> **Note**: If asked for more than one byte at a time, a `Stream` is always free to return less data than requested from Read for any reason. Never presume that a call to `Read` returned as much data as it could.

### Position & Seeking

Streams automatically update their current position each time a read or write operation is completed. The `Position` property can be set to move to the desired location.  
This is not guaranteed to work because it's not always possible to support it. Some streams will throw `NotSupportedException` when trying to set the `Position` property.

Stream also defines a Seek method, this allows to specify the position required relative to the stream's current position.  
Passing `SeekOrigin.Current` as second argument will set the position by adding the first argument to the current position.

```cs
public abstract long Seek(long offset, SeekOrigin origin);  // offset can be negative
```

### Flushing

Writing data to a Stream does not necessarily cause the data to reach its destination immediately.  
When a call to `Write` returns, all that is known is that it has copied the data _somewhere_; but that might be a buffer in memory, not the final target.

The Stream class therefore offers a `Flush` method. This tells the stream that it has to do whatever work is required to ensure that any buffered data is written to its target, even if that means making suboptimal use of the buffer.

A stream automatically flushes its contents when calling `Dispose`. Flush only when it's needed to keep a stream open after writing out buffered data.  
It is particularly important if there will be extended periods during which the stream is open but inactive.

> **Note**: When using a `FileStream`, the `Flush` method does not necessarily guarantee that the data being flushed has made it to disk yet. It merely makes the stream pass the data to the OS.  
Before calling `Flush`, the OS hasn't even seen the data, so if the process terminates suddenly, the data would be lost.  
After `Flush` has returned, the OS has everything the code has written, so the process could be terminated without loss of data.  
However, the OS may perform additional buffering of its own, so if the power fails before the OS gets around to writing everything to disk, the data will still be lost.

To guarantee that data has been written persistently (rather than merely ensuring that it has been handed it to the OS), use either the `WriteThrough` flag, or call the `Flush` overload that takes a bool, passing `true` to force flushing to disk.

### [StreamReader][stream_reader_docs] & [StreamWriter][stream_writer_docs] (Text Files)

[stream_reader_docs]: https://docs.microsoft.com/en-us/dotnet/api/system.io.streamreader
[stream_writer_docs]: https://docs.microsoft.com/en-us/dotnet/api/system.io.streamwriter

The most useful concrete text-oriented streams types are `StreamReader` and `StreamWriter`, which wrap a `Stream` object.  
It's possible to constructing them by passing a `Stream` as a constructor argument, or a string containing the path of a file, in which case they will automatically construct a `FileStream` and then wrap that.

[Encoding](https://docs.microsoft.com/en-us/dotnet/api/system.text.encoding)

```cs
// Will detect encoding from stream contents
StreamReader file = new StreamReader(string path);
StreamReader file = new StreamReader(string path, System.Text.Encoding encoding);  // encoding is System.Text.Encoding

// Default Encoding: UTF-8 w/o BOM (Byte Order Mark)
StreamWriter file = new StreamWriter(string path);
StreamWriter file = new StreamWriter(string path, bool boolean);  // true to append data to the file; false to overwrite the file.
StreamReader file = new StreamReader(string path, System.Text.Encoding encoding);  // encoding is System.Text.Encoding
StreamReader file = new StreamReader(string path, bool append, System.Text.Encoding encoding);  // encoding is System.Text.Encoding

// USAGE
try
{
    using (StreamReader file = new StreamReader(path))  // stream to read
    {
        while(!file.EndOfStream)  // keep reading until the end op file
        {
            file.ReadLine();  // read a whole line from the file
        }
    }

    using (StreamWriter file = new StreamWriter(path))  // stream to write
    {
        file.write();  // write to file
    }
}
catch (Exception e)
{
    // handle exception
}
```

### StringReader & StringWriter

The `StringReader` and `StringWriter` classes serve a similar purpose to `MemoryStream`: they are useful when working with an API that requires either a `TextReader` or `TextWriter` (abstract text streams), but you want to work entirely in memory.  
Whereas `MemoryStream` presents a Stream API on top of a `byte[]` array, `StringReader` wraps a string as a `TextReader`, while `StringWriter` presents a `TextWriter` API on top of a `StringBuilder`.

## Files & Directories

### [FileStream](https://docs.microsoft.com/en-us/dotnet/api/system.io.filestream) Class (Binary Files)

The `FileStream` class derives from `Stream` and represents a file from the filesystem.

It' common to use the constructors in which the `FileStream` uses OS APIs to create the file handle. It's possible to provide varying levels of detail on how this si to be done.  
At a minimum the file's path and a value from the `FileMode` enumeration must be provided.

```cs
// overloaded FileStream Constructors
public FileStream(string path, FileMode mode);
public FileStream(string path, FileMode mode, FileAccess access);
public FileStream(string path, FileMode mode, FileAccess access, FileShare share);
public FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize);
public FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, bool useAsync);
public FileStream(string path, FileMode mode, FileAccess access, FileShare share, int bufferSize, FileOptions options);
```

| `FileMode`     | Behavior if file exists                              | Behavior if file does not exist |
| -------------- | ---------------------------------------------------- | ------------------------------- |
| `CreateNew`    | Throws `IOException`                                 | Creates new file                |
| `Create`       | Replaces existing file                               | Creates new file                |
| `Open`         | Opens existing file                                  | Throws `FileNotFoundException`  |
| `OpenOrCreate` | Opens existing file                                  | Creates new file                |
| `Truncate`     | Replaces existing file                               | Throws `FileNotFoundException`  |
| `Append`       | Opens existing file, setting Position to end of file | Creates new file                |

**`FileAccess` Enumeration**:

- `Read`: Read access to the file. Data can be read from the file. Combine with Write for read/write access.
- `Write`: Write access to the file. Data can be written to the file. Combine with Read for read/write access.
- `ReadWrite`: Read and write access to the file. Data can be written to and read from the file.

**`FileShare` Enumeration**:

- `Delete`: Allows subsequent deleting of a file.
- `None`: Declines sharing of the current file. Any request to open the file (by this process or another process) will fail until the file is closed.
- `Read`: Allows subsequent opening of the file for reading. If this flag is not specified, any request to open the file for reading (by this process or another process) will fail until the file is closed. However, even if this flag is specified, additional permissions might still be needed to access the file.
- `ReadWrite`: Allows subsequent opening of the file for reading or writing. If this flag is not specified, any request to open the file for reading or writing (by this process or another process) will fail until the file is closed. However, even if this flag is specified, additional permissions might still be needed to access the file.
- `Write`: Allows subsequent opening of the file for writing. If this flag is not specified, any request to open the file for writing (by this process or another process) will fail until the file is closed. However, even if this flag is specified, additional permissions might still be needed to access the file.

**`FileOptions` Enumeration**:

- `WriteThrough`: Disables OS write buffering so data goes straight to disk when you flush the stream.
- `AsynchronousSpecifies`: the use of asynchronous I/O.
- `RandomAccessHints`: to filesystem cache that you will be seeking, not reading or writing data in order.
- `SequentialScanHints`: to filesystem cache that you will be reading or writing data in order.
- `DeleteOnCloseTells`: `FileStream` to delete the file when you call `Dispose`.
- `EncryptedEncrypts`: the file so that its contents cannot be read by other users.

> **Note**: The `WriteThrough` flag will ensure that when the stream is disposed or flushed, all the data written will have been delivered to the drive, but the drive will not necessarily have written that data persistently (drives can defer writing for performance), so data loss id still possible if the power fails.

```cs
// object to read or write to a file (file can be binary)
{
    using(FileStream fstream = new FileStream(path, FileMode.OpenOrCreate, FileAccess.ReadWrite))
    {
        // operations on file stream
    }
}
```

### [File](https://docs.microsoft.com/en-us/dotnet/api/system.io.file) Class

The static `File` class provides methods for performing various operations on files.

```cs
File.Create(string path);  // Return Read/Write FileStream to file
File.Open(string path, System.IO.FileMode mode);  // Open a FileStream on the specified path with read/write access with no sharing.
File.Open(string path, System.IO.FileMode mode, System.IO.FileAccess access);  // Opens a FileStream on the specified path, with the specified mode and access with no sharing.
File.Open(string path, System.IO.FileMode mode, System.IO.FileAccess access, System.IO.FileShare share);
File.OpenRead(string path);  // Open an existing file for reading, returns a FileStream
File.OpenText(string path);  // Open an existing UTF-8 encoded text file for reading, returns a StreamReader
File.OpenWrite(string path);  // Open an existing file for writing, returns a FileStream

File.Delete(string path);  // Delete the specified file
File.Move(string sourceFileName, string destFileName, bool overwrite);  // Move specified file to a new location (can specify a new filename and to overwrite the destination file if it already exists)
File.Exists(string path);  // Whether the specified file exists.

File.GetCreationTime(string path);  // Return DateTime set to the creation date and time for the specified file
File.GetLastAccessTime(string path);  // Return DateTime set to the date and time that the specified file was last accessed
File.GetLastWriteTime(string path);  // Return DateTime set to the date and time that the specified file was last written to
File.GetAttributes(string path);  // Return FileAttributes of the file

File.Encrypt(string path);  // Encrypt a file so that only the account used to encrypt the file can decrypt it.
File.Decrypt(string path);  // Decrypt a file that was encrypted by the current account using the Encrypt() method.

File.ReadAllText(string path);  // Return a string containing all the text in the file
File.ReadAllLines(string path);  // Returns a string[] containing all lines of the file
File.ReadLines(string path); // Returns IEnumerable<string> containing all the text in the file
File.ReadAllBytes(string path);  // Returns a byte[] containing the contents of the file.

File.WriteAllLines(string path, IEnumerable<string> contents);  // writes a collection of strings to the file
File.WriteAllLines(string path, string[] contents);  // writes a collection of strings to the file

File.AppendAllText(string path, string contents);  // appends the specified string to the file
File.AppendAllLines(string path, IEnumerable<string> contents);  // appends a collection of strings to the file

// Replace the contents of a specified file with the contents of another file, deleting the original file, and creating a backup of the replaced file.
File.Replace(string sourceFileName, string destinationFileName, string destinationBackupFileName);
```

### [Directory](https://docs.microsoft.com/en-us/dotnet/api/system.io.directory) Class

Exposes static methods for creating, moving, and enumerating through directories and subdirectories.

```cs
Directory.CreateDirectory(string path);  // Create directory as specified
Directory.Delete(string path);  // Delete an empty directory from a specified path (dir must be writable)
Directory.Delete(string path, bool recursive);  // Delete the specified directory and, if indicated, any subdirectories and files in the directory
Directory.Move(string sourceDirName, string destDirName);  // Move a file or a directory and its contents to a new location
Directory.Exists (string path);  // Whether the given path refers to an existing directory on disk

Directory.GetLogicalDrives();  // string[] of names of the logical drives on the computer in the form "<drive letter>:\"
Directory.GetParent(string path);  // DirectoryInfo of parent directory of the specified path, including both absolute and relative paths
Directory.GetCurrentDirectory();  // string of current working directory of the application
Directory.SetCurrentDirectory(string path);  // Set the application's current working directory to the specified directory

Directory.GetCreationTime(string path);  // DateTime set to the creation date and time for the specified directory
Directory.GetLastAccessTime(string path);  // DateTime set to the date and time the specified file or directory was last accessed
Directory.GetLastWriteTime(string path);  // DateTime set to the date and time the specified file or directory was last written to

Directory.EnumerateDirectories (string path, string searchPattern, SearchOption searchOption);  // IEnumerable<string> of directory full names that match a search pattern in a specified path
Directory.GetDirectories (string path, string searchPattern, System.IO.SearchOption searchOption);  // string[] of directory full names that match a search pattern in a specified path

Directory.EnumerateFiles(string path, string searchPattern, SearchOption searchOption);  // IEnumerable<string> of full file names that match a search pattern in a specified path
Directory.GetFiles(string path, string searchPattern, SearchOption searchOption);  // string[] of full file names that match a search pattern in a specified path

Directory.EnumerateFileSystemEntries(string path, string searchPattern, SearchOption searchOption);  // IEnumerable<string> array of file names and directory names that match a search pattern in a specified path
Directory.GetFileSystemEntries (string path, string searchPattern, SearchOption searchOption);  // string[] array of file names and directory names that match a search pattern in a specified path
```

### [Path](https://docs.microsoft.com/en-us/dotnet/api/system.io.path) Class

```cs
Combine(string path1, string path2);  // Combine two strings into a path
Combine(string[] paths);  // Combine strings into a path

GetFullPath(string path);  // absolute path for the specified path string
GetFullPath(string path, string basePath);  // absolute path from a relative path and a fully qualified base path
GetRelativePath (string relativeTo, string path);  // relative path from one path to another
GetPathRoot (string path);  // Get the root directory information from the path contained in the specified string
GetDirectoryName (string path);  // directory information for the specified path string

GetExtension (string path);  // extension (including the period ".") of the specified path string
GetFileName (string path);  // file name and extension of the specified path string
GetFileNameWithoutExtension (string path);  // file name of the specified path string without the extension

HasExtension (string path);  // whether a path includes a file name extension
IsPathFullyQualified (string path);  // whether the specified file path is fixed to a specific drive or UNC path
IsPathRooted (string path);  // whether the specified path string contains a root

EndsInDirectorySeparator (string path);  // true if the path ends in a directory separator; otherwise, false
TrimEndingDirectorySeparator (string path);  // Trim one trailing directory separator beyond the root of the specified path

GetInvalidFileNameChar();  // char[] containing the characters that are not allowed in file names
GetInvalidPathChars();  // char[] containing the characters that are not allowed in path names

GetTempPath();  // path of the current user's temporary folder
GetTempFileName();  // Create a uniquely named, zero-byte temporary file on disk and returns the full path of that file
GetRandomFileName();  // random folder name or file name

// get full path from relative
string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"relative_path.ext");  // path to a file in the project directory

// get special folder location
string appDataPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
```

### [FileInfo][fileinfo_docs], [DirectoryInfo][directoryinfo_docs] & [FileSystemInfo][filesysteminfo_docs]

[fileinfo_docs]: https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo
[directoryinfo_docs]: https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
[filesysteminfo_docs]: https://docs.microsoft.com/en-us/dotnet/api/system.io.filesysteminfo

Classes to hold multiple info about a file or directory. If some property changes using the method `Refresh()` will update the data.

### CLR Serialization

Types are required to opt into CLR serialization. .NET defines a [Serializable] attribute that must be present before the CLR will serialize the type (class).

```cs
[Serializable]
class ClassName{
    // class contents
}
```

Serialization works directly with an object's fields. It uses reflection, which enables it to access all members, whether public or private.

> **Note**: CLR Serialization produces binary streams in a .NET specific format

---

## DateTime & TimeSpan

### [TimeSpan Struct](https://docs.microsoft.com/en-us/dotnet/api/system.timespan)

Object that represents the difference between two dates

```cs
TimeSpan Interval = new DateTime() - new DateTime()  // difference between dates

// constructors
TimeSpan(hours, minutes, seconds);  // all parameters are integers
TimeSpan(days, hours, minutes, seconds);  // all parameters are integers
TimeSpan(days, hours, minutes, seconds, milliseconds);  // all parameters are integers

// from primitive types
TimeSpan interval = TimeSpan.FromSeconds(seconds);
TimeSpan interval = TimeSpan.FromMinutes(minutes);
TimeSpan interval = TimeSpan.FromHours(hours);
TimeSpan interval = TimeSpan.FromDays(days);
```

---

## Memory Efficiency

The CLR is able to perform automatic memory management thanks to its garbage collector (GC). This comes at a price: when a CPU spends time on garbage collection, that stops it from getting on with more productive work.  
In many cases, this time will be small enough not to cause visible problems. However, when certain kinds of programs experience heavy load, GC costs can come to dominate the overall execution time.

C# 7.2 introduced various features that can enable dramatic reductions in the number of allocations. Fewer allocations means fewer blocks of memory for the GC to recover, so this translates directly to lower GC overhead. There is a price to pay, of course: these GC-efficient techniques add significant complication to the code.

### `Span<T>`

The `System.Span<T>` (a `ref struct`) value type represents a sequence of elements of type `T` stored contiguously in memory. Those elements can live inside an array, a string, a managed block of memory allocated in a stack frame, or unmanaged memory.

A `Span<T>` encapsulates three things: a pointer or reference to the containing memory (e.g., the string or array), the position of the data within that memory, and its
length.  

Access to a span contents is done like an and since a `Span<T>` knows its own length, its indexer checks that the index is in range, just as the built-in array type does.

```cs
Span<int> numbers = stackalloc int[] { 1, 2, 3 };
var first = numbers[0];
```

> **Note**: Normally, C# won’t allow to use `stackalloc` outside of code marked as unsafe, since it allocates memory on the stack producing a pointer. However, the compiler makes an exception to this rule when assigning the pointer produced by a `stackalloc` expression directly into a span.

The fact that `Span<T>` and `ReadOnlySpan<T>` are both `ref struct` types ensures that a span cannot outlive its containing stack frame, guaranteeing that the stack frame on which the stack-allocated memory lives will not vanish while there are still outstanding references to it.

In addition to the array-like indexer and `Length` properties, `Span<T>` offers a few useful methods.  
The `Clear` and `Fill` methods provide convenient ways to initialize all the elements in a span either to the default value or a specific value.  
Obviously, these are not available on `ReadOnlySpan<T>`.

The `Span<T>` and `ReadOnlySpan<T>` types are both declared as `ref struct`. This means that not only are they value types, they are value types that can live only on the
stack. So it's not possible to have fields with span types in a class, or any struct that is not also a `ref struct`.

This also imposes some potentially more surprising restrictions:

- it's  not possible to use a span in a variable in an async method.
- there are restrictions on using spans in anonymous functions and in iterator methods

This restriction is necessary for .NET to be able to offer the combination of array-like performance, type safety, and the flexibility to work with multiple different containers.

> **Note**: it's possible to use spans in local methods, and even declare a ref struct variable in the outer method and use it from the nested one, but with one restriction: it's not possible a delegate that refers to that local method, because this would cause the compiler to move shared variables into an object that lives on the heap.

## `Memory<T>`

The `Memory<T>` type and its counterpart, `ReadOnlyMemory<T>`, represent the same basic concept as `Span<T>` and `ReadOnlySpan<T>`: these types provide a uniform view
over a contiguous sequence of elements of type `T` that could reside in an array, unmanaged memory, or, if the element type is char, a string.  
But unlike spans, these are not `ref struct` types, so they can be used anywhere. The downside is that this means they cannot offer the same high performance as spans.

It's possible to convert a `Memory<T>` to a `Span<T>`, and likewise a `ReadOnlyMemory<T>` to a `ReadOnlySpan<T>`.  
This makes these memory types useful when you want something span-like, but in a context where spans are not allowed.

---

## Regular Expressions

[regex reference](https://docs.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference)

```cs
Match match = Regex.Match(string, pattern, regexOptions);

match.Success;  // whether there was a match or not

match.Groups[index];  // numbered capture group (first group is always whole match)
match.Groups[name];  // named capture group

match.Groups[index].Value;  // whole captured string
match.Groups[index].Captures;  // list of strings in the matched group
match.Groups[index].Index;  // position in the input string of the matched group
```

---

## Unsafe Code & Pointers

The `unsafe` keyword denotes an _unsafe context_, which is required for any operation involving pointers.

In an unsafe context, several constructs are available for operating on pointers:

- The `*` operator may be used to perform pointer indirection ([Pointer indirection][ptr_indirection]).
- The `->` operator may be used to access a member of a struct through a pointer ([Pointer member access][ptr_member_acces]).
- The `[]` operator may be used to index a pointer ([Pointer element access][ptr_elem_access]).
- The `&` operator may be used to obtain the address of a variable ([The address-of operator][ptr_addr_of]).
- The `++` and `--` operators may be used to increment and decrement pointers ([Pointer increment and decrement][ptr_incr_decr]).
- The `+` and `-` operators may be used to perform pointer arithmetic ([Pointer arithmetic][ptr_math]).
- The `==`, `!=`, `<`, `>`, `<=`, and `>=` operators may be used to compare pointers ([Pointer comparison][ptr_comparison]).
- The `stackalloc` operator may be used to allocate memory from the call stack ([Stack allocation][stack_alloc]).

The `fixed` statement prevents the garbage collector from relocating a movable variable. It's only permitted in an unsafe context.  
It's also possible to use the fixed keyword to create fixed size buffers.

The `fixed` statement sets a pointer to a managed variable and "pins" that variable during the execution of the statement.  
Pointers to movable managed variables are useful only in a fixed context. Without a fixed context, garbage collection could relocate the variables unpredictably.  
The C# compiler only allows to assign a pointer to a managed variable in a fixed statement.

```cs
unsafe Type UnsafeMethod() { /* unsafe context */ }
// or
unsafe
{
    // Using fixed allows the address of pt members to be taken,
    // and "pins" pt so that it is not relocated.
    Point pt = new Point();
    fixed (int* p = &pt.x)
    {
        *p = 1;
    }
}
```

[ptr_indirection]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#pointer-indirection)
[ptr_member_acces]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#pointer-member-access)
[ptr_elem_access]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#pointer-element-access)
[ptr_addr_of]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#the-address-of-operator)
[ptr_incr_decr]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#pointer-increment-and-decrement)
[ptr_math]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#pointer-arithmetic)
[ptr_comparison]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#pointer-comparison)
[stack_alloc]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#stack-allocation)
[fixed_buffers]: (https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/unsafe-code#fixed-size-buffers)

### Native Memory

```cs
using System.Runtime.InteropServices;

unsafe
{
    byte* buffer = (byte*)NativeMemory.Alloc(100);

    NativeMemory.Free(buffer);
}
```

### DllImport & Extern

The `extern` modifier is used to declare a method that is implemented externally.  
A common use of the extern modifier is with the `DllImport` attribute when using Interop services to call into _unmanaged_ code.  
In this case, the method must also be declared as `static`.

```cs
[DllImport("avifil32.dll")]
private static extern void AVIFileInit();
```
