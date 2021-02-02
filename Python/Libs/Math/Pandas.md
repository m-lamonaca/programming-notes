# Pandas Lib

## Basic Pandas Imports

```py
import numpy as np
import pandas as pd
from pandas import Series, DataFrame
```

## SERIES

1-dimensional labelled array, axis label referred as INDEX.  
Index can contain repetitions.

```py
s = Series(data, index=index, name='name')
# DATA: {python dict, ndarray, scalar value}
# NAME: {string}
s = Series(dict)  # Series created from python dict, dict keys become index values
```

### INDEXING / SELECTION / SLICING

```py
s['index']  # selection by index label
s[condition]  # return slice selected by condition
s[ : ]  # slice endpoin included
s[ : ] = *value  # modifi value of entire slice
s[condition] = *value  # modify slice by condition
```

## MISSING DATA

Missing data appears as NaN (Not a Number).

```py
pd.isnull(array)  # retunn a Series index-bool indicating wich indexes dont have data
pd.notnull(array)  # retunn a Series index-bool indicating wich indexes have data
array.isnull()
array.notnull()
```

### SERIES ATTRIBUTES

```py
s.values  # NumPy representation of Series
s.index  # index object of Series
s.name = "Series name"  # renames Series object
s.index.name = "index name"  # renames index
```

### SERIES METHODS

```py
pd.Series.isin(self, values)  #  boolean Series showing whether elements in Series matcheselements in values exactly

# Conform Series to new index, new object produced unless the new index is equivalent to current one and copy=False
pd.Series.reindex(delf, index=None, **kwargs)
# INDEX: {array} -- new labels / index
# METHOD: {none (dont fill gaps), pad (fill or carry values forward), backfill (fill or carry values backward)}-- hole filling method
# COPY: {bool} -- return new object even if index is same -- DEFAULT True
# FILLVALUE: {scalar} --value to use for missing values. DEFAULT NaN

pd.Series.drop(self, index=None, **kwargs)  # return Series with specified index labels removed
# INPLACE: {bool} -- if true do operation in place and return None -- DEFAULT False
# ERRORS: {ignore, raise} -- If ‘ignore’, suppress error and existing labels are dropped
# KeyError raised if not all of the labels are found in the selected axis

pd.Series.value_counts(self, normalize=False, sort=True, ascending=False, bins=None, dropna=True)
# NORMALIZE: {bool} -- if True then object returned will contain relative frequencies of unique values
# SORT: {bool} -- sort by frequency -- DEFAULT True
# ASCENDING: {bool} -- sort in ascending order -- DEFAULT False
# BINS: {int} -- group values into half-open bins, only works with numeric data
# DROPNA: {bool} -- dont include counts of NaN
```

## DATAFRAME

2-dimensional labeled data structure with columns of potentially different types.
Index and columns can contain repetitions.

```py
df = DataFrame(data, index=row_labels, columns=column_labels)
# DATA: {list, dict (of lists), nested dicts, series, dict of 1D ndarray, 2D ndarray, DataFrame}
# INDEX: {list of row_labels}
# COLUMNS: {list of column_labels}
# outer dict keys interpreted as index labels, inner dict keys interpreted as column labels
# INDEXING / SELECTION / SLICING
df[col]  # column selection
df.at[row, col]  # access a single value for a row/column label pair
df.iat[row, col]  # access a single value for a row/column pair by integer position

df.column_label  # column selection

df.loc[label]  # row selection by label
df.iloc[loc]  # row selection by integer location

df[ : ]  # slice rows
df[bool_vec]  # slice rows by boolean vector
df[condition]  # slice rows by condition

df.loc[:, ["column_1", "column_2"]]  # slice columns by names
df.loc[:, [bool_vector]]  # slice columns by names

df[col] = *value  # modify column contents, if colon is missing it will be created
df[ : ] = *value # modify rows contents
df[condition] = *value  # modify contents

del df[col]  # delete column
```

### DATAFRAME ATTRIBUTES

```py
df.index  # row labels
df.columns  # column labels
df.values  # NumPy representation of DataFrame
df.index.name = "index name"
df.columns.index.name = "columns name"
df.T # transpose
```

