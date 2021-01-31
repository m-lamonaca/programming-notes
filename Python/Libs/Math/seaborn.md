# Seaborn Lib

## Basic Imports For Seaborn

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# set aesthetic parameters in one step
sns.set(style='darkgrid')
#STYLE: {None, darkgrid, whitegrid, dark, white, ticks}
```

## REPLOT (relationship)

```python
sns.replot(x='name_in_data', y='name_in_data', hue='point_color', size='point_size', style='point_shape', data=data)
# HUE, SIZE and STYLE: {name in data} -- used to differenciate points, a sort-of 3rd dimention
# hue behaves differently if the data is categorical or numerical, numerical uses a color gradient
# SORT: {False, True} -- avoid sorting data in function of x
# CI: {None, sd} -- avoid comuting confidence intervals or plot standard deviation
# (aggregate multiple measurements at each x value by plotting the mean and the 95% confidence interval around the mean)
# ESTIMATOR: {None} -- turn off aggregation of multiple observations
# MARKERS: {True, False} -- evidetiate observations with dots
# DASHES: {True, False} -- evidetiate observations with dashes
# COL, ROW: {name in data}  -- categorical variables that will determine the grid of plots
# COL_WRAP: {int} -- “Wrap” the column variable at this width, so that the column facets span multiple rows. Incompatible with a row facet.
# SCATTERPLOT
# depicts the joint distibution of two variables usinga a cloud of points
# kind can be omitted since scatterplot is the default for replot
sns.replot(kind='scatter')  # calls scatterplot()
sns.scatterplot()  # underlying axis-level function of replot()
```

### LINEPLOT

Using semantics in lineplot will determine the aggregation of data.

```python
sns.replot(ci=None, sort=bool, kind='line')
sns.lineplot()  # underlying axis-level function of replot()
```

## CATPLOT (categorical)

Categorical: dicided into discrete groups.

```python
sns.catplot(x='name_in_data', y='name_in_data', data=data)
# HUE: {name in data} -- used to differenciate points, a sort-of 3rd dimention
# COL, ROW: {name in data}  -- categorical variables that will determine the grid of plots
# COL_WRAP: {int} -- “Wrap” the column variable at this width, so that the column facets span multiple rows. Incompatible with a row facet.
# ORDER, HUE_ORDER: {list of strings} -- oreder of categorical levels of the plot
# ROW_ORDER, COL_ORDER: {list of strings} -- order to organize the rows and/or columns of the grid in
# ORIENT: {'v', 'h'} -- Orientation of the plot (can also swap x&y assignement)
# COLOR: {matplotlib color} -- Color for all of the elements, or seed for a gradient palette
# CATEGORICAL SCATTERPLOT - STRIPPLOT
# adjust the positions of points on the categorical axis with a small amount of random “jitter”
sns.catplot(kind='strip', jitter=float)
sns.stripplot()
# SIZE: {float}  -- Diameter of the markers, in points
# JITTER: {False, float} -- magnitude of points jitter (distance from axis)
```

### CATEGORICAL SCATTERPLOT - SWARMPLOT

Adjusts the points along the categorical axis preventing overlap.

```py
sns.catplot(kind='swarm')
sns.swarmplot()
# SIZE: {float}  -- Diameter of the markers, in points
# CATEGORICAL DISTRIBUTION - BOXPLOT
# shows the three quartile values of the distribution along with extreme values
sns.catplot(kind='box')
sns.boxplot()
# HUE: {name in data} -- box for each level of the semantic moved along the categorical axis so they don’t overlap
# DODGE: {bool} -- whether elements should be shifted along the categorical axis if hue is used
```

### CATEGORICAL DISTRIBUTION - VIOLINPLOT

Combines a boxplot with the kernel density estimation procedure.

```py
sns.catplot(kind='violon')
sns.violonplot()
```

### CATEGORICAL DISTRIBUTION - BOXENPLOT

Plot similar to boxplot but optimized for showing more information about the shape of the distribution.  
It is best suited for larger datasets.

```py
sns.catplot(kind='boxen')
sns.boxenplot()
```

### CATEGORICAL ESTIMATE - POINTPLOT

Show point estimates and confidence intervals using scatter plot glyphs.

```py
sns.catplot(kind='point')
sns.pointplot()
# CI: {float, sd} -- size of confidence intervals to draw around estimated values, sd -> standard deviation
# MARKERS: {string, list of strings} --  markers to use for each of the hue levels
# LINESTYLES: {string, list of strings} -- line styles to use for each of the hue levels
# DODGE: {bool, float} -- amount to separate the points for each hue level along the categorical axis
# JOIN: {bool} -- if True, lines will be drawn between point estimates at the same hue level
# SCALE: {float} -- scale factor for the plot elements
# ERRWIDTH: {float} -- thickness of error bar lines (and caps)
# CAPSIZE: {float} -- width of the “caps” on error bars
```

### CATEGORICAL ESTIMATE - BARPLOT

Show point estimates and confidence intervals as rectangular bars.

```py
sns.catplot(kind='bar')
sns.barplot()
# CI: {float, sd} -- size of confidence intervals to draw around estimated values, sd -> standard deviation
# ERRCOLOR: {matplotlib color} -- color for the lines that represent the confidence interval
# ERRWIDTH: {float} -- thickness of error bar lines (and caps)
# CAPSIZE: {float} -- width of the “caps” on error bars
# DODGE: {bool} -- whether elements should be shifted along the categorical axis if hue is used
```

### CATEGORICAL ESTIMATE - COUNTPLOT

Show the counts of observations in each categorical bin using bars.

```py
sns.catplot(kind='count')
sns.countplot()
# DODGE: {bool} -- whether elements should be shifted along the categorical axis if hue is used
```

## UNIVARIATE DISTRIBUTIONS

### DISTPLOT

Flexibly plot a univariate distribution of observations

```py
# A: {series, 1d-array, list}
sns.distplot(a=data)
# BINS: {None, arg for matplotlib hist()} -- specification of hist bins, or None to use Freedman-Diaconis rule
# HIST: {bool} - whether to plot a (normed) histogram
# KDE: {bool} - whether to plot a gaussian kernel density estimate
# HIST_KWD, KDE_KWD, RUG_KWD: {dict} -- keyword arguments for underlying plotting functions
# COLOR: {matplotlib color} -- color to plot everything but the fitted curve in
```

### RUGPLOT

Plot datapoints in an array as sticks on an axis.

```py
# A: {vector} -- 1D array of observations
sns.rugplot(a=data) # -> axes obj with plot on it
# HEIGHT: {scalar} --  height of ticks as proportion of the axis
# AXIS: {'x', 'y'} -- axis to draw rugplot on
# AX: {matplotlib axes} -- axes to draw plot into, otherwise grabs current axes
```

### KDEPLOT

Fit and plot a univariate or bivariate kernel density estimate.

```py
# DATA: {1D array-like} -- inpoy data
sns.kdeplot(data=data)
# DATA2 {1D array-like} -- second input data. if present, a bivariate KDE will be estimated.
# SHADE: {bool} -- if True, shade-in the area under KDE curve (or draw with filled contours is bivariate)
```

## BIVARIATE DISTRIBUTION

### JOINTPLOT

Draw a plot of two variables with bivariate and univariate graphs.

```py
# X, Y: {string, vector} -- data or names of variables in data
sns.jointplot(x=data, y=data)
# DATA:{pandas DataFrame} -- DataFrame when x and y are variable names
# KIND: {'scatter', 'reg', 'resid', 'kde', 'hex'} -- kind of plot to draw
# COLOR: {matplotlib color} -- color used for plot elements
# HEIGHT: {numeric} -- size of figure (it will be square)
# RATIO: {numeric} -- ratio of joint axes height to marginal axes height
# SPACE: {numeric} -- space between the joint and marginal axes
# JOINT_KWD, MARGINAL_KWD, ANNOT_KWD: {dict} -- additional keyword arguments for the plot components
```

## PAIR-WISE RELATIONISPS IN DATASET

### PAIRPLOT

Plot pairwise relationships in a dataset.

```py
# DATA: {pandas DataFrame} -- tidy (long-form) dataframe where each column is a variable and each row is an observation
sns.pairplot(data=pd.DataFrame)
# HUE: {string (variable name)} -- variable in data to map plot aspects to different colors
# HUE_ORDER: {list of strings} -- order for the levels of the hue variable in the palette
# VARS: {list of variable names} -- variables within data to use, otherwise every column with numeric datatype
# X_VARS, Y_VARS: {list of variable names} -- variables within data to use separately for rows and columns of figure
# KIND: {'scatter', 'reg'} -- kind of plot for the non-identity relationships
# DIAG_KIND: {'auto', 'hist', 'kde'} -- Kind of plot for the diagonal subplots. default depends hue
# MARKERS: {matplotlib marker or list}
# HEIGHT:{scalar} -- height (in inches) of each facet
# ASPECT: {scalar} -- aspect * height gives the width (in inches) of each facet
```
