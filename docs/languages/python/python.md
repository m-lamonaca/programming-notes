# Python Notes

## Basics

### Naming Convention

Class -> PascalCase  
Method, Function -> snake_case  
Variable -> snake_case

```py linenums="1"
# standard comment
'''multiline comment'''
"""DOCSTRING"""

help(object.method) # return method explanation
dir(object) # return an alphabetized list of names comprising (some of) the attributes of the given object

import sys # import module
from sys import argv # import single item from a module
from sys import * # import all elements of a module (no module syntax.method needed)
import sys as alias # import the module with an alias, I use alias.method

# CHARACTER SET
import string
string.ascii_lowercase = 'abcdefghijklmnopqrstuvwxyz'
string.asci_uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.asci_letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.digits = '0123456789'
string.hexdigits = '0123456789abcdefABCDEF'
string.octdigits = '01234567'
string.punctuation
string.whitespace

# SPECIAL CHARACTERS
# (\a, \b, \f, \n, \r, \t, \u, \U, \v, \x, \\)
```

### Assignment Operation

```py linenums="1"
"""instructions to the right of = executed before instructions to the left of ="""
variable = expression # the type of the variable is dynamically decided by python based on the content
var_1, var_2 = value1, value2 # parallel assignment
var_1, var_2 = var_2, var_1 # swap values

# conditional assignment
x = a if condition else b
x = a or b # If bool (a) returns False, then x is assigned the value of b
# a series of OR expressions has the effect of returning the first item that evaluates True, or the last item (last item should be a literal).
```

### Variable Type Conversion

`type(expression)`

### Expression Assignment

```py linenums="1"
(var: = expression) # assign an expression to a variable to avoid repeating the expression
```

### Variable Comparison (`==` vs `is`)

`==` compares the values ​​of objects
`is` compares the identities of objects

### On Screen Output

```py linenums="1"
print() # print blank line and wrap
print('string' * n) # print string n times
print('string1 \ n string2') # wrap with \ n
print(variable) # print variable content
print('string', end = '') # print without wrapping

# FORMATTING
name = 'Alex'
marks = 94.5
print(name, marks)
print('Name is', name, '\ nMarks are', marks)
# expand the rest of the expression and write tense before = in output
print(f '{name =}, {marks =}') # OUTPUT: name = Alex, marks = 94.5

# USE OF PLACEHOLDERS
print('Name is% s, Marks are% 3.2f'%(name, marks)) # method inherited from C. Variable is substituted for% ..
print("Name is {}, Marks are {}". format(name, marks))
print("Name is {1}, Marks are {2}". format(marks, name)) # indices in brackets sort elements in .format
print("Name is {n}, Marks are {m}". format(m = '94 .5 ', n =' Alex ')) # indices in brackets sort elements in .format
print(f'Name is {name}, Marks are {marks} ') # formatting with f-strings
```

### Format Specification Mini-Language

`{value:width.precision symbol}`

Format: `[[fill]align] [sign] [#] [width] [grouping] [.precision] [type]`

| `[align]` | Alignment              |
| --------- | ---------------------- |
| `:<`      | left alignment         |
| `:>`      | right alignment        |
| `:=`      | padding after the mark |
| `:^`      | centered               |

| `[sign]` | NUMBER SIGNS                                                                                                    |
| -------- | --------------------------------------------------------------------------------------------------------------- |
| `:+`     | sign for both positive and negative numbers                                                                     |
| `:-`     | sign only for negative numbers                                                                                  |
| `:`      | space for num > 0, '-' for num < 0                                                                              |
| `:#`     | alternative form:prefix integers type (0x, 0b, 0o), floats and complexes always have at least one decimal place |

| `[grouping]` | GROUPING                             |
| ------------ | ------------------------------------ |
| `:,`         | use comma to separate thousands      |
| `:_`         | use underscore to separate thousands |

| `[type]` | OUTPUT TYPE                                                                 |
| -------- | --------------------------------------------------------------------------- |
| `:s`     | output is string                                                            |
| `:b`     | output is binary                                                            |
| `:c`     | output is character                                                         |
| `:d`     | output is a decimal integer (base 10)                                       |
| `:or`    | output is octal integer (base 8)                                            |
| `:x`     | output is hexadecimal integer (base 16)                                     |
| `:X`     | output is hexadecimal integer (base 16) with uppercase                      |
| `:e`     | output is exponential notation (6-digit base precision)                     |
| `:E`     | output is exponential notation (6-digit base precision) uppercase separator |
| `:f`     | output is float (6-digit base precision)                                    |
| `:%`     | output is percentage (multiplies * 100, displays as:f)                      |

### Keyboard Input

```py linenums="1"
# input always returns a STRING
s = input() # input request without message
s = input('Prompt') # request input
i = int(input('prompt')) # request input with type conversion

# MULTIPLE INPUTS
list = [int(x) for x in input('prompt'). split('separator')]
# save multiple inputs in a list(.split separates values ​​and defines separator
```

## Numeric Types

```py linenums="1"
a = 77
b = 1_000_000 # underscore can be used to separate groups of digits
c = -69

# float numbers
x = 3.15
y = 2.71
z = 25.0

d = 6 + 9j # complex number
# returns a complex number starting with two reals
complex(real, imag) # -> complex #(real + imag * 1j)

e = 0B1101 # BINARY TYPE(0B ...)
f = 0xFF # EXADECIMAL TYPE(0X ...)
o = 0o77 # OCTAL TYPE
g = True # BOOLEAN TYPE

# VARIABLE TYPE CONVERSION
h = int(y)
i = float('22 .5 ')

# NUMERIC BASIC CONVERSION
bin(3616544)
hex(589)
oct(265846)

# UNICODE CONVERSION
ord(c) # Given a string representing one Unicode character, return an integer representing the Unicode code point of that character
chr(i) # Return the string representing a character whose Unicode code point is the integer i


pow(x, y) # x ^ y
abs(num) # returns absolute value of num(| num |)
round(num, precision) # rounds number to given precision, does not convert float to int
```

### Comparison of Decimal Numbers

Do not use `==` or `! =` To compare floating point numbers. They are approximations or have several digits.
It is worth checking if the difference between the numbers is small enough.

