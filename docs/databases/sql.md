# SQL

## DDL

```sql linenums="1"
show databases;    -- mostra database
CREATE DATABASE <database>;    -- database creation
use <database_name>;    -- usa un database particolare
exit;    -- exit mysql

show tables;    -- mostra tabelle del database

-- INLINE COMMENT
/* MULTI-LINE COMMENT */
```

### Table Creation

```sql linenums="1"
CREATE TABLE <table_name>
    (<field_name> <field_type> <option>,
    ...);
```

### PRIMARY KEY from multiple fields

```sql linenums="1"
CREATE TABLE <table_name>(
    ...,
    PRIMARY KEY (<field1>, ...),
);
```

### Table Field Options

```sql linenums="1"
PRIMARY KEY -- marks primary key as field option
NOT NULL -- marks a necessary field
REFERENCES <table> (<field>) -- adds foreign key reference
UNIQUE (<field>) -- set field as unique (MySQL)
<field> UNIQUE -- T-SQL
```

### Table Modification

```sql linenums="1"
ALTER TABLE <table>
    ADD PRIMARY KEY (<field>, ...),    -- definition of PK after table creation
    ADD <field_name> <field_type> <option>;    -- addition of a new field, field will have no value in the table

ALTER TABLE <table>
    CHANGE <field_name> <new_name> <new_type>;
    ALTER COLUMN <field_name> <new_name> <new_type>;    -- T-SQL

ALTER TABLE <table>
    DROP <field>;

ALTER TABLE <table>
    ADD FOREIGN KEY (<field>) REFERENCES <TABLE> (<FIELD>);
```

## DML

### Data Insertion

```sql linenums="1"
INSERT INTO <table> (field_1, ...) VALUES (value_1, ...), (value_1, ...);
INSERT INTO <table> VALUES (value_1, ...), (value_1, ...);    -- field order MUST respect tables's columns order
```

### Data Update

```sql linenums="1"
UPDATE <table> SET <field> = <value>, <field> = <value>, ... WHERE <condition>;
```

### Data Elimination

```sql linenums="1"
DELETE FROM <table> WHERE <condition>
DELETE FROM <table> -- empty the table
```

## Data Selection

`*`: denotes all table fields

```sql linenums="1"
SELECT * FROM <table>;    -- show table contents
SHOW columns FROM <table>;    -- show table columns
DESCRIBE <table>;    -- shows table
```

### Alias

```sql linenums="1"
SELECT <field> as <alias>; -- shows <field/funzione> with name <alias>
```

### Conditional Selection

```sql linenums="1"
SELECT * FROM <table> WHERE <condition>;    -- shows elements that satisfy the condition
AND, OR, NOT    -- logic connectors

SELECT * FROM <table> WHERE <field> Between <value_1> AND <value_2>;
```

### Ordering

```sql linenums="1"
SELECT * FROM <table> ORDER BY <field>, ...;    -- shows the table ordered by <field>
SELECT * FROM <table> ORDER BY <field>, ... DESC;    -- shows the table ordered by <field>, decreasing order
SELECT * FROM <table> ORDER BY <field>, ... LIMIT n;    -- shows the table ordered by <field>, shows n items
SELECT TOP(n) * FROM <table> ORDER BY <field>, ...;    -- T-SQL
```

## Grouping

```sql linenums="1"
SELECT * FROM <table> GROUP BY <field>;
SELECT * FROM <table> GROUP BY <field> HAVING <condition>;
SELECT DISTINCT <field> FROM <table>;    -- shows elements without repetitions
```

### Ricerca caratteri in valori

`%`: any number of characters

```sql linenums="1"
SELECT * FROM <table> WHERE <field> LIKE '<char>%';    -- selects items in <field> that start with <char>
SELECT * FROM <table> WHERE <field> LIKE '%<char>';    -- selects items in <field> that end with <char>
SELECT * FROM <table> WHERE <field> LIKE '%<char>%';    -- selects items in <field> that contain <char>
SELECT * FROM <table> WHERE <field> NOT LIKE '%<char>%';    -- selects items in <field> that do not contain <char>
```