### DATAFRAME METHODS

```py
pd.DataFrame.isin(self , values)  # boolean DataFrame showing whether elements in DataFrame matcheselements in values exactly

# Conform DataFrame to new index, new object produced unless the new index is equivalent to current one and copy=False
pd.DataFrame.reindex(self, index=None, columns=None, **kwargs)
# INDEX: {array} -- new labels / index
# COLUMNS: {array} -- new labels / columns
# METHOD: {none (dont fill gaps), pad (fill or carry values forward), backfill (fill or carry values backward)}-- hole filling method
# COPY: {bool} -- return new object even if index is same -- DEFAULT True
# FILLVALUE: {scalar} --value to use for missing values. DEFAULT NaN

pd.DataFrame.drop(self, index=None, columns=None, **kwargs)  # Remove rows or columns by specifying label names
# INPLACE: {bool} -- if true do operation in place and return None -- DEFAULT False
# ERRORS: {ignore, raise} -- If ‘ignore’, suppress error and existing labels are dropped
# KeyError raised if not all of the labels are found in the selected axis
```

## INDEX OBJECTS

Holds axis labels and metadata, immutable.

### INDEX TYPES

```py
pd.Index  # immutable ordered ndarray, sliceable. stortes axis labels
pd.Int64Index  # special case of Index with purely integer labels
pd.MultiIndex  # multi-level (hierarchical) index object for pandas objects
pd.PeriodINdex  # immutable ndarray holding ordinal values indicating regular periods in time
pd.DatetimeIndex  # nanosecond timestamps (uses Numpy datetime64)
```

### INDEX ATTRIBUTERS

```py
pd.Index.is_monotonic_increasing  # Return True if the index is monotonic increasing (only equal or increasing) values
pd.Index.is_monotonic_decreasing  # Return True if the index is monotonic decreasing (only equal or decreasing) values
pd.Index.is_unique  # Return True if the index has unique values.
pd.Index.hasnans  # Return True if the index has NaNs
```

### INDEX METHODS

```py
pd.Index.append(self, other)  # append a collection of Index options together

pd.Index.difference(self, other, sort=None)  # set difference of two Index objects
# SORT: {None (attempt sorting), False (dont sort)}

pd.Index.intersection(self, other, sort=None)  # set intersection of two Index objects
# SORT: {None (attempt sorting), False (dont sort)}

pd.Index.union(self, other, sort=None)  # set union of two Index objects
# SORT: {None (attempt sorting), False (dont sort)}

pd.Index.isin(self, values, level=None)  # boolean array indicating where the index values are in values
pd.Index.insert(self, loc, item)  # make new Index inserting new item at location
pd.Index.delete(self, loc)  # make new Index with passed location(-s) deleted

pd.Index.drop(self, labels, errors='raise')  # Make new Index with passed list of labels deleted
# ERRORS: {ignore, raise} -- If ‘ignore’, suppress error and existing labels are dropped
# KeyError raised if not all of the labels are found in the selected axis

pd.Index.reindex(self, target, **kwargs)  # create index with target’s values (move/add/delete values as necessary)
# METHOD: {none (dont fill gaps), pad (fill or carry values forward), backfill (fill or carry values backward)}-- hole filling method
```

## ARITMETHIC OPERATIONS

NumPy arrays operations preserve labels-value link.  
Arithmetic operations automatically align differently indexed data.  
Missing values propagate in arithmetic computations (NaN `<operator>` value = NaN)

### ADDITION

```py
self + other
pd.Series.add(self, other, fill_value=None)  # add(), supports substituion of NaNs
pd,Series.radd(self, other, fill_value=None)  # radd(), supports substituion of NaNs
pd.DataFrame.add(self, other, axis=columns, fill_value=None)  # add(), supports substituion of NaNs
pd.DataFrame.radd(self, other, axis=columns, fill_value=None)  # radd(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

### SUBTRACTION

```py
self - other
pd.Series.sub(self, other, fill_value=None)  # sub(), supports substituion of NaNs
pd.Series.radd(self, other, fill_value=None)  # radd(), supports substituion of NaNs
ps.DataFrame.sub(self, other, axis=columns, fill_value=None)  # sub(), supports substituion of NaNs
pd.DataFrame.rsub(self, other, axis=columns, fill_value=None)  # rsub(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

