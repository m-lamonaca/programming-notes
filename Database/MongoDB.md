# MongoDB Cheat Sheet

## Terminologia & concetti base

Il database è un contenitore di **collezioni** (tabelle in DB relazionali). Le collezioni sono mini contenitori di **documenti** (record in DB relazionali).

I documenti sono *schema-less* ovvero hanno una struttura dinamica ed essa può cambiare tra documenti all'interno della stessa collezione.  
La struttura di un documento è quella del JSON.

### Tipi di dati

| Tipo              | Documento                                      | Funzione                |
|-------------------|------------------------------------------------|-------------------------|
| Text              | `"Text"`                                       |
| Boolean           | `true`                                         |
| Number            | `42`                                           |
| Objectid          | `"_id": {"$oid": "<id>"}`                      | `ObjectId("<id>")`      |
| ISODate           | `"key": {"$date": "YYYY-MM-DDThh:mm:ss.sssZ"}` | `ISODate("YYYY-MM-DD")` |
| Timestamp         |                                                | `Timestamp(11421532)`   |
| Embedded Document | `{"a": {...}}`                                 |
| Embedded Array    | `{"b": [...]}`                                 |

E' obbligatorio per ogni documento avere un campo `_id` univoco.  
MongoDB di occupa di creare un `ObjectId()` in automatico.

### Uso Database

Per creare un database è sufficiente effettuare uno switch verso un db non-esistente (creazione implicita): `use [database]`  
il db non viene creato finchè non si inserisce un dato.

```sh
show dbs  # list all databases
use <database>  # use a particular database
show collections  # list all collection for the current database

dbs.dropDatabase()  # delete current database
```

## Uso Collezioni

```sh
db.createCollection(name, {options})  # creazione collezione
db.<collection>.insertOne({document})  # creazione implicita collezione
```

## Operazioni CRUD

### Filters

Base Syntax: `{ "outerKey.innerKey": "value" }`
Comparison: `{ key: { $operator : "value"} }`

| Operator | Math Symbol |
|----------|-------------|
| `$gt`    | >           |
| `$gte`   | =>          |
| `$lt`    | <           |
| `$lte`   | <=          |
| `$eq`    | ==          |
| `$ne`    | !=          |

Field Exists: `{ key: {$exists: true} }`
Logical `Or`: `{ $or: [ {filter_1}, {filter_2}, ... ] }`
Membership: `{ key: { $in: [value_1, value_2, ...] } }` or `{ key: { $nin: [value_1, value_2, ...] } }`

### Create

È possibile inserire documenti con il comando `insertOne()` (un documento alla volta) o `insertMany()` (più documenti).

Risultati inserimento:

- errore -> rollback
- successo -> salvataggio intero documneto

```sh
# explicit collection creation, all options are otional
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
db.<collection>.insert()
```

Se `insertMany()` causa un errore il processo di inserimento si arresta. Non viene eseguito il rollback dei documenti già inseriti.

### Read

```sh
db.<collection>.findOne()  # find only one document
db.<collection>.find(filter)  # show selected documents
db.<collection>.find(filter, {key: 1})  # show selected values form documents (1 or true => show, 0 or false => dont show, cant mix 0 and 1)
db.<collection>.find(filter, {_id: 0, key: 1})  # only _id can be set to 0 with other keys at 1
db.<collection>.find().pretty()  # show documents formatted
db.<collection>.find().limit(n)  # show n documents
db.<collection>.find().limit(n).skip(k)  # show n documents skipping k docs
db.<collection>.find().count()  # number of found docs
db.<collection>.find().sort({key1: 1, ... , key_n: -1})  # show documents sorted by specified keys in ascending (1) or descending (-1) order

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

db.<collection>.find().hint( { <field>: 1 } )  # specify the index
db.<collection>.find().hint( "index-name" )  # specify the index using the index name

db.<collection>.find().hint( { $natural : 1 } )  # force the query to perform a forwards collection scan
db.<collection>.find().hint( { $natural : -1 } )  # force the query to perform a reverse collection scan
```

