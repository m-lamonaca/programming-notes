# SQL

`mysql -u root`: avvio mysql come utente root

## DDL

```sql
show databases;    -- mostra database
CREATE DATABASE <database>;    -- dataabse creation
use <database_name>;    -- usa un database particolare
exit;    -- exit mysql

show tables;    -- mostra tabelle del database

-- INLINE COMMENT
/* MULTI-LINE COMMENT */
```

### Table Creation

```sql
CREATE TABLE <table_name>
    (<field_name> <field_type> <option>,
    ...);
```

### PRIMARY KEY from multiple fields

```sql
CREATE TABLE <table_name>(
    ...,
    PRIMARY KEY (<field1>, ...),
);
```

### Table Field Options

```sql
PRIMARY KEY -- marks primary key as field option
NOT NULL -- marks a necessary field
REFERENCES <table> (<field>) -- adds foreign key reference
UNIQUE (<field>) -- set field as unique (MySQL)
<field> UNIQUE -- T-SQL
```

### Table Modification

```sql
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

```sql
INSERT INTO <table> (field_1, ...) VALUES (value_1, ...), (value_1, ...);
INSERT INTO <table> VALUES (value_1, ...), (value_1, ...);    -- field order MUST respest tables's columns order
```

### Data Update

```sql
UPDATE <table> SET <field> = <value>, <field> = <value>, ... WHERE <condition>;
```

### Data Elimination

```sql
DELETE FROM <table> WHERE <condition>
DELETE FROM <table> -- empty the table
```

## Data Selection

`*` Indica tutti i campi

```sql
SELECT * FROM <table>;    -- show table contents
SHOW columns FROM <table>;    -- show table columns
DESCRIBE <table>;    -- shows table
```

### Alias Tabelle

```sql
SELECT <field/funzione> as <alias>; -- mostra <field/funzione> con nome <alias>
```

### Selezione Condizionale

```sql
SELECT * FROM <table> WHERE <condition>;    -- mostra elementi che rispettano la condizione
AND, OR, NOT    -- connettivi logici

SELECT * FROM <table> WHERE <field> Between <value_1> AND <value_2>;
```

### Ordinamento

```sql
SELECT * FROM <table> ORDER BY <field>, ...;    -- mostra tabella ordinata in base a colonna <field>
SELECT * FROM <table> ORDER BY <field>, ... DESC;    -- mostra tabella ordinata decrescente in base a colonna <field>
SELECT * FROM <table> ORDER BY <field>, ... LIMIT n;    -- mostra tabella ordinata in base a colonna <field>, mostra n elementi
SELECT TOP(n) * FROM <table> ORDER BY <field>, ...;    -- T-SQL
```

## Raggruppamento

```sql
SELECT * FROM <table> GROUP BY <field>;
SELECT * FROM <table> GROUP BY <field> HAVING <condition>;
SELECT DISTINCT <field> FROM <table>;    -- mostra elementi senza riperizioni
```

### Ricerca caratteri in valori

`%` 0+ caratteri

```sql
SELECT * FROM <table> WHERE <field> LIKE '<char>%';    -- seleziona elemnti in <field> inizianti per <char>
SELECT * FROM <table> WHERE <field> LIKE '%<char>';    -- seleziona elemnti in <field> terminanti per <char>
SELECT * FROM <table> WHERE <field> LIKE '%<char>%';    -- seleziona elemnti in <field> contenenti <char>
SELECT * FROM <table> WHERE <field> NOT LIKE '%<char>%';    -- seleziona elemnti in <field> non contenenti <char>
```

### Selection from multiple tables

```sql
SELECT a.<field>, b.<field> FROM <table> AS a, <table> AS b
    WHERE a.<field> ...;
