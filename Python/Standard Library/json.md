# JSON Module Cheat Sheet

## JSON Format

JSON (JavaScript Object Notation) is a lightweight data-interchange format.
    It is easy for humans to read and write.
    It is easy for machines to parse and generate.

JSON is built on two structures:

- A collection of name/value pairs.
- An ordered list of values.

An OBJECT is an unordered set of name/value pairs.
An object begins with `{` (left brace) and ends with `}` (right brace).
Each name is followed by `:` (colon) and the name/value pairs are separated by `,` (comma).

An ARRAY is an ordered collection of values.
An array begins with `[` (left bracket) and ends with `]` (right bracket).
Values are separated by `,` (comma).

A VALUE can be a string in double quotes, or a number,
or true or false or null, or an object or an array.
These structures can be nested.

A STRING is a sequence of zero or more Unicode characters,
wrapped in double quotes, using backslash escapes.
A CHARACTER is represented as a single character string.
A STRING is very much like a C or Java string.
A NUMBER is very much like a C or Java number,
except that the octal and hexadecimal formats are not used.

WHITESPACE can be inserted between any pair of tokens.

## Usage

```python

# serialize obj as JSON formatted stream to fp
json.dump(obj, fp, cls=None, indent=None, separators=None, sort_keys=False)
# CLS: {custom JSONEncoder} -- specifies custom encoder to be used
# INDENT: {int > 0, string} -- array elements, object members pretty-printed with indent level
# SEPARATORS: {tuple} -- (item_separator, key_separator)
#   [default: (', ', ': ') if indent=None, (',', ':') otherwise],
#   specify (',', ':') to eliminate whitespace
# SORT_KEYS: {bool} -- if True dict sorted by key

# serialize obj as JSON formatted string
json.dumps(obj, cls=None, indent=None, separators=None, sort_keys=False)
# CLS: {custom JSONEncoder} -- specifies custom encoder to be used
# INDENT: {int > 0, string} -- array elements, object members pretty-printed with indent level
# SEPARATORS: {tuple} -- (item_separator, key_separator)
#   [default: (', ', ': ') if indent=None, (',', ':') otherwise],
#   specify (',', ':') to eliminate whitespace
# SORT_KEYS: {bool} -- if True dict sorted by key

# deserialize fp to python object
json.load(fp, cls=None)
# CLS: {custom JSONEncoder} -- specifies custom decoder to be used

# deserialize s (string, bytes or bytearray containing JSON doc) to python object
json.loads(s, cls=None)
# CLS: {custom JSONEncoder} -- specifies custom decoder to be used
```

## Default Decoder (`json.JSONDecoder()`)

Convertions (JSON -> Python):

- object -> dict
- array -> list
- string -> str
- number (int) -> int
- number (real) -> float
- true -> True
- false -> False
- null -> None

## Default Encoder (`json.JSONEncoder()`)

Convertions (Python -> Json):

- dict -> object
- list, tuple -> array
- str -> string
- int, float, Enums -> number
- True -> true
- False -> false
- None -> null

## Extending JSONEncoder (Example)

```python
import json

class ComplexEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, complex):
            return [obj.real, obj.imag]
        # Let the base class default method raise the TypeError
            return json.JSONEncoder.default(self, obj)
```

## Retrieving Data from json dict

```python
data = json.loads(json)
data["key"]  # retieve the value associated with the key
data["outer key"]["nested key"]  # nested key value retireval
```
