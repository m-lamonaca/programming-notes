# Common Regex Syntax

A **regular expression** is a *pattern* that the regular expression engine attempts to match in input text. A pattern consists of one or more character literals, operators, or constructs.

## Character Classes

A **character class** matches any one of a set of characters.

- `[character_group]`:: matches any single character in *character_group*.
- `[^character_group]`: matches any single character **not** in *character_group*.
- `[first-last]`: matches any single character in range from *first* to *last*.
- `.`: matches any single character except `\n`.
- `\p{name}`: matches any single character in the Unicode general category or named block specified by *name*.
- `\P{name}`: matches any single character **not** in the Unicode general category or named block specified by *name*.
- `\w`: matches any word character.
- `\W`: matches any **non** word character.
- `\s`: matches any whitespace character.
- `\S`: matches any **non** whitespace character.
- `\d`: matches any decimal digit.
- `\D`: matches any character other than a decimal digit.

> **Note**: `^`, `\`, `-` and `]` must be escaped to be used in ranges. (`[ \] \[ \^ \- ]`)

## Anchors

**Anchors**, or atomic zero-width assertions, cause a match to succeed or fail depending on the current position in the string, but they do not cause the engine to advance through the string or consume characters.

- `^`: The match must be at the *start* of a string/line.
- `$`: The match must be at the *end* of a string/line.
- `\A`: The match must occur at the start of the string.
- `\Z`: The match must occur at the end of the string or before `\n` at the end of the string.
- `\z`: The match must occur at the end of the string.
- `\G`: The match must occur at the point where the previous match ended, or if there was no previous match, at the position in the string where matching started.
- `\b`: The match must occur on a boundary between a `\w` (alphanumeric) and a `\W` (non-alphanumeric) character.
- `\B`: The match must not occur on a `\b` boundary.

## Grouping Constructs

**Grouping constructs** delineate subexpressions of a regular expression and typically capture substrings of an input string.

### Subexpressions

```regex title="Regex Syntax"
(subexpression)
```

The *subexpression* is any valid regular expression pattern.

Captures that use parentheses are numbered automatically from left to right based on the order of the opening parentheses in the regular expression, starting from `1`. The capture that's numbered `0` is the text matched by the entire regular expression pattern.

> **Note**: named capture groups are always ordered last, after non-named capture groups.

It's possible to access the captured group in the following ways:

- By using the *backreference construct* within the regular expression.

    The matched subexpression is referenced in the same regular expression by using the syntax `\number`, where number is the ordinal number of the captured subexpression.

- By using the *named backreference construct* within the regular expression.

    The matched subexpression is referenced in the same regular expression by using the syntax `\k<name>`, where name is the name of a capturing group, or `\k<number>`, where number is the ordinal number of a capturing group.

    A capturing group has a default name that is identical to its ordinal number. For more information, see Named matched subexpressions later in this topic.

- By using the `$number` *replacement sequence* where number is the ordinal number of the captured subexpression.

### Named Subexpressions

```regex title="Regex Syntax"
(?<name> subexpression)
(?'name' subexpression)
```

THe *name* is a valid group name, and *subexpression* is any valid regular expression pattern. *name* must not contain any punctuation characters and cannot begin with a number.

It's possible to access the named captured group in the following ways:

- By using the named *backreference construct* within the regular expression.

    The matched subexpression is referenced in the same regular expression by using the syntax `\k<name>`, where name is the name of the captured subexpression.

- By using the *backreference construct* within the regular expression.

    The matched subexpression is referenced in the same regular expression by using the syntax `\number`, where number is the ordinal number of the captured subexpression.

    Named matched subexpressions are numbered consecutively from left to right after matched subexpressions.

- By using the `${name}` *replacement sequence* where name is the name of the captured subexpression.
- By using the `$number` *replacement sequence* where number is the ordinal number of the captured subexpression.

### Noncapturing groups

```regex title="Regex Syntax"
(?:subexpression)
```

The *subexpression* is any valid regular expression pattern. The noncapturing group construct is typically used when a quantifier is applied to a group, but the substrings captured by the group are of no interest.

### Zero-width positive lookahead assertions

```regex title="Regex Syntax"
(?= subexpression)
```

The *subexpression* is any regular expression pattern. For a match to be successful, the input string must match the regular expression pattern in subexpression, although the matched substring is not included in the match result. A zero-width positive lookahead assertion does not backtrack.

Typically, a zero-width positive lookahead assertion is found at the end of a regular expression pattern. It defines a substring that must be found at the end of a string for a match to occur but that should not be included in the match. It is also useful for preventing excessive backtracking.

It's possible to use a zero-width positive lookahead assertion to ensure that a particular captured group begins with text that matches a subset of the pattern defined for that captured group.

### Zero-width negative lookahead assertions

```regex title="Regex Syntax"
(?! subexpression)
```

The *subexpression* is any regular expression pattern. For the match to be successful, the input string must not match the regular expression pattern in subexpression, although the matched string is not included in the match result.

A zero-width negative lookahead assertion is typically used either at the beginning or at the end of a regular expression. At the beginning of a regular expression, it can define a specific pattern that should not be matched when the beginning of the regular expression defines a similar but more general pattern to be matched. In this case, it is often used to limit backtracking. At the end of a regular expression, it can define a subexpression that cannot occur at the end of a match.

### Zero-width positive lookbehind assertions

```regex title="Regex Syntax"
(?<= subexpression)
```

The *subexpression* is any regular expression pattern. For a match to be successful, subexpression must occur at the input string to the left of the current position, although subexpression is not included in the match result. A zero-width positive lookbehind assertion does not backtrack.

Zero-width positive lookbehind assertions are typically used at the beginning of regular expressions. The pattern that they define is a precondition for a match, although it is not a part of the match result.

### Zero-width negative lookbehind assertions

```regex title="Regex Syntax"
(?<! subexpression)
(?> subexpression)
```

Hte *subexpression* is any regular expression pattern. For a match to be successful, subexpression must not occur at the input string to the left of the current position. However, any substring that does not match subexpression is not included in the match result.

Zero-width negative lookbehind assertions are typically used at the beginning of regular expressions. The pattern that they define precludes a match in the string that follows. They are also used to limit backtracking when the last character or characters in a captured group must not be one or more of the characters that match that group's regular expression pattern.

### Atomic groups

```regex title="Regex Syntax"
(?> subexpression )
```

The *subexpression* is any regular expression pattern.

Ordinarily, if a regular expression includes an optional or alternative matching pattern and a match does not succeed, the regular expression engine can branch in multiple directions to match an input string with a pattern. If a match is not found when it takes the first branch, the regular expression engine can back up or backtrack to the point where it took the first match and attempt the match using the second branch. This process can continue until all branches have been tried.

The `(?>subexpression)` language construct disables backtracking. The regular expression engine will match as many characters in the input string as it can. When no further match is possible, it will not backtrack to attempt alternate pattern matches. (That is, the subexpression matches only strings that would be matched by the subexpression alone; it does not attempt to match a string based on the subexpression and any subexpressions that follow it.)

## Quantifiers

A quantifier specifies how many instances of the previous element (which can be a character, a group, or a character class) must be present in the input string for a match to occur.

- `*`: Matches the previous element zero or more times.
- `+`: Matches the previous element one or more times.
- `?`: Matches the previous element zero or one time.
- `{n}`: Matches the previous element exactly n times.
- `{n}`: Matches the previous element at least n times.
- `{n,m}`: Matches the previous element at least n times, but no more than m times.
- `*?`: Matches the previous element zero or more times, but as few times as possible.
- `+?`: Matches the previous element one or more times, but as few times as possible.
- `??`: Matches the previous element zero or one time, but as few times as possible.
- `{n}?`: Matches the previous element at least n times, but as few times as possible.
- `{n,m}?`: Matches the previous element between n and m times, but as few times as possible.

## Alternation Constructs

Alternation constructs modify a regular expression to enable either/or matching.

- `|`: Matches any one element separated by the vertical bar (`|`) character.

## Backreference Constructs

A backreference allows a previously matched subexpression to be identified subsequently in the same regular expression.

`\number`: Backreference. Matches the value of a numbered subexpression.
`\k<name>`: Named backreference. Matches the value of a named expression.

## Substitutions

Substitutions are regular expression language elements that are supported in replacement patterns.

- `$ number`: Substitutes the substring matched by group number.
- `${ name }`: Substitutes the substring matched by the named group name.
- `$$`: Substitutes a literal "$".
- `$&`: Substitutes a copy of the whole match.
- $`: Substitutes all the text of the input string before the match.
- `$'`: Substitutes all the text of the input string after the match.
- `$+`: Substitutes the last group that was captured.
- `$_`: Substitutes the entire input string.

## Special Constructs

- `(.*)`: Matches anything
- `(.*?)`: Matches anything, but as few times as possible
- `(?# comment )`: code comment, can be in the middle of the pattern

Brackets escapes:

- `\(`
- `\)`
- `\[`
- `\]`

Special characters escapes:

- `\a`
- `\b`
- `\f`
- `\n`
- `\r`
- `\t`
- `\u`
- `\U`
- `\v`
- `\x`
- `\\`
- `\?`
- `\*`
- `\+`
- `\.`
- `\^`
- `\$`
