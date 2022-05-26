# NumPy Lib

## MOST IMPORTANT ATTRIBUTES ATTRIBUTES

```py
array.ndim     # number of axes (dimensions) of the array
array.shape  # dimensions of the array, tuple of integers
array.size  # total number of elements in the array
array.itemsize  # size in bytes of each element
array.data  # buffer containing the array elements
```

## ARRAY CREATION

Unless explicitly specified `np.array` tries to infer a good data type for the array that it creates.  
The data type is stored in a special dtype object.

```py
var = np.array(sequence)  # creates array
var = np.asarray(sequence)  # convert input to array
var = np.ndarray(*sequence)  # creates multidimensional array
var = np.asanyarray(*sequence)  # convert the input to an ndarray
# nested sequences will be converted to multidimensional array

var = np.zeros(ndarray.shape)  # array with all zeros
var = np.ones(ndarray.shape)  # array with all ones
var = np.empty(ndarray.shape)  # array with random values
var = np.identity(n)  # identity array (n x n)

var = np.arange(start, stop, step)  # creates an array with parameters specified
var = np.linspace(start, stop, num_of_elements)  # step of elements calculated based on parameters
```

## DATA TYPES FOR NDARRAYS

```py
var = array.astype(np.dtype)  # copy of the array, cast to a specified type
# return TypeError if casting fails
```

The numerical `dtypes` are named the same way: a type name followed by a number indicating the number of bits per element.

| TYPE                              | TYPE CODE    | DESCRIPTION                                                                                |
|-----------------------------------|--------------|--------------------------------------------------------------------------------------------|
| int8, uint8                       | i1, u1       | Signed and unsigned 8-bit (1 byte) integer types                                           |
| int16, uint16                     | i2, u2       | Signed and unsigned 16-bit integer types                                                   |
| int32, uint32                     | i4, u4       | Signed and unsigned 32-bit integer types                                                   |
| int64, uint64                     | i8, u8       | Signed and unsigned 32-bit integer types                                                   |
| float16                           | f2           | Half-precision floating point                                                              |
| float32                           | f4 or f      | Standard single-precision floating point. Compatible with C float                          |
| float64, float128                 | f8 or d      | Standard double-precision floating point. Compatible with C double and Python float object |
| float128                          | f16 or g     | Extended-precision floating point                                                          |
| complex64, complex128, complex256 | c8, c16, c32 | Complex numbers represented by two 32, 64, or 128 floats, respectively                     |
| bool                              | ?            | Boolean type storing True and False values                                                 |
| object                            | O            | Python object type                                                                         |
| string_                           | `S<num>`       | Fixed-length string type (1 byte per character), `<num>` is string length                |
| unicode_                          | `U<num>`      | Fixed-length unicode type, `<num>` is length                                              |

## OPERATIONS BETWEEN ARRAYS AND SCALARS

Any arithmetic operations between equal-size arrays applies the operation element-wise.

array `+` scalar --> element-wise addition (`[1, 2, 3] + 2 = [3, 4, 5]`)
array `-` scalar --> element-wise subtraction (`[1 , 2, 3] - 2 = [-2, 0, 1]`)
array `*` scalar --> element-wise multiplication (`[1, 2, 3] * 3 = [3, 6, 9]`)
array / scalar --> element-wise division (`[1, 2, 3] / 2 = [0.5 , 1 , 1.5]`)

array_1 `+` array_2 --> element-wise addition (`[1, 2, 3] + [1, 2, 3] = [2, 4, 6]`)
array_1 `-` array_2 --> element-wise subtraction (`[1, 2, 4] - [3 , 2, 1] = [-2, 0, 2]`)
array_1 `*` array_2 --> element-wise multiplication (`[1, 2, 3] * [3, 2, 1] = [3, 4, 3]`)
array_1 `/` array_2 --> element-wise division (`[1, 2, 3] / [3, 2, 1] = [0.33, 1, 3]`)

## SHAPE MANIPULATION

