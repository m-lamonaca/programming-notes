# JavaScript Cheat Sheet

## Basics

### Notable javascript engines

- **Chromium**: `V8` from Google  
- **Firefox**: `SpiderMonkey` from Mozilla  
- **Safari**: `JavaScriptCore` from Apple  
- **Internet Explorer**: `Chakra` from Microsoft  

### Comments

```javascript
//single line comment
/*multiline comment*/
```

### File Header

```javascript
/**
 * @file filename.js
 * @author author's name
 * purpose of file
 *
 * detailed explanantion of what the file does on multiple lines
 */
```

### Naming Conventions

| Elements | Case      |
| -------- | --------- |
| variable | camelCase |

### Modern Mode

If located at the top of the script the whole script works the “modern” way (enables post-ES5 functionalities).  
`"use strict"`

### Pop-Up message

Interrupts script execution until closure, **to be avoided**

```javascript
alert("message");
```

### Print message to console

`console.log(value);`

## Variables

### Declaration & Initialization

[var vs let vs const](https://www.freecodecamp.org/news/var-let-and-const-whats-the-difference/)

Variable names can only contain numbers, digits, underscores and $. Varieble names are camelCase.

`let`: Block-scoped; access to variable restricted to the nearest enclosing block.
`var`: Function-scoped

`let variable1 = value1, variable2 = value2;`
`var variable1 = value1, variable2 = value2;`

### Scope

Variabled declared with `let` are in local to the code block in which are declared.
Variabled declared with `var` are local only if declared in a function.

```js
function func(){
    variable = value;  // implicitly declared as a global variable
    var variable = value;  // local variable
}

var a = 10;  // a is 10
let b = 10;  // b is 10
{
    var x = 2, a = 2;  // a is 2
    let y = 2, b = 2;  // b is 2
}
// a is 2, b is 10
// x can NOT be used here
// y CAN be used here
```

### Constants

Hard-coded values are UPPERCASE and snake_case, camelCase otherwise.  
`const CONSTANT = value;`

## Data Types

`Number`, `String`, `Boolean`, etc are *built-in global objects*. They are **not** types. **Do not use them for type checking**.

### Numeric data types

Only numeric type is `number`.

```javascript
let number = 10;  //integer numbers
number = 15.7;  //floating point numbers
number = Infinity;  //mathematical infinity
number = - Infinity;
number = 1234567890123456789012345678901234567890n;  //BigInt, value > 2^53, "n" at the end
number = "text" / 2;  //NaN --> not a number.
```

[Rounding Decimals in JavaScript](https://www.jacklmoore.com/notes/rounding-in-javascript/)
[Decimal.js](https://github.com/MikeMcl/decimal.js)

Mathematical expression will *never* cause an error. At worst the result will be NaN.

### String data type

```javascript
let string = "text";
let string$ = 'text';
let string_ = `text ${expression}`;  //string interpolation (needs backticks)

string.length;  // length of the string
let char = string.charAt(index);  // extaraction of a single character by position
string[index]; // char extraction by property access
let index = strinf.indexOf(substring);  // start index of substring in string
```

Property access is unpredictable:

- does not work in IE7 or earlier
- makes strings look like arrays (confusing)
- if no character is found, `[ ]` returns undefined, `charAt()` returns an empty string
- Is read only: `string[index] = "value"` does not work and gives no errors

### [Slice vs Substring vs Substr](https://stackoverflow.com/questions/2243824/what-is-the-difference-between-string-slice-and-string-substring)

If the parameters to slice are negative, they reference the string from the end. Substring and substr doesn´t.

```js
string.slice(begin [, end]);
string.substring(from [, to]);
string.substr(start [, length]);
```

### Boolean data type

```javascript
let boolean = true;
let boolean_ = false;
```

### Null data type

```javascript
let _ = null;
```

### Undefined

```javascript
let $;  //value is "undefined"
$ = undefined;
```

### Typeof()

```javascript
typeof x;  //returns the type of the variable x as a string
typeof(x);  //returns the type of the variable x as a string
```

The result of typeof null is "object". That’s wrong.  
It is an officially recognized error in typeof, kept for compatibility. Of course, null is not an object.
It is a special value with a separate type of its own. So, again, this is an error in the language.  

### Type Casting

```javascript
String(value);  //converts value to string

Number(value);  //converst value to a number
Number(undefined);  //--> NaN
Number(null);  //--> 0
Number(true);  //--> 1
Number(false);  //--> 0
Number(String);  //Whitespaces from the start and end are removed. If the remaining string is empty, the result is 0. Otherwise, the number is “read” from the string. An error gives NaN.

Boolean(value);  //--> true
Boolean(0); //--> false
Boolean("");  //--> false
Boolean(null);  //--> false
Boolean(undefined);  //--> false
Boolean(NaN);  //--> false


//numeric type checking the moronic way
typeof var_ == "number";  // typeof returns a string with the name of the type
```

### Type Checking

```js
isNaN(var);  // converts var in number and then check if is NaN

Number("A") == NaN;  //false ?!?

```

### Dangerous & Stupid Implicit Type Casting

```js
2 + 'text';  //"2text", implicit conversion and concatenation
1 + "1";  //"11", implicit conversion and concatention
"1" + 1;  //"11", implicit conversion and concatention
+"1";  //1, implicit conversion
+"text";  // NaN
1 == "1";  //true
1 === "1";  //false
1 == true;  //true
0 == false;  //true
"" == false;  //true
```

## Operators

| Operator     | Operation       |
| ------------ | --------------- |
| `(...)`      | grouping        |
| a`.`b        | member access   |
| `new` a(...) | object creation |
| a `in` b     | membership      |

### Mathemetical Operators

| Operator | Operation      |
| -------- | -------------- |
| a `+` b  | addition       |
| a `-` b  | subtraction    |
| a `*` b  | multiplication |
| a `**` b | a^b            |
| a `/` b  | division       |
| a `%` b  | modulus        |

### Unary Increment Operators

| Operator     | Operation         |
| ------------ | ----------------- |
| `--`variable | prefix decrement  |
| `++`variable | prefix incremente |
| variable`--` | postfiz decrement |
| variable`++` | ostfix increment  |

### Logical Operators

| Operator | Operation       |
| -------- | --------------- |
| a `&&` b | logical **AND** |
| a `||` b | logical **OR**  |
| `!`a     | logical **NOT** |

### Comparison Operators

| Operator  | Operation           |
| --------- | ------------------- |
| a `<` b   | less than           |
| a `<=` b  | less or equal to    |
| a `>` b   | greater than        |
| a `>=` b  | greater or equal to |
| a `==` b  | equaltity           |
| a `!=` b  | inequality          |
| a `===` b | strict equality     |
| a `!==` b | strict inequality   |

### Bitwise Logical Operators

| Operator  | Operation                    |
| --------- | ---------------------------- |
| a `&` b   | bitwise AND                  |
| a `|` b   | bitwise OR                   |
| a `^` b   | bitwise XOR                  |
| `~`a      | bitwise NOT                  |
| a `<<` b  | bitwise left shift           |
| a `>>` b  | bitwise rigth sigt           |
| a `>>>` b | bitwise unsigned rigth shift |

### Compound Operators

| Operator   | Operation   |
| ---------- | ----------- |
| a `+=` b   | a = a + b   |
| a `-=` b   | a = a - b   |
| a `*=` b   | a = a * b   |
| a `**=` b  | a = a ** b  |
| a `/=` b   | a = a / b   |
| a `%=` b   | a = a % b   |
| a `<<=` b  | a = a << b  |
| a `>>=` b  | a = a >> b  |
| a `>>>=` b | a = a >>> b |
| a `&=` b   | a = a & b   |
| a `^=` b   | a = a ^ b   |
| a `|=` b   | a = a ! b   |

## Decision Statements

### IF-ELSE

```javascript
if (condition) {
    //code here
} else {
    //code here
}
```

### IF-ELSE Multi-Branch

```javascript
if (condition) {
    //code here
} else if (condition) {
    //code here
} else {
    //code here
}
```

### Ternary Operator

`condition ? instruction1 : istruction2;`  
Ff TRUE execute instruction1, execute instruction2 otherwise.

### Switch Statement

```javascript
switch (expression) {
    case expression:
        //code here
        break;

    default:
        //code here
        break;
}
```

## Loops

### While Loop

```javascript
while (condition) {
    //code here
}
```

### Do-While Loop

```javascript
do {
    //code here
} while (condition);
```

### For Loop

```javascript
// baseic for
for (begin; condition; step) { }

for (var variable in iterable) { }  // for/in statement loops through the properties of an object
for (let variable in iterable) { }  // inistatiate a new variable at each iteration

// for/of statement loops through the values of an iterable objects
// for/of lets you loop over data structures that are iterable such as Arrays, Strings, Maps, NodeLists, and more.
for (var variable of iterable) { }
for (let variable of iterable) { }  // inistatiate a new variable at each iteration

// foreach (similar to for..of)
itearble.forEach(() => { /* statements */ });
```

### Break & Continue statements

`break;`  exits the loop.  
`continue;` skip to next loop cycle.

```javascript
labelname: for(begin; condition; step) {
    //code here
}

break labelname;  //breaks labelled loop and nested loops inside it
```

## Arrays

```js
let array = [];  // empty array
let array = ["text", 3.14, [1.41]];  // array declaration and initialization

array.length;  // number of items in the array
array[index];  // access to item by index
array[index] = item; // change or add item by index

array.push(item);  //add item to array
array.pop();  // remove and return last item

array.join("separator");  // constuct a string from the items of the array, sepatated by SEPARATOR
array.find(item => condition); // returns the value of the first element in the provided array that satisfies the provided testing function
array.fill(value, start, end);  // filla an array with the passed value


// https://stackoverflow.com/a/37601776
array.slice(start, end);  // RETURN list of items between indexes start and end-1
array.splice(start, deleteCount, [items_to_add]);  // remove and RETURN items from array, can append a list of items. IN PLACE operation
```

### `filter()` & `map()`, `reduce()`

```js
let array = [ items ];

// execute an operation on each item, producing a new array
array.map(function);
array.map(() => operation); 

array.filter(() => condition);  // return an items only if the condition is true

// execute a reducer function on each element of the array, resulting in single output value
array.reduce((x, y) => ...);
```

## Spread Operator (...)

```js
// arrays
let array1 = [ 1, 2, 3, 4, 5, 6 ];
let array2 = [ 7, 8, 9, 10 ];
let copy = [ ...array1 ];  // shallow copy
let copyAndAdd = [ 0, ...array1, 7 ];  // insert all values in new array
let merge = [ ...array1, ...attay2 ];  // merge the arrays contents in new array

// objects
let obj = { prop1: value1, prop2: value2 };
let clone = { ...obj, prop: value };  // shallow copy, and update copy prop
let cloneAndAdd = { prop0: value0, ...obj, prop3: value3 };

// strings
let alphabet = "abcdefghijklmnopqrstxyz"
let letters = [ ...alphabet ];  // alphabet.split("")

//function arguments
let func = (arg1 = val1, arg2 = val2) => expression;
let args = [ value1, value2 ];
func(arg0, ...args);
```

## Dictionaries

```js
let dict = { FirstName: "Chris", "one": 1, 1: "some value" };


// add new or update property
dict["Age"] = 42;

// direct property by name
// because it's a dynamic language
dict.FirstName = "Chris";
```

### Iterating Key-Value pairs

```js
for(let key in dict) {
  let value = dict[key];

  // do something with "key" and "value" variables
}

```

## Functions

### JSDOC documentation standard

```javascript
/**
 * @param {type} parameter - description
 * @returns {type} parameter - description
 * */
```

### Function Declaration

```javascript
// ...args will contain extra parameters (rest argument)
function functionName(parameter=default-value, ...args) {
    //code here
    return <expression>;
}
```

### Default Parameters (old versions)

```javascript
function functionName(parameters) {
    if (parameter == undefined) {
        paremeter = value;
    }

    //code here
    return <expression>;
}
```

### Function Expressions

```javascript
let functionName = function(parameters) {
    //code here
    return expression;
}
```

### Arrow Functions

```javascript
(input) => { /* statements */ }
(input) => expression;
input => expression;  // parenthesis are optional
() => expression;  // no parameters syntax

// variants
let func = (input) => {
    // code here
};

let func = (input) => expression;
let func = input => expression;

func();  // function call

// rerurn object literal
let func = (value) => ({property: value});
```

## Object Oriented Programming

An object is a collection of related data and/or functionality.

**Note**: It's not possible to transform a variable in an object simply by using the object assignement.

```js
let variable = value;

// object literal
let obj = {
    property: value,
    variable,  // same as variable: variable

    object: {
        ...
    },

    method: function() {
        // code here
        this.properyName;  // reference to object property inside the object
    }

    method; () => {
        obj.propertyName;  // this is undefined here, use full object name
    }
};

// access to property (non existant porperties will return Undefined)
obj.property;  // dot notation
obj["property"];  // array notation

// property modification (will add property if missing)
obj.property = value;  // dot notation
obj["property"] = value;  // array notation

obj.func(); //method access

delete obj.propertyName;  // delete property

Object.keys(obj);  // list of all property names
Object.entries(obj);  // list contents as key-value pairs
```

### Constructors and object instances

JavaScript uses special functions called **constructor functions** to define and initialize objects and their features.
Notice that it has all the features you'd expect in a function, although it doesn't return anything or explicitly create an object — it basically just defines properties and methods.

```js
// constructor function definition
function Class(params) {
    this.property = param;

    this.method = function(parms) { /* code here */ }
}

let obj = new Class(params);  // object instantiation

let obj = new Object();  // cretaes empty object
let obj = new Object({
    // JSON
});
```

### Prototypes

Prototypes are the mechanism by which JavaScript objects *inherit* features from one another.

JavaScript is often described as a **prototype-based language**; to provide inheritance, objects can have a prototype object, which acts as a template object that it inherits methods and properties from.

An object's prototype object may also have a prototype object, which it inherits methods and properties from, and so on.
This is often referred to as a **prototype chain**, and explains why different objects have properties and methods defined on other objects available to them.
If a method is implemented on an object (and not it's prototype) then only that object will heve that method and not all the ones that come from the same prototype.

```js
// constuctor function
function Obj(param1, ...) {
    this.param1 = param1,
    ...
}

// method on the object
Obj.prototype.method = function(params) {
    // code here (operate w/ this)
}

let obj = new Obj(args);  // object instantiation
obj.method();  // call method from prototype
```

### Extending with prototypes

```js
// constructor function
function DerivedObj(param1, param2, ...) {
    Obj.call(this, param1);  // use prototype constructor
    this.param2 = param2;
}

// extend Obj
DerivedObj.prototype = Object.create(Obj.prototype);

// method on object
DerivedObj.prototype.method = function() {
    // code here (operate w/ this)
}

let dobj = new DerivedObj(args);  // object instantiation
dobj.method();  // call method from prototype
```

### Classes (ES6+)

```js
class Obj {
    constructor(param1, ...) {
        this.param1 = param1,
        ...
    }

    get param1()  // getter
    {
        return this.param1;
    }

    func() {
        // code here (operate w/ this)
    }

    static func() { }  // static method

// object instantiation
let obj = new Obj(param1, ...);
obj.func();  // call method
```

### Extending with Classes

```js
class DerivedObj extends Obj {
    constructor(param1, param2, ...){
        super(param1);  // use superclass constructor
        this.param2 = param2;
    }

    newFunc() { }
}

let dobj = DerivedObj();
dobj.newFunc();
```

## Deconstruction

### Object deconstruction

```js
let obj = {
    property: value,
    ...
}

let { var1, var2 } = obj;  // extract values from object into variables
let { property: var1, property2 : var2 } = obj;  // extract props in variables w/ specified names
let { property: var1, var2 = defalut_value } = obj;  // use default values if object has less then expected props
```

### Array Deconstrions

```js
let array = [ 1, 2, 3, 4, 5, 6 ];
let [first, , third, , seventh = "missing" ] = array;  // extract specific values from array
```

## Serialization

```js
let object = {
    // ojectt attributes
}

let json = JSON.stringify(object);  // serialieze onbect in JSON

let json = {  /* JSON */ };
let object = JSON.parse(json);  // deserialize to Object
```

## Timing

### Timers

Function runs *once* after an interval of time.

```js
// param1, param2, ... are the arguments passed to the function (IE9+)
let timerId = setTimeout(func [, milliseconds, param1, param2, ... ]);  // wait milliseconds before executing the code (params are read at execution time)

// works in IE9
let timerId =  setTimeout(function(){
    func(param1, param2);
}, milliseconds);

// Anonymous functions with arguments
let timerId = setTimeout(function(arg1, ...){
    // code here
}, milliseconds, param1, ...);

clearTimeout(timerId)  // cancel execution

// exemple of multiple consecutive schedules
let list = [1 , 2, 3, 4, 5, 6, 7, 8, 9, 10, "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
function useTimeout(pos=0) {

    setTimeout(function(){
        console.log(list[pos]);
        pos += 1;  // update value for next call

        if (pos < list.length) {  // recursion exit condition
            useTimeout(pos);  // schedule next call with new walue
        }
    }, 1_000, pos);
}

useTimeout();
```

### `let` vs `var` with `setTimeout`

```js
// let instantitates a new variable for each iteration
for (let i = 0; i < 3; ++i) {
    setTimeout(function() {
        console.log(i);
    }, i * 100);
}
// output: 0, 1, 2

for (var i = 0; i < 3; ++i) {
    setTimeout(function() {
        console.log(i);
    }, i * 100);
}
// output: 3, 3, 3
```

### Preserving the context

```js
let obj = {
    prop: value,

    method1 : function() { /* statement */ }

    method2 : function() {
        let self = this  // memorize context inside method (otherwise callback will not know it)
        setTimeout(function() { /* code here (uses self) */ })
    }
}


// better
let obj = {
    prop: value,

    method1 : function() { /* statement */ }

    method2 : function() {
        setTimeout(() => { /* code here (uses this) */ })  // arrow func does not create new scope, this context preserved
    }
}
```

### Intervals

Function runs regularly with a specified interval. JavaScript is **Single Threaded**.

```js
// param1, param2, ... are the arguments passed to the function (IE9+)
let timerId = setInterval(func, milliseconds [, param1, param2, ... ]); // (params are read at execution time)

// works in IE9
let timerId =  setInterval(function(){
    func(param1, param2);
}, milliseconds);

// Anonymous functions with arguments
let timerId = setInterval(function(arg1, ...){
    // code here
}, milliseconds, param1, ...);

clearTimeout(timerId);  // cancel execution
```

## DateTime

A date consists of a year, a month, a day, an hour, a minute, a second, and milliseconds.

There are generally 4 types of JavaScript date input formats:

- **ISO Date**: `"2015-03-25"`
- Short Date: `"03/25/2015"`
- Long Date: `"Mar 25 2015"` or `"25 Mar 2015"`
- Full Date: `"Wednesday March 25 2015"`

```js
// constructors
new Date();
new Date(milliseconds);
new Date(dateString);
new Date(year, month, day, hours, minutes, seconds, milliseconds);

// accepts parameters similar to the Date constructor, but treats them as UTC. It returns the number of milliseconds since January 1, 1970, 00:00:00 UTC.
Date.UTC(year, month, day, hours, minutes, seconds, milliseconds);

//static methods
Date.now();  // returns the number of milliseconds elapsed since January 1, 1970 00:00:00 UTC.

// methods
let date = new Date();
date.toSting(); // returns a string representing the specified Date object
date.toUTCString();
date.toDateString();
date.toTimeString();  // method returns the time portion of a Date object in human readable form in American English.


// get date

dare.getMonth();
date.getMinutes();
date.getFullYear();

// set date
date.setFullYear(2020, 0, 14);
date.setDate(date.getDate() + 50);

// parse valid dates
let msec = Date.parse("March 21, 2012");
let date = new Date(msec);
```

### Comparing Dates

Comparison operators work also on dates

```js
let date1 = new Date();
let date2 = new Date("May 24, 2017 10:50:00");

if(date1 > date2){
        console.log('break time');
} else {
        console.log('stay in class');
}
```

## [Exports](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export)

[Firefox CORS not HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS/Errors/CORSRequestNotHttp)

**NOTE**: Firefox 68 and later define the origin of a page opened using a `file:///` URI as unique. Therefore, other resources in the same directory or its subdirectories no longer satisfy the CORS same-origin rule. This new behavior is enabled by default using the `privacy.file_unique_origin` preference.

```json
"privacy.file_unique_origin": "false"
```

In `page.html`

```html
<!-- must specyfy module as type for importer and source -->
<script src="scripts/module.js"></script>
<script src="scripts/script.js"></script>
```

In `module.js`:

```js
// exporting indivisual fratures
export default function() {}  // one per module
export func = () => expression;  // zero or more per module

// Export list
export { name1, name2, …, nameN };

// Renaming exports
export { variable1 as name1, variable2 as name2, …, nameN };

// Exporting destructured assignments with renaming
export const { name1, name2: bar } = o;

 // re-export
export { func } from "other_script.js" 
```

In `script.js`:

```js
import default_func_alias, { func as alias } from "./module.js";  // import default and set alias
import { default as default_func_alias, func as alias } from "./module.js";  // import default and set alias

// use imported functions
default_func_alias();
alias();
```

```js
import * from "./module.js";  // import all

module.function();  // use imported content with fully qualified name
```