## Strings

```py linenums="1"

string = 'string content' # assignment and creation of string variable
string = '''multi
line
string'''

string3 = string1 + string2 # string concatenation(operator polymorphism +)

# INDEXING(selection of a character in the string)
string[0]
string[2]
string[-3] # selection starting from the bottom(negative index)

# REPETITION (repeat string output)
print(string * n)

len(string) # show the length of a string

# SLICING (extraction of sub-strings, does not include the position of the last index)
string[0: 5]
string[: 6]
string[-3: -1]

# SLICING WITH STEP
string[0: 12: 3]
string[15 :: - 1]
string[:: - 1] # selection in reverse order (negative step)

# STRIPPING (elimination of spaces before and after string)
string = 'stripping test'
string.strip()
string.lstrip() # only left spaces removed
string.rstrip() # only right spaces removed
string.removeprefix(prefix) # If the string starts with the prefix string, return string [len (prefix):]
string.removesuffix(suffix) # If the string ends with the suffix string and that suffix is ​​not empty, return string [: - len (suffix)]

# SUBSTRING IDENTIFICATION
#returns starting index of the substring or -1 if it is not present
string.find('substring', 0, len (string)) # you can specify the start and end index of the search

# COUNT OF APPARITIONS
string.count('t')

# REPLACEMENT
string.replace('multi', 'multiple')

# UPPER CASE CONVERSION
string.upper()
string.lower()
string.title()
string.capitalize()

# SEPARATION IN LIST ELEMENTS
string.split()
string.split('separator') # separate using separator (separator omitted in list)
string.partition('char') # -> tuple # separates the string from the 3 parts at the first occurrence of separator

# IS_CHECK METHODS -> bool
string.isalnum()
string.isalpha()
string.islower()
string.isspace()
string.istitle()
string.isupper()
string.endswith('char')

# JOIN INSTRUCTION()
''.join(iterable) # merges all elements of the iterable into the new string

# FORMATTING
string.center(width, 'char') # stretch the string with char to width
'...\t...'.expandtabs() # transform tabs into spaces
```

## Lists

```py linenums="1"
list = [9, 11, 'WTC', -5.6, True] # lists can contain data of different types

list[3] # indexing
list[3: 5] # slicing
list * 3 # repetition
len(list) # length
list3 = list1 + list2 # list concatenation (operator + polymorphism)
list[index] = value # modify list element
del (list [1]) # remove by index (INBUILT IN PYTHON)
# modify the list between the start and stop indices by reassigning the elements of the iterable
list[start: stop] = iterable

# LIST METHODS
list.append(object) # add object to background
list.count(item) # counts the number of occurrences of item
list.extend(sequence) # add sequence elements to the list
list.insert(position, object) # insert object in list [position]
list.index(item) # returns the index of item
list.remove(item) # remove item
poplist(item) # delete item and return it
list.clear() # remove all elements

list.sort() # sorts in ascending order (in place)
list.sort(reverse = True) # sorts in descending order (in place)
list.reverse() # invert the string (in place)

# CLONING
list1 = [...]
list2 = list1 # list2 points to the same object of list 1 (changes are shared)
list3 = list1 [:] # list3 is a clone of list1 (no shared changes)

# NESTED LISTS (MATRICES)
list_1 = [1, 2, 3]
list_2 = [4, 5, 6]
list_3 = [7, 8, 9]

matrix = [list_1, list_2, list_3]
matrix [i][j] # identify element of list_i index j

# MAXIMUM AND MINIMUM
max(list)
min(list)

# ALL () & ANY ()
all(sequence) # returns TRUE if all elements of the sequence are true
any(sequence) # returns TRUE if at least one element of the sequence has the value True

# MAP INSTRUCTION
# apply function to iterable and create new list (map object)
# function can be lambda
map(function, iterable) # -> map object

# FILTER INSTRUCTION ()
# create a new list composed of the iterable elements for which the function returns TRUE
filter(function, iterable) # -> filter object

# ZIP INSTRUCTION ()
# create a tuple generator by joining two or more iterables
# [(seq_1 [0], seq_2 [0], ...), (seq_1 [1], seq_2 [1], ...), ...]
# truncate the sequence to the length of the shortest input sequence
zip(seq_1, seq_2, ...) # -> zip object (tuple generator)

# LIST COMPREHENSIONS
var = [expression for element in sequence if condition] # create list from pre-existing list (instead of map, filter, reduce) applying any manipulations
# expression can be lambda, if is optional
var = [expression if condition else statement for element in sequence] # list comprehension with IF-ELSE
var = [expression_1 for element in [expression_2 for element in sequence]] # nested list comprehension
var = [(exp_1, exp_2) for item_1 in seq_1 for item_2 in seq_2] # -> [(..., ...), (..., ...), ...]
```

## Tuple

```py linenums="1"
# TUPLES CANNOT BE MODIFIED
tuple = (69, 420, 69, 'abc') # tuple assignment
tuple = (44,) # single element tuples need a comma

tuple[3] # indexing
tuple * 3 # repetition
tuple.count(69) # counting
tuple.index(420) # find index
len(tuple) # length tuple

# CONVERSION FROM TUPLE TO LIST
tuple = tuple(list)

# TUPLE UNPACKING
tup = (item_1, item_2, etc)
var_1, var_2, etc = tup
# var_1 = item_1, var_2 = item_2, ...

tup = (item_1, (item_2, item_3))
var_1, (var_2, var_3) = tup
# var_1 = item_1, var_2 = item_2, var_3 = item_3

#OPERATOR * VAR (tuple unpacking)
var_1, var_2, * rest = sequence # var_1 = seq [0], var_2 = seq [1], rest = seq [2:]
var_1, * body, var_2, var_3 = sequence # var_1 = seq [0], body = seq [1: -2], var_2 = sequence [-2], var_3 = seq [-1]
# * var retrieves the excess items, if in parallel assignment usable max once but in any position
```

## Set

