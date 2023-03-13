# Kotlin

## Package & Imports

```kotlin
package com.app.uniqueID

import <package>
```

## Variable & Constants

```kotlin

var variable: Type    //variable declaration
var variable = value    //type can be omitted if it can be deduced by initialization

val CONSTANT_NAME: Type = value    //constant declaration
```

### Nullable Variables

For a variable to hold a null value, it must be of a nullable type.  
Nullable types are specified suffixing `?` to the variable type.

```kotlin
var nullableVariable: Type? = null

nullableVariable?.method()    //correct way to use
//if var is null don't execute method() and return null

nullablevariavle!!.method()    //unsafe way
//!! -> ignore that var can be null
```

## Decision Statements

### `If` - `Else If` - `Else`

```kotlin
if (condition) {
    //code here
} else if (condition) {
    //code here
} else {
    //code here
}
```

### Conditional Expressions

```kotlin
var variable: Type = if (condition) {
    //value to be assigned here
} else if (condition) {
    //value to be assigned here
} else {
    //value to be assigned here
}
```

### `When` Expression

Each branch in a `when` expression is represented by a condition, an arrow (`->`), and a result.  
If the condition on the left-hand side of the arrow evaluates to true, then the result of the expression on the right-hand side is returned.  
Note that execution does not fall through from one branch to the next.

```kotlin
when (variable){
    condition -> value
    condition -> value
    else -> value
}

//Smart casting
when (variable){
    is Type -> value
    is Type -> value
}

//instead of chain of if-else
when {
    condition -> value
    condition -> value
    else -> value
}
```

## Loops

### `For` Loop

```kotlin
for (item in iterable){
    //code here
}

//loop in a numerical range
for(i in start..end) {
    //code here
}
```

## Functions

```kotlin
fun functionName(parameter: Type): Type {
    //code here

    return <expression>
}
```

### Simplifying Function Declarations

```kotlin
fun functionName(parameter: Type): Type {
    return if (condition) {
        //returned value
    } else {
        //returned value
    }
}

fun functionName(parameter: Type): Type = if (condition) {
    //returned value
    else {
        //returned value
    }
}
```

### Anonymous Functions

```kotlin
val anonymousFunction: (Type) -> Type = { input ->
    //code acting on input here
}

val variableName: Type = anonymousFunction(input)
```

### Higher-order Functions

A function can take another function as an argument. Functions that use other functions as arguments are called *higher-order* functions.  
This pattern is useful for communicating between components in the same way that you might use a callback interface in Java.

```kotlin
fun functionName(parameter: Type, function: (Type) -> Type): Type {
    //invoke function
    return function(parameter)
}
```

## Object Oriented Programming

### Class

```kotlin
//primary constructor
class ClassName(private var attribute: Type) {

}

class ClassName {

    private var var1: Type

    //secondary constructor
    constructor(parameter: Type) {
        this.var1 = parameter
    }
}
```

### Companion Object

[Companion Object Docs](https://kotlinlang.org/docs/tutorials/kotlin-for-py/objects-and-companion-objects.html)

```kotlin
class ClassName {

    // in java: static
    companion object  {
        // static components of the class
    }
}
```

## Collections

### ArrayList

```kotlin
var array:ArrayList<Type>? = null  // List init

array.add(item)  //add item to list
```