```py
np.reshape(array, new_shape)  # changes the shape of the array
np.ravel(array)  #  returns the array flattened
array.resize(shape)  # modifies the array itself
array.T  # returns the array transposed
np.transpose(array)     # returns the array transposed
np.swapaxes(array, first_axis, second_axis)  # interchange two axes of an array
# if array is an ndarray, then a view of it is returned; otherwise a new array is created
```

## JOINING ARRAYS

```py
np.vstack((array1, array2))   # takes tuple, vertical stack of arrays (column wise)
np.hstack((array1, array2))  # takes a tuple, horizontal stack of arrays (row wise)
np.dstack((array1, array2)) # takes a tuple, depth wise stack of arrays (3rd dimension)
np.stack(*arrays, axis)  # joins a sequence of arrays along a new axis (axis is an int)
np.concatenate((array1, array2, ...), axis) # joins a sequence of arrays along an existing axis (axis is an int)
```

## SPLITTING ARRAYS

```py
np.split(array, indices)  # splits an array into equall7 long sub-arrays (indices is int), if not possible raises error
np.vsplit(array, indices)  # splits an array equally into sub-arrays vertically (row wise) if not possible raises error
np.hsplit(array, indices)  # splits an array equally into sub-arrays horizontally (column wise) if not possible raises error
np.dsplit(array, indices)  # splits an array into equally sub-arrays along the 3rd axis (depth) if not possible raises error
np.array_split(array, indices) # splits an array into sub-arrays, arrays can be of different lengths
```

## VIEW()

```py
var = array.view()  # creates a new array that looks at the same data
# slicing returns a view
# view shapes are separated but assignment changes all arrays
```

## COPY()

```py
var = array.copy()  # creates a deep copy of the array
```

## INDEXING, SLICING, ITERATING

1-dimensional  --> sliced, iterated and indexed as standard
n-dimensional --> one index per axis, index given in tuple separated by commas `[i, j] (i, j)`
dots (`...`) represent as many colons as needed to produce complete indexing tuple

- `x[1, 2, ...] == [1, 2, :, :, :]`
- `x[..., 3] == [:, :, :, :, 3]`
- `x[4, ..., 5, :] == [4, :, :, 5, :]`
iteration on first index, use .flat() to iterate over each element
- `x[*bool]` returns row with corresponding True index
- `x[condition]` return only elements that satisfy condition
- x`[[*index]]` return rows ordered by indexes
- `x[[*i], [*j]]` return elements selected by tuple (i, j)
- `x[ np.ix_( [*i], [*j] ) ]` return rectangular region

## UNIVERSAL FUNCTIONS (ufunc)

Functions that performs element-wise operations (vectorization).

