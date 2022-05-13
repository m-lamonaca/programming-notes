# PowerShell Cheat Sheet

Cmdlets are formed by a verb-noun pair. Cmdlets are case-insensitive.

**It's all .NET**
A PS string is in fact a .NET System.String
All .NET methods and properties are thus available

Note that .NET functions MUST be called with parentheses while PS functions CANNOT be called with parentheses.
If you do call a cmdlet/PS function with parentheses, it is the same as passing a single parameter list.

## Screen Output

```ps1
Write-Host "message"
```

## User Input

```ps1
# Reading a value from input:
$variable = Read-Host "prompt"
```

## Variables

```ps1
# Declaration
[type]$var = value
$var = value -as [type]

[int]$a = 5
$b = 6 -as [double]  # ?

# Here-string (multiline string)
@"
Here-string
$a + $b = ($a + $b)
"@

@'
Literal Here-string
'@

# Swapping
$a, $b = $b, $a

# Interpolation
Write-Host "text $variable"  # single quotes will not interpolate
Write-Host (<expression>)
```

### Built-in Variables

```ps1
$True, $False  # boolean
$null  # empty value
$?  # last program return value
$LastExitCode  # Exit code of last run Windows-based program
$$  # The last token in the last line received by the session
$^  # The first token
$PID  # Script's PID
$PSScriptRoot  # Full path of current script directory
$MyInvocation.MyCommand.Path  # Full path of current script
$Pwd  # Full path of current directory
$PSBoundParameters  # Bound arguments in a function, script or code block
$Args # Unbound arguments

. .\otherScriptName.ps1  # Inline another file (dot operator)
```

### Lists & Dictionaries

```ps1
$List = @(5, "ice", 3.14, $True)  # Explicit syntax
$List = 2, "ice", 3.14, $True  # Implicit syntax
$List = (1..10)  # Inclusive range
$List = @()  # Empty List

$String = $List -join 'separator'
$List = $String -split 'separator'

# List comprehensions
$List = sequence | Where-Object {$_ command}  # $_ is current object
$Dict = @{"a" = "apple"; "b" = "ball"}  # Dict definition
$Dict["a"] = "acorn"  # Item update

# Loop through keys
foreach ($k in $Dict.keys) {
    # Code here
}
```

## Flow Control

```ps1
if (condition) {
    # Code here
} elseif (condition) {
    # Code here
} else {
    # Code here
}
```

### Switch

`Switch` has the following parameters:

- **Wildcard**: Indicates that the condition is a wildcard string. If the match clause is not a string, the parameter is ignored. The comparison is case-insensitive.
- **Exact**: Indicates that the match clause, if it is a string, must match exactly. If the match clause is not a string, this parameter is ignored. The comparison is case-insensitive.
- **CaseSensitive**: Performs a case-sensitive match. If the match clause is not a string, this parameter is ignored.
- **File**: Takes input from a file rather than a value statement. If multiple File parameters are included, only the last one is used. Each line of the file is read and evaluated by the Switch statement. The comparison is case-insensitive.
- **Regex**: Performs regular expression matching of the value to the condition. If the match clause is not a string, this parameter is ignored. The comparison is case-insensitive. The `$matches` automatic variable is available for use within the matching statement block.

```ps1
switch(variable) {
    20                      { "Exactly 20"; break }
    { $_ -eq 42 }           { "The answer equals 42"; break }
    { $_ -like 's*' }       { "Case insensitive"; break }
    { $_ -clike 's*'}       { "clike, ceq, cne for case sensitive"; break }
    { $_ -notmatch '^.*$'}  { "Regex matching. cnotmatch, cnotlike, ..."; break }
    { $list -contains 'x'}  { "if a list contains an item"; break }
    default                 { "Others" }
}

# syntax
switch [-regex|-wildcard|-exact][-casesensitive] (<value>)
{
    "string"|number|variable|{ expression } { statement_list }
    default { statement_list }
}

# or

switch [-regex|-wildcard|-exact][-casesensitive] -file filename
{
    "string"|number|variable|{ expression } { statement_list }
    default { statement_list }
}
```

### Loops

```ps1
# The classic for
for(setup; condition; iterator) {
    # Code here
}

range | % { command }

foreach (item in iterable) {
    # Code Here
}

while (condition) {
    # Code here
}

do {
    # Code here
} until (condition)

do {
    # Code here
} while (condition)
```

