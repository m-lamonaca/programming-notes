# C# Collections

## Arrays

An array is an object that contains multiple elements of a particular type. The number of elements is fixed for the lifetime of the array, so it must be specified when the array is created.

An array type is always a reference type, regardless of the element type. Nonetheless, the choice between reference type and value type elements makes a significant difference in an array's behavior.

```cs linenums="1"
type[] array = new type[dimension];
type array[] = new type[dimension];  //invalid

type[] array = {value1, value2, ..., valueN};  // initializer
var array = new type[] {value1, value2, ..., valueN};  // initializer (var type needs new operator)
var array = new[] {value1, value2, ..., valueN};  // initializer w/ element type inference (var type needs new operator), can be used as method arg

array[index];    // value access
array[index] = value;    // value assignment
array.Length;  // dimension of the array

// from IEnumerable<T>
array.OfType<Type>();  // filter array based on type, returns IEnumerable<Type>
```

### [Array Methods](https://docs.microsoft.com/en-us/dotnet/api/system.array?view=netcore-3.1#methods)

```cs linenums="1"
// overloaded search methods
Array.IndexOf(array, item);  // return index of searched item in passed array
Array.LastIndexOf(array, item); // return index of searched item staring from the end of the array
Array.FindIndex(array, Predicate<T>)  // returns the index of the first item matching the predicate (can be lambda function)
Array.FindLastIndex(array, Predicate<T>)  // returns the index of the last item matching the predicate (can be lambda function)
Array.Find(array, Predicate<T>)  // returns the value of the first item matching the predicate (can be lambda function)
Array.FindLast(array, Predicate<T>)  // returns the value of the last item matching the predicate (can be lambda function)
Array.FindAll(array, Predicate<T>)  // returns array of all items matching the predicate (can be lambda function)
Array.BinarySearch(array, value)  // Searches a  SORTED array for a value, using a binary search algorithm; returns the index of the found item

Array.Sort(array);
Array.Reverse(array);  // reverses the  order of array elements
Array.Clear(start_index, x);  //removes reference to x elements starting at start index. Dimension of array unchanged (cleared elements value is set tu null)
Array.Resize(ref array, target_dimension);  //expands or shrinks the array dimension. Shrinking drops trailing values. Array passed by reference.

// Copies elements from an Array starting at the specified index and pastes them to another Array starting at the specified destination index.
Array.Copy(sourceArray, sourceStartIndex, destinationArray, destinationStartIndex, numItemsToCopy);
// Copies elements from an Array starting at the first element and pastes them into another Array starting at the first element.
Array.Copy(sourceArray, destinationArray, numItemsToCopy);
Array.Clone();  // returns a shallow copy of the array
```

### Multidimensional Arrays

C# supports two multidimensional array forms: [jagged][jagg_arrays] arrays and [rectangular][rect_arrays] arrays (*matrices*).

[jagg_arrays]: https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/arrays/jagged-arrays
[rect_arrays]: https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/arrays/multidimensional-arrays

```cs linenums="1"
//specify first dimension
type[][] jagged = new type[][]
{
    new[] {item1, item2, item3},
    new[] {item1},
    new[] {item1, item2},
    ...
}

// shorthand
type[][] jagged =
{
    new[] {item1, item2, item3},
    new[] {item1},
    new[] {item1, item2},
    ...
}

// matrices
type[,] matrix = new type[n, m];  // n * m matrix
type[,] matrix = {{}, {}, {}, ...};  // {} for each row to initialize
type[, ,] tensor = new type[n, m, o] // n * m * o tensor

matrix.Length;  // total number of elements (n * m)
matrix.GetLength(int dimension); // get the size of a particular direction
// row = 0, column = 1, ...
```

## [Lists](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1)

`List<T>` stores sequences of elements. It can grow or shrink, allowing to add or remove elements.