```py
np.abs(array)  # vectorized abs(), return element absolute value
np.fabs(array)  # faster abs() for non-complex values
np.sqrt(array)  # vectorized square root (x^0.5)
np.square(array) # vectorized square (x^2)
np.exp(array)  # vectorized natural exponentiation (e^x)
np.log(array)  # vectorized natural log(x)
np.log10(array)  # vectorized log10(x)
np.log2(array)  # vectorized log2(x)
np.log1p(array)  # vectorized log(1 + x)
np.sign(array)  # vectorized sign (1, 0, -1)
np.ceil(array)  # vectorized ceil()
np.floor(array)  # vectorized floor()
np.rint(array)     # vectorized round() to nearest int
np.modf(array)  #  vectorized divmod(), returns the fractional and integral parts of element
np.isnan(array)   # vectorized x == NaN, return boolean array
np.isinf(array)  # vectorized test for positive or negative infinity, return boolean array
np.isfineite(array)  # vectorized test fo finiteness, returns boolean array
np.cos(array)  # vectorized cos(x)
np.sin(array)  # vectorized sin(x)
np.tan(array)  # vectorized tan(x)
np.cosh(array)  # vectorized cosh(x)
np.sinh(array)   # vector sinh(x)
np.tanh(array)  # vectorized tanh(x)
np.arccos(array)  # vectorized arccos(x)
np.arcsinh(array)  # vectorized arcsinh(x)
np.arctan(array)  # vectorized arctan(x)
np.arccosh(array)  # vectorized arccosh(x)
np.arcsinh(array)  # vectorized arcsin(x)
np.arctanh(array)  # vectorized arctanh(x)
np.logical_not(array)  # vectorized not(x), equivalent to -array

np.add(x_array, y_array)  # vectorized addition
np.subtract(x_array, y_array)  # vectorized subtraction
np.multiply(x_array, y_array)  # vectorized multiplication
np.divide(x_array, y_array)  # vectorized division
np.floor_divide(x_array, y_array)  # vectorized floor division
np.power(x_array, y_array)  # vectorized power
np.maximum(x_array, y_array)  # vectorized maximum
np.minimum(x_array, y_array)  # vectorized minimum
np.fmax(x_array, y_array)  # vectorized maximum, ignores NaN
np.fmin(x_array, y_array)  # vectorized minimum, ignores NaN
np.mod(x_array, y_array)  # vectorized modulus
np.copysign(x_array, y_array)  #  vectorized copy sign from y_array to x_array
np.greater(x_array, y_array)  # vectorized x > y
np.less(x_array, y_array)  # vectorized x < y
np.greter_equal(x_array, y_array)  # vectorized x >= y
np.less_equal(x_array, y_array)  # vectorized x <= y
np.equal(x_array, y_array)  # vectorized x == y
np.not_equal(x_array, y_array)  # vectorized x != y
np.logical_and(x_array, y_array)  # vectorized x & y
np.logical_or(x_array, y_array)  # vectorized x | y
np.logical_xor(x_array, y_array)  # vectorized x ^ y
```

## CONDITIONAL LOGIC AS ARRAY OPERATIONS

```py
np.where(condition, x, y)  # return x if condition == True, y otherwise
```

## MATHEMATICAL AND STATISTICAL METHODS

`np.method(array, args)` or `array.method(args)`.  
Boolean values are coerced to 1 (`True`) and 0 (`False`).

```py
np.sum(array, axis=None)  # sum of array elements over a given axis
np.median(array, axis=None)  # median along the specified axis
np.mean(array, axis=None)  # arithmetic mean along the specified axis
np.average(array, axis=None)  #  weighted average along the specified axis
np.std(array, axis=None)  # standard deviation along the specified axis
np.var(array, axis=None)  # variance along the specified axis

np.min(array, axis=None)  # minimum value along the specified axis
np.max(array, axis=None)  # maximum value along the specified axis
np.argmin(array, axis=None)  # indices of the minimum values along an axis
np.argmax(array, axis=None)  # indices of the maximum values
np.cumsum(array, axis=None)  # cumulative sum of the elements along a given axis
np.cumprod(array, axis=None)  # cumulative sum of the elements along a given axis
```

## METHODS FOR BOOLEAN ARRAYS

```py
np.all(array, axis=None)  # test whether all array elements along a given axis evaluate to True
np.any(array, axis=None)  # test whether any array element along a given axis evaluates to True
```

## SORTING

```py
array.sort(axis=-1)  # sort an array in-place (axis = None applies on flattened array)
np.sort(array, axis=-1)  # return a sorted copy of an array (axis = None applies on flattened array)
```

## SET LOGIC

```py
np.unique(array)  # sorted unique elements of an array
np.intersect1d(x, y)  # sorted common elements in x and y
np.union1d(x, y)  # sorte union of elements
np.in1d(x, y)  #  boolean array indicating whether each element of x is contained in y
np.setdiff1d(x, y)  # Set difference, elements in x that are not in y
np.setxor1d()  # Set symmetric differences; elements that are in either of the arrays, but not both
```

## FILE I/O WITH ARRAYS

