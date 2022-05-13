# Pillow

## Standard Imports

```py
from PIL import Image
```

## OPENING IMAGE FILE

Returns `IOError` if file cannot be opened.

```py
image = Image.open(filepath, mode)    # open image file (returns Image object)
# FILEPATH: filename (string) or file object (musk implement seek, tell, write methods)

image.format    # image file extension
image.size    # 2-tuple (width, height) in pixels
image.mode    # defines number and name of bands in image, pixel type and depth
```

## SAVING IMAGE FILE

```py
image.save(filepath, fmt)
# FMT: optional format override
```

## IMAGE CROPPING

```py
box = (left, top, right, bottom)    # position in pixels
cropped = image.crop(box)
```

## IMAGE PASTE

```èy
# region dimension MUST be same as box
image.paste(region, box)
```

## SPLITTING AND MERGING BANDS

`image.mode` should be RGB

```py
r, g, b = image.split()
img = image.merge(r, g, b)
```
