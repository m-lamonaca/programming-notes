# Entity Framework

## Model & Data Annotations

```cs
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace <Project>.Model
{
    public class Entity
    {
        [Key]  // set as PK (Id & EntityId are automatically detected to be PKs)
        public int Id { get; set; }

        [Required]
        public Type ForeignObject { get; set; }  // Not Null in DB
        public Type ForeignObject { get; set; }  // Allow Null in DB

        public int Prop { get; set; }  // Not Null in DB (primitive are not nullable)
        public int? Prop { get; set; }  // Allow Null in DB
    }
}
```

## Context

NuGet Packages to install:

- `Microsoft.EntityFrameworkCore`
- `Microsoft.EntityFrameworkCore.Tools` to use migrations
- `Microsoft.EntityFrameworkCore.Design` *or* `Microsoft.EntityFrameworkCore.<db_provider>.Design` needed for tools to work (bundled w\ tools)
- `Microsoft.EntityFrameworkCore.<db_provider>`

```cs
using Microsoft.EntityFrameworkCore;

namespace <Project>.Model
{
    class Context : DbContext
    {
        public Context(DbContextOptions options) : base(options)
        {
        }
    }

    // or

    class Context : DbContext
    {
        private const string _connectionString = "Server=<server_name>;Database=<database>;UID=<user>;Pwd=<password>";

        // connect to db
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(_connectionString);  // specify connection
        }

        //DBSet<TEntity> represents the collection of all entities in the context (or that can be queried from the database) of a given type
        public DbSet<Entity> Entities { get; set; }
    }
}
```

## Migrations

Create & Update DB Schema if necessary.

In Packge Manager Shell:

```ps1
PM> Add-Migration <migration_name>
PM> update-database [-Verbose] # use the migrations to modify the db, -Verbose to show SQL queries
```

In dotnet cli:

```ps1
dotnet tool install --global dotnet-ef  # if not already installed

dotnet ef migrations add <migration_name>
dotnet ef database update
```

## CRUD

### Create

```cs
public static bool InsertOne(Entity entity)
{
    int rows = 0;

    using(var context = new Context())
    {
        context.Add(entity);
        context.SaveChanges();
    }

    return rows == 1;
}

public static bool InsertMany(IEnumerable<Entity> entities)
{
    int rows = 0;

    using(var context = new Context())
    {
        context.AddRange(entities);
        context.SaveChanges();
    }

    return rows == entities.Count();
}
```

### Read

[Referenced Object Not Loading Fix](https://stackoverflow.com/a/5385288)

```cs
public static List<Entity> SelectAll()
{
    using(var context = new Context())
    {
        return context.Entities.ToList();
    }
}

static Entity SelectOneById(int id)
{
    using(var context = new Context())
    {
        return context.Entities.Find(id);

        // force read of foreign key identifying referenced obj
        return context.Entities.Include(c => c.ForeignObject).Find(id);

    }
}
```

### Update

```cs
public static bool UpdateOne(Entity entity)
{
    int rows = 0;

    using(var context = new Context())
    {
        context.Entities.Update(entity);
        context.SaveChanges();
    }

    return rows == 1;
}

public static bool UpdateMany(IEnumerable<Entity> entities)
{
    int rows = 0;

    using(var context = new Context())
    {
        context.UpdateRange(entities);
        context.SaveChanges();
    }

    return rows == entities.Count();
}
```

### Delete

```cs
public static bool DeleteOne(Entity entity)
{
    int rows = 0;

    using(var context = new Context())
    {
        context.Entities.Remove(entity);
        context.SaveChanges();
    }

    return rows == 1;
}

public static bool DeleteMany(IEnumerable<Entity> entities)
{
    int rows = 0;

    using(var context = new Context())
    {
        context.RemoveRange(entities);
        context.SaveChanges();
    }

    return rows == entities.Count();
}
```