### MULTIPLICATION

```py
self * other
pd.Series.mul(self, other, fill_value=None)  # mul(), supports substituion of NaNs
pd.Series.rmul(self, other, fill_value=None)  # rmul(), supports substituion of NaNs
ps.DataFrame.mul(self, other, axis=columns, fill_value=None)  # mul(), supports substituion of NaNs
pd.DataFrame.rmul(self, other, axis=columns, fill_value=None)  # rmul(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

### DIVISION (float division)

```py
self / other
pd.Series.div(self, other, fill_value=None)  # div(), supports substituion of NaNs
pd.Series.rdiv(self, other, fill_value=None)  # rdiv(), supports substituion of NaNs
pd.Series.truediv(self, other, fill_value=None)  # truediv(), supports substituion of NaNs
pd.Series.rtruediv(self, other, fill_value=None)  # rtruediv(), supports substituion of NaNs
ps.DataFrame.div(self, other, axis=columns, fill_value=None)  # div(), supports substituion of NaNs
pd.DataFrame.rdiv(self, other, axis=columns, fill_value=None)  # rdiv(), supports substituion of NaNs
ps.DataFrame.truediv(self, other, axis=columns, fill_value=None)  # truediv(), supports substituion of NaNs
pd.DataFrame.rtruediv(self, other, axis=columns, fill_value=None)  # rtruediv(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

### FLOOR DIVISION

```py
self // other
pd.Series.floordiv(self, other, fill_value=None)  # floordiv(), supports substituion of NaNs
pd.Series.rfloordiv(self, other, fill_value=None)  # rfloordiv(), supports substituion of NaNs
ps.DataFrame.floordiv(self, other, axis=columns, fill_value=None)  # floordiv(), supports substituion of NaNs
pd.DataFrame.rfloordiv(self, other, axis=columns, fill_value=None)  # rfloordiv(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

### MODULO

```py
self % other
pd.Series.mod(self, other, fill_value=None)  # mod(), supports substituion of NaNs
pd.Series.rmod(self, other, fill_value=None)  # rmod(), supports substituion of NaNs
ps.DataFrame.mod(self, other, axis=columns, fill_value=None)  # mod(), supports substituion of NaNs
pd.DataFrame.rmod(self, other, axis=columns, fill_value=None)  # rmod(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

### POWER

```py
other ** self
pd.Series.pow(self, other, fill_value=None)  # pow(), supports substituion of NaNs
pd.Series.rpow(self, other, fill_value=None)  # rpow(), supports substituion of NaNs
ps.DataFrame.pow(self, other, axis=columns, fill_value=None)  # pow(), supports substituion of NaNs
pd.DataFrame.rpow(self, other, axis=columns, fill_value=None)  # rpow(), supports substituion of NaNs
# OTHER: {scalar, sequence, Series, DataFrame}
# AXIS: {0, 1, index, columns} -- whether to compare by the index or columns
# FILLVALUE: {None, float} -- fill missing value
```

## ESSENTIAL FUNCTIONALITY

### FUNCTION APPLICATION AND MAPPING

NumPy ufuncs work fine with pandas objects.

