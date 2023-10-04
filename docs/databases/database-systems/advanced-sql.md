# Advanced SQL

SQL is a composed by:

- Data Manipulation Language (DML)
- Data Definition Language (DDL)
- Data Control Language (DCL)

It also includes:

- View definition
- Integrity & Referential Constraints
- Transactions

> **Note**: SQL is based on **bags** (duplicates) adn **sets** (no duplicates)

## Aggregations

Functions that return a single value from a bag of tuples:

- `AVG()`: return the average value
- `MIN()`: return the minimum value
- `MAX()`: return the maximum value
- `SUM()`: return the sum of values
- `COUNT()`: count the number of values

> **Note**: aggregate functions can only be used in the `SELECT` output list.
> **Note**: `COUNT`, `SUM`, `AVG` support `DISTINCT`.

### Group By

Project tuples into subsets and calculate aggregates against each subset.

> **Note**: Not-aggregated values in `SELECT` output clause must appear in the `GROUP BY` clause

```sql
SELECT * FROM <table>
GROUP BY <table>.<field>;
```

### Having

Filters results based on aggregation computation. Like `WHERE` clause for a `GROUP BY`.

```sql
SELECT COUNT(1) AS count FROM <table>
GROUP BY <table>.<field>
HAVING count > 0;
```

## String Operations

> **Note**: strings are case sensitive and defined with single-quotes (`'`).

`LIKE` is used for string matching: `%` matches any substring (including empty strings) while `_` matches any single character.

```sql
SELECT * FROM <table>
WHERE <table>.<field> LIKE '%@c_';
```

Other common string functions/operators:

- `UPPER()`: convert string to uppercase
- `LOWER()`: convert string to lowercase
- `||` is used to concatenate two strings.

```sql
SELECT * FROM <table>
WHERE <table>.<field> = LOWER(<table>.<field> || '-suffix');
```

## DateTime  Operations

DateTime Functions:

- `NOW()`: get current timestamp
- `DATE('<timestamp>')`: convert string to date
- `UNIX_TIMESTAMP(<date>)`: convert to unix epoch

## Output Redirection

Store query results in another table provided that the number and type of columns is the same.

```sql
SELECT * INTO <new_table> FROM <table>; -- write result into new table (must not exist)
INSERT INTO <dest_table> (SELECT * FROM <src_table>); -- write result into existing table
```

## Output Control

`ORDER BY` sorts the results based on a specific attribute(s).

```sql
SELECT * FROM <table> ORDER BY <table>.<field> ASC; -- default direction
SELECT * FROM <table> ORDER BY <table>.<field> DESC;

SELECT * FROM <table> ORDER BY <table>.<field_1> ASC, <table>.<field_2> DESC;
```

`LIMIT` limits the number of tuples returned in output. Can set an offset to return a range.

```sql
SELECT * FROM <table> LIMIT 10;
SELECT * FROM <table> LIMIT 10 OFFSET 5;
```

## Nested Queries

Inner queries can appear (almost) anywhere in the query. They are often difficult to optimize.

> **Note**: inner queries can reference attributes and tables of the outer query but not vice-versa.

```sql
SELECT * FROM <table> WHERE <table>.<field> IN (SELECT <table.field> ...);
SELECT (SELECT <table>.<field> FROM <table> WHERE ...) FROM <table> WHERE <expr>;
```

Nested query operators:

- `ALL()`: must satisfy expression for all rows in sub-query.
- `ANY()`: must satisfy expression for at least one row in sub-query.
- `IN`: equivalent to `=ANY()`.
- `EXISTS`: at least one row is returned.

## Window Functions

Perform a calculation across a set of tuples related to a single row. Like an aggregation but tuples are not grouped into a single output tuple.

The `OVER` keyword specifies how to group together tuples when computing the window function.

```sql
SELECT ..., FUNC_NAME(<expr>) 
OVER (
    PARTITION BY <expr>, ...
    ORDER BY <expr>, ...
) 
FROM <table>;
```

Special window functions:

- `ROW_NUMBER()`: number of the current row
- `RANK()`: order position of the current row

## Common Table Expressions (CTE)

Provides a way to write auxiliary statements for a larger query. Alternative to nested queries and views.

```sql
WITH <cte_name> (<column>, ...) AS (SELECT ...)  -- temporary table from query result
SELECT <column>, ... FROM <cte_name>
```

**Note**: CTEs can be recursive with the `RECURSIVE` keyword.
