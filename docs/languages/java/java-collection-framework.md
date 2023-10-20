# Java Collection Framework - JCF

All classes that permit the handling of groups of objects constitute the Java Collection Framework.

A Collection is a *container* in which several objects are grouped in a *single entity*.

The **Java Collection Framework** is constituted by:

- **Interfaces** the define the operations of a generic collection. They can be split into two categories:
  - **Collection**: used to optimize operations of insertion, modification and deletion of elements in a group of objects.
  - **Map**: optimized for look-up operations.
- **Classes** that implement the interfaces using different data structures.
- **Algorithms** consisting in methods to operate over a collection.

![Java Collection Hierarchy](../../img/java_java-collection-framework.png "Java Collection Hierarchy")

## java.util.Collections

### Collection Functions

```java linenums="1"
boolean add (Object o) e.g., <x>.add (<y>)    //append to collection, false if fails
boolean add (int index, Object o)    //insertion at given index
boolean addAll (Collection c)    //appends a collection to another
void clear()     //remove items from container
boolean contains (Object o)    //true if object is in collection
boolean containsAll (Collection c)    //true if all items of collection are in another
boolean isEmpty (Object o) e.g., if (<x>.isEmpty()) ...    //true if collection is empty
boolean remove (Object o)    //remove object from collection
Object remove (int index)    //remove object at given index
void removeAll (Collection c)    //remove all items form collection
int size ()    //number og items in collection
Object [] toArray()    //transform collection in array
Iterator iterator()    //returns iterator to iterate over the collection
```

### Collections Methods

```java linenums="1"
Collection<E>.forEach(Consumer<? super T> action);
```

### Iterator

Abstracts the problem of iterating over all the elements of a collection;

- `public Iterator (Collection c)` creates the Iterator
- `public boolean hasNext()` checks if there is a successive element
- `public Object next()` extracts the successive element

### ArrayList

**Note**: ArrayLists can't contain *primitive* values. *Use wrapper classes* instead.

```java linenums="1"
import java.util.ArrayList;
ArrayList<Type> ArrayListName = new ArrayList<Type>(starting_dim);    //resizable array
ArrayList<Type> ArrayListName = new ArrayList<Type>();    //resizable array
ArrayList<Type> ArrayListName = new ArrayList<>();    //resizable array (JAVA 1.8+)


ArrayListName.add(item);    //append item to collection
ArrayListName.add(index, item);  // add item at position index, shift all item from index and successive towards the end af the ArrayList
ArrayListName.set(index, item);  // substitute EXISTING item
ArrayListName.get(index);    //access to collection item
ArrayListName.remove(item)    //remove first occurrence of item from collection
ArrayListName.remove(index)    //remove item at position index
ArrayListName.clear()    //empties the ArrayList
ArrayListName.contains(object);  // check if object is in the ArrayList
ArrayListName.IndexOf(object);  // returns the index of the object
ArrayListName.isEmpty();  // check wether the list is empty

ArrayListName.size();    //dimension of the ArrayList
ArrayListName.tirmToSize();  // reduce ArrayList size to minimum needed
// ArrayList size doubles when a resize is needed.

//run through to the collection with functional programming (JAVA 1.8+)
ArrayListName.forEach(item -> function(v));
```

### Collection Sorting

To sort a collection it's items must implement `Comparable<T>`:

```java linenums="1"
class ClassName implements Comparable<ClassName> {

    @override
    public int compareTo(Classname other){
        //compare logic
        return <int>;
    }
}

List<ClassName> list;
//valorize List
Collections.sort(list);    //"natural" sorting uses compareTo()
```

Otherwise a `Comparator()` must be implemented:

```java linenums="1"
class Classname {
    //code here
}

// Interface object (!) implements directly a method
Comparator<ClassName> comparator = new Comparator<ClassName>() {

    @Override
    public int compare(ClassName o1, Classname o2) {
        //compare logic
        return <int>;
    }
};

List<ClassName> list;
//valorize List
Collections.sort(list, comparator);    //"natural" sorting uses compareTo()
```

`Comparator<T>` and `Comparable<T>` are functional interfaces