### Operators

```ps1
# Conditionals
$a -eq $b  # is equal to
$a -ne $b  # in not equal to
$a -gt $b  # greater than
$a -ge $b  # greater than or equal to
$a -lt $b  # less than
$a -le $b  # less than or equal to

# Logical
$true -And $False
$True -Or $False
-Not $True
```

### Exception Handling

```ps1
try {} catch {} finally {}
try {} catch [System.NullReferenceException] {
    echo $_.Exception | Format-List -Force
}
```

## [Functions](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions?view=powershell-7)

```ps1
function func() {}

# function with named parameters
function func ([type]$param=default_value, ...) { }
function func {
    param([type]$param=default_value, ...)

    # statements
}

# function call
func argument  
func -param value

# switch parameters
function func ([switch]$param, ...) { }

func  # param is $false
func -param  # param is $true
```

If the function defines a `Begin`, `Process` or `End` block, all the code **must reside inside** those blocks. No code will be recognized outside the blocks if any of the blocks are defined.

If the function has a `Process` keyword, each object in `$input` is removed from `$input` and assigned to `$_`.

```ps1
function [<scope:>]<name> [([type]$parameter1[,[type]$parameter2])]
{
  param([type]$parameter1 [,[type]$parameter2])  # other way to specify named parameters
  dynamicparam {<statement list>}

  # processing pipelines
  begin {<statement list>}  # runned once, at start of pipeline
  process {<statement list>}  # runned for each item in the pipeline
  end {<statement list>}  # runned once, at end of pipeline
}
```

Optionally, it's possible to provide a brief help string that describes the default value of the parameter, by adding the `PSDefaultValue` attribute to the description of the parameter, and specifying the `Help` property of `PSDefaultValue`.

```ps1
function Func {
  param (
      [PSDefaultValue(Help = defValue)]
      $Arg = 100
  )
}
```

## Script Arguments

### Parsing Script Arguments

```ps1
$args  # array of passed arguments
$args[$index]  # access to the arguments
$args.count  # number of arguments
```

### Script Named Arguments

In `scripts.ps1`:

```ps1
param($param1, $param2, ...)  # basic usage
param($param1, $param2=defvalue, ...)  # with default values
param([Type] $param1, $param2, ...)  # specify a type
param([Parameter(Mandatory)]$param1, $param2, ...)  # setting a parameter as necessary

param([switch]$flag=$false, ...)  # custom flags
```

In PowerShell:

```ps1
.\script.ps1 arg1 arg2  # order of arguments will determine which data goes in which parameter

.\script.ps1 -param2 arg2 -param1 arg1  # custom order
```

### Filters

A filter is a type of function that runs on each object in the pipeline. A filter resembles a function with all its statements in a `Process` block.

```ps1
filter [<scope:>]<name> {<statement list>}
```

## PowerShell Comment-based Help

The syntax for comment-based help is as follows:

```ps1
# .<help keyword>
# <help content>
```

or

```ps1
<#
.<help keyword>
<help content>
#>
```

Comment-based help is written as a series of comments. You can type a comment symbol `#` before each line of comments, or you can use the `<#` and `#>` symbols to create a comment block. All the lines within the comment block are interpreted as comments.

All of the lines in a comment-based help topic must be contiguous. If a comment-based help topic follows a comment that is not part of the help topic, there must be at least one blank line between the last non-help comment line and the beginning of the comment-based help.

Keywords define each section of comment-based help. Each comment-based help keyword is preceded by a dot `.`. The keywords can appear in any order. The keyword names are not case-sensitive.

### .SYNOPSIS

A brief description of the function or script. This keyword can be used only once in each topic.

### .DESCRIPTION

A detailed description of the function or script. This keyword can be used only once in each topic.

### .PARAMETER

The description of a parameter. Add a `.PARAMETER` keyword for each parameter in the function or script syntax.

Type the parameter name on the same line as the `.PARAMETER` keyword. Type the parameter description on the lines following the `.PARAMETER` keyword. Windows PowerShell interprets all text between the `.PARAMETER` line and the next keyword or the end of the comment block as part of the parameter description. The description can include paragraph breaks.

```ps1
.PARAMETER  <Parameter-Name>
```

The Parameter keywords can appear in any order in the comment block, but the function or script syntax determines the order in which the parameters (and their descriptions) appear in help topic. To change the order, change the syntax.