```py
pd.DataFrame.applymap(self, func)  # apply function element-wise

pd.DataFrame.apply(self, func, axis=0, args=())  # apllay a function along an axis of a DataFrame
# FUNC: {function} -- function to apply
# AXIS: {O, 1, index, columns} -- axis along which the function is applied
# ARGS: {tuple} -- positional arguments to pass to func in addition to the array/series
# SORTING AND RANKING
pd.Series.sort_index(self, ascending=True **kwargs)  # sort Series by index labels
pd.Series.sort_values(self, ascending=True, **kwargs)  # sort series by the values
# ASCENDING: {bool} -- if True, sort values in ascending order, otherwise descending -- DEFAULT True
# INPALCE: {bool} -- if True, perform operation in-place
# KIND: {quicksort, mergesort, heapsort} -- sorting algorithm
# NA_POSITION {first, last} -- ‘first’ puts NaNs at the beginning, ‘last’ puts NaNs at the end

pd.DataFrame.sort_index(self, axis=0, ascending=True, **kwargs)  # sort object by labels along an axis
pd.DataFrame.sort_values(self, axis=0, ascending=True, **kwargs)  # sort object by values along an axis
# AXIS: {0, 1, index, columns} -- the axis along which to sort
# ASCENDING: {bool} -- if True, sort values in ascending order, otherwise descending -- DEFAULT True
# INPALCE: {bool} -- if True, perform operation in-place
# KIND: {quicksort, mergesort, heapsort} -- sorting algorithm
# NA_POSITION {first, last} -- ‘first’ puts NaNs at the beginning, ‘last’ puts NaNs at the end
```

## DESCRIPTIVE AND SUMMARY STATISTICS

### COUNT

```py
pd.Series.count(self)  # return number of non-NA/null observations in the Series
pd.DataFrame.count(self, numeric_only=False)  # count non-NA cells for each column or row
# NUMERIC_ONLY: {bool} -- Include only float, int or boolean data -- DEFAULT False
```

### DESCRIBE

Generate descriptive statistics summarizing central tendency, dispersion and shape of dataset’s distribution (exclude NaN).

```py
pd.Series.describe(self, percentiles=None, include=None, exclude=None)
pd.DataFrame.describe(self, percentiles=None, include=None, exclude=None)
# PERCENTILES: {list-like of numbers} -- percentiles to include in output,between 0 and 1 -- DEFAULT [.25, .5, .75]
# INCLUDE: {all, None, list of dtypes} -- white list of dtypes to include in the result. ignored for Series
# EXCLUDE: {None, list of dtypes} -- black list of dtypes to omit from the result. ignored for Series
```

### MAX - MIN

```py
pd.Series.max(self, skipna=None, numeric_only=None)  # maximum of the values for the requested axis
pd.Series.min(self, skipna=None, numeric_only=None)  # minimum of the values for the requested axis
pd.DataFrame.max(self, axis=None, skipna=None, numeric_only=None)  # maximum of the values for the requested axis
pd.DataFrame.min(self, axis=None, skipna=None, numeric_only=None)  # minimum of the values for the requested axis
# SKIPNA: {bool} -- exclude NA/null values when computing the result
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### IDXMAX - IDXMIN

```py
pd.Series.idxmax(self, skipna=True)  # row label of the maximum value
pd.Series.idxmin(self, skipna=True)  # row label of the minimum value
pd.DataFrame.idxmax(self, axis=0, skipna=True)  #  Return index of first occurrence of maximum over requested axis
pd.DataFrame.idxmin(self, axis=0, skipna=True)  #  Return index of first occurrence of minimum over requested axis
# AXIS:{0, 1, index, columns} -- row-wise or column-wise
# SKIPNA: {bool} -- exclude NA/null values. ff an entire row/column is NA, result will be NA
```

### QUANTILE

```py
pd.Series.quantile(self, q=0.5, interpolation='linear')  # return values at the given quantile
pd.DataFrame.quantile(self, q=0.5, axis=0, numeric_only=True, interpolation='linear') # return values at the given quantile over requested axis
# Q: {flaot, array} -- value between 0 <= q <= 1, the quantile(s) to compute -- DEFAULT 0.5 (50%)
# NUMERIC_ONLY: {bool} -- if False, quantile of datetime and timedelta data will be computed as well
# INTERPOLATION: {linear, lower, higher, midpoint, nearest} -- SEE DOCS
```

### SUM

```py
pd.Series.sum(self, skipna=None, numeric_only=None, min_count=0)  # sum of the values
pd.DataFrame.sum(self, axis=None, skipna=None, numeric_only=None, min_count=0)  # sum of the values for the requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values when computing the result
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
# MIN_COUNT: {int} -- required number of valid values to perform the operation. if fewer than min_count non-NA values are present the result will be NA
```

### MEAN

```py
pd.Series.mean(self, skipna=None, numeric_only=None)   # mean of the values
pd.DataFrame.mean(self, axis=None, skipna=None, numeric_only=None)  # mean of the values for the requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values when computing the result
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### MEDIAN

