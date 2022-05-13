
# CSV Module Cheat Sheet

``` python
# iterate lines of csvfile
.reader (csvfile, dialect, ** fmtparams) -> reader object

# READER METHODS
.__ next __ () # returns next iterable object line as a list or dictionary

# READER ATTRIBUTES
dialect # read-only description of the dialec used
line_num # number of lines from the beginning of the iterator
fieldnames

# convert data to delimited strings
# csvfile must support .write ()
#type None converted to empty string (simplify SQL NULL dump)
.writer (csvfile, dialect, ** fmtparams) -> writer object

# WRITER METHODS
# row must be iterable of strings or numbers or of dictionaries
.writerow (row) # write row formatted according to the current dialect
.writerows (rows) # write all elements in rows formatted according to the current dialect. rows is iterable of row

# CSV METHODS
# associate dialect to name (name must be string)
.register_dialect (name, dialect, ** fmtparams)

# delete the dialect associated with name
.unregister_dialect ()

# returns the dialect associated with name
.get_dialect (name)

# list of dialects associated with name
.list_dialect (name)

# returns (if empty) or sets the limit of the csv field
.field_size_limit (new_limit)

'''
csvfile - iterable object returning a string on each __next __ () call
          if csv is a file it must be opened with newline = '' (universal newline)
dialect - specify the dialect of csv (Excel, ...) (OPTIONAL)

fmtparams --override formatting parameters (OPTIONAL) https://docs.python.org/3/library/csv.html#csv-fmt-params
'''

# object operating as a reader but maps the info in each row into an OrderedDict whose keys are optional and passed through fieldnames
class csv.Dictreader (f, fieldnames = None, restket = none, restval = None, dialect, * args, ** kwargs)
'''
f - files to read
fieldnames --sequence, defines the names of the csv fields. if omitted use the first line of f
restval, restkey --se len (row)> fieldnames excess data stored in restval and restkey

additional parameters passed to the underlying reader instance
'''

class csv.DictWriter (f, fieldnames, restval = '', extrasaction, dialect, * args, ** kwargs)
'''
f - files to read
fieldnames --sequence, defines the names of the csv fields. (NECESSARY)
restval --se len (row)> fieldnames excess data stored in restval and restkey
extrasaction - if the dictionary passed to writerow () contains key not present in fieldnames extrasaction decides action to be taken (raise cause valueError, ignore ignores additional keys)

additional parameters passed to the underlying writer instance
'''

# DICTREADER METHODS
.writeheader () # write a header line of fields as specified by fieldnames

# class used to infer the format of the CSV
class csv.Sniffer
.sniff (sample, delimiters = None) #parse the sample and return a Dialect class. delimiter is a sequence of possible box delimiters
.has_header (sample) -> bool # True if first row is a series of column headings

#CONSTANTS
csv.QUOTE_ALL # instructs writer to quote ("") all fields
csv.QUOTE_MINIMAL # instructs write to quote only fields containing special characters such as delimiter, quote char ...
csv.QUOTE_NONNUMERIC # instructs the writer to quote all non-numeric fields
csv.QUOTE_NONE # instructs write to never quote fields
```