```

## Funzioni

```sql
SELECT COUNT(*) FROM <field>;    -- conta numero elemneti nel campo
SELECT MIN(*) FROM <table>;    -- restituisce il valore minimo
SELECT MAX(*) FROM <table>;    -- restituisce valore massimo
SELECT AVG(*) FROM <table>;    -- media valori del campo
ALL (SELECT ...)
ANY (SELECT ...)
```

## Query Annidate

```sql
SELECT * FROM <table> WHERE EXISTS (SELECT * FROM <table>)  -- selected field existing in subquery
SELECT * FROM <table> WHERE NOT EXISTS (SELECT * FROM <table>)  -- selected field not existing in subquery
```

## New table from data

Create new table with necessary fields:

```sql
CREATE TABLE <table> (
    (<field_name> <field_type> <option>,
    ...);
)
```

Fill fields with data from table:

```sql
INSERT INTO <table>
    SELECT <fields> FROM <TABLE> WHERE <condition>;
```

## Join

Permette di legare due tabelle correlando i dati, le tabelle devono avere almeno un campo in comune.  
Primary key deve comparire in altra tabella come foreign key.

```sql
SELECT * FROM <table1> JOIN <table2> ON <table1>.<field> = <table2>.<field>;    -- seleziono tutti gli elementi che hanno una relarione tra le due tabelle
SELECT * FROM <table1> LEFT JOIN <table2> ON <condition>;    -- seleziona tutti gli elementi di table1 e i eventuali elementi richiamati dal join
SELECT * FROM <table1> RIGHT JOIN <tabl2> ON <condition>    -- -- seleziona tutti gli elementi di table2 e i eventuali elementi richiamati dal join
```

[Inner Join, Left Join, Right Join, Full Outer Join](https://www.diffen.com/difference/Inner_Join_vs_Outer_Join)

## Multiple Join

```sql
SELECT * FROM <table1>
JOIN <table2> ON <table1>.<field> = <table2>.<field>
JOIN <table3> ON <table2>.<field> = <table3>.<field>;
```

[char, nchar, varchar, nvarchar](https://stackoverflow.com/questions/176514/what-is-the-difference-between-char-nchar-varchar-and-nvarchar-in-sql-server)

***

## T-SQL (MSSQL Server)

### T-SQL Insert From table

```sql
USE [<db_name>]

SET IDENTITY_INSERT [<destination_table>] ON

INSERT INTO <table> (field_1, ...)

SELECT (field_1, ...) FROM <source_table>

SET IDENTITY_INSERT [<destination_table>] OFF
```

### T-SQL Parametric Query

```sql
-- variable declaration
DECLARE @var_name <type>

-- init variable (input parameter)
SET @var_name = <value>

-- use in query (memorize data)
SELECT @var_name = COUNT(*)  -- query won't show results in the "table view" sice param is used in SELECT
FROM <table> ...

-- display message (query won't show results in the "table view")
PRINT 'Text: ' + @var_name
PRINT 'Text: ' + CONVERT(type, @var_name)  -- convert data before printing
GO
```

### T-SQL View

A view represents a virtual table. Join multiple tables in a view and use the view to present the data as if the data were coming from a single table.

```sql
CREATE VIEW <name> AS
SELECT * FROM <table> ...
```

### T-SQL Stored Procedure

[Stored Procedure How-To](https://docs.microsoft.com/en-us/sql/relational-databases/stored-procedures/create-a-stored-procedure "Create a Stored Procedure - Microsoft Docs")
[T-SQL Stored Procedure](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql)

Stored Procedure Definition:

```sql
CREATE PROCEDURE <Procedure_Name>
    -- Add the parameters for the stored procedure here
    <@Param1> <Datatype_For_Param1> = <Default_Value_For_Param1>,
    <@Param2> <Datatype_For_Param2>
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;  -- dont return number of selected rows

    -- Insert statements for procedure here
    SELECT ...
END
GO
```

Stored Procedure call in query:

```sql
USE <database>
GO

-- Stored Procedure call
EXECUTE <Procedure_Name>
-- or
EXEC <Procedure_Name>
```