```py
pd.Series.median(self, skipna=None, numeric_only=None)  # median of the values
pd.DataFrame.median(self, axis=None, skipna=None, numeric_only=None)  # median of the values for the requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values when computing the result
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### MAD (mean absolute deviation)

```py
pd.Series.mad(self, skipna=None)  # mean absolute deviation
pd.DataFrame.mad(self, axis=None, skipna=None)  # mean absolute deviation of the values for the requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values when computing the result
```

### VAR (variance)

```py
pd.Series.var(self, skipna=None, numeric_only=None)  # unbiased variance
pd.DataFrame.var(self, axis=None, skipna=None, ddof=1, numeric_only=None)  #  unbiased variance over requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values. if an entire row/column is NA, the result will be NA
# DDOF: {int} -- Delta Degrees of Freedom. divisor used in calculations is N - ddof (N represents the number of elements) -- DEFAULT 1
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### STD (standard deviation)

```py
pd.Series.std(self, skipna=None, ddof=1, numeric_only=None)  # sample standard deviation
pd.Dataframe.std(self, axis=None, skipna=None, ddof=1, numeric_only=None)  # sample standard deviation over requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values. if an entire row/column is NA, the result will be NA
# DDOF: {int} -- Delta Degrees of Freedom. divisor used in calculations is N - ddof (N represents the number of elements) -- DEFAULT 1
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### SKEW

```py
pd.Series.skew(self, skipna=None, numeric_only=None)  # unbiased skew Normalized bt N-1
pd.DataFrame.skew(self, axis=None, skipna=None, numeric_only=None)  #  unbiased skew over requested axis Normalized by N-1
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values when computing the result
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### KURT

Unbiased kurtosis over requested axis using Fisher’s definition of kurtosis (kurtosis of normal == 0.0). Normalized by N-1.

```py
pd.Series.kurt(self, skipna=None, numeric_only=None)
pd.Dataframe.kurt(self, axis=None, skipna=None, numeric_only=None)
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values when computing the result
# NUMERIC_ONLY: {bool} -- include only float, int, boolean columns, not immplemented for Series
```

### CUMSUM (cumulative sum)

```py
pd.Series.cumsum(self, skipna=True)  # cumulative sum
pd.Dataframe.cumsum(self, axis=None, skipna=True)  # cumulative sum over requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values. if an entire row/column is NA, the result will be NA
```

### CUMMAX - CUMMIN (cumulative maximum - minimum)

```py
pd.Series.cummax(self, skipna=True)  # cumulative maximum
pd.Series.cummin(self, skipna=True)  # cumulative minimumm
pd.Dataframe.cummax(self, axis=None, skipna=True)  # cumulative maximum over requested axis
pd.Dataframe.cummin(self, axis=None, skipna=True)  # cumulative minimum over requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values. if an entire row/column is NA, the result will be NA
```

### CUMPROD (cumulative product)

```py
pd.Series.cumprod(self, skipna=True)  # cumulative product
pd.Dataframe.cumprod(self, axis=None, skipna=True)  # cumulative product over requested axis
# AXIS: {0, 1, index, columns} -- axis for the function to be applied on
# SKIPNA: {bool} -- exclude NA/null values. if an entire row/column is NA, the result will be NA
```

### DIFF

Calculates the difference of a DataFrame element compared with another element in the DataFrame.  
(default is the element in the same column of the previous row)

```py
pd.Series.diff(self, periods=1)
pd.DataFrame.diff(self, periods=1, axis=0)
# PERIODS: {int} -- Periods to shift for calculating difference, accepts negative values -- DEFAULT 1
# AXIS: {0, 1, index, columns} -- Take difference over rows or columns
```

### PCT_CAHNGE

Percentage change between the current and a prior element.

