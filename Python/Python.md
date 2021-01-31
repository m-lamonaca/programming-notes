# Python Notes

## Basics

```py
#!/usr/bin/env python

# commento standard
'''commento multilinea'''
"""DOCSTRING"""

'''
NAMING CONVENTION
Class --> PascalCase
Method, Function --> snake_case
Variable --> snake_case
'''

help(oggetto.metodo)  # restituisce spiegazione metodo
dir(object)  # return an alphabetized list of names comprising (some of) the attributes of the given object

import sys # importa modulo
from sys import argv # importa singolo elemento da un modulo
from sys import * # importa tutti gli elementi di un modulo (non cecessaria sintassi modulo.metodo)
import sys as alias # importa il modulo con un alias, utilizzo alias.metodo

# SET CARATTERI
import string
string.ascii_lowecase = 'abcdefghijklmnopqrstuvwxyz'
string.asci_uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.asci_letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
string.digits = '0123456789'
string.hexdigits = '0123456789abcdefABCDEF'
string.octdigits = '01234567'
string.punctuation
string.whitespace

# CARATTERI SPECIALI
# (\a, \b, \f, \n, \r, \t, \u, \U, \v, \x, \\)
```

### Operazione Assegnamento

```py
"""istruzioni a dx di = eseguite prima di istruzioni a sx di ="""
variabile = espressione # il tipo della variabile viene deciso dianmicamente da python in base al contenuto
var_1, var_2 = valore1, valore2  # assegnamento parallelo
var_1, var_2 = var_2, var_1  # swap valori

# conditional assignement
x = a if condition else b
x = a or b  # If bool(a) returns False, then x is assigned the value of b
# a series of OR expressions has the effect of returning the first item that evaluates True, or the last item (last item sould be a literal).
```

### Conversione Tipo Variabile

`tipo(espressione)`

### Assegnamento Espressioni

```py
(var := expressione)  # assegna ad una variabile un espressione per evitare di ripetere l'espressione
```

### Confronto Variabili (`==` vs `is`)

`==` confronta i valori degli oggetti
`is` compara le identità degli oggetti

### Output Su Schermo

```py
print() # stampa linea vuota e va a capo
print('stringa'*n) # stampa stringa n volte
print('stringa1 \n stringa2') # va a capo con \n
print(variabile) # stampa contenuto variabile
print('stringa', end='') # stampa senza andare a capo

# FORMATTAZIONE
name = 'Alex'
marks = 94.5
print(name, marks)
print('Name is', name, '\nMarks are', marks)
# espande il resto dell'espressione e scrive teso prima di = in output
print(f'{name=}, {marks=}')  # OUTPUT: name=Alex, marks=94.5

# USO DEI PLACEHOLDER
print('Name is %s,  Marks are %3.2f' % (name, marks))  # metodo ereditato da C. La variabile viene sostituita al posto di %..
print("Name is {}, Marks are {}".format(name, marks))
print("Name is {1}, Marks are {2}".format(marks, name))  # indici in parentesi odrinano elementi in .format
print("Name is {n}, Marks are {m}".format(m = '94.5', n = 'Alex'))  # indici in parentesi odrinano elementi in .format
print(f'Name is {name}, Marks are {marks}')   # formattazione con f-strings
```

### Format Specification Mini-Language

`{value:width.precision symbol}`
`width.precision` => numeroCifreTottali.numeroCifreDecimali

Format: `[[fill]align] [sign] [#] [width] [grouping] [.precidion] [type]`

OVVERRIDE __format__()
{!a} | chiama ascii() sulla variabile
{!r} | chiama repr() sulla variabile
{!s} | chiama str() sulla variabile

RIEMPIMENTO [fill]
{<qualsiasi_carattere>}

| `[align]` | Allinemanto            |
| --------- | ---------------------- |
| `:<`      | allinemaneto sininstra |
| `:>`      | allinemento destra     |
| `:=`      | padding dopo il segno  |
| `:^`      | centrato               |

| `[sign]` | SEGNI NUMERI                                                                                                   |
| -------- | -------------------------------------------------------------------------------------------------------------- |
| `:+`     | segno sia per numeri positivi che negativi                                                                     |
| `:-`     | segno solo per numeri negativi                                                                                 |
| `:`      | spazio per num > 0, '-' per num < 0                                                                            |
| `:#`     | forma alternativa: interi prefisso tipo (0x, 0b, 0o), float e complessi hanno sempre almeno una cifra decimale |

| `[grouping]` | RAGGRUPPAMENTO                       |
| ------------ | ------------------------------------ |
| `:,`         | usa virgola per separare migliaia    |
| `:_`         | usa underscore per separare migliaia |

| `[type]` | TIPO OUTPUT                                                                    |
| -------- | ------------------------------------------------------------------------------ |
| `:s`     | output è stringa                                                               |
| `:b`     | output è binario                                                               |
| `:c`     | output è carattere                                                             |
| `:d`     | output è intero decimale (base 10)                                             |
| `:o`     | output è intero ottale (base 8)                                                |
| `:x`     | output è intero esadecimale (base 16)                                          |
| `:X`     | output è intero esadecimale (base 16) con lettere maiuscole                    |
| `:e`     | output è notazione esponenziale (precisione base 6 cifre)                      |
| `:E`     | output è notazione esponenziale (precisione base 6 cifre) separatore maiuscolo |
| `:f`     | output è float (precisione base 6 cifre)                                       |
| `:%`     | output è percentuale (moltiplica * 100, diplay come :f)                        |

### Input Da Tastiera

```py
# input ritorna sempre una STRINGA
s = input() # richiesta input senza messaggio
s = input('Prompt') # richiesta imput
i = int(input('prompt')) # richiesta input con conversione di tipo

# INPUT MULTIPLI
lista = [int(x) for x in input('prompt').split('separatore')]
# salva input multipli in una lista (.split separa i valori e definisce il separatore
```

## Tipi Numerici

```py
a = 77
b = 1_000_000  # underscore può essere usato per seoarare gruppi di cifre
c = -69

# float numbers
x = 3.15
y = 2.71
z = 25.0

d = 6 + 9j  # complex number
# restituisce un numero complesso a partire da due reali
complex(real, imag)  # -> complex  # (real + imag * 1j)

e = 0B1101  # BINARY TYPE (0B...)
f = 0xFF  # EXADECIMAL TYPE(0X...)
o = 0o77  # OCTAL TYPE
g = True  # BOOLEAN TYPE

# CONVERSIONE TIPO VARIABILE
h = int(y)
i = float('22.5')

# CONVERSIONE BASE NUMERICA
bin(3616544)
hex(589)
oct(265846)

# COVERSIONE UNICODE
ord(c)  # Given a string representing one Unicode character, return an integer representing the Unicode code point of that character
chr(i)  # Return the string representing a character whose Unicode code point is the integer i


pow(x, y)  # x^y
abs(num)  # ritorna valore assoluto di num (|num|)
round(num, precisione)  # arrotonda il numero alla data precisione, non converte float to int
```

### Confronto Numeri Decimali

Non usare `==` o `!=` per confrontare numeri in virgola mobile. Essi sono approssiamazioni o hanno parecchie cifre.  
Conviene verificare se la differenza tra i numeri è sufficientemente piccola.

## Stringhe

