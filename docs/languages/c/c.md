# C/C++

## Library Import

```c linenums="1"
#include <stdio.h>  // search in current + system directories
#include "lib.h" // search in current directory
```

## Special Operators

Operator   | Operator Name
-----------|----------------------------------------------------
`::`       | global reference operator
`&`        | address operator (returns a memory address)
`*`        | deferentiation operator (returns the pointed value)

## Namespace definition

Can be omitted and replaced by namespace`::`  
`using namespace <namespace>;`

## Main Function

```c linenums="1"
int main(int argc, char *argv[]) { }
```

## Variables & Types

### Constant Declaration

```c linenums="1"
#define constant_name value
const type constant_name = value;
```

### Variable Declaration

```c linenums="1"
type var_name = value;    //c-like initialization
type var_name (value);    //constructor initialization
type var_name {value};    //uniform initialization
type var_1, var_2, ..., var_n;
```

### Type Casting

`(type) var;`  
`type(var);`

### Variable Types

Type                     | Value Range                       | Byte
-------------------------|-----------------------------------|------
`short`                  | -32768 to 32765                   | 1
`unsigned short`         | 0 to 65535                        | 1
`int`                    | -2147483648 to 2147483647         | 4
`unsigned int`           | 0 to 4294967295                   | 4
`long`                   | -2147483648 to 2147483647         | 4
`unsigned long`          | 0 to 4294967295                   | 4
`long long`              |                                   | 8
`float`                  | +/- 3.4e +/- 38 (~7 digits)       | 4
`double`                 | +/- 1.7e +/- 308 (~15 digits)     | 8
`long double`            |                                   | 16 (?)

Type                     | Value
-------------------------|-----------------------------
`bool`                   | true or false
`char`                   | ascii characters
`string`                 | sequence of ascii characters
`NULL`                   | empty value

### Integer Numerals

Example  | Type
---------|------------------------
`75`     | decimal
`0113`   | octal (zero prefix)
`0x4`    | hexadecimal (0x prefix)
`75`     | int
`75u`    | unsigned int
`75l`    | long
`75ul`   | unsigned long
`75lu`   | unsigned long

### Floating Point Numerals

Example     | Type
------------|-------------
`3.14159L`  | long double
`60.22e23f` | float

Code      | Value
----------|---------------
`3.14159` | 3.14159
`6.02e23` | 6.022 * 10^23
`1.6e-19` | 1.6 * 10^-19
`3.0`     | 3.0

### Character/String Literals

`'z'` single character literal  
`"text here"` string literal

### Special Characters

