# [Click](https://click.palletsprojects.com) Lib

## Command Creation

```py
import click

# the decorator converts the function into a Command which then can be invoked
@click.command()
def hello():
    click.echo('Hello World!')

if __name__ == '__main__':
    hello()
```

### Nesting Commands

Commands can be attached to other commands of type `Group`. This allows arbitrary nesting of scripts. As an example here is a script that implements two commands for managing databases:

```py
@click.group()
def cli():
    pass

@click.command()
def initdb():
    click.echo('Initialized the database')

@click.command()
def dropdb():
    click.echo('Dropped the database')

cli.add_command(initdb)
cli.add_command(dropdb)
```

The `group()` decorator works like the `command()` decorator, but creates a Group object instead which can be given multiple subcommands that can be attached with `Group.add_command()`.

For simple scripts, it’s also possible to automatically attach and create a command by using the `Group.command()` decorator instead.  
The above script can instead be written like this:

```py
@click.group()
def cli():
    pass

@cli.command()
def initdb():
    click.echo('Initialized the database')

@cli.command()
def dropdb():
    click.echo('Dropped the database')
```

You would then invoke the Group in your setuptools entry points or other invocations:

```py
if __name__ == '__main__':
    cli()
```

### Adding Parameters

To add parameters, use the `option()` and `argument()` decorators:

```py
@click.command()
@click.option('--count', default=1, help='number of greetings')
@click.argument('name')
def hello(count, name):
    for x in range(count):
        click.echo(f'Hello {name}!')
```
