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
- `Microsoft.EntityFrameworkCore.Tools` to use migrations in Visual Studio
- `Microsoft.EntityFrameworkCore.Tools.DotNet` to use migrations in `dotnet` cli (`dotnet-ef`)
- `Microsoft.EntityFrameworkCore.Design` *or* `Microsoft.EntityFrameworkCore.<db_provider>.Design` needed for tools to work (bundled w\ tools)
- `Microsoft.EntityFrameworkCore.<db_provider>`

```cs
using Microsoft.EntityFrameworkCore;

namespace <Project>.Model
{
    class Context : DbContext
    {
        private const string _connectionString = "Server=<server_name>;Database=<database>;UID=<user>;Pwd=<password>";

        // connect to db
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(_connectionString);  // specify connection
        }

        // or

        public Context(DbContextOptions options) : base(options)
        {
        }

        //DBSet<TEntity> represents the collection of all entities in the context (or that can be queried from the database) of a given type
        public DbSet<Entity> Entities { get; set; }
        public DbSet<Entity> Entities => Set<Entity>();  // with nullable reference types
    }
}
```

## Migrations

Create & Update DB Schema if necessary.

In Package Manager Shell:

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
context.Add(entity);
context.AddRange(entities);

context.SaveChanges();
```

### Read

[Referenced Object Not Loading Fix](https://stackoverflow.com/a/5385288)

```cs
context.Entities.ToList();
context.Entities.Find(id);

// force read of foreign key identifying referenced obj
context.Entities.Include(c => c.ForeignObject).Find(id);
```

### Update

```cs
context.Entities.Update(entity);
context.UpdateRange(entities);

context.SaveChanges();
```

### Delete

```cs
context.Entities.Remove(entity);
context.RemoveRange(entities);

context.SaveChanges();
```
