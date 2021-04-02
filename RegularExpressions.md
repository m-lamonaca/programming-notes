# Common Regex Syntax

## Character Types

`\d` any digit (0-9)  
`\D` any non digit character  
`\s` whitespace (space, tab, new line)  
`\S` any non whitespace charaters  
`\w` any alphanumeric charater (a-z, A-Z)  
`\W` any non alphanumeric character  
`\b` whitespace surrounding words (only at row start or end)  
`\B` whitespace surrounding words (not at row start or end)  
`\A` search only at string start  
`\Z` search only at string end  
`.` any charaters but newline (CRLF, CR, LF)  

## Quantifiers

`+` one or more repetitions  
`*` zero or more repetitions  
`?` zero or one repetition  
`{m}` exactly *m* times  
`{m, n}` at least *m* times, at most *n* times

The `*`, `x`, and `?` qualifiers are all greedy; they match as much text as possible  
Adding `?` *after* the qualifier makes it perform the match in non-greedy or minimal fashion; as few characters as possible will be matched.

## Special Characters

`\a, \b, \f, \n, \r, \t, \u, \U, \v, \x, \\, \?, \*, \+ , \., \^, \$` special characters  
`\(`, `\)`, `\[`, `\]` brackets escaping

## Delimiters

`^` match must be at start of string/line  
`$` match must be at end of string/line  
`^__$` match must be whole string  

## Character classes

`[__]` one of the charaters in the class (`[ab]` --> a or b)  
`[__]{m , n}` consecutive characters in the class (`[aeiou]{2}` --> ae, ao, ...)  
`[a-z]` sequence of lowercase characters  
`[A-Z]` sequence of uppercase characters  
`[a-zA-Z]` sequence of lowercase or uppercase characters  
`[a-z][A-Z]` sequence of lowercase characters followed by sequence of uppercase charaters  
`[^__]` anything but the elements of the class (include `\n` to avoid matching line endings)

`^`, `\`, `-` and `]` must be escaped to be used in clases: `[ \]\[\^\- ]`

## Groups

`(__)` REGEX subgroup  
`(REGEX_1 | REGEX_2)` match in multiple regex (R1 OR R2)  
`(?=__)` match only if `__` is next substring  
`(?!__)` match only if `__` is not next substring  
`(?<=__)` match only if `__` is previous substring  
`(?<!__)` match only if `__` is not previous substring  

`\<number>` refers to n-th group  

## Special Cases

`(.*)` match anything  
`(.*?)` match anything, non-greedy match
