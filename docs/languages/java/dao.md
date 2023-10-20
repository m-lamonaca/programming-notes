# Database Access Object

## DB

Connection to the DB.

```java linenums="1"
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {

    private Connection conn;  // db connection obj

    private final String URL = "jdbc:<dbms>:<db_url>/<database>";
    private final String USER = "";
    private final String PWD = "";

    public DB() {
        this.conn = null;
    }

    public void connect() {
        try {
            this.conn = DriverManager.getConnection(URL, USER, PWD);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void disconnect() {
        if(conn != null) {
            try {
                this.conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Connection getConn() {
        return conn;
    }
}
```

## `I<Type>DAO`

Interface for CRUD methods on a database.

```java linenums="1"
package dao;

import java.sql.SQLException;
import java.util.List;

public interface I<Type>DAO {

    String RAW_QUERY = "SELECT * ..."
    public Type Query() throws SQLException;
}

```

## `<Type>DAO`

Class implementing `I<Type>DAO` and handling the communication with the db.

```java linenums="1"
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class <Type>DAO implements I<Type>DAO {

    private <Type> results;

    private Statement statement;  // SQL instruction container
    private ResultSet rs;  // Query results container
    private DB db;

    public <Type>DAO() {
        db = new DB();
    }

    @Override
    public Type Query() throws SQLException {
        // 1. connection
        db.connect();

        // 2. instruction
        statement = db.getConn().createStatement();  // statement creation

        // 3. query
        rs = statement.executeQuery(RAW_QUERY);  // set the query

        // 4. results
        while(rs.next()) {
            // create and valorize Obj
            // add to results
        }

        // 5. disconnection
        db.disconnect()

        // 6. return results
        return results;
    }
}
```
