
# Collections Module

``` py
# COUNTER ()
# subclass dictionary for counting hash-capable objects
from collections import Counter
Counter (sequence) # -> Counter object
# {item: num included in sequence, ...}

var = Counter (sequence)
var.most_common (n) # produce list of most common elements (most common n)
sum (var.values ​​()) # total of all counts
var.clear () #reset all counts
list (var) # list unique items
set (var) # convert to a set
dict (var) # convert to regular dictionary
var.items () # convert to a list of pairs (element, count)
Counter (dict (list_of_pairs)) # convert from a list of pairs
var.most_common [: - n-1: -1] # n less common elements
var + = Counter () # remove zero and negative counts


# DEFAULTDICT ()
# dictionary-like object that takes a default type as its first argument
# defaultdict will never raise a KeyError exception.
# non-existent keys return a default value (default_factory)
from collections import defaultdict
var = defaultdict (default_factory)
var.popitem () # remove and return first element
var.popitem (last = True) # remove and return last item


# OREDERDDICT ()
# subclass dictionary that "remembers" the order in which the contents are entered
# Normal dictionaries have random order
name_dict = OrderedDict ()
# OrderedDict with same elements but different order are considered different


# USERDICT ()
# pure implementation in pythondi a map that works like a normal dictionary.
# Designated to create subclasses
UserDict.data # recipient of UserDict content


# NAMEDTUPLE ()
# each namedtuple is represented by its own class
from collections import namedtuple
NomeClasse = namedtuple (NomeClasse, parameters_separated_from_space)
var = ClassName (parameters)
var.attribute # access to attributes
var [index] # access to attributes
var._fields # access to attribute list
var = class._make (iterable) # transformain namedtuple
var._asdict () # Return OrderedDict object starting from namedtuple


# DEQUE ()
# double ended queue (pronounced "deck")
# list editable on both "sides"
from collections import deque
var = deque (iterable, maxlen = num) # -> deque object
var.append (item) # add item to the bottom
var.appendleft (item) # add item to the beginning
var.clear () # remove all elements
var.extend (iterable) # add iterable to the bottom
var.extendleft (iterable) # add iterable to the beginning '
var.insert (index, item) # insert index position
var.index (item, start, stop) # returns position of item
var.count (item)
var.pop ()
var.popleft ()
var.remove (value)
var.reverse () # reverse element order
var.rotate (n) # move the elements of n steps (dx if n> 0, sx if n <0)
var.sort ()
```