```py linenums="1"
# SETS MAY NOT CONTAIN REPEATED ELEMENTS (THEY ARE OMITTED)
# THE ORDER DOES NOT MATTER (NO SLICING, INDEXING, REPETITION, ...)
set = {10, 20, 30, 'abc', 20}
len(set) # length set
set() # create empty set ({} create empty dictionary)
# FREEZING SETS (no longer editable)
fset = frozenset(set)

# OPERATORS
set_1 - set_2 # elements in set_1 but not in set_2
set_1 | set_2 # elements in set_1 or set_2
set_1 & set_2 # elements in set_1 and set_2
set_1 ^ set_1 # elements in either set_1 or set_2
set_1 <= set_2 # elements set_1 also in set_2
set_1 < set_2 # set_1 <= set_2 and set_1! = set_2
set_1 >= set_2 # elements set_2 also in set_1
set_1 > set_2 # set_1> = set_2 and set_1! = set_2

# METHODS SET
set.pop(item) # remove and return item
set.add(item) # add item to set

set.copy() # -> set # returns a copy of the set
set.clear() # remove all elements from the set
set.remove(item) # remove item from set if present, otherwise raise KeyError
set.discard(item) # remove item from set if present, otherwise do nothing
set.difference(* sets) # -> set # returns elements in set that are absent in * sets
set.difference_update(* sets) # remove differences from set_2
set.union(* sets) # -> set # returns all elements of sets
set.update(* sets) # add * sets elements to set
set.intersection(* sets) # -> set # returns the elements common to sets
set.intersection_update(* sets) # remove all elements except those common to sets
set.symmetric_difference(* sets) # -> set # returns elements not common to sets
set.symmetric_difference_update(* sets) # remove all elements common to sets (leave only uncommon elements)

set_1.isdisjoint(set_2) # -> bool # True if there are no common elements (intersection is empty)
set_1.issubset(set_2) # -> bool # True if every element of set_1 is also in set_2
set_1.issuperset(set_2) # -> bool # True if every element of set_2 is also in set_1

# SET COMPREHENSIONS
var = {expression for element in sequence if condition}

# SLICE OBJECT
# [start: stop: step] -> slice object (start, stop, step)
var_1 = slice(start, stop, step) # assignment to variable
var_2[var_1] # same as var_2 [start: stop: step]

# ELLIPSIS OBJECT
var[i, ...] # -> shortcut for var [i,:,:,:,]
# used for multidimensional slices (NumPy, ...)

```

## Bytes e Bytearray

```py linenums="1"
# THE BYTES CANNOT BE MODIFIED OR INDEXED
# THE BYTEARRAYS CAN BE MODIFIED AND INDEXED
# YOU CANNOT DO REPETITION AND SLICING ON BYTE OR BYTEARRAY

b = bytes(list)
ba = bytearray(list)

# item of bytes and bytearray is always integer between 0 and 255
# slice of bytes and bytearray is binary sequence (even if len = 1)

# BYTES AND BYTEARRAY METHODS
bytes.fromhex(pair_hex_digits) # -> byte literal
b'bite_literal'.hex() # -> str # returns a string containing hex digit pairs
bytearray.fromhex(pair_hex_digits) # -> byte literal
bytes.count(subseq, start, end) # returns subseq appearance count between start and end positions
bytearray.count(subseq, start, end) # returns subseq appearance count between start and end positions
```

## Encoding-Decoding & Unicode

Unicode Literals:

- `\u0041` --> 'A'
- `\U00000041` --> 'A'
- `\x41` --> 'A'

```py linenums="1"
# ENCODING
# transform string into literal byte
# UnicodeEncodeError on error
# errors = ignore -> skip error-causing characters
# errors = replace -> replace? to characters causing error
# errors = xmlcharrefreplace -> substitutes XML entities for error-causing characters
string.encode('utf-8', errors = 'replace') # -> b'byte literals'

# BOM (BYTE ORDER MARK)
# byte literal given to indicate byte ordering (little-endian vs big-endian)
# in little-endian the least significant bytes come first (e.g. U + 0045 -> DEC 069 -> encoded as 69 and 0)
# U + FEFF (ZERO WIDTH NO-BREAK SPACE) -> b '\ xff \ xfe' indicates little-endian

# DECODING
# transform byte literal to string
# error = 'replace' replaces errors (byte literals not belonging to decoding format) with U + FFFD "REPLACEMENT CHARACTER"
bytes.decode ('utf-8', errors = 'replace') # -> str

# UNICODE NORMALIZATION
# handling canonical unicode equivalents (e.g. é, and \ u0301 are equivalent for unicode)
unicodedata.normalize(form, unicode_string) # FORM: NFC, NFD, NFCK, NFDK
# NFC -> "Normalization Form C" -> produces the shortest equivalent string
# NFD -> "Normalization Form D" -> produces the longest equivalent string

# CASE FOLDING UNICODE
# transform to lowercase with some differences (116 differences, 0.11% of Unicode 6.3)
string.casefold()

# USEFUL FUNCTIONS FOR NORMALIZED EQUIVALENCE (Source: Fluent Python p. 121, Luciano Ramalho)
from unicodedata import normalize

def nfc_eual(str_1, str_2):
    return (normalize('NFC', str1) == normalize('NFC', str2))
def fold_equal (str_1, str_2):
    return (normalize('NFC', str_1).casefold() ==
            normalize('NFC', st_2).casefold())
```

## Memoryview

```py linenums="1"
# memoryview objects allow python to access the data inside the object
# without copy if it supports the buffer protocol
v = memoryview(object) # create a memoryview with reference to object
# slice of memoryview produces new memoryview

# MEMORYVIEW METHODS
v.tobytes() # return data as bytestring, equivalent to bytes (v)
v.hex() # returns string containing two hex digits for each byte in the buffer
v.tolist() # returns the data in the buffer as a list of elements
v.toreadonly()
v.release() # release the buffer below
v.cast(format, shape) # change the format or shape of the memoryview
see object # object of the memoryview
v.format # format of the memoryview
v.itemsize # size in bytes of each element of the memoryview
v.ndim # integer indicating the size of the multidimensional array represented
v.shape # tuple of integers indicating the shape of the memoryview
```

