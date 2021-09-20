# Time & Datetime

## Time

```py
# epoch: tempo in secondi trascorso (in UNIX parte da 01-010-1970)
import time  # UNIX time
variabile = time.time()  # restituisce il tempo (In secondi) trascorso da 01-01-1970
variabile = time.ctime(epochseconds)  # trasforma l'epoca in data

var = time.perf_counter()  # ritorna il tempo di esecuzione attuale
# tempo di esecuzione = tempo inizio - tempo fine
```

### time.srtfrime() format

| Format | Data                                                                                                       |
|--------|------------------------------------------------------------------------------------------------------------|
| `%a`   | Locale's abbreviated weekday name.                                                                         |
| `%A`   | Locale's full weekday name.                                                                                |
| `%b`   | Locale's abbreviated month name.                                                                           |
| `%B`   | Locale's full month name.                                                                                  |
| `%c`   | Locale's appropriate date and time representation.                                                         |
| `%d`   | Day of the month as a decimal number `[01,31]`.                                                            |
| `%H`   | Hour (24-hour clock) as a decimal number `[00,23]`.                                                        |
| `%I`   | Hour (12-hour clock) as a decimal number `[01,12]`.                                                        |
| `%j`   | Day of the year as a decimal number `[001,366]`.                                                           |
| `%m`   | Month as a decimal number `[01,12]`.                                                                       |
| `%M`   | Minute as a decimal number `[00,59]`.                                                                      |
| `%p`   | Locale's equivalent of either AM or PM.                                                                    |
| `%S`   | Second as a decimal number `[00,61]`.                                                                      |
| `%U`   | Week number of the year (Sunday as the first day of the week) as a decimal number `[00,53]`.               |
| `%w`   | Weekday as a decimal number `[0(Sunday),6]`.                                                               |
| `%W`   | Week number of the year (Monday as the first day of the week) as a decimal number `[00,53]`.               |
| `%x`   | Locale's appropriate date representation.                                                                  |
| `%X`   | Locale's appropriate time representation.                                                                  |
| `%y`   | Year without century as a decimal number `[00,99]`.                                                        |
| `%Y`   | Year with century as a decimal number.                                                                     |
| `%z`   | Time zone offset indicating a positive or negative time difference from UTC/GMT of the form +HHMM or -HHMM |
| `%Z`   | Time zone name (no characters if no time zone exists).                                                     |
| `%%`   | A literal `%` character.                                                                                   |

## Datetime

```py
import datetime
today = datetime.date.today()   # restituisce data corrente
today = datetime.datetime.today()  # restituisce la data e l'ora corrente

# esempio di formattazione
print('Current Date: {}-{}-{}' .format(today.day, today.month, today.year))
print('Current Time: {}:{}.{}' .format(today.hour, today.minute, today.second))

var_1 = datetime.date(anno, mese, giorno)  # crea oggetto data
var_2 = datetime.time(ora, minuti, secondi, micro-secondi)  # crea oggetto tempo
dt = datetime.combine(var_1, var_2)  # combina gli oggetti data e tempo in un unico oggetto

date_1 = datetime.date('year', 'month', 'day')
date_2 = date_1.replace(year = 'new_year')

#DATETIME ARITHMETIC
date_1 - date_2  # -> datetime.timedelta(num_of_days)
datetime.timedelta  # durata esprimente differenza tra due oggetti date, time o datetime
```
