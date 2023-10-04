# Disk Oriented Database Storage

The DBMS assumes that the primary storage location of the database is non-volatile disk.

The DBMS component's manage the movement of data between non-volatile and volatile storage.

![storage-hierarchy]

Access Times:

- L1 Cache Ref: 0.5 ns
- L2 Cache Ref: 7ns
- RAM: 100 ns
- SSD: 150 µs
- HDD: 10 ms
- Network Storage: ~30 ms
- Tape Archives: 1 s

The goal is to allow the DBMS to manage databases that exceed the amount of memory available.

Reading/writing to disk is expensive, so it must be managed carefully to avoid large stalls ans performance degradation.

![disk-operations]

## OS Memory Management

It's possible to use memory mapping (`mmap`) to store the contents of a file into a process' address space. The OS is responsible for moving the file pages in and out of memory.

The OS does not know the intended usage for the memory and so fine-grained control over the pages is not possible:

- When the physical memory is full the (un)loading of memory pages can slow or stall the thread.  
- Using multiple thread is viable on multiple reads but is complicated on multiple writes.
- The order of unloaded pages is not controllable

There are some solutions to this problem:

- `madvise`: tell the OS how certain pages are expected to be read.
- `mlock`: tell the OS that memory ranges cannot be paged out (can still write on it).
- `msync`: tell the OS to flush memory ranges out to disk.

Using `mmap` leads to performance and correctness problems.

DBMS (almost) always wants to control things itself and can do a better job at it:

- flushing dirty pages to disk in the correct order
- specialized pre-fetching
- buffer replacement policy
- thread/process scheduling

## File Storage

The DBMS stores a database as one or more files on disk. The OS does not know anything about the contents of those files.

The **storage manager** is responsible for maintaining a database's files. It organizes files as a collection of _pages_. It tracks data read/written to pages and the available space.

A **page** is a fixed-size block of data. It can contain tuples, metadata, indexes, log records, etc.  
Most systems do not mix page types and some require pages to be self-contained for disaster recovery purposes.

Each page is given a _unique identifier_. The DBMS uses an indirection layer to map page ids to physical locations.

There are three different notion of "pages" in a DBMS:

- Hardware Page (usually 4KB)
- OS Page (usually 4KB)
- Database Page (512B - 165KB)

Hardware pages are the size at which the device can guarantee a "failsafe write".

Different DBMSs manage pages in files on disk in different ways:

- Heap File Organization
- Sequential / Sorted File Organization
- Hashing File Organization

At this point in the hierarchy it does not matter the content of a page.

### Database Heap File

A **Heap file** is an unordered collection of pages where tuples are stored in random order. Metadata is needed to keep track what pages exist and which have free space.

There are two ways to represent a heap file:

- Linked List
- Page Directory

### Linked List

Maintain a _header page_ at the beginning of the file that stores two pointers:

- HEAD of the _free page list_
- HEAD of the _data page list_

Each page keeps track of the number of free slots in itself.

![linked-list-heap-file]

### Page Directory

The DBMS maintains special pages that track the location of data pages in the database files.  
The directory also records the number of free slots per page.

The DBMS has to make sure that the directory pages are in sync with the data pages.

![page-directory]

## Page Layout

Every page contains a _header_ of metadata about the page contents:

- Page Size
- Checksum
- DBMS Version
- Transaction Visibility
- Compression Information

Data inside a page can be organized with two approached:

- Tuple oriented
- Log oriented

### Log Oriented Page Layout

Instead of storing tuples in pages, the DBMS only stores **log records** in the files.

The system appends log records of _how_ the database was modified:

- Inserts store the entire tuple.
- Deletes mark the tuple as deleted.
- Updates contain the delta of just the attributes that were modified.

To read a record, the DBMS scans the log and "recreates" the tuple to find what it needs.

![log-record]

### Tuple Oriented Page Layout

The most common layout scheme is called _slotted  pages_. The slot array maps "slots" to the tuples' starting position offsets.

The header keeps track of:

- the number of used slots.
- the offset of the starting location of the last used slot.

The tuples start from the end of the page and grow "upwards" while the slot array starts from the beginning of the page and grows "downwards".  
When the two meet the page is full.

> **Note**: the position and growing behavior is similar to a program's stack and heap memory

![page-layout]

### Record IDs

The DBMS needs a way to keep track of individual tuple. Each tuple is assigned and unique **record identifier**.  
Most common is `page_id + offset/slot`. They can also contain file location info.

> **Note**: an application _cannot_ rely on record ids to derive meaning.

## Tuple Layout

A tuple is essentially a sequence of bytes. It's the job of the DBMS to interpret those bytes into types and values.

The DBMS's _catalogs_ contain the schema information about tables and can be used to understand the tuple layout.

Each tuple is prefixed with and _header_ that contains metadata about it:

- visibility info (concurrency control)
- bitmap for `NULL` values

Attributes are typically stored in the order in which they are defined while creating the table.

