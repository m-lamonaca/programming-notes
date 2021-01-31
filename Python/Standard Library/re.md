# Regex Module Cheat Sheet

Compile a regular expression pattern into a regular expression object, which can be used for matching.

```py
regex_obj = re.compile(r"")  # raw string doesn't escapes special caracters

# cerca la corrispondenza con REGEX_OBJ nella stringa
match_obj = regex_obj.search(stringa)  # -> oggetto Match

# cerca la corrispondenza con REGEX_OBJ all'inizio della stringa
# se non vi sono corrispondenze l'oggetto match ha valore NONE
match_obj = regex_obj.match(stringa)  # -> oggetto Match

# l'intera stringa eve corrispondere a REGEX_OBJ
# se non vi sono corrispondenze l'oggetto match ha valore NONE
match_obj = regex_obj.fullmatch(stringa)  # -> oggetto Match

# restituisce tutte le sottostringhe corrispondenti a REGEX_OBJ in una lista.
# In caso non ve ne siano la lista è vuota
# se nel pattern sono presenti due o più gruppi verrà restituita una lista di tuple.
# Solo il contenuto dei gruppi vine restituito.
regex_obj.findall(stringa)  

# suddivide le stringhe in base a REGEX_OBJ, caratteri cercati non riportati nella lista
regex_obj.split(pattern, stringa)

# sostituisce ogni sottostringa corrispondente a REGEX_OBJ con substringa
regex_obj.sub(substringa, stringa)
```

## Match Objects

L'oggetto match contiene True/None, info sul match, info su string, REGEX usata e posizione della corrispondenza

```python
match_obj.group([number])  # restituisce la stringa individuata, [number] selezione il sottogurppo della REGEX
match_obj.groups()  # Return a tuple containing all the subgroups of the match
match_obj.start()  # posizione inizio corrispondenza
match_obj.end()  # posizione fine corrispondenza
```

## Regex Configuration

```python
re.compile(r"", re.OPTION_1 | re.OPTION_2 | ...)  # specify options

# Allows regex that are more readable by allowing visually separate logical sections of the pattern and add comments.
re.VERBOSE

# Make the '.' special character match any character at all, including a newline. Corresponds to the inline flag (?s).
re.DOTALL
re.IGNORECASE
re.MULTILINE
```