```py

stringa = 'contenuto stringa' # asegnazione e creazione variabile stringa
stringa = '''multi
line
string'''

stringa3 = stringa1 + stringa2 # concatenazione stringhe (polimorfismo operatore +)

# INDEXING (selezione di un carattere nella srtinga)
stringa[0]
stringa[2]
stringa[-3]  # selezione partendo dal fondo (indice negativo)

# REPETITION (ripetizione output stringa)
print(stringa  * n)

len(stringa) # mostra la lunghezza di una stringa

# SLICING (estrazione di sottostringhe, non include la posizione dell'ultimo indice)
stringa[0:5]
stringa[:6]
stringa[-3:-1]

# SLICING CON STEP
stringa[0:12:3]
stringa[15::-1]
stringa[::-1] # selezione in ordine inverso (step negativo)

# STRIPPING (eliminazione spazzi prima e dopo stringa)
stringa='   stripping test   '
stringa.strip()
stringa.lstrip() # solo spazi a sinistra rimossi
stringa.rstrip() # solo spazi a destra rimossi
stringa.removeprefix(prefix)  # If the string starts with the prefix string, return string[len(prefix):]
stringa.removesuffix(suffix)  # If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]

# INDIVIDUAZIONE SOTTOSTRINGA
#ritorna indice di partenza della sottostringa o -1 se essa non è  presente
stringa.find('sottostringa', 0, len(stringa)) # si può specificare l'indice di partenza e fine della ricerca

# CONTEGGIO APPARIZIONI
stringa.count('t')

# RIMPIAZZO
stringa.replace('multi', 'multiple')

# CONVERSIONE MAIUSCOLO-MINUSCOLO
stringa.upper()
stringa.lower()
stringa.title()
stringa.capitalize()

# SEPARAZIONE IN ELEMENTI LISTA
stringa.split()
stringa.split('separatore')  # separa usando il separatore (separatore omesso nella lista)
stringa.partition('char')  # -> tuple   # sepra la stringa i 3 parti alla prima occorrenza di separatore

# METODI IS_CHECK --> bool
stringa.isalnum()
stringa.isalpha()
stringa.islower()
stringa.isspace()
stringa.istitle()
stringa.isupper()
stringa.endswith('char')

# ISTRUZIONE JOIN()
''.join(iterabile)  # unisce tutti gli elementi dell'iterabile nella nuova stringa

# FORMATTING
string.center(larghezza, 'char')  # allarga la stringa con char fino a raggiungere larghezza
'...\t...'.expandtabs()  # trasforma tabs in spaces
```

## Liste

```py
lista = [9, 11, 'WTC', -5.6, True] # le liste possono contenere dati di tipo diverso

lista[3] # indexing
lista[3:5] # slicing
lista * 3 # repetition
len(lista) # lenght
lista3 = lista1 + lista2 # concatenazione liste (polimorfismo operatore +)
lista[indice] = valore  # modifica elemento lista
del(lista[1]) # rimozione per indice (INBUILT IN PYTHON)
# modifica la lista tra gli indici start e stop riasegnando gli elementi dell'iterabile
lista[start:stop] = iterabile

# METODI LISTE
lista.append(oggetto)  # aggiunge oggetto al fondo
lista.count(item)  # conta il numero di occorrenze di item
lista.extend(sequenza)  # aggiunge gli elementi di sequenza alla lista
lista.insert(posizione, oggetto)  # inserise oggetto in lista[posizione]
lista.index(item)  # restituisce l'indice di item
lista.remove(item)  # rimuove item
lista.pop(item)  # elimina item e lo restituisce
lista.clear()  # rimozione di tutti gli elementi

lista.sort()  # sorts in ascending order (in place)
lista.sort(reverse = True) # sorts in descending order  (in place)
lista.reverse()  # inverte la stringa (in place)

# CLONING
list1 = [...]
list2 = list1  # list2 points to the same object of list 1 (changes are shared)
list3 = list1[:]  # list3 is a clone of list1 (no shared changes)

# LISTE ANNIDATE (MATRICI)
lista_1 = [1, 2, 3]
lista_2 = [4, 5, 6]
lista_3 = [7, 8, 9]

matrice = [lista_1, lista_2, lista_3]
matrice[i][j]  # identifica elemento di lista_i indice j

# MASSIMO E MINIMO
max(lista)
min(lista)

# ALL() & ANY()
all(sequenza)   # ritorna TRUE se tutti gli elementi della sequenza hanno valore True
any(sequenza)   # ritorna TRUE se almeno un elemento della sequenza ha valore True

# ISTRUZIONE MAP
# applica la funzione all'iterabile e crea una nuova lista (oggetto map)  
# funzione può essere lambda
map(funzione, iterabile)  # -> oggetto map

# ISTRUZIONE FILTER()
# crea una nuova lista composta dagli elementi di iterabile per cui la funzione ritorna TRUE
filter(funzione, iterabile)  # -> oggetto filter

# ISTRUZIONE ZIP()
# crea una generatore di tuple unendo due o più iterabili
# [(seq_1[0], seq_2[0], ...), (seq_1[1], seq_2[1], ...), ...]
# tronca la sequenza alla lunghezza della sequenza input più corta
zip(seq_1, seq_2, ...)  # -> oggetto zip (generatore di tuple)

# LIST COMPREHENSIONS
var = [espressione for elemento in sequenza if condizione] # crea lista da lista pre-esistente (al posto di map, filter, reduce) applicando eventuali manipolazioni
# l'espressione può essere una lambda, l'if è opzionale
var = [espresione if condizione else istruzione for elemento in sequenza]  # list comprehension con  IF-ELSE
var = [espressione_1 for elemento in [espressione_2 for elemento in sequenza]]  # list comprehension annidata
var = [(exp_1, exp_2) for item_1 in seq_1 for item_2 in seq_2]  # --> [(..., ...), (..., ...), ...]
```

## Tuple

```py
# LE TUPLE NON POSSONO ESSERE MODIFICATE
tuple = (69, 420, 69, 'abc') # assegnazione tuple
tuple = (44, ) # tuple di signolo elemento necessitano di una virgola

tuple[3] # indexing
tuple * 3 # repetition
tuple.count(69) # counting
tuple.index(420) # individuazione indice
len(tuple) # lunghezza tuple

# CONVERSIONE DA TUPLE A LISTA
tuple = tuple(lista)

# TUPLE UNPACKING
tup = (item_1, item_2, etc)
var_1, var_2, etc = tup
# var_1 = item_1, var_2 = item_2, ...

tup = (item_1, (item_2, item_3))
var_1, (var_2, var_3) = tup
# var_1 = item_1, var_2 = item_2, var_3 = item_3

#OPERATORE *VAR (tuple unpacking)
var_1, var_2, *rest = sequenza  #  var_1 = seq[0], var_2 = seq[1], rest = seq[2:]
var_1, *body, var_2, var_3 = sequeza  # var_1 = seq[0], body = seq[1:-2], var_2 = sequenza[-2], var_3 = seq[-1]
# *var recupera gli item in eccesso, se in assegnamento parallelo usabile max una volta ma in posizione qualsiasi
```

## Set

```py
# I SET NON POSSONO CONTENERE ELEMENTI RIPETUTI (VENGONO OMESSI)
# L'ORDINE NON IMPORTA (NO SLICING, INDEXING, REPETITION, ...)
set = {10, 20, 30, 'abc', 20}
len(set)  # lunghezza set
set()  # crea set vuoto ({} cre dizionario vuoto)
# FREEZING SETS (non più modificabili)
fset = frozenset(set)

# OPERATORI
set_1 - set_2  # elementi in set_1 ma non in set_2
set_1 | set_2  # elementi in set_1 o set_2
set_1 & set_2  # elementi in set_1 e set_2
set_1 ^ set_1  # elementi in  o set_1 o set_2
set_1 <= set_2  # elementi set_1 anche in set_2
set_1 < set_2  # set_1 <= set_2 and set_1 != set_2
set_1 >= set_2  # elementi set_2 anche in set_1
set_1 > set_2  # set_1 >= set_2 and set_1 != set_2

# METODI SET
set.pop(item)  # rimuove e restituisce item
set.add(item)  # aggiunge item al set

set.copy()  # -> set  # restituisce una copia del set
set.clear()  # rimuove tutti gli elementi dal set
set.remove(item)  # rimuove item dal set se presente, altrimenti solleva KeyError
set.discard(item)  #rimuove item dal set se presente, altrimenti fa nulla
set.difference(*sets)  # -> set  # restituisce elementi in set che sono assenti in *sets
set.difference_update(*sets)  # rimuove le differenze dal set_2
set.union(*sets)  # -> set  # restituisce tutti gli elemnti dei set
set.update(*sets)   # aggiunge elementi *sets a set
set.intersection(*sets)  # -> set  # restituisce gli elementi comuni ai set
set.intersection_update(*sets)  # rimuove tutti gli elementi tranne quelli comuni ai set
set.symmetric_difference(*sets)  # -> set  # restituisce gli elementi non comuni ai set
set.symmetric_difference_update(*sets)  # rimuove tutti gli elementi comuni ai set (lasci solo gli elementi non comuni)

set_1.isdisjoint(set_2)  # -> bool  # True se non ci sono elementi comunni (intersezione è vuota)
set_1.issubset(set_2)  # -> bool  # True se ogni elemento di set_1 è anche in set_2
set_1.issuperset(set_2)  # -> bool  # True se ogni elemento di set_2 è anche in set_1

# SET COMPREHENSIONS
var = {espressione for elemento in sequenza if condizione}

# OGGETTO SLICE
# [start:stop:step] --> oggetto slice(start, stop, step)
var_1 = slice(start, stop, step)  # assegnamento a variabile
var_2[var_1]  # uguale a var_2[start:stop:step]

# OGGETTO ELLIPSIS
var[i, ...]  # --> shortcut per var[i , :, : ,:,]
# usato per slice multidimensionale (NumPy, ...)
```

