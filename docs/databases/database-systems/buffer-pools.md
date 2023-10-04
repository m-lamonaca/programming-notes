# Buffer Pools & Memory

## Buffer Pool Manager

The **buffer pool** is a memory region organized as an array of fixed-size pages. An array entry is called a _frame_.

When a DBMS requests a page, an exact copy is placed into one of these frames.

The **page table** keeps track of pages that are currently in memory. It also maintains additional metadata per page:

- Dirty Flag
- Pin/Reference Counter

![buffer-pool]

### Page Table vs Page Directory

The _page directory_ is the mapping from page ids to page locations in the database file. All changes must be recorded on disk to allow the DBMS to find the data on restart.

The _page table_ is the mapping from page ids to a copy og the page in the buffer pool frames. This is an in-memory data structure that does not need to be stored on disk.

### Allocation Polices

_Global Policies_ make decisions for all active transactions.

_Local Policies_ allocate frames for specific transactions without considering behaviour of concurrent transactions. This still need to support sharing pages.

## Buffer Pool Optimizations

### Multiple Buffer Pools

The DBMS does not always have a single buffer pool for the entire system:

- multiple buffer pool instances
- per-database buffer pool
- per-page type buffer pool

Multiple buffer pools help to reduce latch contention and improve locality.

There are multiple approaches to manage multiple buffer pools:

- Object Id: embed an object id in record ids and then maintain from objects to specific buffer pools.
- Hashing: hash the page id to select which buffer pool to access.

![multiple-buffer-pools]

### Pre-Fetching

The DBMS can also prefetch pages based on a query plan in order to reduce the wait between the request of a page end its load in memory.

### Scan Sharing

Queries can reuse data retrieved from storage or operator computations. This is done by allowing multiple queries to attach to a single cursor that scans a table. It's also possible to share intermediate results.

If a query stats a scan and if there is one already doing the same operation, then the DBMS will attach the new cursor to the second query cursor.  
The DBMS keeps track of where the second query joined the first so that it can retrieve the pages that were already scanned by the first query.

> **Note**: _Scan Sharing_ is different from _Output Caching_.

### Buffer Pool Bypass

The sequential scan will not store fetched pages in the buffer pool to avoid overhead. The used memory is local to the query thread and will be discarded as the scan finishes. This avoids the overhead of going to the page table and of evicting pages if the buffer is full.

### OS Page Cache

Most disk operations go through the OS API. Unless the DBMS tells it to, the OS maintains its own filesystem cache.  
Most DBMSs use direct I/O (`O_DIRECT`) to bypass the OS's cache to avoid redundant copies of pages and the loss of control over I/O, since the DBMS has different eviction policies.

## Page Replacement Policies

When the DBMS needs to free up a frame to make space for a new page, it must decide which page to _evict_ from the buffer pool.

Goals:

- **Correctness**: do not evict _pinned_ data.
- **Accuracy**: evict rarely used pages.
- **Speed**
- **Metadata Overhead**

### LRU (Last Recently Used)

Maintain a timestamp of when each page was last accessed. When the DBMS needs to evict a page, select the one with the oldest timestamp.

> **Note**: Keep the pages in sorted order to reduce search time on eviction

### CLOCK

Approximation of LRU without needing a separate timestamp per page.

Each page has a _reference bit_. When the page is accessed the bit is set to 1.

The pages are organised in a circular buffer with a "clock hand". Upon sweeping, check if a page's bit is set to 1: toggle if is 1, evict if is zero.

> **Note**: LRU and CLOCK replacement policies are susceptible to _sequential flooding_. A sequential scan that reads every page pollutes the buffer pool with pages that are read only once. In this case the most recently used page is actually the most unneeded one.

### LRU-K

Track the history of last _K_ references to each page as timestamps and compute the interval between subsequent access.  
The DBMS then uses this history to estimate the next time that page is going to be accessed.

### Localization

The DBMS chooses which page to evict on a transaction/query basis. This minimizes the pollution of the pool from each query.

### Priority Hints

The DBMS knows the context of each page during query execution. It can provide hints to the buffer pool on whether a page is important or not.

### Dirty Pages

**Fast**: if a page in the buffer pool is _not_ dirty, then the DBMS can simply drop it.
**Slow**: if a page is dirty, then the DBMS must write back to disk to ensure that its changes are persisted.

It's a tradeoff between fast evictions versus writing dirty pages that will not be read again in the future.

> **Note**: a page is _dirty_ if a query has modified it while it's in the buffer pool (not yet written to disk).

### Background Writing

The DBMS can periodically walk through the page table and write dirty pages to disk. When a dirty page is safely written, the DBMS can either evict it or just unset the dirty flag.

> **Note**: need to be careful to avoid writing dirty pages before their log records have been written.

<!-- images -->
[buffer-pool]: ../../img/buffer-pool.excalidraw.svg "Buffer Pool"
[multiple-buffer-pools]: ../../img/multiple-buffer-pools.excalidraw.svg "Multiple Buffer Pools"
