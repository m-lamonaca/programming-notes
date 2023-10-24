# [Redis](https://redis.io/)

Redis is in the family of databases called **key-value stores**.

The essence of a key-value store is the ability to store some data, called a value, inside a key. This data can later be retrieved only if we know the exact key used to store it.

Often Redis it is called a *data structure* server because it has outer key-value shell, but each value can contain a complex data structure, such as a string, a list, a hashes, or ordered data structures called sorted sets as well as probabilistic data structures like *hyperloglog*.

## [Redis Commands](https://redis.io/commands)

### Server Startup

```bash linenums="1"
redis-server  # start the server
redis-cli
```

### [Key-Value Pairs](https://redis.io/commands#generic)

```sh linenums="1"
SET <key> <value> [ EX <seconds> ] # store a key-value pair, TTL optional
GET <key>  # read a key content
EXISTS <key>  # check if a key exists
DEL <key>  # delete a key-value pair

INCR <key>  # atomically increment a number stored at a given key
INCRBY <key> <amount>  # increment the number contained inside a key by a specific amount
DECR <key>
DECRBY <key> <amount>

# re-setting the key will make it permanent (TTL -1)
EXPIRE <key> <seconds>  # make the key expire after <second> seconds
TTL <key>  # see remaining seconds before expiry
PEXPIRE <key> <seconds>  # make the key expire after <second> milli-seconds
PTTL <key>  # see remaining milli-seconds before expiry
PERSIST <key>  # make the key permanent
```

### [Lists](https://redis.io/commands#list)

A list is a series of ordered values.

```sh linenums="1"
RPUSH <key> <value1> <value2> ... # add one or more values to the end of the list
LPUSH <key> <value1> <value2> ...  # add one or more values to the start of a list

LLEN  # number of items in the list
LRANGE <key> <start_index> <end_index>  # return a subset of the list, end index included. Negative indexes count backwards from the end

LPOP  # remove and return the first item fro the list
RPOP  # remove and return the last item fro the list
```

### [Sets](https://redis.io/commands#set)

A set is similar to a list, except it does not have a specific order and each element may only appear once.

```sh linenums="1"
SADD <key> <value1> <value2> ... # add one or more values to the set (return 0 if values are already inside)
SREM <key> <value>  # remove the given member from the set, return 1 or 0 to signal if the member was actually there or not.
SPOP <key> <value>  # remove and return value from the set

SISMEMBER <key> <value>  # test if value is in the set
SMEMBERS <key>  # lis of all set items

SUINION <key1> <key2> ...  # combine two or more sets and return the list of all elements.
```

### [Sorted Sets](https://redis.io/commands#sorted_set)

Sets are a very handy data type, but as they are unsorted they don't work well for a number of problems. This is why Redis 1.2 introduced Sorted Sets.

A sorted set is similar to a regular set, but now each value has an associated score. This score is used to sort the elements in the set.

```sh linenums="1"
ZADD <key> <score> <value>  # add a value with it's score

ZRANGE <key> <start_index> <end_index>  # return a subset of the sortedSet

...
```

### [Hashes](https://redis.io/commands#hash)

Hashes are maps between string fields and string values, so they are the perfect data type to represent objects.

```sh linenums="1"
HSET <key> <field> <value> [ <field> <value> ... ] # set the string of a hash field
HSETNX <key> <field> <value>  # set the value of a hash field, only if the field does not exist

HEXISTS <key> <field>  # determine if a hash field exists

HLEN <key>  # get the number of fields in a hash
HSTRLEN <key> <field>  # get the length of the value of a hash field
HGETALL <key>  # get all fields and values in a hash
HGET <key> <field>  # get data on a single field
HKEYS <key>  # get all the fields in a hash
HVALS <key>  # get all the values in a hash

HDEL <key> <field_1> <field_2> ...  # delete one or more field hashes

HMGET <key> <field> [<field> ...]  # get the values of all the given hash fields
HMSET <key> <field> <value> [<field> <value> ...]  # set multiple hash fields to multiple values

HINCRBY <key> <field> <amount>  # increment the integer value of a hash field by the given number
HINCRBYFLOAT <key> <field> <amount> # increment the float value of a hash field by the given amount

HSCAN <key> <cursor> [MATCH <pattern>] [COUNT <count>]  # incrementally iterate hash fields and associated values
```
