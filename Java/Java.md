# Java Cheat Sheet

```java
//single line comment
/* multi line comment */
/** javaDoc docstring */
```

Java element | Case
-------------|------------
package      | lowercase
class        | PascalCase
variable     | camelCase
method       | camelCase

## Basics

Package definition: `package <package_location>;`

### Main Method (entry point of algorithm)

```java
public static void main (String[] args) {
    //code here
}
```

### Variable Assignement

`Type variable_1 = <expr>, ..., variable_n = <expr>;`

### Constant Definition (outside of main method/function)

```java
public static final Type CONSTANT_NAME = value;
public static final double PI = 3.14159;   //example
```

### Constant Definition (inside main method/function)

```java
final Type CONSTANT_NAME = value;
final double PI = 3.14159;   //example
```

### Screen Output

```java
System.out.println(output_1 + _ + output_n);   //newline at every invocation
System.out.print(output_1 + _ + output_n);
```

### Output Formatting

[String.format() Examples](https://dzone.com/articles/java-string-format-examples)

```java
System.out.printf("stringa %..", variable);
System.out.println(String.format(format, args));
```

Methods ereditated from C. The value pf the variable substitutes %.  
`%d` int, `%f` float, `%c` char, `%s` string, `%e` scientific notation.  
`%digitNumber.decimalDigitNumber` specifies the space occupied by the output.

`NumberFormat` class is used to format a number output.

```java
Locale locale = new Locale("language", "country");  // as defined by IETF lang tag, RCF 5646, RCF 4647
NumberFormat fmt = NumberFormat.getCurrencyInstance(locale);  // format a number as a currency based on a Locale
fmt.format(number);  // apply format to a number, returns a String
```

## Keyboard Input

```java
import java.util.Scanner;   //package import
Scanner scanner = new Scanner(System.in);  //Scanner obj init
scanner.useDelimiter("delimitatore");   //delimiter setting
scanner.close()  //closing of Scanner, releases memory

int variabile_int_1 = scanner.nextInt();   //takes integer number
String string_1 = scanner.nextLine();   //takes line of text (\n ends line)
String string_1 = scanner.next();   //takes text (spacec ends word)
double variabile_double_1 = scanner.nextDouble();  //takes double decimal number
boolean variabile_bool = scanner.netxBoolean();  //takes boolean value
//(TRUE, FALSE, true, false, True, False)
```

The `nextLine()` method imports from the **last** `\n`.  
Thus when switching to a different input method is necessary to call `nextLine()` one more time to avoid errors.

### Primitive Types

```java
TYPE        WRAPPER     SIZE        MIN_VALUE               MAX_VALUE
int         Integer                 -2147483648             2147483647
byte        Byte        8 bit       -128                    127
short       Short       16 bit      -32768                  32767
long - L    Long        32 bit      -9223372036854775808    9223372036854775807
float - f   Float       32 bit      1.4 * 10^-45            3.4028235 * 10^38
double - d  Double      64 bit      4.9 * 10^-324           1.7976931348623157 * 10^308
char        Character   16 bit      U+0000 (0)              U+FFFF (65535)
boolean     Boolean                 false                   true
```

Digits can be separated by _ (underscore).  
If not specified int & double are the default types.

### Floating-Point numbers & Precision Calcs

Don't use `==` or `!=` to confront floating value numbers since they use approximation or have a lot of digits.  
It's best to check if the difference between two numbers is small enought.  
For high precision calcs is best to use `BigDecimal`.

### Type Conversion (casting) & Type checking

```java
Type variable = (Type) <expression>;  // convert to other Type
var instanceof Type;  // true if var is an instance of Type
```

### Wrapper Classes

Every primitive type has a corresponding wrapper class.  
Wrapper classes permits the creation of an object with the same type of a primitive type but with added methods and constants.

```java
WrapperClass objectName = new WrapperClass(primitiveValue);  //decalration
WrapperClass objectName = primitiveValue;  //shortened declaration


Type variable = object.<Type>Value();  //unboxing
Type variable = object;  //autoboxing
Type variable = new WrapperClass(primitiveValue);  //automatic unboxing

WrapperClass.MIN_VALUE  //constant holding min possible value of wrapper class
WrapperClass.MAX_VALUE  //constant holding man possible value of wrapper class

ClasseWrapper.parseClasseWrapper(stringa);  //converte il valore di una stringa in uno della classe wrapper (metodo statico), eccezione NumberFOrmatException se l'operazione fallisce
ClasseWrapper.toString(valore_tipo_primitivo);  //converte il valore della classe wrapper in una string (metodo statico)
```

### String & Char

```java
String string = "text";  //strings always in double quotes
char character = 'C';  //chars always in single quotes
```

### Special Characters

Escape Character   | Character
-------------------|-----------------------
`\n`               | new line  
`\t`               | tab  
`\b`               | backspace  
`\r`               | carriage return  
`\f`               | form feed  
`\\`               | backslash  
`\"`               | double quote  
`\u<4_hex_digits>` | unicode characters  
`\x<digits>`       | hexadecimal characters  
`\o<digits>`       | octal characters  
`\<digits>`        | ASCII character  

### String Concatenation

The value of the variable is appende to the string literal.  
`"text" + variabile`  
String are immutable. Concatenation creates a new string.

### String Conversion to Number

```java
double d  = Double.parseDouble(string);
float f = Float.parseFloat(string);
int i = integer.parseInt(string);
```

### String Class Methods

```java
string.equals(otherString);   // returns TRUE if the strings are equal
srting.equalsIgnoreCase(otherString);   // returns TRUE if the strings are equals ignoring the case
string.charAt(index);  // returns the character at positon INDEX
string.startsWith(otherString);  // returns TRUE if string starts with otherString
string.endsWith(otherString)  // returns TRUE if string ends with otherString
string.concat(otherString);   // concatenation of two strings
string.indexOf(otherString);  // returns index of the first occurrence of othre string
string.lastIndexOf(otherString);  // returns index of the last occurrence of othre string
string.length();    // returns the length of the string
string.toLowerCase();   // transform the string in uppercase characters
string.toUpperCase();   // transform the string in lowercase characters
string.repalce(character, newCharacter);   // substitutes character with newCharacter
string.replaceAll(regex, replacecment);
string.substring(start, end);   // returns a substring starting as START and ending at END (incluced)
string.trim();   // removes spaces before and after the string
string.Split(delimiter);  // return a String[] generated by splitting string at the occurrence of delimiter
string.compareTo(otherString);
```

`compareTo()` returns a number:  

- `-1` if `string` precedes `otherString`
- `0` if the strings are equal  
- `1` if `otherString` precedes `string`

`compareTo()` compares the lexicographic order (based on UNICODE).  
To compare in alphabetical order voth strings must have the same case.

### Mathematical Operations

```java
Math.PI  // value of pi
Math.E  // value of e

Math.abs(x);  //absolute value of x
Math.acos(x);
Math.asin(x)
Math.atan(x)
Math.atan2(y, x)
Math.ceil(x)
Math.cos(x)
Math.exp(x);  //e^x
Math.floor(x)
Math.log(x)
Math.max(x, y)
Math.min(x, y)
Math.pow(x, y);  //x^y
Math.random()
Math.rint(x)
Math.round(x)
Math.sin(x)
Math.sqrt(x);  //square root, x^(1/2)
Math.tan(x)
Math.toDegrees(rad)
Math.toRadians(deg)
```

### Arithmetic Operators

operator   | operation
-----------|----------
a `+` b    | sum
a `-` b    | subtraction
a `*` b    | multiplication
a `/` b    | division
a `%` b    | modulo
a`++`      | increment
a`--`      | decrement

### Comparison Operators

operator   | operation
-----------|----------
a `==` b     | equal to
a `!=` b     | not equal to
a `>` b      | greater than
a `<` b      | lesser than
a `>=` b     | greater than or equal to
a `<=` b     | lesser than or equal to

### Logical Operators

operator   | operation
-----------|----------
`!`a         | logical negation (**NOT**)
a `&&` b,    | logical **AND**
a `||` b,    | logical **OR**

### Bitwise Operators

operator   | operation
-----------|----------
`~`a       | bitwise **NOT**
a `&` b    | bitwise **AND**
a `|` b    | bitwise **OR**
a `^` b    | bitwise **XOR**
a `<<` b   | bitwise left shift
a `>>` b   | bitwise right shift

### Compound Assignement Operators

operator   | operation
-----------|----------
a `+=` b   | a = a + b
a `-=` b   | a = a - b
a `*=` b   | a = a * b
a `/=` b   | a = a / b
a `%=` b   | a = a % b
a `&=` b   | a = a & b
a `|=` b   | a = a | b
a `^=` b   | a = a ^ b
a `<<=` b  | a = a << b
a `>>=` b  | a = a >> b

### Operator Precedence

1. unary operators `++` , `--`, `!`
2. binary arithmetic opeartors `*`, `/`, `%`
3. binary arithmetic opeartors `+`, `-`
4. boolean operators `<`, `>` , `<=`, `>=`
5. boolean operators `==`, `!=`
6. bitwise operator `&`
7. bitwise operator `|`
8. logical operator `&&`
9. logical operator `||`

### Short Circuit Evaluation

If in `(expressionA || expressionB)` expressionA results `true`, Java returns `true` without evaluating expressionB.  
If in `(expressionA && expressionB)` expressionA results `false`, Java returns `false` without evaluating expressionB.  
Full evaluation can be forced using `&` and `|`.

## Decision Statements

### `If Else`

```java
if (condition) {
    //code here
} else {
    //code here
}
```

### `If, Else If, Else`

```java
if (condition) {
    //code here
} else if (condition) {
    //code here
} else if (condition){
    //code here
} else {
    //code here
}
```

### Ternary Operator

`(condition) ? istruzione_1 : istruzione_2;`  
if condition is `true` executes instruction1 otherwise executes instruction2.

### `Switch`

```java
switch (matchExpression) {
    case matchingPattern:
        //code here
        break;
    case matchingPattern:
        //code here
        break;
    default:
        //code here
        break;
}
```

Omitting the `break` keyword causes multiple branches to execute the same code.

## Loop Statements

### `While` Loop

```java
while (condition) {
   //code here
}
```

### `Do While` Loop

```java
do {
    //code here
} while (espressione_booleana);
```

Loop body executed *at least* one time

### `For` Loop

```java
for (initializer; condition; iterator) {
    //code here
}
```

### `Foreach` Loop

```java
for (Type variable : iterable){
    //code here
}
```

### Multiple iterators in `For` Loop

```java
for (initializer1, initializer2; condition; iterator1, iterator2) {
    //code here
}
```

The iterator declared in the for is a local variable and can be used only in the for loop block.

### Forced Program Termination

`System.exit(returnedValue);` forces the termination of the program execution returning a specified value.

### Assertion Checks

If the asertion check is enabled (`java -ebableassetrions programName`) the execution of the algorithm is terminated if an assertion fails.  
Asseretions can be used to check if a variable has a wanted value in a precise point in the code (Sanity Check).

```java
assert <booleanExpression>;
```

## Static Methods

Static methods are not bound to an *instance* of a class but they act on the class *itself*.  

### Static Void Method Definition

```java
static void methodName (parameters) {
    //code here
}
```

### Static Method Definition

```java
static tipo_metodo methodName (parameters) {
    //code here
    return <espressione>;   //returned type MUST match method type
}
```

### Static Method Invocation

```java
methodName(arguments);
ClassName.methodName(arguments);    //if method is used outside its class
```

## Array

## Array Delcaration

```java
Type[] arrayName = new Type[dimension];

Type arrayName[] = new Type[dimension];

arrayName.length  //length of the array
```

Its possible to break the declaration in two lines  

```java
Type[] arrayName;
arrayType = new Type[dimension];
```

## Array Creation by Initializzation

`Type[] arrayName = {value1, value2, ...}`  
Array dimansion is determined by the number of values.

### Arrays as method parameters

```java
static Type methodName (Type[] arrayName) {
    //code here
}

methodName(arrayName);  //[] omitted when passing array as argument
```

Single elements of an array can be passed to a method. Array dimension can be omitted.  

### Equality of Arrays

As arrays ar object in Java, the operators `==` and `!=` confront the memory address of the arrays.  
Array contents must be confronted by looping through the array.

### Methods returning Arrays

```java
static Type[] methodName (parameters) {
    Type[] arrayName = new Type[dimension];  //array declaration
    //array valorization
    return arrayName;
}
```

## Variable numbers of parameters in a method

```java
static Type methodName (parameters, tipo[] ArrayName) {
    //code here
}
```

It's not necessary to specify a dimension of the array, it's determined by Java

### Multi-Dimensional Arrays

```java
Type[]...[] arrayName = new Type[dimension1]...[dimensionN];
Type arrayName[]...[] = new Type[dimension1]...[dimensionN];
```

### Multi-Dimensional Arrats as parameters

```java
static Type methodName (Type[]...[] ArrayName) {
    //code here
}
```

### Methods returning multi-dimensional arrays

```java
static Type[]...[] methodName (parameters) {
    Type[]...[] array = new Type[dimension1]...[dimensionN];
    //array valorization
    return array;
}
```

### Array Length of multi-dimensional arrays

```java
array.length  //row lenght
array[rowIndex].length  //column length
```

### Irregular Table Visualization

```java
static void viewTable (Type[][] matrix){
    for (int row = 0; row < matrix.length; row++){   //run through the rows
        for (int column = 0; column < arrayName[row].length; column++){   //run through the columns
            System.put.print(arrayName[row][column] + "\t");   //print item followed by a tab
        }
        System.out.println();   //newline after each matrix row
    }
}
```

## Recursion Guidelines

The core of the recursion must be constituited by a *conditional instruction* that permits to handle the cases basend on the method argument.  
*At laest one* of the alternatives must contain a recurive call to che mathod. The call must resolve recuced version of the task handled by the method.  
*At leats one* of the alternatives must not contain a recursive call or it must produce a value that constituites a base case or an arrest value.

## Exception Handling

An **Exception** is an object used to signal an anomalous event.
**Checked Exceptions** must be handled in a catch meanwhile **Uncchecked Exceptions** do not need to be catched like `RuntimeException`.
Unchecked exceptions usually mean thathere is an error in the logic of the program that must be fixed.

### `Try-Catch-Finally`

This construct permits to monitor what happens in a block of code and to specify what to do in case of errors (*exceptions*).

```java
try {
    //monitored code
} catch (SpecificException e) {
    //in case of errors use this
} catch (SpecificException1 | SpecficException2 | ... | SpecificExceptionN e) {
    //in case of errors use this
} catch (Exception e) {
    //in case of error use this
    e.getMessage();  // access to Exception error message
} finally {
    //code executed anyways
}
```

A `try-catch` construct can handle multiple exceptions at once.  Every `catch` is analyzed in sequence and is executed the first to happen thus is best to leave a generic exception last.

### Try with Resources

```java
try (
    //resource definition
){
    //dangerious code
} catch (Exception e) {
    //in case of error use this
} finally {
    //code executed anyway
}
```

### `Throw` & `Throws`

The `throw` keyword is used to generate a custom exception in a point of the code.  
`throw` is used together with an exception type.

```java
Type methodName(parameters) {
    if (condition) {
      throw new Exception("error message");
    }
}
```

The `throws` keyword is used to indicate what exception Type may be thrown by a method.  
`throws` is used together with a exception class. It's used to send the exception to the method caller.

```java
Type methodName(parameters) throws ExcpetionClass {
    if (condition) {
      throw new SpecificException("error message");
    }
}
```

### Defining Personalized Exceptions

A user-defined exception has to inherit from `Exception` or one of it's descendants.

```java
public class CustomException extends Exception {

    public CustomException(){
        super("Base Message");  // ese Exception constructor
    }

    public CustomException(string message){
        super(message);
    }

    // CustomException inherits getMessage() from Exception

}

```

## Object Oriented Programming

### Access Modifiers

`public` variables, methoda, classes are usable outside of class of definition.  
`private`    variables, methods, classes are  *only* usable inside class of definition.  
`protected` variables, methods, classes can be accessed *only* by defining class, it's descendants and the package.  
`final` classes and methods cannot be extended or overridden.
If not specified variables, methods and classes are *only* accessible from the same package.

### Instance Method Definition

```java
Type methodName (parameters) {
    //code here
}
```

### `Void` Instance Method

```java
void methodName (parameters) {
    //code here
}
```

### Class Definition

```java
public class ClassName {
    //instance variables declaration

    //instantiation block
    {
        // this code is called before the constructor when an object is instantiated
    }

    //constructors definition

    // getters & setters

    // override of superclass' methods

    //instance methods definition
}
```

### `This` identifier

`this.instanceVariable` identifies the instance variable
It's possible to use `this` to distinguish between instance and static variables with the same name.

### Classes and Reference Addresses

A an instance of a class doesen't contain an object of that class but a memory address in whitch the object is memorized.  
operations of assignement (`=`) and confront (`==`) act on the memory address  and not on the values of the objects.  
To confront object is necessary to define a `equals()` method that chacks if the values of the object attributes are equal.  

### Constructors

Constructrs are special methods that are invoked with the `new` operator when an object is instantiated.  
Constructors assign the starting values of the object attributes.  
If a constructor id defined Java doesen't create the default constructor.

```java
class ClassName (){

    //attributes dclaration (aka instance variables)

    //constuctor
    public ClassName(parameters){
        this.attribute = value;  //value is passed to the constructor at obj instantiation
    }

    public ClassName(parameters, otherParameters){
        this(parameters);  // invoke other consstructor for subset of parameters, must be FIRST INSTRUCTION
        this.attribute = value;  // deal with the remaining parameters
    }
}
```

### Static Variables

`Type staticVariable = value;`  
Statc variables are shared by all objects of a class and all static method can act upon them.  
Static variable do not belong to the class objects.

### Getters & Setter Methods

```java
public void setAttribute(Type attribute){
    this.attribute = attribute;
}

public Type getAttribute(){
    return this.attribute;
}
```

### `ToString()` Method

Automatically returns a string if the object is directly called in a print method.

```java
@Override
Public String toString(){
    return "string-representation-of-object"
}
```

### Static Methods in Classes

Static methods are used to effectuate operations not applied to objects.  
Outside of the class of definition thay are invoked with ClassName.methodName()  
Static method **cannot** act on instance variables.  

### Method Overloading

A class can have multiple methods with the same name given that each method has a different number or type of parameters (different method *signature*).  

### Inheritance & Method Overriding

Child classes inherit all methods and attributes from parent class.  
Child methods can *override* parent methods to adapt their functionality.  
Overriding and overridden classes **must** have the same name.
A child class can inherit from *only* one parent class.

Child class **must** implement a constructor that instantiates the parent (super) class.  
`super()` instantiates the superclass of the child class.

```java
class ChildClass extends PerentClass{

    public ChildClass(parentParameters, childParameters){
        super(parentParameters);  // if omitted super() is calles (parent's default constructor)
        // assignement of child attributes
    }

    //calss overrides parent class (must have same name)
    @Override
    Type methodName(parameters){
        //code here
    }

    super().methodName(parameters);  // calls the parent's method
}
```

An overridden method that returns a `ParentClass` can be overridden to return a `ChildClass`. This is the only case in which an overridden method can change the retured type.
An overridden method can change the access modifier as long as the new modifier is more "permissive".

A `ParentClass` type can contain a `ChildClass` object. This is useful for using collections and arrays of objects.

```java
ParentClass objectName = ChildClass();  // upcast
(ChildClass)ParentClassObject;  // downcast
```

### Abstact Classes & Abstract Methods

An Abstact Class is a particular class that contains an Abstact Method.
This type of class cannot be instantiated but is used leave the specific implementatio of some of it's methods to extending classes.
Abstact classes are marked by the `abstract` keyword.

An abstract method is a method witout imlementation.  
The methods **must** be `public` and marked with the `abstract` keyword.

```java
//abstarct class
abstract class className{
    //attributes here
    //constructor here
    //getters & setters here

    public abstract Type methodName();  //no method code

}
```

### Interfaces

An Interface is a class with *only* abstact methods. An interface has more flexibility than an abstract class.  
Interfaces are used to set requirements for child clases without specifing how to satisfy those requirements since it's methods will be implemented in child classes.  
An Interface is marked by the `interface` keyword.
If an implementing class implements only `some` of the interface's mathod than the class **must be abstract**.

Interfaces' methods are always `abstract` and `public`, no need for the kyword.
Interfaces' attributes are always `public static final`, no need for the keyword.

A class can implement *more than one* Interface.

```java
public interface InterfaceName{
    //attributes here

    Type methodName();  //no method code
}

// interfaces can extend interfaces
public interface OtherInterface extends InterfaceName {
    //attributes here
    Type methodName();  // inherited from extended interface
    Type otherMethod();  // defined in thes interface
}

class ClassName implements Interface1, Interface2 {...}
```

Types of Interfaces:

- Normal (multiple methods)
- Single Abstract Method (`@FunctionalInterface`, used with *Lamda Expressions*)
- Marker (Empty, *no methods*)

Since Java 1.8 interfaces can implements also `static` methods.

### Enumerations

Enums are used to restrict the type of data to a set of the possible constatnt values.
Enums are classes which constructor is private by default.
It's still possible to createa a custom constructor to add values.

```java
enum enumName {
    value1,
    value2,
    ... ,
    valueN;
}

//definition of an enumeration w/ custom constructor for valorization
//constructor is not usable outside enum definition
enum enumName {
    value1(value),  //call constructor to valorize
    value2(value),
    ... ,
    valueN(value);

    private Type value;

    Type enumName(Type paramenter) {
        this.value = parameter;
    }

    //getters are allowed, the values is a constant --> no setters
    public Type getValue(){
        retrurn this.value;
    }
}

enumName variable;  //creation of a variable of type enumName
```

### Anonymous Classes

*Anonymous classes* make the code more concise. They enable to declare and instantiate a class at the same time. They are like local classes except that they do not have a name. Useful if is needed a local class that is used once.

```java
AnonymousClass objectName = new AnonymousClass(Type parameter, ...) {

    // attributes

    // methods
};
```

### Cloning

```java
class ClassName implements Cloneable {

}
```

## Generics

```java
// WARNING: T is not instantiable, new t(), new t[] are INVALID
public class GenericClass<T> {
    private T generic;

    public GenericClass() { }
    public GenericClass(T data){
        this.generic = data;
    }

    public T getGeneric() {
        return generic;
    }

    public void setGeneric(T data) {
        this. generic = data;
    }

}

GenericClass<Type> obj = new GenericClass<>();
GenericClass<Type>[] obj = new GenericClass<>[];  // invalid
```

### Multiple Generics

```java
public class GenericClass<T1, T2, ...> { }  // number of generic types is not limited
```

### Parameters Constraints

Specify an interface or class that the generic type must implement/inherit.

```java
public class GenericClass<T extends Interface1 & Interface2> { }
public class GenericClass<T1 extends Interface1 & Interface2, T2 extends Class1> { }
public class GenericClass<T extends Class1> { }
```

### Generic Methods

```java
public class ClassName{

    public <T> methodName() {
        // code here
        return <T>_obj
    }

    public <T> methodName(T obj) {
        // code here
        return return <T>_obj
    }
}

public class GenericClass<S> {

    public <T> methodName() {
        // code here
        return <T>_obj
    }

    public <T> methodName(T obj) {
        // code here
        return return <T>_obj
    }
}

obj.<Type>methodName();  // generic method call
```

## File I/O

### Text Files

#### Writing on a file

```java
// opening/creating the file for writing
PrintWriter outStream = null;  // output stream creation
try{
    outStream = new PrintWriter(filename);  // file-stream binding, file will be empty (creates or overwrites file)
    outStream = new PrintWriter(new FileOutputStream(filename, true));  // stream for appending text
} catch (FileNotFoundException e) {
    // code here
}

// write on the file
outSteram.print("");
outSteram.println("");

outStream.close()  // close stream and write buffer contents.
```

**Note**: writing operations do not write direcly on the file. The sent data is collected in a **buffer**. When the buffer is *full* the data is written in the file. This is called *buffering* and is used to spped up operations.

#### Reading from a file

```java
Filereader filereader = new Filereader("filename");  //open the file
Scanner scanner = new Scanner(filereader);  //scanner for the file


Scanner inStream = null;
try{
    inStream = new Scanner(File(filename));
} catch (FileNotFoundException e) {
    // code here
}

inStream.hasNext();  // true if there is data to be read with next()
inStream.hasNextDouble();  // true if there is data to be read with nextDouble()
inStream.hasNextInt();  // true if there is data to be read with nextInt()
inStream.hasNextLine();  // true if there is data to be read with nextLine()


BufferedReader inStream = null;
try {
    inStream = new BufferReader(new Filereader(filename));  //buffed reader for file
} catch (FileNotFoundException e) {
    // code here
}

// BuffredReader Methods
public String readLine() throws IOException  // return file line or null (file has ended)
public int read() throws IOException  // return an integer representin a char or -1 (file has ended)
public long skip(n) throws IOException  // skip n characters
public void close() throws IOException  // closes the stream
```

#### `File()` class

The File class is an abstraction of the file and it's path. The abstraction is independant from the OS.

```java
File("path/to/file")  // UNIX like path
File("path\\to\\file")  // Windows path

file.canRead()  // true if file is readeble
file.canWrite()  // true if file is writable
file.delete()  // true if file has been deleted
file.exists()  // check if exist a file with the filename used in the constructor
file.getName()  // returns the filename
file.getPath()  // returns the file's path
file.lenghth()  // file lenght in bytes
```

### Bynary Files

#### Writing to a binary file

```java
ObjectOutputStream outStream;
try {
    outStream = new ObjectOutputStream(new FileOutputSteam(filename));
    // write operations here since they can cause IOException
} catch (FileNotFoundException e) {

} catch (IOException e){

}

// ObjectOutputStream Methods
public ObjectOutputStream(OutputStream streamObj) throws IOException, FileNotFoundException
public ObjectOutputStream(new FileOutputStream(filename)) throws IOException, FileNotFoundException
public ObjectOutputStream(new FileOutputStream(new File(filename))) throws IOException, FileNotFoundException
public void writeInt(int n) throws IOException
public void writeLong(long n) throws IOException
public void writeDouble(double x) throws IOException
public void writeFloat(float x) throws IOException
public void writeChar(int c) throws IOException
public void writeChar(char c) throws IOException
public void writeBoolean(boolean b) throws IOException
public void writeUTF(String s) throws IOException
public void writeObject(Object obj) throws IOException, NotSerializableException, InvalidClassException  // Object must be serializable
public void close()
```

#### Reading from a binary file

```java
ObjectInputStream inStream;
try {
    inStream = new ObjectInputStream(new FileinputSteam(filename));
} catch (FileNotFoundException e) {

} catch (IOException e){

}

try {
    while(true){
        // read fom file
    }
} catch (EOFException e) {  // thrown when and of file has been reached
    // do nothing, only used to stop the cycle
}

// ObjectOutputStream Methods
public ObjectOutputStream(InputStream streamObj) throws IOException, FileNotFoundException
public ObjectOutputStream(new FileInputStream(filename)) throws IOException, FileNotFoundException
public ObjectOutputStream(new FileInputStream(new File(filename))) throws IOException, FileNotFoundException
public void readInt(int n) throws IOException
public void readLong(long n) throws IOException
public void readDouble(double x) throws IOException
public void readFloat(float x) throws IOException
public void readChar(int c) throws IOException
public void readChar(char c) throws IOException
public void readBoolean(boolean b) throws IOException
public void readUTF(String s) throws IOException
public void readObject(Object obj) throws IOException, NotSerializableException, InvalidClassException  // Object must be serializable
public void close()
```

### Object & Array I/O with Binary Files (Serialization)

Needed for a class to be *serializable*:

- implements the `Serializable` interface
- all instance variables are serializable
- superclass, if exists, is serializable or has default constructor

An array is serializable if it's base type is a rerializable object.

```java
SerializableObject[] array = (SerializableObject[])inStream.readObject();  // read returns Object, cast needed
```

## Functional Programming in Java

### Functional Interfaces

Functional interfaces provide target types for *lambda expressions*.

General purpose `@functioanlInterfaces`:

```java
// takes input, performs actions, return boolean
public interface Predicate<T> {
    boolean test(T t);
}

// takes input, performs action, no output returned
public interface Consumer<T> {
    void accept(T t);
}

// takes no input, performs action, returns an output
public interface Supplier<T> {
    T get();
}

// takes T as input, performs action, returns R as output
public interface Function<T, R> {
    R apply(T t);
}
```

### Streams

In java a *stream* is a [Monad][1]. Monads allow the programmer to compose a sequence of operations, similar to a pipeline chaining expressions together.

The features of Java stream are:

- A stream is not a data structure instead it takes input from the Collections, Arrays or I/O channels.
- Streams don’t change the original data structure, they only provide the result as per the pipelined methods.
- Each intermediate operation is lazily executed and returns a stream as a result, hence various intermediate operations can be pipelined. Terminal operations mark the end of the stream and return the result.

**Intermediate Operations**:

- `anyMatch()`
- `distinct()`
- `filter()`
- `findFirst()`
- `flatmap()`
- `map()`
- `skip()`
- `sorted()`

**Terminal Operations**:

- `forEach()` applies the same operation on each element
- `collect()` saves the elements in a new collection
- reduce to a single summary element: `count()`, `max()`, `min()`, `reduce()`, `summaryStatistics()`

[1]: https://en.wikipedia.org/wiki/Monad_%28functional_programming%29#Usage

### Lambda Expressions

Usable only by a `@FunctionalInterface`'s method or a method of a *stream*.

```java
lambda operator -> body;

//zero parameter
() -> body;

//one parameter
(p) -> body

// multiple parameter
(p1, p2, ...) -> body
```