```cs linenums="1"
using System.Collections.Generics;

List<T> list = new List<T>();
List<T> list = new List<T> {item_1, ...};  // initialized usable since list implements IEnumerable<T> and has Add() method (even extension method)
List<T> list = new List<T>(dimension);  // set list starting dimension
List<T> list = new List<T>(IEnumerable<T>);  // create a list from an enumerable collection


list.Add(item);    //item insertion into the list
list.AddRange(IEnumerable<T> collection);  // insert multiple items
list.Insert(index, item);  // insert an item at the specified index
list.InsertRange(index, item);  // insert items at the specified index

list.IndexOf(item);  // return index of searched item in passed list
list.LastIndexOf(item); // return index of searched item staring from the end of the array
list.FindIndex(Predicate<T>)  // returns the index of the first item matching the predicate (can be lambda function)
list.FindLastIndex(Predicate<T>)  // returns the index of the last item matching the predicate (can be lambda function)
list.Find(Predicate<T>)  // returns the value of the first item matching the predicate (can be lambda function)
list.FindLast(Predicate<T>)  // returns the value of the last item matching the predicate (can be lambda function)
list.FindAll(Predicate<T>)  // returns list of all items matching the predicate (can be lambda function)
list.BinarySearch(value)  // Searches a  SORTED list for a value, using a binary search algorithm; returns the index of the found item

list.Remove(item);  // remove item from list
list.RemoveAt(index);  // remove item at specified position
list.RemoveRange(index, quantity);  // remove quantity items at specified position

list.Contains(item);  // check if item is in the list
list.TrueForAll(Predicate<T>);  // Determines whether every element matches the conditions defined by the specified predicate

list[index];  // access to items by index
list[index] = value;  // modify to items by index
list.Count;  // number of items in the list

list.Sort(); // sorts item in crescent order
list.Reverse(); // Reverses the order of the elements in the list

// from IEnumerable<T>
list.OfType<Type>();  // filter list based on type, returns IEnumerable<Type>
list.OfType<Type>().ToList();  // filter list based on type, returns List<Type>
```

## [Iterators](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/iterators)

An iterator can be used to step through collections such as lists and arrays.

An iterator method or `get` accessor performs a custom iteration over a collection. An iterator method uses the `yield return` statement to return each element one at a time.
When a `yield return` statement is reached, the current location in code is remembered. Execution is restarted from that location the next time the iterator function is called.

It's possible to use a `yield break` statement or exception to end the iteration.

**Note**: Since an iterator returns an `IEnumerable<T>` is can be used to implement a `GetEnumerator()`.

```cs linenums="1"
// simple iterator
public static System.Collections.IEnumerable<int> IterateRange(int start = 0, int end)
{
    for(int i = start; i < end; i++){
        yield return i;
    }
}
```

## List & Sequence Interfaces

### [`IEnumerable<T>`](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.ienumerable-1)

Exposes the enumerator, which supports a simple iteration over a collection of a specified type.

```cs linenums="1"
public interface IEnumerable<out T> : IEnumerable
{
    IEnumerator<T> GetEnumerator();  // return an enumerator
}

// iterate through a collection
public interface IEnumerator<T>
{
    // properties
    object Current { get; }  // Get the element in the collection at the current position of the enumerator.

    // methods
    void IDisposable.Dispose();  // Perform application-defined tasks associated with freeing, releasing, or resetting unmanaged resources
    bool MoveNext();  // Advance the enumerator to the next element of the collection.
    void Reset();  // Set the enumerator to its initial position, which is before the first element in the collection.
}
```

**Note**: must call `Dispose()` on enumerators once finished with them, because many of them rely on this. `Reset()` is legacy and can, in some situations, throw `NotSupportedException()`.

### [`ICollection<T>`](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.icollection-1)

```cs linenums="1"
public interface ICollection<T> : IEnumerable<T>
{
    // properties
    int Count { get; }  // Get the number of elements contained in the ICollection<T>
    bool IsReadOnly { get; }  // Get a value indicating whether the ICollection<T> is read-only

    // methods
    void Add (T item);  // Add an item to the ICollection<T>
    void Clear ();  // Removes all items from the ICollection<T>
    bool Contains (T item);  // Determines whether the ICollection<T> contains a specific value
    IEnumerator GetEnumerator ();  // Returns an enumerator that iterates through a collection
    bool Remove (T item);  // Removes the first occurrence of a specific object from the ICollection<T>
}
```

### [`IList<T>`](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.ilist-1)

```cs linenums="1"
public interface IList<T> : ICollection<T>, IEnumerable<T>
{
    // properties
    int Count { get; }  // Get the number of elements contained in the ICollection<T>
    bool IsReadOnly { get; }  // Get a value indicating whether the ICollection<T> is read-only
    T this[int index] { get; set; }  // Get or set the element at the specified index

    // methods
    void Add (T item);  // Add an item to the ICollection<T>
    void Clear ();  // Remove all items from the ICollection<T>
    bool Contains (T item);  // Determine whether the ICollection<T> contains a specific value
    void CopyTo (T[] array, int arrayIndex);  // Copy the elements of the ICollection<T> to an Array, starting at a particular Array index
    IEnumerator GetEnumerator ();  // Return an enumerator that iterates through a collection
    int IndexOf (T item);  // Determine the index of a specific item in the IList<T>
    void Insert (int index, T item);  // Insert an item to the IList<T> at the specified index
    bool Remove (T item);  // Remove the first occurrence of a specific object from the ICollection<T>
    oid RemoveAt (int index);  // Remove the IList<T> item at the specified index
}
```