| Format String | C Type               | Python Type | Standard Size |
| ------------- | -------------------- | ----------- | ------------- |
| `x`           | `pad byte`           | `no value`  |
| `c`           | `char`               | `bytes`     | `1`           |
| `b`           | `signed char`        | `integer`   | `1`           |
| `B`           | `unsigned char`      | `integer`   | `1`           |
| `?`           | `_Bool`              | `bool`      | `1`           |
| `h`           | `short`              | `integer`   | `2`           |
| `H`           | `unsigned short`     | `integer`   | `2`           |
| `i`           | `int`                | `integer`   | `4`           |
| `I`           | `unsigned int`       | `integer`   | `4`           |
| `l`           | `long`               | `integer`   | `4`           |
| `L`           | `unsigned long`      | `integer`   | `4`           |
| `q`           | `long long`          | `integer`   | `8`           |
| `Q`           | `unsigned long long` | `integer`   | `8`           |
| `n`           | `ssize_t`            | `integer`   |
| `N`           | `size_t`             | `integer`   |
| `f`           | `float`              | `float`     | `4`           |
| `F`           | `double`             | `float`     | `8`           |
| `s`           | `char[]`             | `bytes`     |
| `P`           | `char[]`             | `bytes`     |

## Dictionaries

```py linenums="1"
# SET OF KEY-VALUE PAIRS
d = {1: 'Alex', 2: 'Bob', 3: 'Carl'}
d = dict (one = 'Alex', two = 'Bob', three = 'Carl')
d = dict (zip ([1,2,3], ['Alex', 'Bob', 'Carl']))
d = dict ([(1, 'Alex'), (2, 'Bob'), (3, 'Carl')])

d[key] # returns value associated with key
d[4] = 'Dan' # add or change element
list(d) # returns a list of all elements
len(d) # returns the number of elements
del(d[2]) # delete element

# DICTIONARY METHODS
d.clear() # remove all elements
d.copy() # shallow copy of the dictionary
d.get(key) # returns the value associated with key
d.items() # return key-value pairs (view object)
d.keys() # return dictionary keys (view object)
d.values​​() # returns dictionary values ​​(view object)
d.pop(key) # remove and return the value associated with key
d.popitem() # remove and return the last key-value pair
d.setdefault(key, default) # if the key is present in the dictionary it returns it, otherwise it inserts it with the default value and returns default

d.update(iterable) # add or modify dictionary elements, argument must be key-value pair

# DICT UNION
d = {'spam': 1, 'eggs': 2, 'cheese': 3}
e = {'cheese': 'cheddar', 'aardvark': 'Ethel'}

d | e # {'spam': 1, 'eggs': 2, 'cheese': 'cheddar', 'aardvark': 'Ethel'}
e | d # {'aardvark': 'Ethel', 'spam': 1, 'eggs': 2, 'cheese': 3}
d |= e # {'spam': 1, 'eggs': 2, 'cheese': 'cheddar', 'aardvark': 'Ethel'}

# NESTED DICTIONARIES (it is possible to nest dictionaries within dictionaries)
my_dict = {'key_1': 123, 'key_2': [12, 23, 33], 'key_3': ['item_0', 'item_1', 'item_2']}
my_dict ['key'][0] # returns nested element

# DICT COMPREHENSIONS
var = {key: value for element in sequence}
```

## Operators

### Mathematical Operators

| Operator | Operation                      |
| -------- | ------------------------------ |
| x `+` y  | addition, string concatenation |
| x `-` y  | subtraction                    |
| x `*` y  | multiplication                 |
| x `*+` y | exponentiation                 |
| x `/` y  | division (result always float) |
| x `//` y | integer division               |
| x `%` y  | modulo, remainder              |

### Relational Operators

| Operator | Operation           |
| -------- | ------------------- |
| x `<` y  | less than           |
| x `<=` y | less or equal to    |
| x `>` y  | greater than        |
| x `>=` y | greater or equal to |
| x `==` y | equality            |
| x `!=` y | inequality          |

### Assignment

| Operator  | Operation  |
| --------- | ---------- |
| x `+=` y  | x = x + y  |
| x `-=` y  | x = x - y  |
| x `*=` y  | x = x \* y |
| x `/=` y  | x = x / y  |
| x `//=` y | x = x // y |
| x `%=` y  | x = x % y  |
| x `<<=` y | x = x << y |
| x `>>=` y | x = x >> y |
| x `&=` y  | x = x & y  |
| x `       | =` y       | x = x | y |
| x `^=` y  | x = x ^ y  |

### Bitwise Operators

| Operator | Operation       |
| -------- | --------------- |
| `~`x     | bitwise NOT     |
| x `&` y  | bitwise AND     |
| x `^` y  | bitwise XOR     |
| x `|` y  | bitwise OR      |
| x `<<` y | left bit shift  |
| x `>>` y | right bit shift |

### Logical Operators

| Operator | Operation   |
| -------- | ----------- |
| `and`    | logical AND |
| `or`     | logical OR  |
| `not`    | logical NOT |

### Identity Operators

| Operator | Operation            |
| -------- | -------------------- |
| `is`     | reference equality   |
| `is not` | reference inequality |

### Membership Operators

| Operator | Operation              |
| -------- | ---------------------- |
| `in`     | item in collection     |
| `not in` | item not in collection |

### OPerator Precedence

1. assignment operators `+=`, `-=`, `*=`, `/=`, `%=`, `**=`, `//=`
2. binary arithmetic operators `*`, `/`, `%`, `//` (floor division)
3. binary arithmetic operators `+`, `-`
4. boolean operators `<`, `>`, `<=`, `>=`
5. boolean operators `==`, `!=`
6. boolean operator `and`
7. boolean operator `or`
8. boolean operator `not`

## Conditional Statements

Any object can be tested for truth value for use in an if or while condition or as operand of the Boolean operations.

built-in objects considered *false*:

- constants defined to be false: `None` and `False`.
- zero of any numeric type: `0`, `0.0`, `0j`, `Decimal(0)`, `Fraction(0, 1)`
- empty sequences and collections: `''`, `()`, `[]`, `{}`, `set()`, `range(0)`

### `if-else`

```py linenums="1"
if (condition):
    # code here
elif (condition):
    # code here
else:
    # code here
```

