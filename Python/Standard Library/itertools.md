# Itertools Module

``` py
# accumulate ([1,2,3,4,5]) -> 1, 3 (1 + 2), 6 (1 + 2 + 3), 10 (1 + 2 + 3 + 6), 15 (1+ 2 + 3 + 4 + 5)
# accumulate (iter, func (,)) -> iter [0], func (iter [0] + iter [1]) + func (prev + iter [2]), ...
accumulate (iterable, func (_, _))

# iterator returns elements from the first iterable,
# then proceeds to the next until the end of the iterables
# does not work if there is only one iterable
chain (* iterable)

# concatenates elements of the single iterable even if it contains sequences
chain.from_iterable (iterable)

# returns sequences of length r starting from the iterable
# items treated as unique based on their value
combinations (iterable, r)

# # returns sequences of length r starting from the iterable allowing the repetition of the elements
combinations_with_replacement (iterable, r)

# iterator filters date elements returning only those that have
# a corresponding element in selectors that is true
compress (data, selectors)

count (start, step)

# iterator returning values ​​in infinite sequence
cycle (iterable)

# iterator discards elements of the iterable as long as the predicate is true
dropwhile (predicate, iterable)

# iterator returning values ​​if predicate is false
filterfalse (predicate, iterable)

# iterator returns tuple (key, group)
# key is the grouping criterion
# group is a generator returning group members
groupby (iterable, key = None)

# iterator returns slices of the iterable
isslice (iterable, stop)
isslice (iterable, start, stop, step)

# returns all permutations of length r of the iterable
permutations (iterable, r = None)

# Cartesian product of iterables
# loops iterables in order of input
# [product ('ABCD', 'xy') -> Ax Ay Bx By Cx Cy Dx Dy]
# [product ('ABCD', repeat = 2) -> AA AB AC AD BA BB BC BD CA CB CC CD DA DB DC DD]
product (* iterable, repetitions = 1)

# returns an object infinite times if repetition is not specified
repeat (object, repetitions)

# iterator compute func (iterable)
# used if iterable is pre-zipped sequence (seq of tuples grouping elements)
starmap (func, iterable)

# iterator returning values ​​from iterable as long as predicate is true
takewhile (predicate, iterable)

# returns n independent iterators from the single iterable
tee (iterable, n = 2)

# produces an iterator that aggregates elements from each iterable
# if the iterables have different lengths the missing values ​​are filled according to fillervalue
zip_longest (* iterable, fillvalue = None)
```
