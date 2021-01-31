# SQLite in Android

[Kotlin SQLite Documentation](https://developer.android.com/training/data-storage/sqlite)
[NoSQL DB Realm Docs](https://realm.io/docs)

## Database Helper

Create database in memory and its tables.

```kotlin
class DatabaseHelper(
    context: Context?,
    name: String?,
    factory: SQLiteDatabase.CursorFactory?,
    version: Int
) : SQLiteOpenHelper(context, name, factory, version) {  // super constructor?

    // called on db creation if it does not exists (app installation)
    override fun onCreate() {
        sqLiteDatabase?.execSQL("CREATE TABLE ...")  // create table
    }

    override fun onUpgrade(sqLiteDatabase: SQLiteDatabase?, ...) {
        // table update logic
    }
}
```

## AppSingleton

Make data persistent.

```kotlin
class AppSingleton consturctor(context: Context) {

    var dataabse: SQLiteDatabase? = null  // point to database file in memory

    companion object {

        @Volatile
        private var INSTANCE: AppSingleton? = null

        // syncronized makes sure that all instances of the singleton are actually the only existing one
        fun getInstance(context: Contecxt) = INSTANCE ?: syncronized(this) {
            INSTANCE ?: Singleton(context).also {
                INSTANCE = it
            }
        }
    }

    // called to create DB in device memory
    fun openDatabase(context: Context?) {
        var databaseHelper = DatabaseHelper(context, "AppDB_Name.sqlite", null, version) {
            database = databaseHelper.writeDatabase  //?
        }
    }
}
```

## Activity

```kotlin
override fun onCreate() {

    // either creates or reads DB
    AppSingleton.getInstance().openDatabase(this)  // context is this

    val controller = ModelController()
    controller.insert(model)  // insert data from object
}
```

## ModelController

Controller to handle data from the objects and interact with the Database

```kotlin
sqLiteDatabse = AppISngleton.getInstance().database  // reference to the database from the singleton

contentValues = ContentValues()  // dict like structure to insert data in DB
contentValuest.put("DB_Column", value)  // put data in the structure

// insertion query V1
sqLiteDatabase?.insert("table", null, contentValue)

//insertion query V2
sqLiteDatabase?.rawQuey("INSERT INTO ...")

// returns a Cursor()
val cursor = sqLiteDatabase?.query("table", ArrayOf(columns_to_read), "WHERE ...", "GROUP BY ...", "HAVING ...", "ORDER BY ...")

try {
    if (cursor != null) {
        while(cursor.moveToNext()) {  // loop through cursor data
            data = cursor.getString(cursor.getColumnIndex("DB_Column"))  // read data from the cursor
        }
    }
} finally {
    cursor?.close()
}
```
