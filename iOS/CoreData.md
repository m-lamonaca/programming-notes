# Core Data

Internal device data memorization in integrated DB.
Used to store data from API for offline use.

The data added or update at app launch from the APIs.

## CoreData Structure

CoreData are handled by the file `.xcdatamodel` which contains info about the *Entities* that will contain data.

The structure is similar to a DB on file (postgreSQL, sqlite).
Entities are equivalent to relational DBs tables.

An Entity is identified by a name what will be used in read/write operations.
