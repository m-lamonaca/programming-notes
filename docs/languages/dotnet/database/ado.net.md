# [ADO.NET](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/ "ADO.NET Docs")

`ADO.NET` is a set of classes that expose data access services for .NET.
The `ADO.NET` classes are found in `System.Data.dll`, and are integrated with the XML classes found in `System.Xml.dll`.

[ADO.NET provider for SQLite](https://system.data.sqlite.org/index.html/doc/trunk/www/index.wiki "System.Data.SQLite")

## [Connection Strings](https://www.connectionstrings.com)

### [SQL Server 2019](https://www.connectionstrings.com/sql-server-2019/)

- Standard Security:
  - `Server=<server_name>; Database=<database>; UID=<user>; Pwd=<password>;`
  - `Server=<server_name>; Database=<database>; User ID=<user>; Password=<password>;`
  - `Data Source=<server_name>; Initial Catalog=<database>; UID=<user>; Pwd=<password>;`
- Specific Instance: `Server=<server_name>\<instance_name>; Database=<database>; User ID=<user>; Password=<password>;`
- Trusted Connection (WinAuth): `Server=<server_name>; Database=<database>; Trusted_Connection=True;`
- MARS: `Server=<server_name>; Database=<database>; Trusted_Connection=True; MultipleActiveResultSets=True;`

> **Note**: *Multiple Active Result Sets* (MARS) is a feature that works with SQL Server to allow the execution of multiple batches on a single connection.

### [SQLite](https://www.connectionstrings.com/sqlite/)

- Basic: `Data Source: path\to\db.sqlite3; Version=3;`
- In-Memory Database: `Data Source=:memory:; Version=3; New=True`
- With Password: `Data Source: path\to\db.sqlite3; Version=3; Password=<password>`

## Connection to DB

```cs linenums="1"
using System;
using System.Data.SqlClient;  // ADO.NET Provider, installed through NuGet

namespace <namespace>
{
    class Program
    {
        static void Main(string[] args)
        {
            // Connection to SQL Server DBMS
            SqlConnectionStringBuilder connectionString = new SqlConnectionStringBuilder();
            connectionString.DataSource = "<server_name>";
            connectionString.UserID = "<user>";
            connectionString.Password = "<password>";
            connectionString.InitialCatalog = "<database>";

            // more compact
            SqlConnectionStringBuilder connectionString = new SqlConnectionStringBuilder("Server=<server_name>;Database=<database>;UID=<user>;Pwd=<password>")
        }
    }
}
```

## DB Interrogation

### `SqlConnection`

```cs linenums="1"
using (SqlConnection connection = new SqlConnection())
{
    connection.ConnectionString = connectionString.ConnectionString;
    connection.Open();  // start communication w/ sql server
}

// more compact
using (SqlConnection connection = new SqlConnection(connectionString)) {
    connection.Open()
}
```

### [SqlCommand](https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlcommand)

```cs linenums="1"
string sql = "<sql_instruction>";

using (SqlCommand command = new SqlCommand())
{
    command.Connection = connection;  // SqlConnection
    command.CommandText = "... @Parameter";  // or name of StoredProcedure

    // add parameters to the SqlParameterCollection, WARNING: table names or columns cannot be parameters
    command.Parameters.Add("@Parameter", SqlDbType.<DBType>, columnLength).Value = value;
    command.Parameters.AddWithValue("@Parameter", value);
    command.Parameters.AddWithValue("@Parameter", (object) value ?? DBNull.Value);  // if Parameter is nullable

    // Create an instance of a SqlParameter object.
    command.CreateParameter();

    command.CommandType = CommandType.Text;  // or StoredProcedure

    int affectedRows = command.ExecuteNonQuery();  // execute the query and return the number of affected rows
}
```

### `SqlDataReader`

```cs linenums="1"
using (SqlDataReader cursor = command.ExecuteReader())  // object to get data from db
{
    while (cursor.Read())  // get data till possible
    {
        // preferred methodology
        cursor["<column_name>"].ToString();  // retrieve data form the column
        cursor[<column_index>].ToString();  // retrieve data form the column

        // check for null before retrieving the value
        if(!cursor.IsDBNull(n))
        {
            cursor.Get<SystemType>(index);  // retrieve data form the n-th column
        }
    }
}
```
