# Spring Project

## Libs

- MySql Driver
- Spring Data JPA (data persistance)
- Spring Boot Dev Tools
- Jersey (Serializzazione)
- Spring Web

## application.properties

```ini
spring.datasource.url=DB_url
spring.datasource.username=user
spring.datasource.password=password

spring.jpa.show-sql=true

server.port=server_port
```

## Package `entities`

Model of a table of the DB

```java
package <base_pakcage>.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity  // set as DB Entity (DB record Java implementation)
public class Entity {

    @Id  // set as Primary Key
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // id is autoincremented by the DB
    private int id;

    // no constructor (Spring requirement)

    // table columns attributes

    // getters & setters

   // toString()
}
```

## Package `dal`

Spring Interface for DB connection and CRUD operations.

```java
package <base_package>.dal  // or .repository

import org.springframework.data.repository.JpaRepository;
import org.springframework.data.repository.Query;
import org.springframework.data.repository.query.Param;

// interface for spring Hibernate JPA
// CrudRepository<Entity, PK_Type>
public interface IEntityDAO extends JpaRepository<Entity, Integer> {

    // custom query
    @Query("FROM <Entity> WHERE param = :param")
    Type query(@Param("param") Type param);
}
```

## Package `services`

Interfaces and method to access the Data Access Layer (DAL).

In `IEntityService.java`:

```java
package <base_package>.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import <base_package>.Entity;
import <base_package>.IEntityRepository;

// CRUD method implemented on Entity
public interface IEntityService {

    String FIND_ALL = "SELECT * FROM <table>"
    String FIND_ONE = "SELECT * FROM <table> WHERE id = ?"

    List<Entity> findAll();
    Entity findOne(int id);
    void addEntity(Entity e);
    void updateEntity(int id, Entity e);
    void deleteEntity(Entity e);
    void deleteEntity(int id);

}
```

In `EntityService.java`:

```java
package com.lamonacamarcello.libri.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import <base_package>.entities.Entity;
import <base_package>.repos.ILibriRepository;

// implementation of IEntityService
@Service
public class EntityService implements IEntityService {

    @Autowired  // connection to db (obj created by spring as needed: Inversion Of Control)
    private IEntityDAO repo;

    @Override
    public List<Entity> findAll() {
        return repo.findAll();
    }

    @Override
    public Entity findOne(int id) {
        return repo.findById(id).get();
    }

    @Override
    public void addEntity(Entity e) {
        repo.save(e);
    }

    @Override
    public void updateEntity(int id, Entity e) {
    }

    @Override
    public void deleteEntity(Entity e) {
    }

    @Override
    public void deleteEntity(int id) {
    }

    // custom query
    Type query(Type param) {
        return repo.query(param);
    }
}
```

## Package `integration`

REST API routes & endpoints to supply data as JSON.

```java
package com.lamonacamarcello.libri.integration;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import <base_package>.entities.Entity;
import <base_package>.services.IEntityService;

@RestController  // returns data as JSON
@RequestMapping("/api")  // controller route
public class EntityRestCtrl {

    @Autowired  // connection to service (obj created by spring as needed: Inverion Of Control)
    private IEntityService service;

    @GetMapping("entities")  // site route
    public List<Entity> findAll(){
        return service.findAll();
    }

    @GetMapping("/entities/{id}")
    public Entity findOne(@PathVariable("id") int id) {  // use route variable
        return service.findOne(id);
    }

    @PostMapping("/entities")
    public void addEntity(@RequestBody Entity e) {  // added entity is in the request body
        return service.addEntity(e)
    }

    // PUT / PATCH -> updateEntity(id, e)

    // DELETE -> deleteEntity(id)
}
```