> **Note**: metadata about the schema is _not_ stored.

![tuple-layout]

```sql
CREATE TABLE <table> (
    a INT PRIMARY KEY,
    b INT NOT NULL,
    c FLOAT,
    d INT
)
```

## Data Representation

- Fixed Precision Numbers: [IEEE-754]
- Variable Length Data: header with length, followed by data bytes
- Time & Date: 32/64-bit integer of microseconds since Unix epoch

### Variable Precision Numbers

Inexact, variable-precision numeric type stored as specified by [IEEE-754]. Typically faster than arbitrary precision numbers but can have rounding errors.

### Fixed Precision Numbers

Numeric data types with arbitrary precision and scale. Used when rounding errors are unacceptable.

Typically stored in exact, variable-length binary representation with additional metadata.

### Large Values

Most DBMS don't allow a tuple to exceed the size of a single page.

To store values that are larger than a page, the DBMS uses separate **overflow** storage pages.

Some systems allow to store really large values in an external file but the DBMS _cannot manipulate_ the contents of the external file.  
This means no durability protections ans not transaction protections.

[To BLOB or Not to BLOB Paper](to-blob-or-not-to-blob-larg-object-storage-in-a-database-or-a-filesystem.pdf "To BLOB or not to BLOB PDF")

![overflow-page]

### System Catalog

A DBMS stores metadata about databases in it's internal catalogs. The catalogs contain metadata about:

- Tables, columns, indexes, views
- Users, permissions
- Internal statistics

Almost every DBMS stores their database's catalog in itself.

It's possible to query the database internal `INFORMATION_SCHEMA` catalog to get info about the database. This catalog in an ANSI standard set of read only views that provide info about all of the tables, views, columns, procedures in a database.

```sql
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_catalog = '<db_name>';  -- list of tables
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name = '<table>';  -- schema of a table
```

> **Note**: DBMS also have non-standard shortcuts to retrieve this information.

## Database Workloads & Data Storage Models

- [**On-Line Transaction Processing** (`OLTP`)][OLTP]: Simple queries that read/update a small amount of data that is related to a single entity in the database.
- [**On-Line Analytical Processing** (`OLAP`)][OLAP]: Complex queries that read large portions of the database spanning multiple entities.

The DBMS can store tuples in different ways that are better for either OLTP or OLAP workloads.

### N-Ary Storage Model (`NSM`)

The DBMS stores all attributes for a single tuple contiguously in a page (aka _row store_). It's ideal for OLTP workloads where queries tend to operate only on an individual entity and insert-heavy workloads.

Advantages:

- fast inserts, updates and deletes.
- good for queries that need the entire tuple.

Disadvantages:

- Not good for scanning large portions of the table and/or subsets of the attributes.

![nary-storage-model]

### Decomposition Storage Model (`NSM`)

The DBMS stores the values of a single attribute for all tuples contiguously in a page (aka _column store_). It's ideal for OLAP workloads where read-only queries perform large scans over a subset og the table attributes.

![decomposition-storage-model]

To identify all the parts of the same tuple in the different pages there are two choices:

- Fixed-length Offsets: each value ahs same length and is in the same position
- Embedded Tuple Ids: each value is stored with it's tuple id in a column

![dsm-tuple-identification]

Advantages:

- Reduces the amount of wasted disk I/O because DBMS reads only the data that it needs
- Better quality of processing and data compression

Disadvantages:

- Slow for point queries, inserts, update and deletes because of tuple splitting/stitching.

<!-- images -->
[storage-hierarchy]: ../../img/storage-hierarchy.excalidraw.svg "Storage Hierarchy"
[disk-operations]: ../../img/disk-operations.excalidraw.svg "Disk Operations"
[linked-list-heap-file]: ../../img/linked-list.excalidraw.svg "Heap File as a Linked List"
[page-directory]: ../../img/page-directory.excalidraw.svg "Page Directory"
[page-layout]: ../../img/page-layout.excalidraw.svg "Page Layout"
[log-record]: ../../img/log-record.excalidraw.svg "Log Record"
[tuple-layout]: ../../img/tuple-layout.excalidraw.svg "Tuple Layout"
[overflow-page]: ../../img/overflow-page.excalidraw.svg "Overflow Page"
[nary-storage-model]: ../../img/nary-storage-model.excalidraw.svg "N-Ary Storage Model"
[decomposition-storage-model]: ../../img/decomposition-storage-model.excalidraw.svg "Decomposition Storage Model"
[dsm-tuple-identification]: ../../img/dsm-tuple-identification.excalidraw.svg "DSM Tuple Identification"

<!-- references -->
[IEEE-754]: https://wikipedia.org/wiki/IEEE_754 "IEEE-754 Standard"
[OLTP]: https://en.wikipedia.org/wiki/Online_transaction_processing "On-Line Transaction Processing - Wikipedia"
[OLAP]: https://en.wikipedia.org/wiki/Online_analytical_processing "On-Line Analytical Processing - Wikipedia"