## Bytes e Bytearray

```py
# I  BYTE NON SI POSSONO MODIFICARE NE INDICIZZARE
# I BYTEARRAY SI POSSONO MODIFICARE E INDICIZZARE
# NON SI PUO' FARE REPETITION E SLICING SU BYTE O BYTEARRAY

b = bytes(lista)
ba = bytearray(lista)

# item di bytes e bytearray è sempre intero tra 0 e 255
# slice di bytes e bytearray è sequenza binaria (anche se len = 1)

# METODI BYTES E BYTEARRAY
bytes.fromhex(pair_hex_digits)  # -> byte literal
b'bite_literal'.hex()  # -> str  # restituisce una stringa contenente coppie di cifre hex
bytearray.fromhex(pair_hex_digits)  # -> byte literal
bytes.count(subseq, start, end)  # restituisce conteggio apparizioni subseq tra posizioni start e end
bytearray.count(subseq, start, end)  # restituisce conteggio apparizioni subseq tra posizioni start e end
```

## Encoding-Decoding & Unicode

BYTE LITERALS
ASCII --> stesso carattere
tab, newline, carriage return, escape sequence --> \t, \n, \r, \\
altro --> escape sequence exadeciamle (null byte --> \x00)

Unicode Literals:

- `\u0041` --> 'A'
- `\U00000041` --> 'A'
- `\x41` --> 'A'

```py
# ENCODING
# trasforma stringa in byte literal
# errors= |> UnicodeEncodeError in caso di errore
# errors=ignore --> salta caratteri causanti errore
# errors=replace --> sostituisce ? a caratteri causanti errore
# errors=xmlcharrefreplace --> sostituisce entità XML a caratteri causanti errore
stringa.encode('utf-8', errors='replace')  # -> b'byte literals'

# BOM (BYTE ORDER MARK)
# byte literal premesso per indicare l'ordinamento dei byte (little-endian vs big-endian)
# in little-endian i byte meno significativi vengono prima (e.g. U+0045 --> DEC 069 --> encoded as 69 and 0)
# U+FEFF (ZERO WIDTH NO-BREAK SPACE) --> b'\xff\xfe' indica little-endian

# DECODING
# trasforma byte literal in stringa
# error='replace' sostituisce gli errori (byte literal non appartenentia formato di decodifica) con U+FFFD "REPLACEMENT CHARARCTER"
bytes.decode('utf-8', errors='replace')  # -> str

# NORMALIZZAZIONE UNICODE
# gestione equivalenti canconici unicode (e.g. é, e\u0301 sono equivalenti per unicode)
import unicodedata
unicodedata.normalize(form, unicode_string)  # FORM: NFC,NFD, NFCK, NFDK
# NFC --> "Normalization Form C" --> produce la stringa equivalente più corta
# NFD --> "Normalization Form D" --> produce la stringa equivalente più lunga

# CASE FOLDING UNICODE
# trasforma in minuscolo con alcune differenze (116 differenze, 0.11% di Unicode 6.3)
stringa.casefold()

# FUNZIONI UTILI PER EQUIVALENZA NORMALIZZATA (Source: Fluent Python p. 121, Luciano Ramalho)
from unicodedata import normalize
def nfc_eual(str_1, str_2):
    return (normalize('NFC', str1) == normalize('NFC', str2))
def fold_equal(str_1, str_2):
    return (normalize('NFC', str_1).casefold() ==
            normalize('NFC', st_2).casefold())
```

## Memoryview

```py
# oggetti memoryview consentono a python l'accesso ai dati all'interno dell'oggetto
#  senza copia se esso supporta il buffer protocol
v = memoryview(oggetto)  # crea un memoryview con riferimento ad oggetto
# slice di memoryview produce nuovo memoryview

# METODI MEMORYVIEW
v.tobytes()  # restituisce i dati come bytestring, equivale a bytes(v)
v.hex()  # restituisce stringa contenete du cifre hex per ogni byte nel buffer
v.tolist()  # restituisce i dati nel buffer come un lista di elementi
v.toreadonly()
v.release()  # rilascia il buffer sottostante
v.cast(format, shape)  # cambia il formato o la forma del memoryview
v.oggetto  # oggetto del memoryview
v.format  # formato del memoryview
v.itemsize  # dimensione in byte di ogni elemento del memoryview
v.ndim  # intero indicante le dimensioni dell'array multidimensionale rappresentato
v.shape  # tuple di interi indicanti la forma del memoryview
```

| Format String | C Type               | Python Type | Standard Size |
| ------------- | -------------------- | ----------- | ------------- |
| `x`           | `pad byte`           | `no value`  |
| `c`           | `char`               | `bytes`     | `1`           |
| `b`           | `signed char`        | `integer`   | `1`           |
| `B`           | `unsigned char`      | `integer`   | `1`           |
| `?`           | `_Bool`              | `bool`      | `1`           |
| `h`           | `short`              | `integer`   | `2`           |
| `H`           | `unsigned short`     | `integer`   | `2`           |
| `i`           | `int`                | `integer`   | `4`           |
| `I`           | `unsigned int`       | `integer`   | `4`           |
| `l`           | `long`               | `integer`   | `4`           |
| `L`           | `unsigned long`      | `integer`   | `4`           |
| `q`           | `long long`          | `integer`   | `8`           |
| `Q`           | `unsigned long long` | `integer`   | `8`           |
| `n`           | `ssize_t`            | `integer`   |
| `N`           | `size_t`             | `integer`   |
| `f`           | `float`              | `float`     | `4`           |
| `F`           | `double`             | `float`     | `8`           |
| `s`           | `char[]`             | `bytes`     |
| `P`           | `char[]`             | `bytes`     |

## Dizionari

```py
# SET OF KEY-VALUE PAIRS
d = {1:'Alex', 2:'Bob', 3:'Carl'}
d = dict(one = 'Alex', two = 'Bob', three = 'Carl')
d = dict(zip([1,2,3],['Alex', 'Bob', 'Carl']))
d = dict([(1,'Alex'), (2,'Bob'), (3,'Carl')])

d[key]  # restituisce valore associato a key
d[4] = 'Dan'  # aggiunge o modifica elemento
list(d)  # restituisce una lista di tutti gli elementi
len(d)  # restituisce il numero di elementi
del(d[2])  # elimina elemento

# METODI DIZIONARI
d.clear()  # rimuove tutti gli elementi
d.copy()  # copia superficiale del dizionario
d.get(key)  # restituisce il valore associato a key
d.items()  # restituisce coppie key-value (oggetto view)
d.keys()  # restituisce le chiavi del dizionario (oggetto view)
d.values()   # restituisce i valori del dizionario (oggetto view)
d.pop(key)  # rimuove e restituisce il valore associato a key
d.popitem()  # rimuove e restituisce l'ultima coppia key-value
d.setdefault(key, default)  # se la key è presente nel dizionario la restituisce, altrimenti la inserisce con valore default e restituisce default

d.update(iterabile)  # aggiunge o modifica elementi dizionario, argomento deve essere coppia key-value

# DICT UNION
d = {'spam': 1, 'eggs': 2, 'cheese': 3}
e = {'cheese': 'cheddar', 'aardvark': 'Ethel'}

d | e  # {'spam': 1, 'eggs': 2, 'cheese': 'cheddar', 'aardvark': 'Ethel'}
e | d  # {'aardvark': 'Ethel', 'spam': 1, 'eggs': 2, 'cheese': 3}
d |= e # {'spam': 1, 'eggs': 2, 'cheese': 'cheddar', 'aardvark': 'Ethel'}

# DIZIONARI ANNIDATI (possibile annidare dizioanari all'interno di dizionari)
my_dict = {'key_1':123, 'key_2':[12, 23, 33], 'key_3':['item_0', 'item_1', 'item_2']}
my_dict['key'][0]  # restituisce elemento annnidato

# DICT COMPREHENSIONS
var = {key : value for elemento in sequenza}
```

