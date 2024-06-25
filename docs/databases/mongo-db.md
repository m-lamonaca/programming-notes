# MongoDB

The database is a container of **collections**. The collections are containers of **documents**.

The documents are _schema-less_ that is they have a dynamic structure that can change between documents in the same collection.

## Data Types

| Type              | Example Value                                    | Function                |
| ----------------- | ------------------------------------------------ | ----------------------- |
| Text              | `"Text"`                                         |
| Boolean           | `true`                                           |
| Number            | `42`                                             |
| Objectid          | `"_id": {"$oid": "<id>"}`                        | `ObjectId("<id>")`      |
| ISODate           | `"<key>": {"$date": "YYYY-MM-DDThh:mm:ss.sssZ"}` | `ISODate("YYYY-MM-DD")` |
| Timestamp         |                                                  | `Timestamp(11421532)`   |
| Embedded Document | `{"a": {...}}`                                   |
| Embedded Array    | `{"b": [...]}`                                   |

It's mandatory for each document ot have an unique field `_id`.
MongoDB automatically creates an `ObjectId()` if it's not provided.

## Databases & Collections Usage

To create a database is sufficient to switch towards a non existing one with `use <database>` (implicit creation).
The database is not actually created until a document is inserted.

```sh
show dbs  # list all databases
use <database>  # use a particular database
show collections  # list all collection for the current database

dbs.dropDatabase()  # delete current database

db.createCollection(name, {options})  # explicit collection creation
db.<collection>.insertOne({document})  # implicit collection creation
```

## Operators (MQL Syntax)

```json
/* --- Update operators --- */
{ "$inc":  { "<key>": "<increment>", ... } }  // increment value
{ "$set":  { "<key>": "<value>", ... } }  // set value
{ "$unsetset":  { "<key>": "true", ... } }  // unset value
{ "$push": { "<key>": "<value>", ... } }  // add a value to an array field or turn field into array
{ "$pop": { "<key>": <-1 | 1>, ... } }  // remove first or last array element
{ "$pull": { "<key>": "<value | condition>", ... } }  // remove a specific item in the array
{ "$pullAll": { "<key>": [ "<value1>", "<value2>" ... ], ... } }  // remove all specified values from array

/* --- Query Operators --- */
{ "<key>": { "$in": [ "<value_1>", "<value_2>", ...] } } // Membership
{ "<key>": { "$nin": [ "<value_1>", "<value_2>", ...] } }  // Membership
{ "<key>": { "$exists": true } }  // Field Exists

/* --- Comparison Operators (DEFAULT: $eq) --- */
{ "<key>": { "$gt":  "<value>" }}  // >
{ "<key>": { "$gte": "<value>" }}  // >=
{ "<key>": { "$lt":  "<value>" }}  // <
{ "<key>": { "$lte": "<value>" }}  // <=
{ "<key>": { "$eq":  "<value>" }}  // ==
{ "<key>": { "$ne":  "<value>" }}  // !=

/* --- Logic Operators (DEFAULT $and) --- */
{ "$and": [ { "<expression>" }, ...] }
{ "$or":  [ { "<expression>" }, ...] }
{ "$nor": [ { "<expression>" }, ...] }
{ "$not": { "<expression>" } }

/* --- Array Operators --- */
{ "<key>": { "$all": ["value>", "<value>", ...] } } // field contains all values
{ "<key>": { "$size": "<value>" } }
{ "<array-key>": { "$elemMatch": { "<item-key>": "<expression>" } } }  // elements in array must match an expression

/* --- REGEX Operator --- */
{ "<key>": { "$regex": "/pattern/", "$options": "<options>" } }
{ "<key>": { "$regex": "pattern", "$options": "<options>" } }
{ "<key>": { "$regex": "/pattern/<options>" } }
{ "<key>": "/pattern/<options>" }
```

### Expressive Query Operator

> **Note**:  `$<key>` is used to access the value of the field dynamically

