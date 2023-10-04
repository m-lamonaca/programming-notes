# Hash Tables & Trees

Used in the DBMS for:

- Internal Metadata
- Core Data Storage
- Temporary Data Structures
- Table Indexes

Design Decisions:

- **Data Organization**: How to layout the data structure in memory/pages and what information to store to support efficient access.
- **Concurrency**: How to enable multiple threads to access the data structure at the same time without causing problems.

## Hash Functions & Hash Tables

An **hash table** implements _unordered_ associative arrays (aka dictionaries) that maps keys to values.

It uses an **hash function** to compute an offset into the array for a given key, from which the desired value can be found.

Space Complexity: `O(n)`
Time Complexity:

- Average: `O(1)`
- Worst `O(n)`

Design Decisions:

1. **Hash Function**: How to map a large key space into a smaller domain. Trade-off between speed vs collision rate.
2. **Hashing Scheme**: How to handle key collisions after hashing. Trade-off between table size vs extra logic for key placement.

**Hash Functions**:

- `CRC-64` (1975): used in networking for error detection.
- `MurmurHash` (2008): designed as fast, general-purpose hash function.
- `XXHash` (2012): from the creator of zstd compression.

## Static Hashing

Allocate a giant array that has one slot for _every_ element that needs to be stored.

To find an entry, mod the hash of the key by the number of elements to find the offset in the array.

### Linear Probe Hashing (aka Open-Address Hashing)

Allocate a giant array of slots. The slot for an item is determined by `hash(key) mod N` where N is the number of slots.

If a collision happens (`hash(key_1) == hash(key_2)`), linearly scan for the next first free slot and place the element there. To determine whether and element is present, hash to it's location and scan since the item may have been shifted due to collisions.

Insertions and deletions are generalization of lookups. Deletions leave "tombstones" to keep the state consistent. A tombstone marks the slot as occupied when doing a search scan but can be overwritten by an insertion.

> **Note**: key is stored with value to know when to stop searching.  

![linear-probing]

**Non-Unique Keys Strategies**:

- Separate Linked List: store values with the same key in a linked list
- Redundant Keys: store duplicate keys entries together in the hash table (easier to implement)

### Robin Hood Hashing

Variant of linear probing that steals slots from "rich" keys and gives them to "poor" keys.

Each key tracks the number of positions they are from their the optimal position in the table. On insert, a key takes the slot of another key if the first is further away from it's optimal position than the second key.

The objective is to average the distance to the optimal position for each key.

![robin-hood]

### Cuckoo Hashing

Use different hash tables with different hash function seeds.

On insert, check every table and pick the one that has a free slot. If no table has a free slot, evict the element form one of them and re-hash it to find a new location.

Lookup and deletions are always `O(1)` because only one location per hash table is checked.

## Dynamic Hashing

### Chained Hashing

Maintain a linked list of _buckets_ for each slot in the hash table. Resolve collisions by placing all elements with the same hash into the same bucket. To determine if an element exists, hash to it's bucket and scan for it.

Insertions and deletions are generalization of lookups.

![bucket-chain]

### Extensible Hashing

Extension of chained hashing in which the buckets are split instead of growing forever. Multiple slot locations can point to the same bucket chain. The starting bits of the hash indicate in which bucket is located the value. When a bucket is split the values are reshuffled an the number of significant leading bits increases.

![extendible]

### Linear Hashing

The hash table maintains a _pointer_ that track the next bucket to split. When any bucket overflows, split the bucket at the pointer location.

Use multiple hashes to find the right bucket for a given key.

Can use different overflow criterion:

- Space utilization
- Average Length of Overflow Chains

<!-- links -->
[linear-probing]: ../../img/static-hash-linear-probing.excalidraw.svg "Linear Probe Hashing"
[robin-hood]: ../../img/static-hash-robin-hood.excalidraw.svg "Robin Hood Hashing"
[bucket-chain]: ../../img/dynamic-hash-chain.excalidraw.svg "Chain Hashing"
[extendible]: ../../img/dynamic-hash-extendible.excalidraw.svg "Extendible Hashing"