## Operators

### Methematical Operators

| Operator | Operation                      |
| -------- | ------------------------------ |
| x `+` y  | addition, string concatenation |
| x `-` y  | subtraction                    |
| x `*` y  | multiplication                 |
| x `*+` y | exponentiation                 |
| x `/` y  | division (result always float) |
| x `//` y | integer division               |
| x `%` y  | modulo, remainder              |

### Relational Operators

| Operator | Operation           |
| -------- | ------------------- |
| x `<` y  | less than           |
| x `<=` y | less or equal to    |
| x `>` y  | greater than        |
| x `>=` y | greater or equal to |
| x `==` y | equality            |
| x `!=` y | inequality          |

### Assignement

| Operator  | Operation  |
| --------- | ---------- |
| x `+=` y  | x = x + y  |
| x `-=` y  | x = x - y  |
| x `*=` y  | x = x \* y |
| x `/=` y  | x = x / y  |
| x `//=` y | x = x // y |
| x `%=` y  | x = x % y  |
| x `<<=` y | x = x << y |
| x `>>=` y | x = x >> y |
| x `&=` y  | x = x & y  |
| x `|=` y  | x = x | y  |
| x `^=` y  | x = x ^ y  |

### Bitwise Operators

| Operator | Operation       |
| -------- | --------------- |
| `~`x     | bitwise NOT     |
| x `&` y  | bitwise AND     |
| x `^` y  | bitwise XOR     |
| x `|` y  | bitwise OR      |
| x `<<` y | left bit shift  |
| x `>>` y | rigth bit shift |

### Logical Operators

| Operator | Operation   |
| -------- | ----------- |
| `and`    | logical AND |
| `or`     | logical OR  |
| `not`    | logical NOT |

### Identity Operators

| Operator | Operation            |
| -------- | -------------------- |
| `is`     | reference equality   |
| `is not` | reference inequality |

### Membership Operators

| Operator | Operation              |
| -------- | ---------------------- |
| `in`     | item in cooection      |
| `not in` | item not in collection |

### Precedenza Operatori

1. operatori assegnamento `+=`, `-=`, `*=`, `/=`, `%=`, `**=`, `//=`
2. operatori aritmetici binari `*`, `/`, `%`, `//` (floor division)
3. operatori aritmetici binari `+`, `-`
4. operatori booleani `<`, `>` , `<=`, `>=`
5. operatori booleani `==`, `!=`
6. operatore booleano `and`
7. operatore booleano `or`
8. operatore booleano `not`

## Conditional Statements

Any object can be tested for truth value for use in an if or while condition or as operand of the Boolean operations.

built-in objects considered *false*:

- constants defined to be false: `None` and `False`.
- zero of any numeric type: `0`, `0.0`, `0j`, `Decimal(0)`, `Fraction(0, 1)`
- empty sequences and collections: `''`, `()`, `[]`, `{}`, `set()`, `range(0)`

### `if-else` semplice

```py
if (condizione):
    # code here
else:
    # code here
```

### `if-else` multiramo

```py
if (condizione):
    # code here
elif (condizione):
    # code here
else:
    # code here
```

### Context Manager

Oggetto che definisce il contesto di runtime stabilito all'uso del `with` statement. Il manager gestisce l'entrate e l'uscita dal contesto di runtime per l'esecuzione del blocco di codice.

```py
with risorsa as target:
    # code here

# avvia context manager e lega risorsa restituita dal metodo al target usando operatore as
contextmanager.__enter__(self)

# exit runtime context
# restituisce exc_type, exc_value, traceback
contextmanager.__exit__(self, exc_type, exc_value, traceback)
# exc_type: exception class
# exc_value: exception istance
# traceback: traceback object
# NO EXCEPTION -> restituisce None, None, None
# SOPPRESSIONE ECCEZIONE: necessario restituire valore True
```

## Loops

### Ciclo `while`

```py
while (condizione):
    # code here
else:
    # eseguito solo se condizione diventa False
    # break, continue, return in blocco while non eseguono blocco else
    # code here
```

### Ciclo `for`

```py
for indice in sequenza: # sequenza può essere una lista, set, tuple, etc..
    # code here
else:
    # eseguito solo se for arriva a fondo ciclo
    # break, continue, return in blocco for non eseguono blocco else
    # code here

for indice in range(inizio, fine, step):
    # code here

for key, value in dict.items():
    # code here
```

### Istruzioni `break` & `continue`

`break`: causa l'uscita immediata dal ciclo senza l'esecuzione delle successive iterazioni
`continue`: salte le restanti istruzioni del'iterazione e prosegue il ciclo

### Istruzione `range`

```py
range(inizio, fine, step)  # genera sequenza num interi (non include num stop) con eventuale passo
list(range(inizio, fine, passo))  # restituire sequenza num interi in una lista
```

### Istruzione `enumerate`

```py
enumerate(iterabile)  # restituisce oggetto enumerate
list(enumerate(iterabile))  # restituisce lista di tuple [(1, iterabile[0]), (2, iterabile[1]), (3, iterabile[2])]
```

### Istruzione `zip`

```py
list_1 = [1, 2, 3, 4,  5]
lsit_2 = ['a', 'b', 'c', 'd', 'e']

zip(list_1, list_2)  # restituisce oggetto zip
list(zip(list_1, list_2))  # restituisce lista di tuple fondendo la lista [(list_1[0], list_2[0]), (list_1[1], list_2[1]), ...]
```

### Istruzione `shuffle` e `randint`

```py
from random import shuffle, randint
shuffle(iterabile)  # mischia la lista
randint(inizio, fine)  # restituisce un intero random compreso tra inizio e fine
```

### Istruzione `in`

```py
item in iterabile  # controlla presenza di intem in iterabile (restituisce True o False)
```

## Funzioni

### Definizone Funzione

```py
def nome_funzione (parametri):
    """DOCSTRING"""
    # code here
    return espressione  # if return id missing the function returns None
```

### Invocazione Funzione

`nome_funzione(parametri)`

### Specificare Tipo Paremetri In Funzioni

- parametri prima di `/` possono essere solo *posizionali*
- parametri tra `/` e `*`  possono essere *posizionali* o *keyworded*
- parametri dopo `*` possono essere solo *keyworded*
  
```py
def funz(a, b, /, c, d, *, e, f):
    # code here
```

### Docstring Style

```py
""" descrizione funzione

Args:
    argomento: Type - descrizione del parametro

Returns:
    Type - descrizione di <expr>

Raises:
    Eccezione: Causa dell'eccezione
"""
```

### *args **kwargs

`*args` permette alla funzione di accettare un numero variabile di parametri (parametri memorizzati in una tuple)
`**kwargs` permetta alla funzione di accettare un numero variabile di parametri key-value (parametri memorizzati in un dizionario)
Se usati in combinazione `*args` va sempre prima di `**kwargs` (in def funzione e in chiamata funzione)

```py
def funzione(*args, **kwargs):
    # code here
```

### Funzione con Parametri di default

```py
def funzione (parametro1 = valore1, parametro2 = valore3): # valori di default in caso di omesso uso di argomenti nella chiamata
    # code here
    return espressione

funzione(parametro2 = valore2, parametro1 = valore1) # argometi passati con keyword per imporre l'ordine di riferimento
```

### VARIABILI GLOBALI E LOCALI

```py
# global scope
def funz_esterna():
    # enclosing local scope
    # code here
    def funz_interna():
        # local scope
        # code here
```

**LEGB Rule**:

- **L** - **Local**: Names assigned in any way within a function (`def` or `lambda`), and not declared global in that function.
- **E** - **Enclosing function locals**: Names in the local scope of any and all enclosing functions (`def` or `lambda`), from inner to outer.
- **G** - **Global** (module): Names assigned at the top-level of a module file, or declared global in a def within the file.
- **B** - **Built-in** (Python): Names preassigned in the built-in names module : `open`, `range`, `SyntaxError`,...

`Note`: variabili dichiarate all'interno di una funzione non sono utilizzabili all'esterno

```py
def funzione():
    # istruzione global rende variabile globale.
    # azioni su variabile globale all'interno della funzione hanno effetto anche fuori
    # NORMALMENTE: valori locali rimangono locali
    global variabile
    # code here
```

### Iteratabili, Iteratori E Generatori

**Iterabile**: oggetto implementante `__iter__()`, sequenze e oggetti supportanti `__getitem__` con index `0`