You can also specify a parameter description by placing a comment in the function or script syntax immediately before the parameter variable name. For this to work, you must also have a comment block with at least one keyword.

If you use both a syntax comment and a `.PARAMETER` keyword, the description associated with the `.PARAMETER` keyword is used, and the syntax comment is ignored.

```ps1
<#
.SYNOPSIS
    Short description here
#>
function Verb-Noun {
    [CmdletBinding()]
    param (
        # This is the same as .Parameter
        [string]$Computername
    )
    # Verb the Noun on the computer
}
```

### .EXAMPLE

A sample command that uses the function or script, optionally followed by sample output and a description. Repeat this keyword for each example.

### .INPUTS

The .NET types of objects that can be piped to the function or script. You can also include a description of the input objects.

### .OUTPUTS

The .NET type of the objects that the cmdlet returns. You can also include a description of the returned objects.

### .NOTES

Additional information about the function or script.

### .LINK

The name of a related topic. The value appears on the line below the `.LINK` keyword and must be preceded by a comment symbol `#` or included in the comment block.

Repeat the `.LINK` keyword for each related topic.

This content appears in the Related Links section of the help topic.

The `.Link` keyword content can also include a Uniform Resource Identifier (URI) to an online version of the same help topic. The online version opens when you use the **Online** parameter of `Get-Help`. The URI must begin with "http" or "https".

### .COMPONENT

The name of the technology or feature that the function or script uses, or to which it is related. The **Component** parameter of `Get-Help` uses this value to filter the search results returned by `Get-Help`.

### .ROLE

The name of the user role for the help topic. The **Role** parameter of `Get-Help` uses this value to filter the search results returned by `Get-Help`.

### .FUNCTIONALITY

The keywords that describe the intended use of the function. The **Functionality** parameter of `Get-Help` uses this value to filter the search results returned by `Get-Help`.

### .FORWARDHELPTARGETNAME

Redirects to the help topic for the specified command. You can redirect users to any help topic, including help topics for a function, script, cmdlet, or provider.

```ps1
# .FORWARDHELPTARGETNAME <Command-Name>
```

### .FORWARDHELPCATEGORY

Specifies the help category of the item in `.ForwardHelpTargetName`. Valid values are `Alias`, `Cmdlet`, `HelpFile`, `Function`, `Provider`, `General`, `FAQ`, `Glossary`, `ScriptCommand`, `ExternalScript`, `Filter`, or `All`. Use this keyword to avoid conflicts when there are commands with the same name.

```ps1
# .FORWARDHELPCATEGORY <Category>
```

### .REMOTEHELPRUNSPACE

Specifies a session that contains the help topic. Enter a variable that contains a **PSSession** object. This keyword is used by the [Export-PSSession](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-pssession?view=powershell-7)
cmdlet to find the help topics for the exported commands.

```ps1
# .REMOTEHELPRUNSPACE <PSSession-variable>
```

### .EXTERNALHELP

Specifies an XML-based help file for the script or function.

```ps1
# .EXTERNALHELP <XML Help File>

```

The `.ExternalHelp` keyword is required when a function or script is documented in XML files. Without this keyword, `Get-Help` cannot find the XML-based help file for the function or script.

The `.ExternalHelp` keyword takes precedence over other comment-based help keywords. If `.ExternalHelp` is present, `Get-Help` does not display comment-based help, even if it cannot find a help topic that matches the value of the `.ExternalHelp` keyword.

If the function is exported by a module, set the value of the `.ExternalHelp` keyword to a filename without a path. `Get-Help` looks for the specified file name in a language-specific subdirectory of the module directory. There are no requirements for the name of the XML-based help file for a function, but a best practice is to use the following format:

```ps1
<ScriptModule.psm1>-help.xml
```

If the function is not included in a module, include a path to the XML-based help file. If the value includes a path and the path contains UI-culture-specific subdirectories, `Get-Help` searches the subdirectories
recursively for an XML file with the name of the script or function in accordance with the language fallback standards established for Windows, just as it does in a module directory.

For more information about the cmdlet help XML-based help file format, see [How to Write Cmdlet Help](https://go.microsoft.com/fwlink/?LinkID=123415) in the MSDN library.
***

## Project Oriented Programming

### Classes

```ps1
[class]::func()  # use function from a static class
[class]::attribute  # access to static class attribute
```