```py
pd.Series.Pct_change(self, periods=1, fill_method='pad', limit=None, freq=None)
pd.Dataframe.pct_change(self, periods=1, fill_method='pad', limit=None)
# PERIODS:{int} -- periods to shift for forming percent change
# FILL_METHOD: {str, pda} -- How to handle NAs before computing percent changes -- DEFAULT pad
# LIMIT: {int} -- number of consecutive NAs to fill before stopping -- DEFAULT None
```

## HANDLING MISSING DATA

### FILTERING OUT MISSING DATA

```py
pd.Series.dropna(self, inplace=False)  # return a new Series with missing values removed
pd.DataFrame.dropna(axis=0, how='any', tresh=None, subset=None, inplace=False)  # return a new DataFrame with missing values removed
# AXIS: {tuple, list} -- tuple or list to drop on multiple axes. only a single axis is allowed
# HOW: {any, all} -- determine if row or column is removed from DataFrame (ANY = if any NA present, ALL = if all values are NA). DEFAULT any
# TRESH: {int} -- require that many non-NA values
# SUBSET: {array} -- labels along other axis to consider
# INPLACE: {bool} -- if True, do operation inplace and return None -- DEFAULT False
```

### FILLING IN MISSING DATA

Fill NA/NaN values using the specified method.

```py
pd.Series.fillna(self, value=None, method=None, inplace=False, limit=None)
pd.DataFrame.fillna(self, value=None, method=None, axis=None, inplace=False, limit=None)
# VALUE: {scalar, dict, Series, DataFrame} -- value to use to fill holes, dict/Series/DataFrame specifying which value to use for each index or column
# METHOD: {backfill, pad, None} -- method to use for filling holes -- DEFAULT None
# AXIS: {0, 1, index, columns} -- axis along which to fill missing values
# INPLACE: {bool} -- if true fill in-place (will modify views of object) -- DEFAULT False
# LIMIT: {int} --  maximum number of consecutive NaN values to forward/backward fill -- DEFAULT None
```

## HIERARCHICAL INDEXING (MultiIndex)

Enables storing and manupulation of data with an arbitrary number of dimensions.  
In lower dimensional data structures like Series (1d) and DataFrame (2d).

### MULTIIINDEX CREATION

```py
pd.MultiIndex.from_arrays(*arrays, names=None)  # convert arrays to MultiIndex
pd.MultiIndex.from_tuples(*arrays, names=None)  # convert tuples to MultiIndex
pd.MultiIndex.from_frame(df, names=None)  # convert DataFrame to MultiIndex
pd.MultiIndex.from_product(*iterables, names=None)     #  MultiIndex from cartesian product of iterables
pd.Series(*arrays)  # Index constructor makes MultiIndex from Series
pd.DataFrame(*arrays)  # Index constructor makes MultiINdex from DataFrame
```

### MULTIINDEX LEVELS

Vector of label values for requested level, equal to the length of the index.

```py
pd.MultiIndex.get_level_values(self, level)
```

### PARTIAL AND CROSS-SECTION SELECTION

Partial selection “drops” levels of the hierarchical index in the result  in a completely analogous way to selecting a column in a regular DataFrame.

```py
pd.Series.xs(self, key, axis=0, level=None, drop_level=True)  # cross-section from Series
pd.DataFrame.xs(self, key, axis=0, level=None, drop_level=True)  #  cross-section from DataFrame
# KEY: {label, tuple of label} -- label contained in the index, or partially in a MultiIndex
# AXIS: {0, 1, index, columns} -- axis to retrieve cross-section on -- DEFAULT 0
# LEVEL: -- in case of key partially contained in MultiIndex, indicate which levels are used. Levels referred by label or position
# DROP_LEVEL: {bool} -- If False, returns object with same levels as self -- DEFAULT True
```

### INDEXING, SLICING

Multi index keys take the form of tuples.

```py
df.loc[('lvl_1', 'lvl_2', ...)]  # selection of single row
df.loc[('idx_lvl_1', 'idx_lvl_2', ...), ('col_lvl_1', 'col_lvl_2', ...)]  # selection of single value

df.loc['idx_lvl_1':'idx_lvl_1']  # slice of rows (aka partial selection)
df.loc[('idx_lvl_1', 'idx_lvl_2') : ('idx_lvl_1', 'idx_lvl_2')]  # slice of rows with levels

```