### Context Manager

```py linenums="1"
with resource as target:
     # code here

# start context manager and bind resource returned by method to target using as operator
contextmanager.__enter__(self)

# exit runtime context
# returns exc_type, exc_value, traceback
contextmanager.__exit__(self, exc_type, exc_value, traceback)
# exc_type: exception class
# exc_value: exception instance
# traceback: traceback object
# NO EXCEPTION -> returns None, None, None
# SUPPRESSION EXCEPTION: Must return True value
```

## Loops

### `while`

```py linenums="1"
while(condition):
     # code here
else:
     # executed only if condition becomes False
     # break, continue, return in block while do not perform else block
     # code here
```

### `for`

```py linenums="1"
for index in sequence: # sequence can be a list, set, tuple, etc ..
     # code here
else:
     # executed only if for reaches the end of the loop
     # break, continue, return in block for do not perform else block
     # code here

for index in range (start, end, step):
     # code here

for key, value in dict.items ():
     # code here
```

### `break` & `continue`

`break`: causes the loop to exit immediately without executing subsequent iterations
`continue`: skip the remaining iteration statements and continue the loop

### `range`

```py linenums="1"
range(start, end, step) # generate sequence num integers (does not include num stops) with possible step
list(range(start, end, step)) # return sequence of integers in a list
```

### `enumerate`

```py linenums="1"
enumerate(iterable) # iterable of item & index pairs
list(enumerate(iterable)) # returns list of tuples [(1, iterable [0]), (2, iterable [1]), (3, iterable [2])]
```

### `zip`

```py linenums="1"
list_1 = [1, 2, 3, 4, 5]
list_2 = ['a', 'b', 'c', 'd', 'e']

zip(list_1, list_2) # return zip object
list(zip(list_1, list_2)) # returns list of tuples by merging list [(list_1 [0], list_2 [0]), (list_1 [1], list_2 [1]), ...]
```

### `shuffle` & `randint`

```py linenums="1"
from random import shuffle, randint
shuffle(iterable) # shuffle the list
randint(start, end) # returns a random integer between start and end
```

### `in`

```py linenums="1"
item in iterable # check for the presence of item in iterable (returns True or False)
```

## Functions

### Function Definition

```py linenums="1"
def function_name (parameters):
     "" "DOCSTRING" ""
     # code here
     return expression # if return id missing the function returns None
```

### Specify Type Parameters In Functions

- parameters before `/` can only be *positional*
- parameters between `/` and `*` can be *positional* or *keyworded*
- parameters after `*` can only be *keyworded*
  
```py linenums="1"
def func (a, b, /, c, d, *, e, f):
     # code here
```

### Docstring Style

```py linenums="1"
"""function description

Args:
     argument: Type - description of the parameter

Returns:
     Type - description of <expr>

Raises:
     Exception: Cause of the exception
"""
```

### *args **kwargs

`*args` allows the function to accept a variable number of parameters (parameters stored in a tuple)
`**kwargs` allows the function to accept a variable number of key-value parameters (parameters stored in a dictionary)

When used in combination `*args` always goes before`**kwargs` (in def function and in function call)

```py linenums="1"
def func(*args, **kwargs):
    # code here
```

### Function with default parameters

```py linenums="1"
def function(parameter1 = value1, parameter2 = value3): # default values in case of omitted use of arguments in the call
     # code here
     return expression

function(parameter2 = value2, parameter1 = value1) # arguments passed with keyword to enforce the order of reference
```

### Global And Local Variables

```py linenums="1"
# global scope

def external_func():
     # enclosing local scope

     def internal_func():
         # local scope
```

**LEGB Rule**:

- **L** - **Local**: Names assigned in any way within a function (`def` or `lambda`), and not declared global in that function.
- **E** - **Enclosing function locals**: Names in the local scope of any and all enclosing functions (`def` or `lambda`), from inner to outer.
- **G** - **Global** (module): Names assigned at the top-level of a module file, or declared global in a def within the file.
- **B** - **Built-in** (Python): Names preassigned in the built-in names module : `open`, `range`, `SyntaxError`,...

`Note`: variables declared inside a function are not usable outside

```py linenums="1"
def function():
     # global statement makes a variable global
     # actions on global variable within the function also have an effect outside

     global variable
```

### Iterables, Iterators & Generators

**Iterable**: object implementing `__iter __()`, sequences and objects supporting `__getitem__` with index `0`

**Iterator**: object implementing `__next__` and `__iter__` (**iterator protocol**), when entirely consumed by `next()` it becomes unusable. Returns `StopIteration` when `next()` has returned all elements.

**Generator Function**: function with keyword `yield` (if present also `return` causes `StopIteration`), returns a generator that produces the values ​​one at a time.

**Generator Factory**: generator returning function (may not contain `yield`).

Operation `iter()`:

- calls `__iter__()`
- in the absence of it python uses `__getitem__()` (if present) to create an iterator that tries to retrieve the items in order, starting from the index `0`
- on failure it returns `TypeError`
  
**Note**: `abc.Iterable` does not check for the presence of `__getitem__` to decide if a sub-object is a member therefore the best test for iterability is to use `iter()` and handle exceptions.

### `next()` & `iter()`

```py linenums="1"
next(iterable) # next item of the iterable or error StopIteration

iter(object) # get an iterator from an object
# call callable_onj.next () with no arguments as long as it returns non-sentinel values

iter(callable_obj, sentinel)
```

### Customs Generators

Used to generate a sequence of values to be used once (they are not stored)

```py linenums="1"
def custom_generator(parameters):
     while condition: # or for loop
         yield variable # returns the value without terminating the function, values passed to the caller without storing in a variable

# generator implementation
for item in custom_generator(parameters):
     # code here
```

### Termination Generator And Exception Handling

```py linenums="1"
# raise exception at the suspension point and return generator value
# if the generator terminates without returning values it raises StopIteration
# if an exception is not handled it is propagated to the caller
generator.throw(ExceptionType, exception_value, traceback)

# raises GeneratorExit to the point of suspension
# if generator returns a value -> RuntimeError
# if an exception is raised it propagates to the caller
generator.close()
```

### Generator Comprehensions