**Iteratore**: oggetto implementante `__next__` e `__iter__` (**protocollo iteratore**), quando interamente consumato da next() diventa inutilizablie.
Gli iteratori sono iterabili, viceversa non vero. Restituisce `StopIteration` quando `next()` ha restituito tutti gli elementi.

**Funzione Generatore**: funzione con keyword `yield` (se presente anche `return` causa `StopIteration`), restituisce un generatore che produce i valori uno alla volta.

**Generator Factory**: funzione restituente generatore (può non contenere `yield`).

Funzionamento `iter()`:

- chiama __iter__()
- in assenza di esso python sfrutta __getitem__() (se presente) per creare un iteratore che tenta di recuperare gli item in ordine, partendo dall'indice `0`
- in caso di fallimento resituisce `TypeError "obj_cls is not iterable"`
  
**Note**: `abc.Iterable` non controlla la presenza di `__getitem__` per decidere se un sotto-oggetto è membro conseguentemente il miglior test per l'iterabilità è usare `iter()` e gestirne le eccezioni.

### Istruzioni `next()` & `iter()`

```py
next(iterabile)  # prossimo item dell'iterabile o errore StopIteration

iter(oggetto)  # ottiene un iteratore a partire da un oggetto
# chiama callable_onj.next() senza argomenti finche esso restituisce valori diversi da sentinella

iter(callable_obj, sentinella)
```

### Generatori Personalizzati

Utilizzati per generare una sequenza di valori da utilizzare una sola volta (non vengono memorizzati)

```py
def custom_generator (parametri):
    while condizione:  # oppure for loop
        yield variabile # restituisce il valore senza terminare la funzione, valori passati al chiamante senza memorizzazione in una variabile

# implementazione generatore
for item in custom_generator(parametri):
    # code here
```

### Terminazione Generatore E Exception Handling

```py
# solleva eccezione al punto di sospensione e restituisce valore del generatore
# se il generatore termina senza restituire valori solleva StopIteration
# se un eccezione non viene gestita viene propagata al chiamante
generator.throw(ExceptionType, exceptio_value, traceback)

# solleva GeneratorExit al punto si sospensione
# se generatore restituisce un valore -> RuntimeError
# se viene sollevata unn eccezione essa si propaga al chiamante
generator.close()
```

### Generator Comprehensions

```py
# sequenza di lunghezza zero (valori generati sul momento)
var = (espressione for iterabile in sequenza if condizione)
# ISTRUZIONE ENUMERATE()
# restituisce una lista di tuple associando ad ogni elemendo della sequenza un indice di posizione
# [(0, sequenza[0]), (1, sequenza[1]), (2, sequenza[2]), ...)
enumerate(sequenza)  # -> oggetto enumerate
```

## Coroutine

```py
def simple_coroutine():
    """coroutine definita come un generatore: yield nel blocco"""
    # code here
    # yield in espressione per ricevere dati
    # restituisce None (no variabili a dx di yield)
    var = yield value  # restituisce value e poi sospende coroutine in attesa di input
    # istruzioni a dx di = eseguite prima di istruzioni a sx di =
    # code here

gen_obj = simple_coroutine()  # restituisce oggetto generatore
next(gen_obj)  # avvia coroutine (PRIMING)
gen_obj.send(None)   # avvia coroutine (PRIMING)
gen_obj.send(value)  # invia value alla coroutine (possibile solo in stato suspended)

# STATI DELLA COROUTINE
inspect.generatorstate()  # restituisce lo stato della coroutine
# GEN_CREATED: in attesa di avvio esecuzione
# GEN_RUNNING: attualmente eseguito dall'interprete (visibile se multithreading)
# GEN_SUSPENDED: attualmente sospesa da yield statement
# GEN_CLOSED: l'esecuzione è stata completata

# COROUTINE PRIMING
from functools import wraps
def coroutine(func):
    "Decorator: primes 'func' by advancing to first 'yield'"
    @wraps(func)
    def primer(*args, **kwargs):
        gen = func(*args, **kwargs)
        next(gen)
        return gen
    return primer

# TERMINAZIONE COROUTINE E EXCEPTION HANDLING
# eccezioni in coroutine non gestite si propagano alle iterazioni successive
# un eccezione causa la tarminazione della coroutine che non puo riprendere

# yield solleva eccezione, se gestita ciclo continua
# throw() restituisce valore del generatore
coroutine.throw(exc_type, exc_value, traceback)

# yield solleva GeneratorExit al punto di sospensione
# se il generatore restituisce (yield) un valore -> RuntimeError
# se ci sono altre eccezioni esse vengono propagate al chiamante
coroutine.close()
# stato coroutine diventa GEN_CLOSED
```

### `yield from <iterabile>`

**Note**: auto-priming generators incomplatible with `yield from`

**DELEGATING GENERATOR**: funzione generatore contenente yield from
**SUBGENERATOR**: generatore ottenuto da `yield from <iterabile>`
**CALLER-CLIENT**: codice chiamante *delegating generator*

La funzione principale di `yield from` è aprire una canale bidirezionale tra il chiamante esterno (*client*) e il *subgenerator* interno in modo che valori ed eccezioni possono passare tra i due.

1. client chiama delegating generator, delegating generator chiama subgenerator
2. subgenerator esaurito restituisce valore a `yield from <expr>` (istruzione `return <result>`)
3. delegating generator restituisce `<expr>` a client

- Any values that the subgenerator yields are passed directly to the caller of the delegating generator (i.e., the client code).

- Any values sent to the delegating generator using `send()` are passed directly to the subgenerator.
  - If the sent value is `None`, the subgenerator’s `__next__()` method is called.
  - If the sent value is not `None`, the subgenerator’s `send()` method is called.
  - If the call raises `StopIteration`, the delegating generator is resumed.
  - Any other exception is propagated to the delegating generator.

- `return <expr>` in a generator (or subgenerator) causes `StopIteration(<expr>)` to be raised upon exit from the generator.

- The value of the `yield from` expression is the first argument to the `StopIteration` exception raised by the subgenerator when it terminates.

- Exceptions other than `GeneratorExit` thrown into the delegating generator are passed to the `throw()` method of the subgenerator.
  - If the call raises `StopIteration`, the delegating generator is resumed.
  - Any other exception is propagated to the delegating generator.

- If a `GeneratorExit` exception is thrown into the delegating generator, or the `close()` method of the delegating generator is called, then the `close()` method of the subgenerator is called if it has one.
  - If this call results in an exception, it is propagated to the delegating generator.
  - Otherwise, `GeneratorExit` is raised in the delegating generator

```py
def sub_gen():
    # code here
    sent_input = yield
    # code here
    # risultato di sub_gen() restituito a delegating_gen()
    # risultato di yield from <expr>
    return result

def delegating_gen(var):
    # code here
    var = yield from sub_gen()  # get values from sub_gen

def client():
    # code here
    result = delegating_gen()  # use delegating_gen
    result.send(None)  # termina istanza sub_gen (IMPORATNTE)
```

## Ricorsione

Il nucleo della ricorsione deve essere costituito da un'istruzione condizionale che permette di gestire casi diversi in base al parametro del metodo.
Almeno una delle alternative deve contenere una chiamata ricorsiva del metodo, questa deve risolvere versioni ridotte del compito realizzato dal metodo.
Almeno una delle alternative non deve contenere alcona chiamata ricorsiva o deve produrre il valore da restituire, tali alternative costituiscono i casi base o di arresto

Example:

```py
def factorial(n):
    if (n == 0):
        result = 1 # escape event, necessary to avoid infinite recursion
    else:
        result = (n*factorial(n-1))
    return result

num = int(input('Enther a number to calculate it\'s factorial:'))
print(factorial(num))
```

## Funzioni Avanzate

### Assegnazione Di Funzioni A Variabili

```py
def funzione(parametri):
    # code here

    return espressione

# chiamata funzione senza parentesi
funzione   # restituisce oggetto funzione
var = funzione  # assegna (per riferimento) la funzione ad una variabile.
# la chiamata funziona anche se la funz originale viene eliminata (del funzione)
var()  # chiama la funzione tramite la variabile (usando le parentesi tonde)
```

### Funzioni Annidate

```py
# funz_interna locale viene ritornata per riferimento
def funz_esterna(args):

    def funz_interna():  # funz_interna ha accesso a scope funzione esterna (aka Closure)
        # code here
    return funz_interna  # restituisce funz_interna

funz_esterna()  # chiamata funz_esterna che chiama funz_interna (risultato funz_esterna è riferimento funz_interna)
```

