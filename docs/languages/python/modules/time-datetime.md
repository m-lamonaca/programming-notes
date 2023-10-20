# Time & Datetime

## Time

```py linenums="1"
# epoch: elapsed time in seconds (in UNIX starts from 01-010-1970)
import time # UNIX time
variable = time.time () # returns the time (in seconds) elapsed since 01-01-1970
variable = time.ctime (epochseconds) # transform epoch into date

var = time.perf_counter () # returns the current running time
# execution time = start time - end time
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

```py linenums="1"
import datetime
today = datetime.date.today () # returns current date
today = datetime.datetime.today () # returns the current date and time

# formatting example
print ('Current Date: {} - {} - {}' .format (today.day, today.month, today.year))
print ('Current Time: {}: {}. {}' .format (today.hour, today.minute, today.second))

var_1 = datetime.date (year, month, day) # create date object
var_2 = datetime.time (hour, minute, second, micro-second) # create time object
dt = datetime.combine (var_1, var_2) # combine date and time objects into one object

date_1 = datetime.date ('year', 'month', 'day')
date_2 = date_1.replace (year = 'new_year')

#DATETIME ARITHMETIC
date_1 - date_2 # -> datetime.timedelta (num_of_days)
datetime.timedelta # duration expressing the difference between two date, time or datetime objects
```