```py linenums="1"
# zero-length sequence (instantaneously generated values)
var = (for expression iterable in sequence if condition)
# EDUCATION ENUMERATE ()
# returns a list of tuples associating a position index to each element of the sequence
# [(0, sequence [0]), (1, sequence [1]), (2, sequence [2]), ...)
enumerate(sequence) # -> enumerate object
```

## Coroutines

```py linenums="1"
def simple_coroutine():
    """coroutine defined as a generator: yield in block"""

    # yield in expression to receive data
    # returns None (no variables on the right of yield)
    var = yield value # returns value and then suspends coroutine waiting for input
    # instructions to the right of = executed before instructions to the left of =

gen_obj = simple_coroutine() # returns generator object
next(gen_obj) # start coroutine (PRIMING)
gen_obj.send(None) # start coroutine (PRIMING)
gen_obj.send(value) # send value to the coroutine (only possible in suspended state)

# STATES OF COROUTINE
inspect.generatorstate() # returns the status of the coroutine
# GEN_CREATED: waiting to start execution
# GEN_RUNNING: currently run by the interpreter (visible if multithreaded)
# GEN_SUSPENDED: currently suspended by yield statement
# GEN_CLOSED: execution completed successfully

# COROUTINE PRIMING
from functools import wraps

def coroutine(func):
    "Decorator: primes 'func' by advancing to first 'yield'"

    @wraps(func)
    def primer(*args, **kwargs):
        gen = func(*args, **kwargs)
        next(gen)
        return gen
    return primer

# COROUTINE TERMINATION AND EXCEPTION HANDLING
# exceptions in unhandled coroutines propagate to subsequent iterations
# an exception causes the coroutine to terminate which it cannot resume

# yield raises exception, if handled loop continues
# throw() returns value of the generator
coroutine.throw(exc_type, exc_value, traceback)

# yield raises GeneratorExit to the suspension point
# if the generator yields a value -> RuntimeError
# if there are other exceptions they are propagated to the caller
coroutine.close()
# coroutine state becomes GEN_CLOSED
```

### `yield from <iterabile>`

**Note**: auto-priming generators incompatible with `yield from`

**DELEGATING GENERATOR**: generator function containing `yield from`
**SUBGENERATOR**: generator obtained from `yield from`
**CALLER-CLIENT**: code calling *delegating generator*

The main function of `yield from` is to open a bidirectional channel between the external caller (*client*) and the internal *subgenerator* so that values and exceptions can pass between the two.

1. client calls delegating generator, delegating generator calls subgenerator
2. exhausted subgenerator returns value to `yield from <expr>` (`return <result>` statement)
3. delegating generator returns `<expr>` to client

- Any values that the subgenerator yields are passed directly to the caller of the delegating generator (i.e., the client code).

- Any values sent to the delegating generator using `send()` are passed directly to the subgenerator.
  - If the sent value is `None`, the subgenerator's `__next__()` method is called.
  - If the sent value is not `None`, the subgenerator's `send()` method is called.
  - If the call raises `StopIteration`, the delegating generator is resumed.
  - Any other exception is propagated to the delegating generator.

- `return <expr>` in a generator (or subgenerator) causes `StopIteration(<expr>)` to be raised upon exit from the generator.

- The value of the `yield from` expression is the first argument to the `StopIteration` exception raised by the subgenerator when it terminates.

- Exceptions other than `GeneratorExit` thrown into the delegating generator are passed to the `throw()` method of the subgenerator.
  - If the call raises `StopIteration`, the delegating generator is resumed.
  - Any other exception is propagated to the delegating generator.

- If a `GeneratorExit` exception is thrown into the delegating generator, or the `close()` method of the delegating generator is called, then the `close()` method of the subgenerator is called if it has one.
  - If this call results in an exception, it is propagated to the delegating generator.
  - Otherwise, `GeneratorExit` is raised in the delegating generator

```py linenums="1"
def sub_gen():
     sent_input = yield
     # result of sub_gen() returned to delegating_gen()
     # result of yield from <expr>

     return result

def delegating_gen(var):
     var = yield from sub_gen() # get values from sub_gen

def client():
     result = delegating_gen() # use delegating_gen
     result.send(None) # terminate sub_gen instance (IMPORTANT)
```

## LAMBDA Functions

Possible use within functions. Useful for replacing functions if the logic is simple.

```py linenums="1"
var = lambda argument_list: <expression>
```

## Object Oriented Programming

### Class Definition

```py linenums="1"
class Class:

    static_var = expression

    def __init__(self, value_1, value_2): # parameterized default constructor
        self.variable = value_1 # create instance variables
        self.__private = value_2 # private, accessed via NAME MANGLING

    def method(self, parameters):
        ...

    @staticmethod
    def static_method(parameters): # static methods do not affect instance variables (SELF not needed)
        ...

    @classmethod # method acting on the class and not on the object (useful for alternative constructors)
    def class_method(cls, parameters):
        ...

    object = Class(parameters) # creation of an object
    object.variable = expression # edit public variable
    object.method(parameters) # invocation method of instance
    object._Class__private # access to variable specifying the membership class (NAME MANGLING)
    Class.method(parameters) # static method invocation
```

### Setter & Getter with `@Property`

```py linenums="1"
class Class:
     def __init__(self, parameter):
         self.__parameter = parameter

     @property # getter
     def parameter(self):
         return self.__parameter

     @<parameter>.setter
     def parameter(self, value):
         self.__parameter = value
```

### `__slots__`

The `__slots__` attribute implements the **Flyweight Design Pattern**: it saves the instance attributes in a tuple and can be used to decrease the cost in memory by inserting only the instance variables into it (suppress the instance dictionary).

**Default**: attributes saved in a dictionary (`object .__ dict__`)
**Usage**: `__slots_ = [attributes]`

`__slots__` is not inherited by subclasses, it prevents dynamically adding attributes.

### Inner Classes

```py linenums="1"
class Class:
     def __init__(self, parameters):
         ...

     class InnerClass:
         def __init__(self, parameters):
             ...

         def method(self):
             ...

object_1 = Class(arguments) # create 'external' class
object_2 = Class.InnerClass(arguments) # inner class created as object of the 'external' class
```