### Update

[Update Operators](https://docs.mongodb.com/manual/reference/operator/update/ "Update Operators Documentation")

```sh
db.<collection>.updateOne(filter, $set: {key: value})  # add or modify values
db.<collection>.updateOne(filter, $set: {key: value}, {upsert: true})  # add or modify values, if attribute doesent exists create it

db.<collection>.updateMany(filter, update)

db.<collection>.replaceOne(filter, { document }, options)
```

### Delete

```sh
db.<collection>.deleteOne(filter, options)
db.<collection>.deleteMany(filter, options)

db.<collection>.drop()  # delete whole collection
db.dropDatabase()  # delete entire database
```

## Mongoimport Tool

Utility to import all docs into a specified collection.  
If the collection alredy exists `--drop` deletes it before reuploading it.
**WARNING**: CSV separators must be commas (`,`)

```sh
mongoimport -h <host:port> –d <database> –c <collection> --drop --jsonArray <souce_file>

mongoimport --host <HOST:PORT> --ssl --username <USERNAME> --password <PASSWORD> --authenticationDatabase admin --db <DATABASE> --collection <COLLECTION> --type <FILETYPE> --file <FILENAME>

# if file is CSV and first line is header
mongoimport ... --haderline
```

## Mongoexport Tool

Utility to export documents into a specified file.

```sh
mongoexport -h <host:port> –d <database> –c <collection> <souce_file>

mongoexport --host <host:port> --ssl --username <username> --password <PASSWORD> --authenticationDatabase admin --db <DATABASE> --collection <COLLECTION> --type <FILETYPE> --out <FILENAME>
```

## Mongodump & Mongorestore

`mongodump` exports the content of a running server into `.bson` files.

`mongorestore` Restore backups generated with `mongodump` to a running server.

## Relations

**Nested / Embedded Documents**:

- Group data locically
- Optimal for data belonging together that do not overlap
- Should avoid nesting too deep or making too long arrays (max doc size 16 mb)

```json
{
    _id: Objectid()
    key: "value"
    key: "value"

    innerDocument: {
        key: "value"
        key: "value"
    }
}
```

**References**:

- Divide data between collections
- Optimal for related but shared data used in relations or stand-alone
- Allows to overtake nidification and size limits

NoSQL databases do not have relations and references. It's the app that has to handle them.

```json
{
    key: "value"
    references: ["id1", "id2"]
}

// referenced
{
    _id: "id1"
    key: "value"
}
```

## [Indexes](https://docs.mongodb.com/manual/indexes/ "Index Documentation")

Indexes support the efficient execution of queries in MongoDB.

Without indexes, MongoDB must perform a *collection scan* (*COLLSCAN*): scan every document in a collection, to select those documents that match the query statement.  
If an appropriate index exists for a query, MongoDB can use the index to limit the number of documents it must inspect (*IXSCAN*).

Indexes are special data structures that store a small portion of the collection’s data set in an easy to traverse form. The index stores the value of a specific field or set of fields, ordered by the value of the field. The ordering of the index entries supports efficient equality matches and range-based query operations. In addition, MongoDB can return sorted results by using the ordering in the index.

Indexes *slow down writing operations* since the index must be updated at every writing.

![IXSCAN](https://docs.mongodb.com/manual/_images/index-for-sort.bakedsvg.svg ".find() using an index")

### [Index Types](https://docs.mongodb.com/manual/indexes/#index-types)

- **Normal**: Fields sorted by name
- **Compound**: Multiple Fields sorted by name
- **Multykey**: values of sorted arrays
- **Text**: Ordered text fragments
- **Geospatial**: ordered geodata

**Sparse** indexes only contain entries for documents that have the indexed field, even if the index field contains a null value. The index skips over any document that is missing the indexed field.

### Diagnosys and query planning

```sh
db.<collection>.find({...}).explain()  # explain won't accept other functions
db.explain().<collection>.find({...})  # can accept other functions
db.explain("executionStats").<collection>.find({...})  # more info
```

### Index Creation

```sh
db.<collection>.createIndex( <key and index type specification>, <options> )

db.<collection>.createIndex( { <field>: <type>, <field>: <type>, ... } )  # normal, compound or multikey (field is array) index
db.<collection>.createIndex( { <field>: "text" } )  # text index
db.<collection>.createIndex( { <field>: 2dsphere } )  # geospatial 2dsphere index

# sparse index
db.<collection>.createIndex(
    { <field>: <type>, <field>: <type>, ... },
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
db.<collection>.getIndexes()  # view collenction's index

db.<collection>.dropIndexes()  # drop all indexes
db.<collection>.dropIndex( { "index-name": 1 } )  # drop a specific index
```

## Database Profiling

Profiling Levels:

- `0`: no profiling
- `1`: data on operations slower than `slowms`
- `2`: data on all operations

Logs are saved in the `system.profile` *capped* collection.

```sh
db.setProgilingLevel(n)  # set profiler level
db.setProfilingLevel(1, { slowms: <ms> })
db.getProfilingStatus()  # check profiler satus

db.system.profile.find().limit(n).sort( {} ).pretty()  # see logs
db.system.profile.find().limit(n).sort( { ts : -1 } ).pretty()  # sort by decreasing timestamp
```

## Roles and permissions

**Authentication**: identifies valid users
**Authorization**: identifies what a user can do

- **userAdminAnyDatabase**: can admin every db in the istance (role must be created on admin db)
- **userAdmin**: can admin the specific db in which is created
- **readWrite**: can read and write in the specific db in which is created
- **read**: can read the specific db in which is created

```sh
# create users in the current MongoDB instance
db.createUser(
    {
        user: "dbAdmin",
        pwd: "password",
        roles:[
            {
                role: "userAdminAnyDatabase",
                db:"admin"
            }
        ]
    },
    {
        user: "username",
        pwd: "password",
        roles:[
            {
                role: "role",
                db: "database"
            }
        ]
    }
)
```

## Sharding

**Sharding** is a MongoDB concept through which big datasests are subdivided in smaller sets and distribuited towards multiple instances of MongoDB.  
It's a technique used to improve the performances of large queries towards large quantities of data that require al lot of resources from the server.

A collection containing several documents is splitted in more smaller collections (*shards*)
Shards are implemented via cluster that are none other a group of MongoDB instances.

Shard components are:

- Shards (min 2), instances of MongoDB that contain a subset of the data
- A config server, instasnce of MongoDB which contains metadata on the cluster, that is the set of instances that have the shard data.
- A router (or `mongos`), instance of MongoDB used to redirect the user instructions from the client to the correct server.

![Shared Cluster](https://docs.mongodb.com/manual/_images/sharded-cluster-production-architecture.bakedsvg.svg "Components of a shared cluster")

### [Replica set](https://docs.mongodb.com/manual/replication/)

A **replica set** in MongoDB is a group of `mongod` processes that maintain the `same dataset`. Replica sets provide redundancy and high availability, and are the basis for all production deployments.

## Aggregations

Sequence of operations applied to a collection as a *pipeline* to get a result: `db.collection.aggregate(pipeline, options)`.

[Aggragations Stages][AggrStgs]:

- `$lookup`: Right Join
- `$match`: Where
- `$sort`: Order By
- `$project`: Select *
- ...

[AggrStgs]: https://docs.mongodb.com/manual/reference/operator/aggregation-pipeline/

Example:

```sh
db.collection.aggregate([
    {
        $lookup: {
            from: <collection to join>,
            localField: <field from the input documents>,
            foreignField: <field from the documents of the "from" collection>,
            as: <output array field>
        }
    },
    { $match: { <query> } },
    { $sort: { ... } },
    { $project: { ... } },
    { ... }
])
```