```py
np.save(file, array)  # save array to binary file in .npy format
np.savez(file, *array) # save several arrays into a single file in uncompressed .npz format
np.savez_compressed(file, *args, *kwargs)  # save several arrays into a single file in compressed .npz format
# *ARGS: arrays to save to the file. arrays will be saved with names "arr_0", "arr_1", and so on
# **KWARGS: arrays to save to the file. arrays will be saved in the file with the keyword names

np.savetxt(file, X, fmt="%.18e", delimiter=" ")   # save array to text file
# X: 1D or 2D
# FMT: Python Format Specification Mini-Language
# DELIMITER: {str} -- string used to separate values

np.load(file, allow_pickle=False)  # load arrays or pickled objects from .npy, .npz or pickled files
np.loadtxt(file, dtype=float, comments="#", delimiter=None)
# DTYPE: {data type} -- data-type of the resulting array
# COMMENTS: {str} -- characters used to indicate the start of a comment. None implies no comments
# DELIMITER: {str} -- string used to separate values
```

## LINEAR ALGEBRA

```py
np.diag(array, k=0)  # extract a diagonal or construct a diagonal array
# K: {int} -- k>0 diagonals above main diagonal, k<0 diagonals below main diagonal (main diagonal k = 0)

np.dot(x ,y)  # matrix dot product
np.trace(array, offset=0, dtype=None, out=None)  # return the sum along diagonals of the array
# OFFSET: {int} -- offset of the diagonal from the main diagonal
# dtype: {dtype} -- determines the data-type of the returned array
# OUT: {ndarray} -- array into which the output is placed

np.linalg.det(A)  # compute the determinant of an array
np.linalg.eig(A)  # compute the eigenvalues and right eigenvectors of a square array
np.linalg.inv(A)  # compute the (multiplicative) inverse of a matrix
# A_inv satisfies dot(A, A_inv) = dor(A_inv, A) = eye(A.shape[0])

np.linalg.pinv(A)  # compute the (Moore-Penrose) pseudo-inverse of a matrix
np.linalg.qr()  # factor the matrix a as qr, where q is orthonormal and r is upper-triangular
np.linalg.svd(A)  # Singular Value Decomposition
np.linalg.solve(A, B)  # solve a linear matrix equation, or system of linear scalar equations AX = B
np.linalg.lstsq(A, B)  # return the least-squares solution to a linear matrix equation AX = B
```

## RANDOM NUMBER GENERATION

```py
np.random.seed()
np.random.rand()
np.random.randn()
np.random.randint()
np.random.Generator.permutation(x)  # randomly permute a sequence, or return a permuted range
np.random.Generator.shuffle(x)  # Modify a sequence in-place by shuffling its contents

np.random.Generator.beta(a, b, size=None)  # draw samples from a Beta distribution
# A: {float, array floats} -- Alpha, > 0
# B: {int, tuple ints} -- Beta, > 0

np.random.Generator.binomial(n, p, size=None)  # draw samples from a binomial distribution
# N: {int, array ints} -- parameter of the distribution, >= 0
# P: {float, arrey floats} -- Parameter of the distribution, >= 0 and <= 1

np.random.Generator.chisquare(df, size=None)
# DF: {float, array floats} -- degrees of freedom, > 0

np.random.Generator.gamma(shape, scale=1.0, size=None)  # draw samples from a Gamma distribution
# SHAPE: {float, array floats} -- shape of the gamma distribution, != 0

np.random.Generator.normal(loc=0.0, scale=1.0, Size=None)  # draw random samples from a normal (Gaussian) distribution
# LOC: {float, all floats} -- mean ("centre") of distribution
# SCALE: {float, all floats} -- standard deviation of distribution, != 0

np.random.Generator.poisson(lam=1.0, size=None)  # draw samples from a Poisson distribution
# LAM: {float, all floats} -- expectation of interval, >= 0

np.random.Generator.uniform(low=0.0,high=1.0, size=None)  # draw samples from a uniform distribution
# LOW: {float, all floats} -- lower boundary of the output interval
# HIGH: {float, all floats} -- upper boundary of the output interval

np.random.Generator.zipf(a, size=None)  # draw samples from a Zipf distribution
# A: {float, all floats} -- distribution parameter, > 1
```