Escape Character   | Character
-------------------|-----------------------------
`\n`               | newline
`\r`               | carriage return
`\t`               | tab
`\v`               | vertical tab
`\b`               | backspace
`\f`               | form feed
`\a`               | alert (beep)
`\'`               | single quote (')
`\"`               | double quote (")
`\?`               | question mark (?)
`\\`               | backslash  (\)
`\0`               | string termination character

## Standard Input/Output

### Standard Output

```c linenums="1"
#include <stdio.h>

printf_s("text %<fmt_spec>", variable);
```

### Standard Input

```c linenums="1"
#include <stdio.h>

scanf_s("%<fmt_spec>", &variable);    //return number of successfully accepted inputs
```

### Format Specifiers `%[width].[length][specifier]`

Specifier   | Specified Format
------------|-----------------------------------------
`%d`, `%i`  | singed decimal integer
`%u`        | unsigned decimal integer
`%o`        | unsigned octal
`%x`        | unsigned hexadecimal integer
`%X`        | unsigned hexadecimal integer (UPPERCASE)
`%f`        | decimal floating point (lowercase)
`%F`        | decimal floating point (UPPERCASE)
`%e`        | scientific notation (lowercase)
`%E`        | scientific notation (UPPERCASE)
`%a`        | hexadecimal floating point (lowercase)
`%A`        | hexadecimal floating point (UPPERCASE)
`%c`        | character
`%s`        | string
`%p`        | pointer address

## Operators

### Arithmetic Operators

Operator | Operation
---------|---------------
a `+` b  | sum
a `-` b  | subtraction
a `*` b  | multiplication
a `/` b  | division
a `%` b  | modulo
a`++`    | increment
a`--`    | decrement

### Comparison Operators

Operator | Operation
---------|--------------------------
a `==` b | equal to
a `!=` b | not equal to
a `>` b  | greater than
a `<` b  | lesser than
a `>=` b | greater than or equal to
a `<=` b | lesser than or equal to

### Logical Operator

Operator             | Operation
---------------------|-----------------------
`!`a, `not` a        | logical negation (NOT)
a `&&` b, a `and` b  | logical AND
a `||` b, a `or` b   | logical OR

### Conditional Ternary Operator

`condition ? result_1 : result_2`  
If condition is true evaluates to result_1, and otherwise to result_2

### Bitwise Operators

Operator               | Operation
-----------------------|---------------------
`~`a, `compl` a        | bitwise **NOT**
a `&` b, a `bitand` b  | bitwise **AND**
a `|` b, a `bitor` b   | bitwise **OR**
a `^` b, a `xor` b,    | bitwise **XOR**
a `<<` b               | bitwise left shift
a `>>` b               | bitwise right shift

### Compound Assignment Operators

Operator    | Operation
------------|------------
a `+=` b    | a = a + b
a `-=` b    | a = a - b
a `*=` b    | a = a * b
a `/=` b    | a = a / b
a `%=` b    | a = a % b
a `&=` b    | a = a & b
a `|=` b    | a = a | b
a `^=` b    | a = a ^ b
a `<<=` b   | a = a << b
a `>>=` b   | a = a >> b

### Operator Precedence

1. `!`
2. `*`, `/`, `%`
3. `+`, `-`
4. `<`, `<=`, `<`, `>=`
5. `==`, `!=`
6. `&&`
7. `||`
8. `=`

## Common Functions

### Mathematical Functions

```c linenums="1"
#include <cmath>

abs(x);    // absolute value
labs(x);    //absolute value if x is long, result is long
fabs(x);    //absolute value if x i float, result is float
sqrt(x);    // square root
ceil(x);    // ceil function (next integer)
floor(x);    // floor function (integer part of x)
log(x);    // natural log of x
log10(x);    // log base 10 of x
exp(x);    // e^x
pow(x, y);    // x^y
sin(x);
cos(x);
tan(x);
asin(x);    //arcsin(x)
acos(x);    //arccos(x)
atan(x);    //arctan(x)
atan2(x, y);    //arctan(x / y)
sinh(x);    //hyperbolic sin(x)
cosh(x);    //hyperbolic cos(x)
tanh(x);    //hyperbolic tan(X)
```

### Character Functions

```c linenums="1"
isalnum(c);    //true if c is alphanumeric
isalpha(c);    //true if c is a letter
isdigit(c);    //true if char is 0 1 2 3 4 5 6 7 8 9
iscntrl(c);    //true id c is DELETE or CONTROL CHARACTER
isascii(c);    //true if c is a valid ASCII character
isprint(c);    //true if c is printable
isgraph(c);    //true id c is printable, SPACE excluded
islower(c);    //true if c is lowercase
isupper(c);    //true if c is uppercase
ispunct(c);    //true if c is punctuation
isspace(c);    //true if c is SPACE
isxdigit(c);    //true if c is HEX DIGIT

tolower(c);    //transforms character in lowercase
toupper(c);    //transform character in uppercase
```

### String Functions

```c linenums="1"
strlen(string);    //return length (num of chars) of the string
strcat(destination, source);    //appends chars of string2 to string1
strncat(string1, string2, nchar);    //appends the first n chars of string 2 to string1
strcpy(string1, string2.c_str());    //copies string2 into string1 char by char
strncpy(string1, string2, n);    //copy first n chars from string2 to string1
strcmp(string1, string2);    //compares string1 w/ string2
strncmp(string1, string2, n);    //compares first n chars
//returns < 0 if string1 precedes string2
//returns 0 if string1 == string2
// returns > 0 if string1 succeeds string2
strchr(string, c);    //returns index of c in string if it exists, NULL otherwise
strstr(string1, string2);    //returns pointer to starting index of string1 in string2
strpbrk(string, charSet);    //Returns a pointer to the first occurrence of any character from strCharSet in str, or a NULL pointer if the two string arguments have no characters in common.
```

### String Conversion

```c linenums="1"
atof(string);    //converts string in double if possible
atoi(string);    //converts string in integer if possible
atol(string);    //converts string in long if possible
```

### String Methods

```C linenums="1"++
string.at(pos);    // returns char at index pos
string.substr(start, end);    // returns substring between indexes START and END
string.c_str();    //reads string char by char
string.find(substring);    // The zero-based index of the first character in string object that matches the requested substring or characters
```

## Vectors

```c linenums="1"
#include <vector>
vector<type> vector_name = {values};    //variable length array
```

## Decision Statements

### If Statements

```c linenums="1"
if (condition) { }

if (condition) 
{

}
else if (condition) 
{

}
else
{

}
```

### Switch

```c linenums="1"
switch (expression) {
    case constant_1:
        //code here
        break;

    case constant_2:
        //code here
        break;

    default:
        //code here
}
```

## Loop Statements

### While Loop

```c linenums="1"
while (condition) {
    //code here
}
```

### Do While

```c linenums="1"
do {
    //code here
} while (condition);
```

### For Loop

```c linenums="1"
for (initialization; condition; increase) {
    //code here
}
```

### Break Statement

`break;` leaves a loop, even if the condition for its end is not fulfilled.

### Continue Statement

`continue;` causes the program to skip the rest of the loop in the current iteration.

## Functions

Functions **must** be declared **before** the main function.  
It is possible to declare functions **after** the main only if the *prototype* is declared **before** the main.  
To return multiple variables those variables can be passed by reference so that their values is adjourned in the main.

```c linenums="1"
type function_name(type argument1, ...); // function prototype

type functionName (parameters) {
    return <expression>;
}

void functionName (parameters) { }
```

### Arguments passed by reference without pointers

Passing arguments by reference causes modifications made inside the function to be propagated to the values outside.  
Passing arguments by values copies the values to the arguments: changes remain inside the function.  

```c linenums="1"
type functionName (type &argument1, ...) {
    //code here
    return <expression>;
}
```

`functionName (arguments);`

### Arguments passed by reference with pointers

Passing arguments by reference causes modifications made inside the function to be propagated to the values outside.  
Passing arguments by values copies the values to the arguments: changes remain inside the function.

```c linenums="1"
type function_name (type *argument_1, ...) {
    instructions;
    return <expression>;
}
```

`function_name (&argument_1, ...);`

## Arrays

```c linenums="1"
type arrayName[dimension];    //array declaration
type arrayName[dimension] = {value1, value2, ...};    //array declaration & initialization, values number must match dimension

array[index]    //item access, index starts at 0 (zero)
array[index] = value;    //value assignment at position index
```

## Array as function parameter

The dimension is not specified because it is determined by the passed array.  
The array is passed by reference.

```c linenums="1"
type function(type array[]){
    //code here
}

//array is not modifiable inside the function (READ ONLY)
type function(const type array[]){
    //code here
}

function(array);    //array passed w/out square brackets []
```

### Multi-Dimensional Array (Matrix)

```c linenums="1"
type matrix[rows][columns];
matrix[i][j]    //element A_ij of the matrix
```

### Matrix as function parameter

```c linenums="1"
//matrix passed by reference, second dimension is mandatory
type function(type matrix[][columns]){
    //code here
};

//matrix values READ ONLY
type function(const type matrix[][columns]){
    //code here
}

type function(type matrix[][dim2]...[dimN]){
    //code here
}
```

## Structs

### Struct Definition

```c linenums="1"
struct Struct {
    type field1;
    type field2;
    type field3;
    type field4;
};

Struct variable;    // struct-type variable
variable.field    // field access
```

## Pointers

Pointers hold memory addresses of declared variables, they should be initialized to NULL.

```c linenums="1"
type *pointer = &variable;     //pointer init and assignment
type *pointer = NULL;
type *pointer = otherPointer;
type **pointerToPointer = &pointer;    // pointerToPointer -> pointer -> variable
```

`&variable` extracts the address, the pointer holds the address of the variable.  
pointer type and variable type **must** match.  
(*) --> "value pointed to by"

```c linenums="1"
pointer    //address of pointed value (value of variable)
*pointer    //value of pointed variable
**pointer //value pointed by *pointer (pointer to pointer)
```

### Pointer to array

```c linenums="1"
type *pointer;
type array[dim] = {};


pointer = array;    //point to array (pointer points to first "cell" of array)
pointer++;    //change pointed value to successive "cell" of array
```

### Pointers, Arrays & Functions

```c linenums="1"
func(array)    //pass entire array to function (no need to use (&) to extract address)

type func(type* array){
    array[index]    //access to item of array at index
}
```

### Pointer to Struct

```c linenums="1"
(*structPointer).field    //access to field value
structPointer->structField    //access to field value
```

## Dynamic Structures

Dynamic structures are structures without a fixed number of items.  

Every item in a dynamic structure is called **node**.  
Every node is composed by two parts:

* the value (item)
* pointer to successive node

**Lists** are *linear* dynamic structures in which is only defined the preceding and succeeding item. A List is a group of homogeneous items (all of the same type).  

**Trees**, **Graphs** are non *linear* dynamic structures in which an item cha have multiple successors.  

### Stack

A **Stack** is a list in with nodes can be extracted from one *side* only (*LIFO*).
The extraction of an item from the *top* is called **pop**

```c linenums="1"
// node structure
struct Node {
    type value;
    stack *next;
}
```

#### Node Insertion

```c linenums="1"
Node *stackNode;    //current node
Node* head = NULL;    //pointer to head of stack

int nodeValue;
//assign value to nodeValue

stackNode = (*Node)malloc(sizeof(Node));    //create new node

stackNode->value = nodevalue;    //valorize node
stackNode->next = head;    //update node pointer to old head adding it to the stack

head = stackNode;    //update head to point to new first node
```

#### Node Deletion

```c linenums="1"
stackNode = head->next;    //memorize location of second node
free(head);    //delete first node
head = stackNode;    //update head to point to new first node
```

#### Passing Head To Functions

```c linenums="1"
type function(Node** head)    //value of head passed by address (head is Node*)
{
    *head = ...    //update value of head (pointed variable/object/Node)
}
```

### Queue

A **Queue** is a list in which nodes enter from one side and can be extracted only from the other side (*FIFO*).

### Linked List

A **Linked List** is list in which nodes can be extracted from each side and from inside the linked list.

Linked lists can be *linear*, *circular* or *bidirectional*.  
In circular linked lists the last node points to the first.

Nodes of bidirectional linked lists are composed by three parts:

* the value (item)
* pointer to successive node
* pointer to previous item

Thus the first and last node will have a component empty since they only point to a single node.

### Dynamic Memory Allocation

C does not automatically free allocated memory when nodes are deleted. It must be done manually.  

* `malloc()` returns a void pointer if the allocation is successful.
* `free()` frees the memory

```C linenums="1"
list *pointer = (list*)malloc(sizeof(list));    //memory allocation
free(pointer)    //freeing of memory
```

`malloc()` returns a *void pointer* thus the list must be casted to a void type with `(list*)`

## Files

The object oriented approach is based on the use of *streams*.  
A **Stream** can be considered a stream of data that passes sequentially from a source to a destination.

The available classes in C++ to operate on files are:

* `ifstream` for the input (reading)
* `ofstream` for the output (writing)
* `fstream` for input or output

### File Opening

Filename can be string literal or CharArray (use `c_str()`).

```c linenums="1"
ifstream file;
file.open("filename");    //read from file

ofstream file;
file.open("filename");    //write to file


fstream file;
file.open("filename", ios::in);    //read form file
file.open("filename", ios::out);    //write to file
file.open("filename", ios::app);    //append to file
file.open("filename", ios::trunc);    //overwrite file
file.open("filename", ios::nocreate);    //opens file only if it exists, error otherwise. Does not create new file
file.open("filename", ios::noreplace);    //opens file only if it not exists, error otherwise. If it not exists the file is created.
file.open("filename", ios::binary);    //opens file in binary format
```

If file opening fails the stream has value 0, otherwise the value is the assigned memory address.  
Opening modes can be combined with the OR operator: `ios::mode | ios::mode`.

### Stream state & Input errors

Once a stream is in a **state of error** it will remain so until the status flags are *explicitly resetted*. The input operations on such a stream are *void* until the reset happens.  
To clear the status of a stream the `clear()` method is used.  
Furthermore, when an error on the stream happens **the stream is not cleared** of it's characters contents.  
To clear the stream contents the `ignore()` method is used.
