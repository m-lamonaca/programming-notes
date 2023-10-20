# GraphQL

[How to GraphQL - The Fullstack Tutorial for GraphQL](https://www.howtographql.com/)

GraphQL is a query language for APIa, and a server-side runtime for executing queries by using a type system for the data. GraphQL isn't tied to any specific database or storage engine and is instead backed by existing code and data.

A GraphQL service is created by defining types and fields on those types, then providing functions for each field on each type.

---

## Schema and Types

### Object types and fields

The most basic components of a GraphQL schema are object types, which just represent a kind of object fetchable from the service, and what fields it has.

```graphql linenums="1"
type Type {
  field: Type
  field: Type!  # non-nullable type
  field: [Type]  # array of objects
  field: [Type!]!  # non-nullable array of non-nullable objects
}
```

### Field Arguments

Every field on a GraphQL object type can have zero or more arguments. All arguments are named.

Arguments can be either *required* or *optional*. When an argument is optional, it's possible to define a default value.

```graphql linenums="1"
type Type {
  field: Type,
  field(namedArg: Type = defaultValue): Type
}
```

### Query and Mutation types

Every GraphQL service has a `query` type and may or may not have a `mutation` type. These types are the same as a regular object type, but they are special because they define the *entry point* of every GraphQL query.

### Scalar Types

A GraphQL object type has a name and fields, but at some point those fields have to resolve to some concrete data.
That's where the scalar types come in: they represent the *leaves* of the query. Scalar types do not have sub-types and fields.

GraphQL comes with a set of default scalar types out of the box:

- `Int`: A signed 32‐bit integer.
- `Float`: A signed double-precision floating-point value.
- `String`: A UTF‐8 character sequence.
- `Boolean`: `true` or `false`.
- `ID`: The ID scalar type represents a unique identifier, often used to refetch an object or as the key for a cache. The ID type is serialized in the same way as a `String`; however, defining it as an `ID` signifies that it is not intended to be human‐readable.

In most GraphQL service implementations, there is also a way to specify custom scalar types.

```graphql linenums="1"
scalar ScalarType
```

Then it's up to the implementation to define how that type should be serialized, deserialized, and validated.

### Enumeration Types

Also called *Enums*, enumeration types are a special kind of scalar that is restricted to a particular set of allowed values.

This allows to:

1. Validate that any arguments of this type are one of the allowed values
2. Communicate through the type system that a field will always be one of a finite set of values

```graphql linenums="1"
enum Type{
  VALUE,
  VALUE,
    ...
}
```

**Note**: GraphQL service implementations in various languages will have their own language-specific way to deal with enums. In languages that support enums as a first-class citizen, the implementation might take advantage of that; in a language like JavaScript with no enum support, these values might be internally mapped to a set of integers. However, these details don't leak out to the client, which can operate entirely in terms of the string names of the enum values.

## Lists and Non-Null

Object types, scalars, and enums are the only kinds of types that can be defined in GraphQL.
But when used in other parts of the schema, or in the query variable declarations, it's possible apply additional *type modifiers* that affect **validation** of those values.

It's possible to mark a field as *Non-Null* by adding an exclamation mark, `!` after the type name. This means that the server always expects to return a non-null value for this field, and if it ends up getting a null value that will actually trigger a GraphQL execution error, letting the client know that something has gone wrong.

The *Non-Null* type modifier can also be used when defining arguments for a field, which will cause the GraphQL server to return a validation error if a null value is passed as that argument, whether in the GraphQL string or in the variables.

It's possible to use a type modifier to mark a type as a `List`, which indicates that this field will return an array of that type. In the schema language, this is denoted by wrapping the type in square brackets, `[` and `]`. It works the same for arguments, where the validation step will expect an array for that value.

### Interfaces

Like many type systems, GraphQL supports interfaces. An Interface is an abstract type that includes a certain set of fields that a type must include to implement the interface.

Interfaces are useful when returning an object or set of objects, but those might be of several different types.

```graphql linenums="1"
interface Interface {
  fieldA: TypeA
  fieldB: TypeB
}

type Type implements Interface {
  fieldA: TypeA,
  fieldB: TypeB
  field: Type,
  ...
}
```

### Union Type

Interfaces are useful when returning an object or set of objects, but those might be of several different types.

```graphql linenums="1"
union Union = TypeA | TypeB | TypeC
```

**Note**: members of a union type need to be *concrete* object types; it's not possible to create a union type out of interfaces or other unions.

### Input Type

In the GraphQL schema language, input types look exactly the same as regular object types, but with the keyword input instead of type:

```graphql linenums="1"
input Input {
  field: Type,
  ...
}
```

The fields on an input object type can themselves refer to input object types, but it's not possible to mix input and output types in the schema.
Input object types also can't have arguments on their fields.

---

## Queries, Mutations and Subscriptions

### Simple Query

```graphql linenums="1"
{
  field {  # root field
    ...  # payload
  }
}
```

```json linenums="1"
{
  "data" : {
    "field": {
  ...
    }
  }
}
```

### Query Arguments

In a system like REST, it's possible to only pass a single set of arguments - the query parameters and URL segments in your request.

But in GraphQL, every field and nested object can get its own set of arguments, making GraphQL a complete replacement for making multiple API fetches.

It's aldo possible to pass arguments into scalar fields, to implement data transformations once on the server, instead of on every client separately.

```graphql linenums="1"
{
  fieldA(arg: value)  # filter results
  fieldB(arg: value)
  ...
}
```

### Aliases

```graphql linenums="1"
{
  aliasA: field(arg: valueA) {
    field
  }
  aliasB: field(arg: valueB) {
    field
  }
}
```

### Fragments

Fragments allow to construct sets of fields, and then include them in queries where that are needed.
The concept of fragments is frequently used to split complicated application data requirements into smaller chunks.

```graphql linenums="1"
{
  aliasA: field(arg: valueA) {
    ...fragment
  },
  aliasB: field(arg: valueB) {
    ...fragment
  }
}

# define a set of fields to be retrieved 
fragment fragment on Type {
  field
  ...
}
```

### Using variables inside fragments

It is possible for fragments to access variables declared in the query or mutation.

```graphql linenums="1"
query Query($var: Type = value) {
    aliasA: field(arg: valueA) {
  ...fragment
    }
    aliasB: field(arg: valueB) {
  ...fragment
    }
}

fragment fragment on Type{
    field
    field(arg: $var) {
  field
    ...
  }
    }
}
```

### Operation Name

The *operation type* is either `query`, `mutation`, or `subscription` and describes what type of operation it's intended to be done. The operation type is required unless when using the *query shorthand syntax*, in which case it's not possible to supply a name or variable definitions for the operation.

The *operation name* is a meaningful and explicit name for the operation. It is only required in multi-operation documents, but its use is encouraged because it is very helpful for debugging and server-side logging. When something goes wrong it is easier to identify a query in the codebase by name instead of trying to decipher the contents.

```graphql linenums="1"
query Operation {
  ...
}
```

### Variables

When  working with variables, three things need to be done:

1. Replace the static value in the query with `$variableName`
2. Declare `$variableName` as one of the variables accepted by the query
3. Pass `variableName: value` in the separate, transport-specific (usually JSON) variables dictionary

```graphql linenums="1"
query Operation($var: Type = defaultValue) {
  field(arg: $var) {
    field
    ...
  }
}
```

All declared variables must be either *scalars*, *enums*, or *input* object types. So to pass a complex object into a field, the input type that matches on the server must be known.

Variable definitions can be *optional* or *required*.  If the field requires a non-null argument, then the variable has to be required as well.

Default values can also be assigned to the variables in the query by adding the default value after the type declaration. When default values are provided for all variables, it's possible to call the query without passing any variables. If any variables are passed as part of the variables dictionary, they will override the defaults.

### Directives

A directive can be attached to a field or fragment inclusion, and can affect execution of the query in any way the server desires.

The core GraphQL specification includes exactly two directives, which must be supported by any spec-compliant GraphQL server implementation:

- `@include(if: Boolean)` Only include this field in the result if the argument is `true`.
- `@skip(if: Boolean)` Skip this field if the argument is `true`.

Server implementations may also add experimental features by defining completely new directives.

### Mutations

Operations of mutations:

- **Creating** new data
- **Updating** existing data
- **Deleting** existing data

```graphql linenums="1"
mutation Operation {
  createObject(arg: value, ...) {
    field
    ..
  }
}
```

### Subscriptions

Open a stable connection with the server to receive real-time updates on the operations happening.

```graphql linenums="1"
subscription Operation {
  event {  # get notified when event happens
    field  # data received on notification
    ...
  }
}
```

### Inline Fragments

If you are querying a field that returns an interface or a union type, you will need to use inline fragments to access data on the underlying concrete type. Named fragments can also be used in the same way, since a named fragment always has a type attached.

```graphql linenums="1"
query Operation($var: Type) {
    field(arg: $var) {  # interface of union
  field
  ... on ConcreteTypeA {
    fieldA
  }
  ... on ConcreteTypeB{
    fieldB
  }
    }
}
```

### Meta Fields

GraphQL allows to request `__typename`, a meta field, at any point in a query to get the name of the object type at that point.

```graphql linenums="1"
{
    field(arg: value) {
  __typename
  ... on Type {
    field
  }
    }
}
```

---

## Execution

After being validated, a GraphQL query is executed by a GraphQL server which returns a result that mirrors the shape of the requested query, typically as JSON.

Each field on each type is backed by a function called the *resolver* which is provided by the GraphQL server developer. When a field is executed, the corresponding *resolver* is called to produce the next value.

If a field produces a scalar value like a string or number, then the execution completes. However if a field produces an object value then the query will contain another selection of fields which apply to that object. This continues until scalar values are reached. GraphQL queries always end at scalar values.

### Root fields and Resolvers

At the top level of every GraphQL server is a type that represents all of the possible entry points into the GraphQL API, it's often called the *Root* type or the *Query* type.

```graphql linenums="1"
# root types for entry-points

type Query {
  rootField(arg: Type = defValue, ...): Type
  ...  # other query entry points
}

type Mutation {
  rootField(arg: Type = defValue, ...): Type
  ...  # other mutation entry points
}

type Subscription {
  rootField(arg: Type = defValue, ...): Type
  ...  # other subscription entry points
}
```

A resolver function receives four arguments:

- `obj` The previous object, which for a field on the root Query type is often not used.
- `args` The arguments provided to the field in the GraphQL query.
- `context` A value which is provided to every resolver and holds important contextual information like the currently logged in user, or access to a database.
- `info` A value which holds field-specific information relevant to the current query as well as the schema details