```json
{ "$expr": { "<expression>" } }  // aggregation expression, variables, conditional expressions
{ "$expr":  { "$<comparison_operator>": [ "$<key>", "$<key>" ] } }  // compare field values (operators use aggregation syntax)
```

## Mongo Query Language (MQL)

### Insertion

It's possible to insert a single document with the command `insertOne()` or multiple documents with `insertMany()`.

Insertion results:

- error -> rollback
- success -> entire documents gets saved

```sh
# explicit collection creation, all options are optional
db.createCollection( <name>,
   {
        capped: <boolean>,
        autoIndexId: <boolean>,
        size: <number>,
        max: <number>,
        storageEngine: <document>,
        validator: <document>,
        validationLevel: <string>,
        validationAction: <string>,
        indexOptionDefaults: <document>,
        viewOn: <string>,
        pipeline: <pipeline>,
        collation: <document>,
        writeConcern: <document>
   }
)

db.createCollection("name", { capped: true, size: max_bytes, max: max_docs_num } )  # creation of a capped collection
# SIZE: int - will be rounded to a multiple of 256

# implicit creation at doc insertion
db.<collection>.insertOne({ document }, options)  # insert a document in a collection
db.<collection>.insertMany([ { document }, { document }, ... ], options)  # insert multiple docs
db.<collection>.insertMany([ { document }, { document } ] , { "ordered": false })  # allow the unordered insertion, only documents that cause errors wont be inserted
```

> **Note**: If `insertMany()` fails the already inserted documents are not rolled back but all the successive ones (even the correct ones) will not be inserted.

### Querying

```sh
db.<collection>.findOne()  # find only one document
db.<collection>.find(filter)  # show selected documents
db.<collection>.find().pretty()  # show documents formatted
db.<collection>.find().limit(n)  # show n documents
db.<collection>.find().limit(n).skip(k)  # show n documents skipping k docs
db.<collection>.find().count()  # number of found docs
db.<collection>.find().sort({ "<key-1>": 1, ... , "<key-n>": -1 })  # show documents sorted by specified keys in ascending (1) or descending (-1) order

# projection
db.<collection>.find(filter, { "<key>": 1 })  # show selected values form documents (1 or true => show, 0 or false => don't show, cant mix 0 and 1)
db.<collection>.find(filter, { _id: 0, "<key>": 1 })  # only _id can be set to 0 with other keys at 1
db.<collection>.find(filter, { "<array-key>": { "$elemMatch": { "<item-key>": "<expression>" } } })  # project only elements matching the expression

# sub documents & arrays
db.<collection>.find({ "<key>.<sub-key>.<sub-key>": "<expression>" })
db.<collection>.find({ "<array-key>.<index>.<sub-key>": "<expression>" })

# GeoJSON - https://docs.mongodb.com/manual/reference/operator/query/near/index.html
db.<collection>.find(
    {
        <location field>: {
            $near: {
                $geometry: { type: "Point", coordinates: [ <longitude> , <latitude> ] },
                $maxDistance: <distance in meters>,
                $minDistance: <distance in meters>
            }
        }
    }
)

db.<collection>.find().hint( { "<key>": 1 } )  # specify the index
db.<collection>.find().hint( "index-name" )  # specify the index using the index name

db.<collection>.find().hint( { $natural : 1 } )  # force the query to perform a forwards collection scan
db.<collection>.find().hint( { $natural : -1 } )  # force the query to perform a reverse collection scan
```

> **Note**: `{ <key>: <value> }` in case of a field array will match if the array _contains_ the value

### Updating

