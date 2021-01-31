# LINQ

## LINQ to Objects

<!-- Page: 423/761 of "Ian Griffiths - Programming C# 8.0 - Build Cloud, Web, and Desktop Applications.pdf" -->

The term **LINQ to Objects** refers to the use of LINQ queries with any `IEnumerable` or `IEnumerable<T>` collection directly, without the use of an intermediate LINQ provider or API such as [LINQ to SQL](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/linq/) or [LINQ to XML](https://docs.microsoft.com/en-us/dotnet/standard/linq/linq-xml-overview).

LINQ to Objects will be used when any `IEnumerable<T>` is specified as the source, unless a more specialized provider is available.

### Query Expressions

All query expressions are required to begin with a `from` clause, which specifies the source of the query.
The final part of the query is a `select` (or `group`) clause. This determines the final output of the query and its sytem type.

```cs
// query expression
var result = from item in enumerable select item;

// where clause
var result = from item in enumerable where condition select item;

// ordering
var result = from item in enumerable orderby item.property select item;  // ordered Ienumerble

// let clause
var result = from item in enumerable let tmp = <sub-expr> ...  // assign expression to variable to avoid re-evaluetion on each cycle
// BEWARE: compiled code has a lot of overhead to satisfy let caluse

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

// max item in the IEnumerable
IEnumerable<T>.Max(); // source must implement IComparable<T>

// check if condition is true for all IEnumerbale
IEnumerable<T>.All(IEnumerable<T> source, Func<T, bool> predicate);
IEnumerable<T>.All(IEnumerable<T> source.Predicate);
```

## LINQ to JSON (JSON.NET)

Parses JSON data into objects of type `JObject`, `JArray`, `JProperty`,  and  `JValue`,  all  of  which  derivefrom  a  `JToken`  base  class.
Using these types is similar to working with JSON from JavaScript: it's possible to access the content directly without having to define classes.

```cs
var jo = (JObject) JToken.Parse(json);  // parse json

var propery = jo["property"].Value<Type>();  // extract and convert data from json

// linq query
IENumerable<JProperty> props = jo.Descendants().OfType<JProperty>().Where(p => condition);
```
