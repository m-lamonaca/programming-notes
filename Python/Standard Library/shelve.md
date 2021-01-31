# Shelve Module Cheat Sheet

```python
import shelve

# open a persistent dictionary, returns a shelf object
shelf = shelve.open("filename", flag="c", writeback=False)
```

FLAG:

- r = read
- w = read & write
- c = read, wite & create (if doesen't exist)
- n = always create new

If `writeback` is `True` all entries accessed are also cached in memory, and written back on `sync()` and `close()`.  
This makes it handier to mutate mutable entries in the persistent dictionary, but, if many entries are accessed, it can consume vast amounts of memory for the cache, and it can make the close operation very slow since all accessed entries are written back.

```python
# key is a string, data is an arbitrary object
shelf[key] = data  # store data at key
data = shelf[key]  # retrieve a COPY of data at key

shelf.keys()  # list of all existing keys (slow!)
shelf.values()  # lsit of all existing values

del shelf[key]  # selete data stored at key

shelf.close()  # Synchronize and close the persistent dict object.
# Operations on a closed shelf will fail with a ValueError.
```
