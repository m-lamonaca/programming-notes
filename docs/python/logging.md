# Logging Module

## Configuration

```python
# basic configuration for the logging system
logging.basicConfig(filename="relpath", level=logging.LOG_LEVEL, format=f"message format", **kwargs)  
# DATEFMT: Use the specified date/time format, as accepted by time.strftime().

# create a logger with a name (useful for having multiple loggers)
logger = logging.getLogger(name="logger name")  
logger.level  # LOG_LEVEL for this logger

# disable all logging calls of severity level and below
# alternative to basicConfig(level=logging.LOG_LEVEL)
logging.disable(level=LOG_LEVEL)  
```

### Format (`basicConfig(format="")`)

| Attribute name | Format            | Description                                                                               |
|----------------|-------------------|-------------------------------------------------------------------------------------------|
| asctime        | `%(asctime)s`     | Human-readable time when the LogRecord was created. Modified by `basicConfig(datefmt="")` |
| created        | `%(created)f`     | Time when the LogRecord was created (as returned by `time.time()`).                       |
| filename       | `%(filename)s`    | Filename portion of pathname.                                                             |
| funcName       | `%(funcName)s`    | Name of function containing the logging call.                                             |
| levelname      | `%(levelname)s`   | Text logging level for the message.                                                       |
| levelno        | `%(levelno)s`     | Numeric logging level for the message.                                                    |
| lineno         | `%(lineno)d`      | Source line number where the logging call was issued (if available).                      |
| message        | `%(message)s`     | The logged message, computed as `msg % args`.                                             |
| module         | `%(module)s`      | Module (name portion of filename).                                                        |
| msecs          | `%(msecs)d`       | Millisecond portion of the time when the LogRecord was created.                           |
| name           | `%(name)s`        | Name of the logger used to log the call.                                                  |
| pathname       | `%(pathname)s`    | Full pathname of the source file where the logging call was issued (if available).        |
| process        | `%(process)d`     | Process ID (if available).                                                                |
| processName    | `%(processName)s` | Process name (if available).                                                              |
| thread         | `%(thread)d`      | Thread ID (if available).                                                                 |
| threadName     | `%(threadName)s`  | Thread name (if available).                                                               |

### Datefmt (`basicConfig(datefmt="")`)

| Directive | Meaning                                                                                                                      |
|-----------|------------------------------------------------------------------------------------------------------------------------------|
| `%a`      | Locale's abbreviated weekday name.                                                                                           |
| `%A`      | Locale's full weekday name.                                                                                                  |
| `%b`      | Locale's abbreviated month name.                                                                                             |
| `%B`      | Locale's full month name.                                                                                                    |
| `%c`      | Locale's appropriate date and time representation.                                                                           |
| `%d`      | Day of the month as a decimal number [01,31].                                                                                |
| `%H`      | Hour (24-hour clock) as a decimal number [00,23].                                                                            |
| `%I`      | Hour (12-hour clock) as a decimal number [01,12].                                                                            |
| `%j`      | Day of the year as a decimal number [001,366].                                                                               |
| `%m`      | Month as a decimal number [01,12].                                                                                           |
| `%M`      | Minute as a decimal number [00,59].                                                                                          |
| `%p`      | Locale's equivalent of either AM or PM.                                                                                      |
| `%S`      | Second as a decimal number [00,61].                                                                                          |
| `%U`      | Week number of the year (Sunday as the first day of the week) as a decimal number [00,53].                                   |
| `%w`      | Weekday as a decimal number [0(Sunday),6].                                                                                   |
| `%W`      | Week number of the year (Monday as the first day of the week) as a decimal number [00,53].                                   |
| `%x`      | Locale's appropriate date representation.                                                                                    |
| `%X`      | Locale's appropriate time representation.                                                                                    |
| `%y`      | Year without century as a decimal number [00,99].                                                                            |
| `%Y`      | Year with century as a decimal number.                                                                                       |
| `%z`      | Time zone offset indicating a positive or negative time difference from UTC/GMT of the form +HHMM or -HHMM [-23:59, +23:59]. |
| `%Z`      | Time zone name (no characters if no time zone exists).                                                                       |
| `%%`      | A literal '%' character.                                                                                                     |

## Logs

Log Levels (Low To High):

- default: `0`
- debug: `10`
- info: `20`
- warning: `30`
- error: `40`
- critical: `50`

```python
logging.debug(msg)  # Logs a message with level DEBUG on the root logger
logging.info(msg)  # Logs a message with level INFO on the root logger
logging.warning(msg)  # Logs a message with level WARNING on the root logger
logging.error(msg)  # Logs a message with level ERROR on the root logger
logging.critical(msg)  # Logs a message with level CRITICAL on the root logger
```