### Funzioni Passate Per Argomento

```py
# funzione passata come argomento viene eseguita (chiamata) all'esecuzione della funzione a cui viene passata
def funz_esterna(funzione):
    funzione()  # chiama funzione passata come argomento

funz_esterna() # esecuzione funz_esterna chiama funz_interna
```

### Funzioni Incapsulanti Funzioni (Argomenti Wrapper = Argomenti Wrapped)

```py
def wrapped(*args):
    pass

def wrapper(*args):
    # instructions
    wrapped(*args)  # wrapped chiamata con gli argomeni passati a wrapper AS-IS (args = tupla) senza incapsulamento in una tupla
```

## LAMBDA Functions

Possibile uso all'interno delle funzioni. Utile per sostituire funzioni se la logica è semplice.

```py
var = lambda argument_list: expression
var = lambda argument_list: caso-vero if (condizione) else cado-falso

var(args) # invocazione lambda
```

## Decoratori

Entita' chiamabile che prende in input una funzione (come argomento).
Eventualmente effettua operazioni con la funzione decorata e la restituisce o sostituisce.
vengono eseguiti all'importazione, prima di ogni altra istruzione.

```py
# STRUTTURA DECORATORE PARZIALE (SOSTITUISCE FUNZIONE IMPUT)
def decorator(funzione):  # prende in input una funzione
    def wrapper():  # funzione decoratrice
        # code here

    return wrapper  # restituisce wrapper (chiamata a funz_decorata chiama wrapper)

# STRUTTURA DECORATORE COMPLETA (MODOFICA FUNZIONE INPUT)
def decorator(funzione):  # prende in input una funzione da decorare
    @functools.wraps(funzione)  # keep code inspection avaiable
    def wrapper(*args, **kwargs):  # funzione decoratrice (args, kwargs sono argomenti della funzione decorata)
        # do something before
        var_funz = funzione(*args, **kwargs)
        # do something after
        return var_funz  # restituisce il risultato della decorazione della funzione

    return wrapper  # restituisce wrapper (chiamata a funz_decorata chiama wrapper)

@decorator # applicazione del decoratore alla funzione
def funzione():  # funzione da decorare
    # code here
    return espressione


#STRUTTURA DECORATORE COMPLETA PARAMETRIZZATA
def decorator(*dec_args, **dec_kwargs):  # prende in input argomenti del decoratore

    def outer_wrapper(func):

        def inner_wrapper(*args, **kwargs):  
            # do something before
            var_funz = funzione(*args, **kwargs)
            # do something after
            return var_funz  

        return inner_wrapper

    return outer_wrapper


@decorator(*dec_args, **dec_kwargs)  # decoratore parametrizzato invocato come funzione
def funzione(): # funzione da decorare
    # code here
    return espressione
```

## Programmazione Ad Oggetti

### Creazione Classe

```py
class NomeClasse:

     # creazione variabile statica (o di classe; condivisa da tutte le istanze)
     # ovverride possinile tramite subclassing o assegnazine diretta (oggetto.static_var =)
     # NomeClasse.static_var = cambia l'attributo di classe in tutte le istanze
    static_var = espressione

    def __init__(self, valore_1, valore_2): # costruttore di default parametrizzato
        # attributi sono alias degli argomenti (modifiche in-place cambiano argomenti)
        self.variabile = valore_1   # creazione variabili di istanza
        self.__variabile = valore_2 # variabile appartenente ad oggetti della classe e non ai figli, accesso tarmite NAME MANGLING


    @classmethod  # metodo agente sulla classe e non sull'oggetto (utile x costruttori alternativi)
    def metodo_classe(cls, parametri):
        instruction
        return cls(parametri)  # crea istanza classe (cls accetta anche sottoclassi)

    # i parametri possono essere variabili statiche (Classe.variabile), variabili di istanza (self.variabile) o valori esterni alla classe
    def metodo_istanza(self, parametri):
        # code here
        return espressione

    @staticmethod # indica un metodo statico (NECESSARIO)
    def metodo_statico(parametri):  # metodi statici non influenzano variabili di istanza (SELF non necessatio)
        instruction
        return espressione

    oggetto = NomeClasse(parametri)  # creazione di un oggetto
    oggetto.variabile = espressione  # modifica variabile pubblica
    oggetto.metodo(parametri)  # invocazione metodo di istanza
    NomeClasse.metodo(parametri)  #ivocazione metodo statico
    oggetto._NomeClasse__var_privata   # accesso a variabile specificando la classe di appartenenza  (NAME MANGLING)
```

### Metodi Setter e Getter con `@Property`

I nomi delle funzioni devono essere diversi dalla variabile (3 nomi diversi). Almeno `@property` & `@parametro.setter` devone essere usati.

```py
class NomeClasse:
    def __init__(self, parametro):
        self.__parametro = parametro

    @property  # metodo getter
    def parametro(self):
        """docstring"""
        return self.__parametro

    @parametro.setter
    def parameto(self, valore):
        self.__parametro = valore

    @parametro.deleter  # metodo deleter
    def __parametro(self):
        del self.__parametro
```

### `__slots__`

L'attributo `__slots__` implementa **Flyweight Design Pattern**:
salva gli attributi d'istanza in una tupla e può essere usato per diminuire il costo in memoria inserendovi solo le variabili di istanza (sopprime il dizionario dell'istanza).

**Default**: attributi salvati in un dizionario (`oggetto.__dict__`)
**Uso**: `__slots_ = [attributi]`

`__slots__` non viene ereditato dalle sottoclassi, impedisce l'aggiunta dinamica delgi attributi.

### Fluent Interface

```py
class NomeClasse():

    def __init__(self, parametri):
        instruction

    def metodo_1(self):
    instruction
        return self  # permette il concatenamento di metodi

    def metodo_2(self):
        instruction
        return self

oggetto.metodo_1().metodo_2()
```

### Classi Incapsulate

```py
class Class:
    def __init__(self, parameters):
        instruction

    class InnerClass:
        def __init__(self, parameters):
            instruction

        def metodo(self):
            instruction

oggetto_1 = Class(argomenti) # crea classe 'esterna'
oggetto_2 = Class.InnerClass(argomenti) # inner class creata come oggetto della classe 'esterna'
oggetto.metodo()
```

### Metodi Speciali

I metodi speciali sono definiti dall'uso di doppi underscore; essi permettono l'uso di specifiche funzioni (eventualmente adattate) sugli oggetti definiti dalla classe.

```py
class NomeClasse():

    def __init__(self, parametri):
        istuzioni

    # usato da metodo str() e print()
    # gestisce le richieste di rappresentazione come stringa
    def __str__(self):
        return espressione  # return necessario

    def __len__(self):
        return espressione  # necessario return in quanto len richiede una lunghezza/dimensione

    def __del__(self):  # elimina l'istanda della classe
        instruction  # eventuali istruzionni che avvengono all'eliminazione

oggetto = NomeClasse()
len(oggetto)  # funzione speciale applicata ad un oggetto
del oggetto  # elimina oggetto
```

#### Special Methods List

