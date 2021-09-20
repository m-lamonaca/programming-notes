# Bash Cheat Sheet

[Bash Manual](https://www.gnu.org/software/bash/manual/)

`Ctrl+Shift+C`: copy  
`Ctrl+Shift+C`: paste

## Bash Use Modes

Interactive mode --> shell waits for user's commands
Non-interactive mode --> shell runs scripts

## File & Directories Permissions

File:

- `r`: Read. Can see file content
- `w`: Write. Can modify file content
- `x`: Execute. Can execute file

Directory:

- `r`: Read. Can see dir contents
- `w`: CRD. Can create, rename and delete files
- `x`: Search. Can access and navigate inside the dir. Necessary to operate on files

## File Descriptors

`FD 0` "standard input"    --> Channel for standard input (default keyboard)  
`FD 1` "standard output"   --> Channel for the default output (default screen)  
`FD 2` "standard error"    --> Channel for error messages, info messages, prompts (default keyboard)  
File descriptors chan be joined to create streams that lead to files, devices or other processes.

Bash gets commands by reading lines.  
As soon as it's read enough lines to compose a complete command, bash begins running that command.  
Usually, commands are just a single line long. An interactive bash session reads lines from you at the prompt.  
Non-interactive bash processes read their commands from a file or stream.  
Files with a shebang as their first line (and the executable permission) can be started by your system's kernel like any other program.

### First Line Of Bash

`#!/bin/env bash`  
shebang indicating which interpreter to use

### Simple Command

```bash
[ var=value ... ] command [ arg ... ] [ redirection ... ]  # [.] is optional component
```

### Pipelines (commands concatenation)

```bash
command | file.ext  # link the first process' standard output to the second process' standard input
command |& file.ext  # link the first process' standard output & standard error to the second process' standard input
```

### Lists (sequence of commands)

```bash
command_1; command_2; ...  # execute command in sequence, one after the other
command_1 || command_2 || ...  # execute successive commands only if preceding ones fail
```

### COMPOUND COMMANDs (multiple commands as one)

```bash
# block of commands executed as one
<keyword>
    command_1; command_2; ...
<end_keyword>

{command_1; command_2; ...}  # sequence of commands executed as one
```

### Functions (blocks of easily reusable code)

`function_name () {compound_command}`  
Bash does not accept func arguments, parentheses must be empty

## Command names & Running programs

To run a command, bash uses the name of your command and performs a search for how to execute that command.  
In order, bash will check whether it has a function or builtin by that name.  
Failing that, it will try to run the name as a program.  
If bash finds no way to run your command, it will output an error message.  

## The path to a program

When bash needs to run a program, it uses the command name to perform a search.  
Bash searches the directories in your PATH environment variable, one by one, until it finds a directory that contains a program with the name of your command.  
To run a program that is not installed in a PATH directory, use the path to that program as your command's name.

## Command arguments & Quoting literals

To tell a command what to do, we pass it arguments. In bash, arguments are tokens, that are separated from each other by blank space.  
To include blank space in an argument's value, you need to either quote the argument or escape the blank space within.  
Failing that, bash will break your argument apart into multiple arguments at its blank space.  
Quoting arguments also prevents other symbols in it from being accidentally interpreted as bash code.  

## Managing a command's input and output using redirection

By default, new commands inherit the shell's current file descriptors.  
We can use redirections to change where a command's input comes from and where its output should go to.  
File redirection allows us to stream file descriptors to files.  
We can copy file descriptors to make them share a stream. There are also many other more advanced redirection operators.  

### Redirections

```bash
[x]>file  # make FD x write to file
[x]<file  # make FD x read from file

[x]>&y  # make FD x write to FD y's stream
[x]<&y  # make FD x read from FD y's stream
&>file  # make both FD 1 (standard output) & FD 2 (standard error) write to file

[x]>>file  # make FD x append to end of file
x>&-, x<&-  # close FD x (stream disconnected from FD x)
[x]>&y-, [x]<&y-  # replace FD x with FD y
[x]<>file  # open FD x for both reading and writing to file
```

## Pathname Expansion (filname pattern [glob] matching)

`*` matches any kind of text (even no text).  
`?` matches any single character.  
`[characters]` matches any single character in the given set.  
`[[:classname:]]` specify class of characters to match.
`{}` expand list of arguments (applies command to each one)

`shopt -s extglob` enables extended globs (patterns)

`+(pattern [| pattern ...])` matches when any of the patterns in the list appears, once or many times over. ("at least one of ...").  
`*(pattern [| pattern ...])` matches when any of the patterns in the list appears, once, not at all, or many times over. ("however many of ...").  
`?(pattern [| pattern ...])` matches when any of the patterns in the list appears, once, not at all, or many times over. ("however many of ...").  
`@(pattern [| pattern ...])` matches when any of the patterns in the list appears just once. ("one of ...").  
`!(pattern [| pattern ...])` matches only when none of the patterns in the list appear. ("none of ...").

## Command Substitution

With Command Substitution, we effectively write a command within a command, and we ask bash to expand the inner command into its output and use that output as argument data for the main command.  

```bash
$(inner_command)  # $ --> value-expansion prefix
```

## Shell Variables

```bash
varname=value  # variable assignment
varname="$(command)"  # command substitution, MUST be double-quoted
"$varname", "${varname}"  # variable expansion, MUST be double-quoted (name substituted w/ variable content)

$$  # pid
$#  # number of arguments passed
$@  # all arguments passed
${n}  # n-th argument passed to the command
$0  # name of the script
$_  # last argument passed to the command
$?  # error message of the last (previous) command
!!  # executes last command used (echo !! prints the last command)
```

## Parameter Expansion Modifiers (in double-quotes)

`${parameter#pattern}` removes the shortest string that matches the pattern if it's at the start of the value.  
`${parameter##pattern}` removes the longest string that matches the pattern if it's at the start of the value.  
`${parameter%pattern}` removes the shortest string that matches the pattern if it's at the end of the value.  
`${parameter%%pattern}` removes the longest string that matches the pattern if it's at the end of the value.  
`${parameter/pattern/replacement}` replaces the first string that matches the pattern with the replacement.  
`${parameter//pattern/replacement}` replaces each string that matches the pattern with the replacement.  
`${parameter/#pattern/replacement}` replaces the string that matches the pattern at the beginning of the value with the replacement.  
`${parameter/%pattern/replacement}` replaces the string that matches the pattern at the end of the value with the replacement.  
`${#parameter}` expands the length of the value (in bytes).  
`${parameter:start[:length]}` expands a part of the value, starting at start, length bytes long.  
Counts from the end rather than the beginning by using a (space followed by a) negative value.  
`${parameter[^|^^|,|,,][pattern]}` expands the transformed value, either upper-casing or lower-casing the first or all characters that match the pattern.
Omit the pattern to match any character.

## Decision Statements

### If Statement

Only the final exit code after executing the entire list is relevant for the branch's evaluation.

```bash
if command_list; then
    command_list;
elif command_list; then
    command_list;
else command_list;
fi
```

### Test Command

`[[ argument_1 <operator> argument_2 ]]`

### Arithmetic expansion and evaluation

`(( expression ))`

### Comparison Operators

```bash
[[ "$a" -eq "$b" ]]  # is equal to
[[ "$a" -ne "$b" ]]  # in not equal to
[[ "$a" -gt "$b" ]]  # greater than
[[ "$a" -ge "$b" ]]  # greater than or equal to
[[ "$a" -lt "$b" ]]  # less than
[[ "$a" -le "$b" ]]  # less than or equal to
```

### Arithmetic Comparison Operators

```bash
(("$a" > "$b"))  # greater than
(("$a" >= "$b"))   # greater than or equal to
(("$a" < "$b"))  # less than
(("$a" <= "$b"))   # less than or equal to
```

### String Comparison Operators

```bash
[ "$a" = "$b" ]    # is equal to (whitespace around operator)

[[ $a == z* ]]     # True if $a starts with an "z" (pattern matching)
[[ $a == "z*" ]]   # True if $a is equal to z* (literal matching)
[ $a == z* ]       # File globbing and word splitting take place
[ "$a" == "z*" ]   # True if $a is equal to z* (literal matching)

[ "$a" != "$b" ]   # is not equal to, pattern matching within a [[ ... ]] construct

[[ "$a" < "$b" ]]  # is less than, in ASCII alphabetical order
[ "$a" \< "$b" ]   # "<" needs to be escaped within a [ ] construct.

[[ "$a" > "$b" ]]  # is greater than, in ASCII alphabetical order
[ "$a" \> "$b" ]   # ">" needs to be escaped within a [ ] construct.
```

## Commands short circuit evaluation

```bash
command_1 || command_2  # if command_1 fails executes command_2
command_1 && command_2  # executes command_2 only if command_1 succeeds
```

## Loops

```bash
for var in iterable ; do
    # command here
done
```