[Update Operators](https://docs.mongodb.com/manual/reference/operator/update/ "Update Operators Documentation")

```sh
db.<collection>.replaceOne(filter, update, options)
db.<collection>.updateOne(filter, update, {upsert: true})  # modify document if existing, insert otherwise

db.<collection>.updateOne(filter, { "$push": { ... }, "$set": { ... }, { "$inc": { ... }, ... } })
```

### Deletion

```sh
db.<collection>.deleteOne(filter, options)
db.<collection>.deleteMany(filter, options)

db.<collection>.drop()  # delete whole collection
db.dropDatabase()  # delete entire database
```

---

## MongoDB Database Tools

### [Mongoimport](https://docs.mongodb.com/database-tools/mongoimport/)

Utility to import all docs into a specified collection.  
If the collection already exists `--drop` deletes it before reuploading it.
**WARNING**: CSV separators must be commas (`,`)

```sh
mongoimport <options> <connection-string> <file>

--uri=<connectionString>
--host=<hostname><:port>, -h=<hostname><:port>
--username=<username>, -u=<username>
--password=<password>, -p=<password>
--collection=<collection>, -c=<collection>  # Specifies the collection to import.
--ssl  # Enables connection to a mongod or mongos that has TLS/SSL support enabled.
--type <json|csv|tsv>  # Specifies the file type to import. DEFAULT: json
--drop  # drops the collection before importing the data from the input.
--headerline  # if file is CSV and first line is header
--jsonarray  # Accepts the import of data expressed with multiple MongoDB documents within a single json array. MAX 16 MB
```

### [Mongoexport](https://docs.mongodb.com/database-tools/mongoexport/)

Utility to export documents into a specified file.

```sh
mongoexport --collection=<collection> <options> <connection-string>

--uri=<connectionString>
--host=<hostname><:port>, -h=<hostname><:port>
--username=<username>, -u=<username>
--password=<password>, -p=<password>
--db=<database>, -d=<database>
--collection=<collection>, -c=<collection>
--type=<json|csv>
--out=<file>, -o=<file>  #Specifies a file to write the export to. DEFAULT: stdout
--jsonArray  # Write the entire contents of the export as a single json array.
--pretty  # Outputs documents in a pretty-printed format JSON.
--skip=<number>
--limit=<number>  # Specifies a maximum number of documents to include in the export
--sort=<JSON>  # Specifies an ordering for exported results
```

### [Mongodump][mongodump_docs] & [Mongorestore][mongorestore_docs]

`mongodump` exports the content of a running server into `.bson` files.

`mongorestore` Restore backups generated with `mongodump` to a running server.

[mongodump_docs]: https://docs.mongodb.com/database-tools/mongodump/
[mongorestore_docs]: https://docs.mongodb.com/database-tools/mongorestore/

---

## [Indexes](https://docs.mongodb.com/manual/indexes/ "Index Documentation")

Indexes support the efficient execution of queries in MongoDB.

Without indexes, MongoDB must perform a _collection scan_ (_COLLSCAN_): scan every document in a collection, to select those documents that match the query statement.  
If an appropriate index exists for a query, MongoDB can use the index to limit the number of documents it must inspect (_IXSCAN_).

Indexes are special data structures that store a small portion of the collection's data set in an easy to traverse form. The index stores the value of a specific field or set of fields, ordered by the value of the field. The ordering of the index entries supports efficient equality matches and range-based query operations. In addition, MongoDB can return sorted results by using the ordering in the index.

Indexes _slow down writing operations_ since the index must be updated at every writing.

![IXSCAN](../img/mongodb_ixscan.avif ".find() using an index")

### [Index Types](https://docs.mongodb.com/manual/indexes/#index-types)

- **Normal**: Fields sorted by name
- **Compound**: Multiple Fields sorted by name
- **Multikey**: values of sorted arrays
- **Text**: Ordered text fragments
- **Geospatial**: ordered geodata

**Sparse** indexes only contain entries for documents that have the indexed field, even if the index field contains a null value. The index skips over any document that is missing the indexed field.

### Diagnosis and query planning

```sh
db.<collection>.find({...}).explain()  # explain won't accept other functions
db.explain().<collection>.find({...})  # can accept other functions
db.explain("executionStats").<collection>.find({...})  # more info
```

### Index Creation

```sh
db.<collection>.createIndex( <key and index type specification>, <options> )

db.<collection>.createIndex( { "<key>": <type>, "<key>": <type>, ... } )  # normal, compound or multikey (field is array) index
db.<collection>.createIndex( { "<key>": "text" } )  # text index
db.<collection>.createIndex( { "<key>": 2dsphere } )  # geospatial 2dsphere index

# sparse index
db.<collection>.createIndex(
    { "<key>": <type>, "<key>": <type>, ... },
    { sparse: true }  # sparse option
)

# custom name
db.<collection>.createIndex(
  { <key and index type specification>, },
  { name: "index-name" }  # name option
)
```

### [Index Management](https://docs.mongodb.com/manual/tutorial/manage-indexes/)

```sh
# view all db indexes
db.getCollectionNames().forEach(function(collection) {
   indexes = db[collection].getIndexes();
   print("Indexes for " + collection + ":");
   printjson(indexes);
});
db.<collection>.getIndexes()  # view collection's index

db.<collection>.dropIndexes()  # drop all indexes
db.<collection>.dropIndex( { "index-name": 1 } )  # drop a specific index
```

---

## Cluster Administration

### `mongod`

`mongod` is the main deamon process for MongoDB. It's the core process of the database,
handling connections, requests and persisting the data.

`mongod` default configuration:

- port: `27017`
- dbpath: `/data/db`
- bind_ip: `localhost`
- auth: disabled

[`mongod` config file][mongod_config_file]  
[`mongod` command line options][mongod_cli_options]

[mongod_config_file]: https://www.mongodb.com/docs/manual/reference/configuration-options "`mongod` config file docs"
[mongod_cli_options]: https://www.mongodb.com/docs/manual/reference/program/mongod/#options "`mongod` command line options docs"

### Basic Shell Helpers

```sh
db.<method>()  # database interaction
db.<collection>.<method>()  # collection interaction
rs.<method>();  # replica set deployment and management
sh.<method>();  # sharded cluster deployment and management

# user management
db.createUser()
db.dropUser()

# collection management
db.renameCollection()
db.<collection>.createIndex()
db.<collection>.drop()

# database management
db.dropDatabase()
db.createCollection()

# database status
db.serverStatus()

# database command (underlying to shell helpers and drivers)
db.runCommand({ "<COMMAND>" })

# help
db.commandHelp("<command>)
```

### Logging

The **process log** displays activity on the MongoDB instance and collects activities of various components:

Log Verbosity Level:

- `-1`: Inherit from parent
- `0`: Default Verbosity (Information)
- `1 - 5`: Increases the verbosity up to Debug messages

```sh
db.getLogComponents()  # get components and their verbosity
db.adminCommand({"getLog": "<scope>"})  # retrieve logs (getLog must be run on admin db -> adminCommand)
db.setLogLevel(<level>, "<component>");  # set log level (output is OLD verbosity levels)

tail -f /path/to/mongod.log  # read end og log file
```

> **Note**: Log Message Structure: `<timestamp> <severity-level> <component> <connection> <event> ...`

### Database Profiling

Profiling Levels:

- `0`: no profiling
- `1`: data on operations slower than `slowms` (default 100ms)
- `2`: data on all operations

Events captured by the profiler:

- CRUD operations
- Administrative operations
- Configuration operations

> **Note**: Logs are saved in the `system.profile` _capped_ collection.

```sh
db.setProfilingLevel(n)  # set profiler level
db.setProfilingLevel(1, { slowms: <ms> })
db.getProfilingStatus()  # check profiler status

db.system.profile.find().limit(n).sort( {} ).pretty()  # see logs
db.system.profile.find().limit(n).sort( { ts : -1 } ).pretty()  # sort by decreasing timestamp
```

### Authentication

Client Authentication Mechanisms:

- **SCRAM** (Default): Salted Challenge Response Authentication Mechanism
- **X.509**: `X.509` Certificate
- **LADP**: Lightweight Directory Access Protocol (Enterprise Only)
- **KERBEROS** (Enterprise Only)

### Authorization: Role Based Access Control (RBAC)

Each user has one or more **Roles**. Each role has one or more **Privileges**.  
A privilege represents a group of _actions_ and the _resources_ those actions apply to.

By default no user exists so the ONLY way to act is to connect locally to the server.  
This is the "localhost exception" and it closes after the _first_ user is created.

> **Warn**: Always create an admin user first (ideally with the `userAdmin` role)

Role's **Resources**:

- specific database and collection: `{ "db": "<database>", "collection": "<collection>" }`
- all databases and collections: `{ "db": "", "collection": "" }`
- any databases and specific collection: `{ "db": "", "collection": "<collections>" }`
- specific database and any collection: `{ "db": "<database>", "collection": "" }`
- cluster resource: `{ "cluster": true }`

Role's **Privileges**: `{ resource: { <resource> }, actions: [ "<action>" ] }`

A role can _inherit_ from multiple others and can define **network restrictions** such as _Server Address_ and _Client Source_.

Built-in Roles Groups and Names:

- Database User: `read`, `readWrite`, `readAnyDatabase`, `readWriteAnyDatabase`
- Database Administration: `dbAdmin`, `userAdmin`, `dbOwner`, `dbAdminAnyDatabase`, `userAdminAnyDatabase`
- Cluster Administration: `clusterAdmin`, `clusterManager`, `clusterMonitor`, `hostManager`
- Backup/Restore: `backup`, `restore`
- Super User: `root`

```sh
db.createUser({
    user: "<username>",
    pwd: "<password>",
    roles: [ { role: "<role>", db: "<database>" } ]
})

db.createRole({
    role: "<role>",
    privileges: [
        { resource: { cluster: true }, actions: [ "<action>", ... ] },
        {
            resource: { 
                db: "<database>",
                collection: "<collection>"
            },
            actions: [ "<action>", ... ]
        },
    ],
    roles: [
        { role: "<role>", db: "<database>" }  # inherited permissions
    ]
})

# add role to existing user
db.grantRolesToUser(
    "<user>",
    [
        { 
            role: "<role>"
            db: "<database>",
            collection: "<collection>",
        }
    ]
)

# show role privileges
db.runCommand({
    rolesInfo: { db: "<database>", role: "<role>" },
    showPrivileges: true 
})
```

### [Replica set](https://docs.mongodb.com/manual/replication/)

A **replica set** in MongoDB is a group of `mongod` processes that maintain the `same dataset`. Replica sets provide redundancy and high availability, and are the basis for all production deployments.

### Sharding

**Sharding** is a MongoDB concept through which big datasets are subdivided in smaller sets and distributed towards multiple instances of MongoDB.  
It's a technique used to improve the performances of large queries towards large quantities of data that require al lot of resources from the server.

A collection containing several documents is splitted in more smaller collections (_shards_)
Shards are implemented via cluster that are none other a group of MongoDB instances.

Shard components are:

- Shards (min 2), instances of MongoDB that contain a subset of the data
- A config server, instance of MongoDB which contains metadata on the cluster, that is the set of instances that have the shard data.
- A router (or `mongos`), instance of MongoDB used to redirect the user instructions from the client to the correct server.

![Shared Cluster](../img/mongodb_shared-cluster.avif "Components of a shared cluster")

---

## [Aggregation Framework](https://docs.mongodb.com/manual/reference/operator/aggregation-pipeline/)

Sequence of operations applied to a collection as a _pipeline_ to get a result: `db.collection.aggregate(pipeline, options)`.  
Each step of the pipeline acts on its inputs and not on the original data in the collection.

### Variables

Variable syntax in aggregations:

- `$key`: field path
- `$$UPPERCASE`: system variable (e.g.: `$$CURRENT`)
- `$$foo`: user defined variable

### [`$match` Aggregation Stage][$match_docs]

Filters the documents to pass only the documents that match the specified condition(s) to the next pipeline stage.

```sh
db.<collection>.aggregate([ 
    { "$match": { "<query>" } },

    # key exists and is an array
    { $match: { "<array-key>": { $elemMatch: { $exists: true } } } }
})
```

> **Note**: `$match` can contain the `$text` query operation but it **must** ber the _first_ in a pipeline  
> **Note**: `$match` cannot contain use `$where`  
> **Note**: `$match` uses the same syntax as `find()`

[$match_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/match/ "$match operator docs"

### [`$project` Aggregation Stage][$project_docs]

Passes along the documents with the requested fields to the next stage in the pipeline. The specified fields can be existing fields from the input documents or newly computed fields.

`$project` Array Expression Operators:

- [`$filter`][$filter_docs]
- [`$map`][$map_docs]
- [`$reduce`][$reduce_docs]

`$project` Arithmetic Expression Operators:

- [`$max`][$max_docs]
- [`$min`][$min_docs]
- [`$sum`][$sum_docs]
- [`$avg`][$avg_docs]

```sh
db.<collection>.aggregate([ 
     { 
        "$project": { 
            "_id": 0,  # discard value
            "<key>": 1,  # keep value
            "<key>": "$<other-key>"  # reassign or create field,
            "<key>": { "<expression>" } # calculate field value.

            # filter elements in an array
            "<key>": {
                "$filter": {
                    "input": "$<array-key>",
                    "as": "<name-of-item>",
                    "cond": { "<bool-expression>" }
                }
            },

            # transform array items
            "<key>": {
                "$map": {
                    "input": "$<array-key>",
                    "as": "<item>",
                    "in": { "<expression>" }
                    # $$<item> is the current item's value
                }
            }

            # apply expression to each element in an array and combine them
            "<key>": {
                "$reduce": {
                    "input": "<array-key>",
                    "initialValue": "<value>",
                    "in": { "<expression>" }
                    # $$this is current document, $$value is current accumulated value
                }
            }
        }
    } 
])
```

[$project_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/project/ "$project operator docs"
[$filter_docs]: https://www.mongodb.com/docs/v4.4/reference/operator/aggregation/filter/ "$filter operator docs"
[$map_docs]: https://www.mongodb.com/docs/v4.4/reference/operator/aggregation/map/ "$map operator docs"
[$reduce_docs]: https://www.mongodb.com/docs/v5.0/reference/operator/aggregation/reduce/ "$reduce operator docs"

[$sum_docs]: https://www.mongodb.com/docs/v5.0/reference/operator/aggregation/sum/ "$sum operator docs"
[$max_docs]: https://www.mongodb.com/docs/v5.0/reference/operator/aggregation/max/ "$max operator docs"
[$min_docs]: https://www.mongodb.com/docs/v5.0/reference/operator/aggregation/min/ "$min operator docs"
[$avg_docs]: https://www.mongodb.com/docs/v5.0/reference/operator/aggregation/avg/ "$avg operator docs"

### [`$addFields` Aggregation Stage][$addFields_docs]

Adds new fields to documents (can be result of computation).  
`$addFields` outputs documents that contain _all existing fields_ from the input documents and newly added fields.

```sh
db.<collection>.aggregate({
    { $addFields: { <newField>: <expression>, ... } }
})
```

[$addFields_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/addFields/ "$addFields operator docs"

### [`$group` Aggregation Stage][$group_docs]

The $`group` stage separates documents into groups according to a "group key". The output is one document for each unique group key.

```sh
db.<collection>.aggregate([ 
     { 
        "$group": {
            "_id": "<expression>",  # Group By Expression (Required)
            "<key-1>": { "<accumulator-1>": "<expression-1>" },
            ...
        } 
    }
])
```

[$group_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/group/ "$group operator docs"

### [`$unwind` Aggregation Stage][$unwind_docs]

Deconstructs an array field from the input documents to output a document for each element.  
Each output document is the input document with the value of the array field replaced by the element

```sh
db.<collection>.aggregate([ 
     { "$unwind": "<array-key>" }

     { 
        "$unwind": {
            "path": "<array-key>",  # array to unwind
            "includeArrayIndex": "<string>",  # name of index field
            "preserveNullAndEmptyArrays": <bool>
        } 
     }
], { "allowDiskUse": <bool> })
```

[$unwind_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/unwind/ "$unwind operator docs"

### [`$count` Aggregation Stage][$count_docs]

```sh
db.<collection>.aggregate([ 
     { "$count": "<count-key>" }
])
```

[$count_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/count/ "$count operator docs"

### [`$sort` Aggregation Stage][$sort_docs]

```sh
db.<collection>.aggregate([ 
     { 
        "$sort": { 
            "<key-1>": "<sort order>", 
            "<key-2>": "<sort order>", 
            ... 
        } 
    }
], { "allowDiskUse": <bool> })
```

> **Note**: can take advantage of indexes if early int the pipeline and before any `%project`, `$group` and `$unwind`  
> **Note**: By default `$sort` will use up to 10 MB of RAM. Setting `allowDiskUse: true` will allow for larger sorts

[$sort_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/sort/ "$sort operator docs"

### [`$skip` Aggregation Stage][$skip_docs]

```sh
db.<collection>.aggregate([ 
     { "$skip": "<positive 64-bit integer>" }
])
```

[$skip_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/skip/ "$skip operator docs"

### [`$limit` Aggregation Stage][$limit_docs]

```sh
db.<collection>.aggregate([ 
     { "$limit": "<positive 64-bit integer>" }
])
```

[$limit_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/limit/ "$limit operator docs"

### [`$lookup` Aggregation Stage][$lookup_docs]

Performs a left outer join to a collection _in the same database_ to filter in documents from the "joined" collection for processing.  
The `$lookup` stage adds a new array field to each input document. The new array field contains the matching documents from the "joined" collection.

> **Note**: To combine elements from two different collections, use the [`$unionWith`][$unionWith_docs] pipeline stage.

```sh
db.<collection>.aggregate([ 
    {
        "$lookup": {
            "from": "<foreign-collection>",
            "localField": "<key>",
            "foreignField": "<foreign-collection>.<key>",
            "as": "<output array field>"
        }
    }
])
```

[$lookup_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/lookup/ "$look operator docs"

[$unionWith_docs]: https://www.mongodb.com/docs/manual/reference/operator/aggregation/unionWith/ "$unionWith operator docs"

### [`$graphLookup` Aggregation Stage][$graph_lookup_docs]

Performs a recursive search on a collection, with options for restricting the search by recursion depth and query filter.

The collection on which the aggregation is performed and the `from` collection can be the same (in-collection search) or different (cross-collection search)

```sh
db.<collection>.aggregate([
    {
        $graphLookup: {
            from: <collection>,  # starting collection of the search
            startWith: <expression>,  # initial value(s) of search
            connectFromField: <string>,  # source of the connection
            connectToField: <string>,  # destination of the connection
            as: <string>,  # array of found documents
            maxDepth: <number>,  # recursive search depth limit (steps inside from collection)
            depthField: <string>,  # field containing distance from start
            restrictSearchWithMatch: <document>  # filter on found documents
        }
    }
], { allowDiskUse: true })
```

> **Note**: Having the `connectToField` indexed will improve search performance  
> **Warn**: Can exceed the `100 Mb` memory limit even with `{ allowDiskUse: true }`

[$graph_lookup_docs]: https://www.mongodb.com/docs/upcoming/reference/operator/aggregation/graphLookup/ "$graphLookup operator docs"

### [`$sortByCount` Aggregation Stage][$sort_by_count_docs]

Groups incoming documents based on the value of a specified expression, then computes the count of documents in each distinct group.

Each output document contains two fields: an `_id` field containing the distinct grouping value, and a `count` field containing the number of documents belonging to that grouping or category.

The documents are sorted by count in descending order.

```sh
db.<collection>.aggregate([
    { $sortByCount:  <expression> }
])
```

[$sort_by_count_docs]: https://www.mongodb.com/docs/upcoming/reference/operator/aggregation/sortByCount/ "$sortByCount operator docs"