```py
# se l'operatore no può essere applicato restituire NotImplemented
# operatori aritmetici
__add__(self, other)         # +
__sub__(self, other)         # -
__mul__(self, other)         # *
__matmul__(self, other)      # (@) moltiplicazione matrici
__truediv__(self, other)     # /
__floordiv__(self, other)  # //
__mod__(self, other)         # %
__divmod__(self, other)      # divmod()
__pow__(self, other)         # **, pow()
__lshift__(self, other)      # <<
__rshift__(self, other)      # >>
__and__(self, other)         # &
__xor__(self, other)         # ^
__or__(self, other)          # |

# operatori aritmetici riflessi
# [se self.__dunde__(other) fallisce viene chiamato other.__dunder__(self)]
__radd__(self, other)         # reverse +
__rsub__(self, other)         # reverse -
__rmul__(self, other)         # reverse *
__rmatmul__(self, other)      # reverse @
__rtruediv__(self, other)     # reverse /
__rfloordiv__(self, other)  # reverse //
__rmod__(self, other)         # reverse %
__rdivmod__(self, other)      # reverse divmod()
__rpow__(self, other)         # reverse **, pow()
__rlshift__(self, other)      # reverse <<
__rrshift__(self, other)      # reverse >>
__rand__(self, other)         # reverse &
__rxor__(self, other)         # reverse ^
__ror__(self, other)          # reverse |

# operatori aritmetici in-place (<operator>=)
# implementazione di base (built-in) come self = self <operator> other
# ! da non implementare per oggetti immutabili !
# ! operatori in-place restituiscono self !
__iadd__(self, other)         # +=
__isub__(self, other)         # -=
__imul__(self, other)         # *=
__imatmul__(self, other)      # @=
__itruediv__(self, other)     # /=
__ifloordiv__(self, other)  # //=
__imod__(self, other)         # %=
__ipow__(self, other)         # **=
__ilshift__(self, other)      # <<=
__irshift__(self, other)      # >>=
__iand__(self, other)         # &=
__ixor__(self, other)         # ^=
__ior__(self, other)          # |=

# operatori matematici unari (-, +, abs(), ~)
__neg__(self)  # (-) negazione matematica unaria [if x = 2 then -x = 2]
__pos__(self)  # (+) addizione unaria [x = +x]
__abs__(self)  # [abs()] valore assoluto [|-x| = x]
__invert__(self)  # (~) inversione binaria di un intero [~x == -(x + 1)]

# conversione tipo numerico
__complex__(self)
__int__(self)  # se non definta fall-back a __trunc__()
__float__(self)
__index__(self)  # conversione bin(), hex(), oct() e slicing

# operazioni round() e math.trunc(), math.floor(), math.ceil()
__round__(self)
__trunc__(self)
__floor__(self)
__ceil__(self)

# operatori uguaglianza
self.__eq__(other)  # self == other
self.__ne__(other) # self != other
self.__gt__(other) # self > other
self.__ge__(other) # self >= other
self.__lt__(other) # self < other
self.__le__(other) # self <= other

# operatori uguaglianza riflessi
other.__eq__(self)  # other == self,   fall-back id(self) == id(other)
other.__ne__(self)  # other != self,   fall-back not (self == other)
other.__gt__(self)  # reverse self < other,   fall-back TypeError
other.__ge__(self)  # reverse self <= other,   fall-back TypeError
other.__lt__(self)  # reverse self > other,   fall-back TypeError
other.__le__(self)  # reverse self >= other,   fall-back TypeError
# chiamato quando l'istanza è "chiamata" come funzione
# x(arg1, arg2, arg3) è abbreviazione di x.__call__(arg1, arg2, arg3)
__call__(self, args)

#  stringa rappresentazione oggetto per lo sviluppatore
__repr__(self)

#  stringa rappresentazione oggetto per l'utente (usata da print)
__str__(self)

# specifica formattazione per format(), str.format() [format_spec = format-mini-language]
__format__(format_spec)

# restituisce valore (num intero) univoco per oggetti che hanno valore eguale
# DEVE ESISTERE __EQ__ NELLA CLASSE
# METODO GENERALE: hash((self.param_1, self.param_2, ...))    hash tuple componenti oggetto
__hash__(self)

# rende oggetto iterabile:
# - restituendo self (nell'iteratore)
# - restituendo un iteratore (nell'iterabile)
# - usando yield (nel generatore __iter__)
__iter__(self)

# restituisce prosimo elemento disponibile, StopIteration altrimenti (scorre iteratore)
__next__()

# restituisce valore id verità
__bool__

# restituisce item associato a key di una sequenza (self[key])
# IndexError se key non appropriata
__getitem__(self, key)

# operazione assegamento item in sequenza ( self[key] = value)
# IndexError se key non appropriata
__setitem__(self, key, value)

# operazione eliminazione item in sequenza ( del self[key])
# IndexError se key non appropriata
__delitem__(self, key)

# chiamato da dict.__getitem__() per implementare self[key] se key non è nel dizionario
__missing__(self, key)

# implementa iterazione del contenitore
__iter__(self)

# implementa membership test
__contains__(self, item)

# implementazione issublass(instance, class)
__instancecheck__(self, instance)

# implementazione issubclass(subclass, class)
__subclasscheck__(self, subclass)

# implementa accesso ad attributi (obj.name)
# chiamato se accade AttributeError o se chiamato da __getattribute__()
__getattr__(self, name)

# implementa asseganzione valore ad attributo (obj.name = value)
__setattr__(self, name, value)
```

**Note**: Itearbility is tricky.

To make an object directly iterable (`for i in object`) `__iter__()` and `__next__()` are needed.
To make an iterable through an index (`for i in range(len(object)): object[i]`) `__getitem()__` is needed.

Some of the mixin methods, such as `__iter__()`, `__reversed__()` and `index()`, make repeated calls to the underlying `__getitem__()` method.
Consequently, if `__getitem__()` is implemented with constant access speed, the mixin methods will have linear performance;
however, if the underlying method is linear (as it would be with a linked list), the mixins will have quadratic performance and will likely need to be overridden.

### Ereditarieta`

```py
class ClasseGenitore():
    def __init__(self, parametri):
        instruction

    def metodo_genitore_1(self):
        instruction
        return espressione

    def metodo_genitore_2(self):
        instruction
        return espressione

class ClasseFiglia1(classe_genitore): # classe genitore in parentesi per ereditare variabili e metodi

    def __init__(self, parametri, parametri_genitore):
        ClasseGenitore.__init__(self, parametri_genitore) # eredita variabili genitore

    def metodo(self):
        instruction
        return espressione

    def metodo_genitore_1(self): # override metodo (classe figli con metodo omonimo a classe genitore)
        instruction
        return espressione

class ClasseFiglia2(classe_genitore): # parent class in brackets to inherit properties

    def __init__(self, parametri, parametri_genitore):
        super().__init__(parametri_genitore) # metodo differente per ereditare variabili genitore (SELF non necessario) usando SUPER()
        super(ClasseGenitore, self).__init__(parametri_genitore) # costruttore genitore invocato separatmente

    def metodo(self):
        instruction
        return espressione

    def metodo_genitore_2(self): # metodo genitore aggiornato
        super().metodo_genitore_1() # invoca metodo genitore così com'è
        instruction
        return espressione

classeFiglia1.metodo_genitore_1() # metodo disponibile a classi genitore e figlia
classeFiglia1.metodo() # method disponibile solo a classe figlia
```

**MRO (Method Resolution Order) for Multiple Inheritance**: se una sottoclasse ha un metodo ereditato da più classi che condividono lo stesso nome del metodo il MRO è definito dall'ordine di ereditarietà.

**Multiple Inheritance Best Practices**:

- ereditare un'interfaccia crea un sottotipo (implica relazione is-a)
- ereditare un implementazione evita duplicazione del codice tramite riuso
- se la classe deve definire un interfaccia dovrebbe essere un ABC esplicita
- se la classe deve fornire vari metodi a sottoclassi scorrelate è il caso che sia una classe "minin" le classi mininx non creano nuovi sottotipi ma raggruppano metodi per il riuso.
le classi mixin non devono essere instanziate e le loro sottoclassi non devono ereditare solo da esse
- le classi mixin dovrebbero avere un suffisso mixin nel nome
- classi ABC possono essere mixin, non viceversa

- combinazioni di ABC o minxin utili per codice cliente dovrebbero fornire una "classe aggregato" che le riunisce in modo sensato

### Polimorfismo

**Note**: python non supporta method overloading

```py
# DUCKTYPING
Operare con oggetti senza riguardo per il loro tipo, finchè implementano certi protocolli
class Classe1:
    def metodo_1(self):
        instruction
        return espressione

class Classe2:
    def metodo_1(self):
        instruction
        return espressione

# dato che python è un linguaggio dinamico non importa di che tipo (classe) è l'oggetto passato
# la funzione invoca il metodo dell'oggetto passato indipendentemente dalla classe dell'oggetto
def metodo_polimorfo(oggetto):
    oggetto.metodo_1()
# DEPENDENCY INJECTION CON DUCKTYPING
class Classe:
    def __init__(self, oggetto):
        self.attributo = oggetto

    def metodo_polimorfo(self): # la funzione invoca il metodo dell'oggetto passato
        self.attributo.metodo_1()

class ClasseSupporto1:
    def metodo_1(self):
        instruction
        return espressione

class ClasseSupporto2:
    def metodo_1(self):
        instruction
        return espressione

oggetto_1 = ClasseSupporto1()
# oggetto polimorfo creato passando alla classe l'oggetto di supporto come argomento
oggetto_0 = Classe(oggetto_1)
# invoca il metodo dell'oggetto passato (metodo1)
oggetto_0.metodo_polimorfo()

oggetto_2 = ClasseSupporto2()
# oggetto polimorfo creato passando alla classe l'oggetto di supporto come argomento
oggetto_0 = Classe(oggetto_2)
oggetto_0.metodo_polimorfo() # invoca il metodo dell'oggetto passato
```

