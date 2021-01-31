# Argpasrse Module

## Creating a parser

```py
import argparse

parser = argparse.ArgumentParser(description="description", allow_abbrev=True)
```

**Note**: All parameters should be passed as keyword arguments.

- `prog`: The name of the program (default: `sys.argv[0]`)
- `usage`: The string describing the program usage (default: generated from arguments added to parser)
- `description`: Text to display before the argument help (default: none)
- `epilog`: Text to display after the argument help (default: none)
- `parents`: A list of ArgumentParser objects whose arguments should also be included
- `formatter_class`: A class for customizing the help output
- `prefix_chars`: The set of characters that prefix optional arguments (default: ‘-‘)
- `fromfile_prefix_chars`: The set of characters that prefix files from which additional arguments should be read (default: None)
- `argument_default`: The global default value for arguments (default: None)
- `conflict_handler`: The strategy for resolving conflicting optionals (usually unnecessary)
- `add_help`: Add a -h/--help option to the parser (default: True)
- `allow_abbrev`: Allows long options to be abbreviated if the abbreviation is unambiguous. (default: True)

## [Adding Arguments](https://docs.python.org/3/library/argparse.html#the-add-argument-method)

```py
ArgumentParser.add_argument("name_or_flags", nargs="...", action="...")
```

**Note**: All parameters should be passed as keyword arguments.

- `name or flags`: Either a name or a list of option strings, e.g. `foo` or `-f`, `--foo`.
- `action`: The basic type of action to be taken when this argument is encountered at the command line.
- `nargs`: The number of command-line arguments that should be consumed.
- `const`: A constant value required by some action and nargs selections.
- `default`: The value produced if the argument is absent from the command line.
- `type`: The type to which the command-line argument should be converted to.
- `choices`: A container of the allowable values for the argument.
- `required`: Whether or not the command-line option may be omitted (optionals only).
- `help`: A brief description of what the argument does.
- `metavar`: A name for the argument in usage messages.
- `dest`: The name of the attribute to be added to the object returned by `parse_args()`.

### Actions

`store`: This just stores the argument’s value. This is the default action.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo')
>>> parser.parse_args('--foo 1'.split())
Namespace(foo='1')
```

`store_const`: This stores the value specified by the const keyword argument. The `store_const` action is most commonly used with optional arguments that specify some sort of flag.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo', action='store_const', const=42)
>>> parser.parse_args(['--foo'])
Namespace(foo=42)
```

`store_true` and `store_false`: These are special cases of `store_const` used for storing the values True and False respectively. In addition, they create default values of False and True respectively.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo', action='store_true')
>>> parser.add_argument('--bar', action='store_false')
>>> parser.add_argument('--baz', action='store_false')
>>> parser.parse_args('--foo --bar'.split())
Namespace(foo=True, bar=False, baz=True)
```

`append`: This stores a list, and appends each argument value to the list. This is useful to allow an option to be specified multiple times. Example usage:

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo', action='append')
>>> parser.parse_args('--foo 1 --foo 2'.split())
Namespace(foo=['1', '2'])
```

`append_const`: This stores a list, and appends the value specified by the const keyword argument to the list. (Note that the const keyword argument defaults to None.) The `append_const` action is typically useful when multiple arguments need to store constants to the same list. For example:

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--str', dest='types', action='append_const', const=str)
>>> parser.add_argument('--int', dest='types', action='append_const', const=int)
>>> parser.parse_args('--str --int'.split())
Namespace(types=[<class 'str'>, <class 'int'>])
```

`count`: This counts the number of times a keyword argument occurs. For example, this is useful for increasing verbosity levels:
**Note**: the default will be None unless explicitly set to 0.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--verbose', '-v', action='count', default=0)
>>> parser.parse_args(['-vvv'])
Namespace(verbose=3)
```

`help`: This prints a complete help message for all the options in the current parser and then exits. By default a help action is automatically added to the parser.

`version`: This expects a version= keyword argument in the add_argument() call, and prints version information and exits when invoked:

```py
>>> import argparse
>>> parser = argparse.ArgumentParser(prog='PROG')
>>> parser.add_argument('--version', action='version', version='%(prog)s 2.0')
>>> parser.parse_args(['--version'])
PROG 2.0
```

`extend`: This stores a list, and extends each argument value to the list. Example usage:

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument("--foo", action="extend", nargs="+", type=str)
>>> parser.parse_args(["--foo", "f1", "--foo", "f2", "f3", "f4"])
Namespace(foo=['f1', 'f2', 'f3', 'f4'])
```

### Nargs

ArgumentParser objects usually associate a single command-line argument with a single action to be taken.
The `nargs` keyword argument associates a different number of command-line arguments with a single action.

**Note**: If the nargs keyword argument is not provided, the number of arguments consumed is determined by the action.

`N` (an integer): N arguments from the command line will be gathered together into a list.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo', nargs=2)
>>> parser.add_argument('bar', nargs=1)
>>> parser.parse_args('c --foo a b'.split())
Namespace(bar=['c'], foo=['a', 'b'])
```

**Note**: `nargs=1` produces a list of one item. This is different from the default, in which the item is produced by itself.

`?`: One argument will be consumed from the command line if possible, and produced as a single item. If no command-line argument is present, the value from default will be produced.

For optional arguments, there is an additional case: the option string is present but not followed by a command-line argument. In this case the value from const will be produced.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo', nargs='?', const='c', default='d')
>>> parser.add_argument('bar', nargs='?', default='d')
>>> parser.parse_args(['XX', '--foo', 'YY'])
Namespace(bar='XX', foo='YY')
>>> parser.parse_args(['XX', '--foo'])
Namespace(bar='XX', foo='c')
>>> parser.parse_args([])
Namespace(bar='d', foo='d')
```

`*`: All command-line arguments present are gathered into a list. Note that it generally doesn’t make much sense to have more than one positional argument with `nargs='*'`, but multiple optional arguments with `nargs='*'` is possible.

```py
>>> parser = argparse.ArgumentParser()
>>> parser.add_argument('--foo', nargs='*')
>>> parser.add_argument('--bar', nargs='*')
>>> parser.add_argument('baz', nargs='*')
>>> parser.parse_args('a b --foo x y --bar 1 2'.split())
Namespace(bar=['1', '2'], baz=['a', 'b'], foo=['x', 'y'])
```

`+`: All command-line args present are gathered into a list. Additionally, an error message will be generated if there wasn’t at least one command-line argument present.

```py
>>> parser = argparse.ArgumentParser(prog='PROG')
>>> parser.add_argument('foo', nargs='+')
>>> parser.parse_args(['a', 'b'])
Namespace(foo=['a', 'b'])
>>> parser.parse_args([])
usage: PROG [-h] foo [foo ...]
PROG: error: the following arguments are required: foo
```

`argparse.REMAINDER`: All the remaining command-line arguments are gathered into a list. This is commonly useful for command line utilities that dispatch to other command line utilities.

```py
>>> parser = argparse.ArgumentParser(prog='PROG')
>>> parser.add_argument('--foo')
>>> parser.add_argument('command')
>>> parser.add_argument('args', nargs=argparse.REMAINDER)
>>> print(parser.parse_args('--foo B cmd --arg1 XX ZZ'.split()))
Namespace(args=['--arg1', 'XX', 'ZZ'], command='cmd', foo='B')
```

## Parsing Arguments

```py
# Convert argument strings to objects and assign them as attributes of the namespace. Return the populated namespace.
ArgumentParser.parse_args(args=None, namespace=None)

#  assign attributes to an already existing object, rather than a new Namespace object
class C:
    pass

c = C()
parser = argparse.ArgumentParser()
parser.add_argument('--foo')
parser.parse_args(args=['--foo', 'BAR'], namespace=c)
c.foo  # BAR

# return a dict instead of a Namespace
args = parser.parse_args(['--foo', 'BAR'])
vars(args)  # {'foo': 'BAR'}
```