### Special Methods

Special methods are defined by the use of double underscores; they allow the use of specific functions (possibly adapted) on the objects defined by the class.

```py linenums="1"
class Class():

     def __init__(self, parameters):
         instructions

     # used by str() and print() method
     # handle requests for impersonation as a string
     def __str__ (self):
         return expression # return required

     def __len__ (self):
         return expression # must return as len requires a length / size

     def __del__ (self): # delete the class instance
         instruction # any instructions that occur on deletion

object = Class()
len(object) # special function applied to an object
del object # delete object
```

#### Special Methods List

**Note**: if the operator cannot be applied, returns `NotImplemented`

```py linenums="1"
# arithmetic operators
__add__(self, other)         # +
__sub__(self, other)         # -
__mul__(self, other)         # *
__matmul__(self, other)      # (@) matrix multiplication
__truediv__(self, other)     # /
__floordiv__(self, other)  # //
__mod__(self, other)         # %
__divmod__(self, other)      # divmod()
__pow__(self, other)         # **, pow()
__lshift__(self, other)      # <<
__rshift__(self, other)      # >>
__and__(self, other)         # &
__xor__(self, other)         # ^
__or__(self, other)          # |

# reflex arithmetic operators
# if self.__ dunder __(other) fails, other.__ dunder__(self) is called
__radd__(self, other)         # reverse +
__rsub__(self, other)         # reverse -
__rmul__(self, other)         # reverse *
__rmatmul__(self, other)      # reverse @
__rtruediv__(self, other)     # reverse /
__rfloordiv__(self, other)    # reverse //
__rmod__(self, other)         # reverse %
__rdivmod__(self, other)      # reverse divmod()
__rpow__(self, other)         # reverse **, pow()
__rlshift__(self, other)      # reverse <<
__rrshift__(self, other)      # reverse >>
__rand__(self, other)         # reverse &
__rxor__(self, other)         # reverse ^
__ror__(self, other)          # reverse |

# in-place arithmetic operators
# base implementation (built-in) like self = self <operator> other
#! not to be implemented for immutable objects!
#! in-place operators return self!
__iadd__(self, other)         # +=
__isub__(self, other)         # -=
__imul__(self, other)         # *=
__imatmul__(self, other)      # @=
__itruediv__(self, other)     # /=
__ifloordiv__(self, other)    # //=
__imod__(self, other)         # %=
__ipow__(self, other)         # **=
__ilshift__(self, other)      # <<=
__irshift__(self, other)      # >>=
__iand__(self, other)         # &=
__ixor__(self, other)         # ^=
__ior__(self, other)          # |=

# unary mathematical operators (-, +, abs (), ~)
__neg__(self)  # (-) negazione matematica unaria [if x = 2 then -x = 2]
__pos__(self)  # (+) addizione unaria [x = +x]
__abs__(self)  # [abs()] valore assoluto [|-x| = x]
__invert__(self)  # (~) inversione binaria di un intero [~x == -(x + 1)]

# numeric type conversion
__complex__(self)
__int__(self)  # if not defined fall-back on __trunc__()
__float__(self)
__index__(self)  # conversion in bin(), hex(), oct() e slicing

# operations round() math.trunc(), math.floor(), math.ceil()
__round__(self)
__trunc__(self)
__floor__(self)
__ceil__(self)

# equality operators
self.__eq__(other)  # self == other
self.__ne__(other) # self != other
self.__gt__(other) # self > other
self.__ge__(other) # self >= other
self.__lt__(other) # self < other
self.__le__(other) # self <= other

# reflected equality operators
other.__eq__(self)  # other == self,   fall-back id(self) == id(other)
other.__ne__(self)  # other != self,   fall-back not (self == other)
other.__gt__(self)  # reverse self < other,   fall-back TypeError
other.__ge__(self)  # reverse self <= other,   fall-back TypeError
other.__lt__(self)  # reverse self > other,   fall-back TypeError
other.__le__(self)  # reverse self >= other,   fall-back TypeError

# called when the instance is "called" as a function
# x (arg1, arg2, arg3) is short for x .__ call __ (arg1, arg2, arg3)
__call__(self, args)

# string object representation for the developer
__repr__(self)

# string object representation for user (used by print)
__str__(self)

# specify formatting for format ), str.format() [format_spec = format-mini-language]
__format__(format_spec)

# returns unique (integer) value for objects that have equal value
# __EQ__ MUST EXIST IN THE CLASS, usually hash((self.param_1, self.param_2, ...))
__hash__(self)

# makes object iterable:
# - returning self (in the iterator)
# - returning an iterator (in the iterable)
# - using yield (in the __iter__ generator)
__iter__(self)

# returns next available element, StopIteration otherwise (iterator scrolls)
__next__()

# returns truth value
__bool__()

# returns item associated with key of a sequence (self [key])
# IndexError if key is not appropriate
__getitem__(self, key)

# item assignment operation in sequence (self [key] = value)
# IndexError if key is not appropriate
__setitem__(self, key, value)

# operation deleting item in sequence (del self [key])
# IndexError if key is not appropriate
__delitem__(self, key)

# called by dict.__getitem__() to implement self [key] if key is not in the dictionary
__missing__(self, key)

# implement container iteration
__iter__(self)

# implement membership test
__contains__(self, item)

# implementation issublass (instance, class)
__instancecheck__(self, instance)

# implementation issubclass (subclass, class)
__subclasscheck__(self, subclass)

# implement attribute access (obj.name)
# called if AttributeError happens or if called by __getattribute __()
__getattr__(self, name)

# implement value assignment to attribute (obj.name = value)
__setattr__(self, name, value)
```

**Note**: Itearbility is tricky.

To make an object directly iterable (`for i in object`) `__iter__()` and `__next__()` are needed.
To make an iterable through an index (`for i in range(len(object)): object[i]`) `__getitem()__` is needed.

Some of the mixin methods, such as `__iter__()`, `__reversed__()` and `index()`, make repeated calls to the underlying `__getitem__()` method.
Consequently, if `__getitem__()` is implemented with constant access speed, the mixin methods will have linear performance;
however, if the underlying method is linear (as it would be with a linked list), the mixins will have quadratic performance and will likely need to be overridden.