### Operator Overloading

**Regola fondamentale operatori**: restisuire *sempre* un oggetto, se operazione fallisce restituire `NotImplemented`

Limitations of operator overloading:

- no overloading di tipi built-in
- no creazione nuovi operatori
- no overloading operatori is, and, or, not'''

### Astrazione

Le **interfacce** sono classi astratte con *tutti* metodi astratti, sono usate per indicare quali metodi come le classi figlie *devono* avere.
Le interfaccie hanno *solo* una lista di metodi astratti.

Le **classi astratte** hanno *almeno* un metodo astratto; classi figlie che ereditano da una classe astratta *devono* implementare i metodi astratti.
Le classi astartte *non possono* essere instanziate (non possono generare oggetti).

Le sottoclassi virtuali vengono usate per includere classi di terze parti come sottoclassi di una classe propria.
Esse vengono riconosciute come appartenenti a classe genitore senza però doverne implementare i metodi.

I decoratori `@Classe.register` o `Classe.register(sottoclasse)` servono per marcare sottoclassi.

```py
from abc import abstractmethod, ABC

class ClasseAstratta(ABC):  # classe astratta DEVE EREDITARE da classe parente ABC
    def __init__(self, parametri):
        instruction

    def metodo_genitore(self):
        instruction
        return espressione

    @abstractmethod  # metodo astratto DEVE essere machiato con decoratore @abstractmethod
    def metodo_astratto(self):
        pass
        # metodo astratto DEVE essere sovrascritto (può essere non vuoto)
        #(.super() per invocarlo nella classe concreta)

class ClasseFiglia(classe_genitore): # classe genitore in parentesi per ereditare variabili e metodi

    def __init__(self, parametri, parametri_genitore):
        classe_genitore.__init__(self, parametri_genitore) # necessario per ereditare variabili genitore

    def metodo(self):
        instruction
        return espressione

    def metodo_genitore(self): # override metodo (classe figli con metodo omonimo a classe genitore)
        instruction
        return espressione

    def metodo_astratto(self):  # implementazione metodo astratto ereditato da classe astratta (NECESSARIA) mediante override
        instruction
        return espressione
```

## Exception Handling

```py
# CONTROLLO ASERZIONI
assert condizione, 'mesaaggio di errore' # se l'asserzione risulta falsa mostra un messaggio d'errore

# i tipi di eccezioni sono delle classi. ve ne sono alcune predefinite e se ne possonoi creare di personalizzate
# errori particolari sono oggetti di una particolare classe di eccezioni che a sua volta è figlia della classe di eccezioni base (exception)

class CustomExceptionError(Exception):  # DEVE in qualche modo ereditare dalla classe exception (anche in passaggi successivi di eredità)
    pass # o istruzioni

# blocco try contiene il codice che potrebbe causare un eccezione
# codice dentro try e dopo l'errore non viene eseguito
try:
    instruzioni
    raise CustomExceptionError("message")  # attiva l'eccezione

# except prende il controllo dell'error handling senza passsare per l'interprete
# clocco eseguito se avviene un errore in try

# except errore specificato dalla classe
except ExceptionClass:
    # code here
    # messaggio d'errore di default non viene mostrato
    # il programma non si ferma

# except su errori vari
except:
     # code here

# blocco eseguito se non avviene l'eccezione
else:
    # code here  

# blocco eseguito in tutti i casi, codice di pulizia va qui
finally:
    # code here
```

## File

### Apertura Di Un File

Modalità apertura file testo:

- `w`: write, sovrarscrive contenuto del file
- `r`: read, legge contenuto file
- `a`: append, aggiunge contenuto al file
- `w+`: write & read
- `r+`: write & read & append
- `a+`: append & read
- `x`: exclusive creation, se il file esiste già -> `FileExistError` (modalità estesa di write)

Modalità apertura file binario:

- `wb`: write, sovrarscrive contenuto del file
- `rb`: read, legge contenuto file
- `ab`: append, aggiunge contenuto al file
- `w+b`: write & read
- `r+b`: write & read & append
- `a+b`: append & read
- `xb`: exclusive creation, se il file esiste già -> `FileExistError` (modalità estesa di write)

**Note**: GNU/Linux e MacOSX usano `UTF-8` ovunque mentre windows usa `cp1252`, `cp850`, `mbcs`, `UTF-8`. Non fare affidamento a encoding di default ed usare **esplicitamente** `UTF-8`.

```py
oggetto = open('filename', mode='r', encoding='utf-8')  # encoding MUST BE utf-8 for compatibility
# filename può essere il percorso assoluto della posizione del file (default: file creato nella cartella del codice sorgente)
# doppio slash per evitare escape di \

with open('filename') as file:
    istruzioni_su_file   # blocco usa nome_file per indicare il file

# CHIUSURA DI UN FILE
oggetto.close()

# SCRITTURA IN UN FILE
oggetto.write(stringa)  # scrive singola stinga nel file
oggetto.writelines(*stringhe)  # scrive stringhe multiple sul file

# LETTURA DA UN FILE
oggetto.read()  # restituisce TUTTO il contenuto del file (anche escape sequence) e posuzione il "cursore" a fondo file
oggetto.seek(0)  # restituisce 0 (zero) e posiziona il cursore a inizio file
oggetto.readlines()  # restituisce lista linee file (ATTENZIONE: tiene tutto in memoria, cautela con file grandi)
oggetto.readline()     # restituisce singola linea file

# CONTROLLO ESISTENZA FILE
import os, sys
if os.path.isfile('filepath'):  # controlla esistenza file (TRUE se esiste)
    # code here
else:
    # code here
    sys.exit()  # esce dal programma non eseguendo il cosice successivo

# PICKLE-ING
import pickle, classe  # importa modulo pickle e classe da trasformare in byte stream

fileObj = open('file.dat', 'wb')  # apre file
obj = classFile.classe(parameters)   # crea oggetto
pickle.dump(obj, fileObj)  # traduce la gerarchia dell'oggetto in un byte stream (.dat contiene byte)
fileObj.close()

import pickle   # importa modulo pickle per tradurre byte stream, classe oggetto non necessaria (oggetto codificato nel file)

fileObj = open('file.dat', 'rb')
obj = pickle.load(fileObj)  # traduce oggetto da fileObj
obj.method()  # utilizza metodo dell'oggetto
fileObj.close()
```

## TIMEIT

```py
timeit.timeit(' statement ', setup, timer=default_timer, number=num_of_trials)
# statement: codice da testare (passato come stringa)
# setup: codice di setup
# timer: funzione timer (default_timer = time.perf_counter())
# number: numero di test eseguiti (num esecuzioni statement)
```

## CONTEXTLIB

Utility per operazioni coinvolgenti with statement.

In un generatore decorato con @contextmanager lo statement yield divide il codice in 2 parti:

- **PRE-YIELD**: eseguito alla chiamata __enter__
- **POST-YIELD**: eseguito alla chiamata __exit__

`yield` restituisce il valore da associare al "with-target"

```py
# restituisce context manager che chiude thing alla conclusione del blocco
contextlib.closing(thing)

# costruisce context manager partendo da funzione restituente generatore-iteratore
# senza implementare classe e protocollo
@contextlib.contextmanager
def generator():
    # code here
    yield variabile
    # code here

# classe bese per definire context manager basati su classi
# che possono essere anche usati come decoratori
class contextlib.ContextDecorator

# context manager che permette l'inserimento di indefiniti context manager
# alla finde del blocco with ExitStack chiama __exit__ in ordine LIFO
class contextlib.ExitStack
```

## COPY

Opererazioni di copia (*shallow copy*) e copia profonda (*deep copy*)  
**SHALLOW COPY**: copia il "contenitore" e i riferimenti al contenuto  
**DEEP COPY**: copia il "contenitore" e i contenuti (no riferimento)

```py
copy(x)  # restituisce shallow copy di xor
deepcopy(x)  # restituisce shallow copy di x
```