### Selection from multiple tables

```sql linenums="1"
SELECT a.<field>, b.<field> FROM <table> AS a, <table> AS b
    WHERE a.<field> ...;
```

## Functions

```sql linenums="1"
SELECT COUNT(*) FROM <field>;    -- count of items in <field>
SELECT MIN(*) FROM <table>;    -- min value
SELECT MAX(*) FROM <table>;    -- max value
SELECT AVG(*) FROM <table>;    -- mean of values
ALL (SELECT ...)
ANY (SELECT ...)
```

## Nested Queries

```sql linenums="1"
SELECT * FROM <table> WHERE EXISTS (SELECT * FROM <table>)  -- selected field existing in subquery
SELECT * FROM <table> WHERE NOT EXISTS (SELECT * FROM <table>)  -- selected field not existing in subquery
```

## New table from data

Create new table with necessary fields:

```sql linenums="1"
CREATE TABLE <table> (
    (<field_name> <field_type> <option>,
    ...);
)
```

Fill fields with data from table:

```sql linenums="1"
INSERT INTO <table>
    SELECT <fields> FROM <TABLE> WHERE <condition>;
```

## Join

```sql linenums="1"
SELECT * FROM <table1> JOIN <table2> ON <table1>.<field> = <table2>.<field>;
SELECT * FROM <table1> LEFT JOIN <table2> ON <condition>;
SELECT * FROM <table1> RIGHT JOIN <table2> ON <condition>
```

[Inner Join, Left Join, Right Join, Full Outer Join](https://www.diffen.com/difference/Inner_Join_vs_Outer_Join)

## Multiple Join

```sql linenums="1"
SELECT * FROM <table1>
JOIN <table2> ON <table1>.<field> = <table2>.<field>
JOIN <table3> ON <table2>.<field> = <table3>.<field>;
```

[char, nchar, varchar, nvarchar](https://stackoverflow.com/questions/176514/what-is-the-difference-between-char-nchar-varchar-and-nvarchar-in-sql-server)

---

## T-SQL (MSSQL Server)

### T-SQL Insert From table

```sql linenums="1"
USE [<db_name>]

SET IDENTITY_INSERT [<destination_table>] ON

INSERT INTO <table> (field_1, ...)

SELECT (field_1, ...) FROM <source_table>

SET IDENTITY_INSERT [<destination_table>] OFF
```

### T-SQL Parametric Query

```sql linenums="1"
-- variable declaration
DECLARE @var_name <type>

-- init variable (input parameter)
SET @var_name = <value>

-- use in query (memorize data)
SELECT @var_name = COUNT(*)  -- query won't show results in the "table view" since param is used in SELECT
FROM <table> ...

-- display message (query won't show results in the "table view")
PRINT 'Text: ' + @var_name
PRINT 'Text: ' + CONVERT(type, @var_name)  -- convert data before printing
GO
```

### T-SQL View

A view represents a virtual table. Join multiple tables in a view and use the view to present the data as if the data were coming from a single table.

```sql linenums="1"
CREATE VIEW <name> AS
SELECT * FROM <table> ...
```

### T-SQL Stored Procedure

[Stored Procedure How-To](https://docs.microsoft.com/en-us/sql/relational-databases/stored-procedures/create-a-stored-procedure "Create a Stored Procedure - Microsoft Docs")
[T-SQL Stored Procedure](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql)

Stored Procedure Definition:

```sql linenums="1"
CREATE PROCEDURE <Procedure_Name>
    -- Add the parameters for the stored procedure here
    <@Param1> <Datatype_For_Param1> = <Default_Value_For_Param1>,
    <@Param2> <Datatype_For_Param2>
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;  -- don't return number of selected rows

    -- Insert statements for procedure here
    SELECT ...
END
GO
```

Stored Procedure call in query:

```sql linenums="1"
USE <database>
GO

-- Stored Procedure call
EXECUTE <Procedure_Name>
-- or
EXEC <Procedure_Name>
```
