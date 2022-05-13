# LINQ

## LINQ to Objects

<!-- Page: 423/761 of "Ian Griffiths - Programming C# 8.0 - Build Cloud, Web, and Desktop Applications.pdf" -->

The term **LINQ to Objects** refers to the use of LINQ queries with any `IEnumerable` or `IEnumerable<T>` collection directly, without the use of an intermediate LINQ provider or API such as [LINQ to SQL](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/linq/) or [LINQ to XML](https://docs.microsoft.com/en-us/dotnet/standard/linq/linq-xml-overview).

LINQ to Objects will be used when any `IEnumerable<T>` is specified as the source, unless a more specialized provider is available.

### Query Expressions

All query expressions are required to begin with a `from` clause, which specifies the source of the query.  
The final part of the query is a `select` (or `group`) clause. This determines the final output of the query and its system type.

```cs
// query expression
var result = from item in enumerable select item;

// where clause
var result = from item in enumerable where condition select item;

// ordering
var result = from item in enumerable orderby item.property select item;  // ordered IEnumerable

// let clause, assign expression to variable to avoid re-evaluation on each cycle
var result = from item in enumerable let tmp = <sub-expr> ...  // BEWARE: compiled code has a lot of overhead to satisfy let clause

// grouping (difficult to re-implement to obtain better performance)
var result = from item in enumerable group item by item.property;  // returns IEnumerable<IGrouping<TKey,TElement>>
```

### How Query Expressions Expand

The compiler converts all query expressions into one or more method calls. Once it has done that, the LINQ provider is selected through exactly the same mechanisms that C# uses for any other method call.  
The compiler does not have any built-in concept of what constitutes a LINQ provider.

```cs
// expanded query expression
var result = Enumerable.Where(item => condition).Select(item => item);
```

The `Where` and `Select` methods are examples of LINQ operators. A LINQ operator is nothing more than a method that conforms to one of the standard patterns.

### Methods on `Enumerable` or `IEnumerable<T>`

```cs
Enumerable.Range(int start, int end);  // IEnumerable<int> of values between start & end

IEnumerable<TSource>.Select(Func<TSource, TResult> selector);  // map
IEnumerable<TSource>.Where(Func<T, bool> predicate);  // filter

IEnumerable<T>.FirstOrDefault();  // first element of IEnumerable or default(T) if empty
IEnumerable<T>.FirstOrDefault(T default);  // specify returned default
IEnumerable<T>.FirstOrDefault(Func<T, bool> predicate);  // first element to match predicate or default(T)
// same for LastOrDefault & SingleOrDefault

IEnumerable<T>.Chunk(size);  // chunk an enumerable into slices of a fixed size

// T must implement IComparable<T>
IEnumerable<T>.Max();
IEnumerable<T>.Min();

// allow finding maximal or minimal elements using a key selector
IEnumerable<TSource>.MaxBy(Func<TSource, TResult> selector);
IEnumerable<TSource>.MinBy(Func<TSource, TResult> selector);

IEnumerable<T>.All(Func<T, bool> predicate);  // check if condition is true for all elements
IEnumerable<T>.Any(Func<T, bool> predicate);  // check if condition is true for at least one element

IEnumerable<T>.Concat(IEnumerable<T> enumerable);

// Applies a specified function to the corresponding elements of two sequences, producing a sequence of the results.
IEnumerable<TFirst>.Zip(IEnumerable<TSecond> enumerable, Func<TFirst, TSecond, TResult> func);
IEnumerable<TFirst>.Zip(IEnumerable<TSecond> enumerable); // Produces a sequence of tuples with elements from the two specified sequences.
```

**NOTE**: `Enumerable` provides a set of `static` methods for querying objects that implement `IEnumerable<T>`. Most methods are extensions of `IEnumerable<T>`

```cs
Enumerable.Method(IEnumerable<T> source, args);
// if extension method same as
IEnumerable<T>.Method(args);
```