### Inheritance

```py linenums="1"
class Parent ():
    def __init __ (self, parameters):
        ...

    def method_1(self):
        ...

    def method_2(self):
        ...

class Child(Parent): # parent class in parentheses to inherit variables and methods

    def __init__(self, parameters, parent_parameters):
        Parent.__init__(self, parent_parameters) # inherit parent variables
        ...

    def method (self):
        ...

    def method_parent_1 (self): # override method (child class with homonymous method to parent class)
        ...

class Child(Parent): # parent class in brackets to inherit properties

    def __init__(self, parameters, parent_parameters):
        super().__init__(parent_parameters) # different method to inherit parent variables (SELF not needed) using SUPER()
        super(Parent, self).__init__(parent_parameters) # parent constructor invoked separately

    def method(self):
        ...

    def method_2(self): # parent method updated
        super().method_2() # invoke parent method as is
        ...
```

### Polymorphism

**Note**: python does not support method overloading

```py linenums="1"
# DUCKTYPING
# Working with objects regardless of their type, as long as they implement certain protocols

class Class1:
    def method_1(self):
        ...

class Class2:
    def method_1(self):
        ...

# since python is a dynamic language it doesn't matter what type (class) the object passed is
# the function invokes the object method passed regardless of the object class
def polymorph_method(object):
    object.method_1()

# DEPENDENCY INJECTION WITH DUCKTYPING
class Class:
    def __init__(self, object):
        self.dependency = object

    def method_1(self): # the function invokes the method of the object passed
        self.dependency.method_1()
```

### Operator Overloading

**Operators fundamental rule**: *always* return an object, if operation fails return `NotImplemented`

Limitations of operator overloading:

- no overloading of built-in types
- no creation of new operators
- no overloading operators `is`, `and`, `or`, `not`

### Astrazione

The **interfaces** are abstract classes with *all* abstract methods, they are used to indicate which methods such as child classes *must* have. Interfaces have *only* a list of abstract methods.

**abstract classes** have *at least* one abstract method; child classes that inherit from an abstract class *must* implement abstract methods. Abstract classes *cannot* be instantiated.

Virtual subclasses are used to include third-party classes as subclasses of a class of their own. They are recognized as belonging to the parent class without however having to implement their methods.

The `@Class.register` or `Class.register(subclass)` decorators are used to mark subclasses.

```py linenums="1"
from abc import abstractmethod, ABC

class Abstract(ABC): # abstract class MUST INHERIT from parent class ABC
    def __init__(self, parameters):
        ...

    def parent_method (self):
        ...

    @abstractmethod # abstract method MUST be marked with @abstractmethod decorator
    def abstract_method (self):
        pass
        # abstract method MUST be overridden (can be non-empty)
        # super() to invoke it in the concrete class

class Child(Abstract):

    def __init__(self, parameters, parent_parameters):
        parent_class.__init__(self, parent_parameters)

    def method (self):
        ...

    def parent_method (self): # override method (child class with homonymous method to parent class)
        ...

    def abstract_method (self): # implementation of abstract method inherited from abstract class (NECESSARY) by override
        ...
```

## Exception Handling

```py linenums="1"
# CHECK ASERATIONS
assert condition, 'error message' # if the assertion is false show an error message

# particular errors are objects of a particular class of exceptions which in turn is a child of the base exception class (exception)
class CustomExceptionError(Exception): # MUST somehow inherit from class exception (even in later inheritance steps)
    pass # or instructions

# try block contains code that might cause an exception
# code inside try and after the error it is not executed
try:
    ...
    raise CustomExceptionError ("message") # raise the exception

# except takes control of error handling without passing through the interpreter
# block executed if an error occurs in try

# except error specified by class
except ExceptionClass:
    # Default error message is not shown
    # the program does not stop

# except on generic errors
except:
     # code here

# block executed if exception does not occur
else:
    # code here

# block executed in all cases, cleanup code goes here
finally:
    # code here
```

## File

### Opening A File

Text file opening mode:

- `w`: write, overwrite the contents of the file
- `r`: read, read file contents
- `a`: append, add content to the file
- `w +`: write & read
- `r +`: write & read & append
- `a +`: append & read
- `x`: exclusive creation, if the file already exists -> `FileExistError` (extended write mode)

Open binary file mode:

- `wb`: write, overwrites the contents of the file
- `rb`: read, read file contents
- `ab`: append, add content to the file
- `w + b`: write & read
- `r + b`: write & read & append
- `a + b`: append & read
- `xb`: exclusive creation, if the file already exists -> `FileExistError` (extended write mode)

**Note**: Linux and MacOSX use `UTF-8` everywhere while windows uses `cp1252`, `cp850`,`mbcs`, `UTF-8`. Don't rely on default encoding and use **explicitly** `UTF-8`.

```py linenums="1"
object = open('filename', mode = 'r', encoding = 'utf-8') # encoding MUST BE utf-8 for compatibility
# filename can be the absolute path to the file location (default: file created in the source code folder)
# double slash to avoid \ escaping

with open('filename') as file:
    instructions_to_file # block use filename to indicate file

# CLOSE A FILE
object.close()

# WRITE TO A FILE
object.write(string) # write single string to file
object.writelines(* strings) # write multiple strings to file

# READING FROM A FILE
object.read() # return ALL the contents of the file (including escape sequence) and place the "cursor" at the end of the file
object.seek(0) # returns 0 (zero) and places the cursor at the beginning of the file
object.readlines() # return list of file lines (ATTENTION: keep everything in memory, be careful with large files)
object.readline() # returns single line file

# CHECK FILE EXISTENCE
import os, sys
if os.path.isfile('filepath'): # check file existence (TRUE if it exists)
    # code here
else:
    # code here
    sys.exit() # exits the program and does not execute the next cosice
```

## COPY

**SHALLOW COPY**: copies the "container" and references to the content
**DEEP COPY**: copies the "container" and contents (no reference)

```py linenums="1"
copy (x) # returns shallow copy of xor
deepcopy (x) # returns shallow copy of x
```
