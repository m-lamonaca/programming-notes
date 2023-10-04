# Databases

Organized collection of inter-related data that models some aspect of the real-world. Databases are the core component of most computer applications.

A **DBMS** is the software that allows applications to store and analyze information in a database.  
A general-purpose DBMS is designed to allow the definition, creation, querying, update and administration of database Management System

A **data model** is a collection of concepts for describing the data in a database. A **schema** is a description of a particular collection of data, using a given data model.

## Relational Model

It was proposed by Ted Codd in 1970. It's an abstraction to avoid high maintenance of the DBMS software:

- store database in simple data structures-
- access data through high level language.
- physical storage left to the implementation.
- store database in simple data structures-
- access data through high level language.
- physical storage left to the implementation.

Concepts:

- **Structure**: the definition of relations and their contents.
- **Integrity**: ensures that the database's contents satisfy constraints.
- **Manipulation**: how to access and modify a database's content.

### Relations

A **relation** (aka **table**)is an _unordered_ set that contains the relationship of the _attributes_ (aka _fields_) that represent entities.  
The **domain** of a relation is the set of possible values that the relation can contain.  
A **tuple** (aka **record**) is a set of attribute values in a relation. Values are (normally) atomic/scalar. The special value `NULL` is a member of every domain.

### Primary Keys (PK)

A relation's **primary key** uniquely identifies a single tuple. Some DBMSs automatically create an internal primary key if one is not provided.

### Foreign Keys (FK)

A **foreign key** specifies that an attribute from one relation has to map to a tuple in another relation.

## Data Manipulation Language (DML)

The **data manipulation language** describes how to _store_ and _retrieve_ information from a database.

Kinds of DMLs:

- **Procedural**: the query specifies the (high-level) strategy that the DBMS should use to find the desired result. (Relational Algebra)
- **Non-Procedural**: the query specifies only what data is wanted and not how to find it. (Relational Calculus)

## Relational Algebra

Set of fundamental operations to retrieve and manipulate tuples in a relation. Each operator takes one or more relations as inputs and outputs a new relation. This allows to chain operations together to create more complex operations.

Relational algebra describes the steps needed to obtain a particular result. The order of the steps does influence the performance of the complete operation.

Fundamental Operators:

- Selection (`σ`)
- Projection (`π`)
- Union (`U`)
- Intersection (`∩`)
- Difference (`-`)
- Product (`x`)
- Natural Join (`|X|`)

Extra Operators:

- Rename (`p`)
- Assignment (`R ← S`)
- Duplicate Elimination
- Aggregation (`Y`)
- Sorting (`τ`)
- Division (`÷`)

> **Note**: reactional algebra operates on sets. A set is an unordered list of unique values.

### Select (`σ`)

Choose a subset of tuples from a relation that satisfies a selection predicate. Predicates acts a filters to retain only tuples that fulfill its qualifying requirements. It's possible to combine multiple predicates using conjunctions/disjunctions.

Syntax: `σ(R)`

```sql
SELECT * FROM R WHERE <predicate>;
```

### Projection (`π`)

Generate a relation with tuples that contain only the specified attributes. Allows to rearrange attribute ordering and can manipulate values.

Syntax: `π(R)`

```sql
SELECT (<tuple>) FROM R;
```

### Union (`U`)

Generate a relation that contains all tuples that appear in either only one ore both input relations.

Syntax: `(R U S)`

```sql
(SELECT * FROM R) UNION ALL (SELECT * FROM S);
```

### Intersection (`∩`)

Generate a relation that contains only the tuples that appear in both of the input relations.

Syntax: `(R ∩ S)`

```sql
(SELECT * FROM R) INTERSECT (SELECT * FROM S);
```

### Difference (`-`)

Generate a relation that contains only the tuples that appear in the first and not the second of the input relations.

Syntax: `(R - S)`

```sql
(SELECT * FROM R) EXCEPT (SELECT * FROM S);
```

#### Product (`x`)

Generate a relation that contains all possible combinations of tuples from the input relations.

Syntax: `(R x S)`

```sql
SELECT * FROM R CROSS JOIN S;
SELECT * FROM R, S;
```

### Natural Join (`|X|`)

Generate a relation that contains all tuples that are a combination of two tuples (one from each relation) with common value(S) for one or more attributes.

> **Note**: the matching values must be on the same fields.

Syntax: (`R |X| S`)

```sql
SELECT * FROM R NATURAL JOIN S;
```