### REORDERING AND SORTING LEVELS

```py
pd.MultiIndex.swaplevel(self, i=-2, j=-1)  # swap level i with level j
pd.Series.swaplevel(self, i=-2, j=-1) # swap levels i and j in a MultiIndex
pd.DataFrame.swaplevel(self, i=-2, j=-1, axis=0) # swap levels i and j in a MultiIndex on a partivular axis

pd.MultiIndex.sortlevel(self, level=0, ascending=True, sort_remaining=True)  # sort MultiIndex at requested level
# LEVEL: {str, int, list-like} -- DEFAULT 0
# ASCENDING: {bool} -- if True, sort values in ascending order, otherwise descending -- DEFAULT True
# SORT_REMAINING: {bool} -- sort by the remaining levels after level
```

## DATA LOADING, STORAGE FILE FORMATS

```py
pd.read_fwf(filepath, colspecs='infer', widths=None, infer_nrows=100)  # read a table of fixed-width formatted lines into DataFrame
# FILEPATH: {str, path object} -- any valid string path is acceptable, could be a URL. Valid URLs: http, ftp, s3, and file
# COLSPECS: {list of tuple (int, int), 'infer'} -- list of tuples giving extents of fixed-width fields of each line as half-open intervals { [from, to) }
# WIDTHS: {list of int} -- list of field widths which can be used instead of ‘colspecs’ if intervals are contiguous
# INFER_ROWS: {int} -- number of rows to consider when letting parser determine colspecs -- DEFAULT 100

pd.read_excel()  # read an Excel file into a pandas DataFrame
pd.read_json()  # convert a JSON string to pandas object
pd.read_html()  # read HTML tables into a list of DataFrame objects
pd.read_sql()  # read SQL query or database table into a DataFrame

pd.read_csv(filepath, sep=',', *args, **kwargs )  # read a comma-separated values (csv) file into DataFrame
pd.read_table(filepath, sep='\t', *args, **kwargs)  # read general delimited file into DataFrame
# FILEPATH: {str, path object} -- any valid string path is acceptable, could be a URL. Valid URLs: http, ftp, s3, and file
# SEP: {str} -- delimiter to use -- DEFAULT \t (tab)
# HEADER {int, list of int, 'infer'} -- row numbers to use as column names, and the start of the data -- DEFAULT 'infer'
# NAMES:{array} -- list of column names to use -- DEFAULT None
# INDEX_COL: {int, str, False, sequnce of int/str, None} -- Columns to use as row labels of DataFrame, given as string name or column index -- DEFAULT None
# SKIPROWS: {list-like, int, callable} -- Line numbers to skip (0-indexed) or number of lines to skip (int) at the start of the file
# NA_VALUES: {scalar, str, list-like, dict} -- additional strings to recognize as NA/NaN. if dict passed, specific per-column NA values
# THOUSANDS: {str} -- thousand separator
# *ARGS, **KWARGS -- SEE DOCS

# write object to a comma-separated values (csv) file
pd.DataFrame.to_csv(self, path_or_buf, sep=',', na_rep='', columns=None, header=True, index=True, encoding='utf-8', line_terminator=None, decimal='.', *args, **kwargs)
# SEP: {str len 1} --  Field delimiter for the output file
# NA_REP: {str} -- missing data representation
# COLUMNS: {sequence} -- colums to write
# HEADER: {bool, list of str} -- write out column names. if list of strings is given its assumed to be aliases for column names
# INDEX: {bool, list of str} -- write out row names (index)
# ENCODING: {str} -- string representing encoding to use -- DEFAULT ‘utf-8’
# LINE_TERMINATOR: {str} -- newline character or character sequence to use in the output file -- DEFAULT os.linesep
# DECIMAL: {str} -- character recognized as decimal separator (in EU ,)

pd.DataFrame.to_excel()
pd.DataFrame.to_json()
pd.DataFrame.to_html()
pd.DataFrame.to_sql()
```
