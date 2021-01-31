# String Module Cheat Sheet

## TEMPLATE STRINGS

Template strings support $-based substitutions, using the following rules:

`$$` is an escape; it is replaced with a single `$`.

`$identifier` names a substitution placeholder matching a mapping key of "identifier".  
By default, "identifier" is restricted to any case-insensitive ASCII alphanumeric string (including underscores) that starts with an underscore or ASCII letter.  
The first non-identifier character after the $ character terminates this placeholder specification.

`${identifier}` is equivalent to `$identifier`.  
It is required when valid identifier characters follow the placeholder but are not part of the placeholder.
Any other appearance of `$` in the string will result in a `ValueError` being raised.  
The string module provides a Template class that implements these rules.

```python
from string import Template

# The methods of Template are:
string.Template(template)  # The constructor takes a single argument which is the template string.

substitute(mapping={}, **kwargs)
# Performs the template substitution, returning a new string.
# mapping is any dictionary-like object with keys that match the placeholders in the template.
# Alternatively, you can provide keyword arguments, where the keywords are the placeholders.
# When both mapping and kwds are given and there are duplicates, the placeholders from kwds take precedence.

safe_substitute(mapping={}, **kwargs)
# Like substitute(), except that if placeholders are missing from mapping and kwds,
# instead of raising a KeyError exception, the original placeholder will appear in the resulting string intact.
# Also, unlike with substitute(), any other appearances of the $ will simply return $ instead of raising ValueError.
# While other exceptions may still occur, this method is called “safe” because it always tries to return a usable string instead of raising an exception.
# In another sense, safe_substitute() may be anything other than safe, since it will silently ignore malformed templates containing dangling delimiters, unmatched braces, or placeholders that are not valid Python identifiers.
```