## [Dictionaries](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2)

[ValueCollection](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.valuecollection)
[KeyCollection](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.dictionary-2.keycollection)

**Notes**:

- Enumerating a dictionary will return `KeyValuePair<TKey, TValue>`.
- The `Dictionary<TKey, TValue>` collection class relies on hashes to offer fast lookup (`TKey` should have a good `GetHashCode()`).

```cs linenums="1"
Dictionary<TKey, TValue> dict = new Dictionary<TKey, TValue>();  // init empty dict
Dictionary<TKey, TValue> dict = new Dictionary<TKey, TValue>(IEqualityComparer<TKey>);  // specify key comparer (TKey must implement Equals() and GetHashCode())

// initializer (implicitly uses Add method)
Dictionary<TKey, TValue> dict =
{
    { key, value }
    { key, value },
    ...
}

// object initializer
Dictionary<TKey, TValue> dict =
{
    [key] = value,
    [key] = value,
    ...
}

// indexer access
dict[key];  // read value associated with key (throws KeyNotFoundException if key does not exist)
dict[key] = value;  // modify value associated with key (throws KeyNotFoundException if key does not exist)

dict.Count;  // number of key-value pair stored in the dict
dict.Keys;  // Dictionary<TKey,TValue>.KeyCollection containing the keys of the dict
dict.Values;  // Dictionary<TKey,TValue>.ValueCollection containing the values of the dict

dict.Add(key, value);  // ArgumentException if the key already exists
dict.Clear();  // empty the dictionary
dict.ContainsKey(key);  // check if a key is in the dictionary
dict.ContainsValue(value);  // check if a value is in the dictionary
dict.Remove(key);  // remove a key-value pair
dict.Remove(key, out var);  // remove key-value pair and copy TValue to var parameter
dict.TryAdd(key, value);  // adds a key-value pair; returns true if pair is added, false otherwise
dict.TryGetValue(key, out var);  // put the value associated with kay in the var parameter; true if the dict contains an element with the specified key, false otherwise.
```

## [Sets](https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.hashset-1)

Collection of non duplicate items.

```cs linenums="1"
HashSet<T> set = new HashSet<T>();

set.Add(T); // adds an item to the set; true if the element is added, false if the element is already present.
set.Clear();  //Remove all elements from a HashSet<T> object.
set.Contains(T); // Determine whether a HashSet<T> object contains the specified element.
set.CopyTo(T[]);  // Coy the elements of a HashSet<T> object to an array.
set.CopyTo(T[], arrayIndex);  // Copy the elements of a HashSet<T> object to an array, starting at the specified array index.
set.CopyTo(T[], arrayIndex, count);  // Copies the specified number of elements of a HashSet<T> object to an array, starting at the specified array index.
set.CreateSetComparer();  // Return an IEqualityComparer object that can be used for equality testing of a HashSet<T> object.
set.ExceptWith(IEnumerable<T>);  // Remove all elements in the specified collection from the current HashSet<T> object.
set.IntersectWith(IEnumerable<T>); // Modify the current HashSet<T> object to contain only elements that are present in that object and in the specified collection.
set.IsProperSubsetOf(IEnumerable<T>);  // Determine whether a HashSet<T> object is a proper subset of the specified collection.
set.IsProperSupersetOf(IEnumerable<T>);  // Determine whether a HashSet<T> object is a proper superset of the specified collection.
set.IsSubsetOf(IEnumerable<T>);  // Determine whether a HashSet<T> object is a subset of the specified collection.
set.IsSupersetOf(IEnumerable<T>);  // Determine whether a HashSet<T> object is a superset of the specified collection.
set.Overlaps(IEnumerable<T>);  // Determine whether the current HashSet<T> object and a specified collection share common elements.
set.Remove(T);  // Remove the specified element from a HashSet<T> object.
set.RemoveWhere(Predicate<T>);  // Remove all elements that match the conditions defined by the specified predicate from a HashSet<T> collection.
set.SetEquals(IEnumerable<T>);  // Determine whether a HashSet<T> object and the specified collection contain the same elements.
set.SymmetricExceptWith(IEnumerable<T>); // Modify the current HashSet<T> object to contain only elements that are present either in that object or in the specified collection, but not both.
set.UnionWith(IEnumerable<T>);  // Modify the current HashSet<T> object to contain all elements that are present in itself, the specified collection, or both.
set.TryGetValue(T, out T);  // Search the set for a given value and returns the equal value it finds, if any.
```
