# PyCairo

## Definitions

To do some drawing in PyCairo, we must first create a `Drawing Context`.  
The drawing context holds all of the graphics state parameters that describe how drawing is to be done.  
This includes information such as line width, color, the surface to draw to, and many other things.  
It allows the actual drawing functions to take fewer arguments to simplify the interface.

A `Path` is a collection of points used to create primitive shapes such as lines, arcs, and curves. There are two kinds of paths: open and closed paths.  
In a closed path, starting and ending points meet. In an open path, starting and ending point do not meet. In PyCairo, we start with an empty path.  
First, we define a path and then we make them visible by stroking and/or filling them. After each `stroke()` or `fill()` method call, the path is emptied.  
We have to define a new path. If we want to keep the existing path for later drawing, we can use the `stroke_preserve()` and `fill_preserve()` methods.  
A path is made of sub-paths.

A `Source` is the paint we use in drawing. We can compare the source to a pen or ink that we use to draw the outlines and fill the shapes.  
There are four kinds of basic sources: colors, gradients, patterns, and images.

A `Surface` is a destination that we are drawing to. We can render documents using the PDF or PostScript surfaces, directly draw to a platform via the Xlib and Win32 surfaces.

Before the source is applied to the surface, it is filtered first. The `Mask` is used as a filter.  
It determines where the source is applied and where not. Opaque parts of the mask allow to copy the source.  
Transparent parts do not let to copy the source to the surface.

A `Pattern` represents a source when drawing onto a surface.  
In PyCairo, a pattern is something that you can read from and that is used as the source or mask of a drawing operation.  
Patterns can be solid, surface-based, or gradients.

## Initial Settings

### Context and Surface Setup

```py
surface = cairo.ImageSurface(FORMAT, width, height)    # surface setup
context = cairo.Context(surface)    # drawing context setup

```

Formats:

* `FORMAT_ARGB32`:  
  each pixel is a 32-bit quantity, with alpha in the upper 8 bits, then red, then green, then blue.  
  The 32-bit quantities are stored native-endian. Pre-multiplied alpha is used.  
  (That is, 50% transparent red is 0x80800000, not 0x80ff0000.)

* `FORMAT_RGB24`:  
  each pixel is a 32-bit quantity, with the upper 8 bits unused.  
  Red, Green, and Blue are stored in the remaining 24 bits in that order.

* `FORMAT_A8`:  
  each pixel is a 8-bit quantity holding an alpha value.

* `FORMAT_A1`:  
   each pixel is a 1-bit quantity holding an alpha value. Pixels are packed together into 32-bit quantities.  
   The ordering of the bits matches the endianess of the platform.  
   On a big-endian machine, the first pixel is in the uppermost bit, on a little-endian machine the first pixel is in the least-significant bit.

* `FORMAT_RGB16_565`:  
  each pixel is a 16-bit quantity with red in the upper 5 bits, then green in the middle 6 bits, and blue in the lower 5 bits.

### Source Setup

```py
# Sets the source pattern within Context to an opaque color.
# This opaque color will then be used for any subsequent drawing operation until a new source pattern is set.
context.set_source_rgb(red, green, blue)
# The color components are floating point numbers in the range 0 to 1.
# The default source pattern is opaque black -- set_source_rgb(0.0, 0.0, 0.0).
```

## Drawing

### Lines and Arcs

`context.move_to(x, y)` begins a new sub-path. After this call the current point will be `(x, y)`.  

`context.line_to(x, y)` adds a line to the path from the current position to `(x, y)`

### Path

`context.new_path()` clears current PATH. After this call there will be no path and no current point.  

`context.new_sub_path()` begins a new sub-path. Note that the existing path is not affected. After this call there will be no current point.  
In many cases, this call is not needed since new sub-paths are frequently started with `Context.move_to()`.  
A call to `new_sub_path()` is particularly useful when beginning a new sub-path with one of the `Context.arc()` calls.  
This makes things easier as it is no longer necessary to manually compute the arc's initial coordinates for a call to `Context.move_to()`.

### Stroke

A drawing operator that strokes the current path according to the current line width, line join, line cap, and dash settings.  
After `stroke()`, the current path will be cleared from the cairo context.

### Fill

A drawing operator that fills the current path according to the current *fill rule*.  
(each sub-path is implicitly closed before being filled).  
After `fill()`, the current path will be cleared from the Context.

`context.set_fill_rule(fill_rule)` set a FILL RULE to the cairo context.

For both fill rules, whether or not a point is included in the fill is determined by taking a ray from that point to infinity and looking at intersections with the path.  
The ray can be in any direction, as long as it doesn't pass through the end point of a segment or have a tricky intersection such as intersecting tangent to the path.  
(Note that filling is not actually implemented in this way. This is just a description of the rule that is applied.)

* `cairo.FILL_RULE_WINDING` (default):  
    If the path crosses the ray from left-to-right, counts +1. If the path crosses the ray from right to left, counts -1.  
    (Left and right are determined from the perspective of looking along the ray from the starting point.)  
    If the total count is non-zero, the point will be filled.

* `cairo.FILL_RULE_EVEN_ODD`:  
    Counts the total number of intersections, without regard to the orientation of the contour.  
    If the total number of intersections is odd, the point will be filled.

## Writing

```py
surface = cairo.ImageSurface(FORMAT, width, height)    # surface setup
context = cairo.Context(surface)    # drawing context setup

# Replaces the current FontFace object in the Context.
context.set_font_face(family, slant, weight)
context.set_font_size()    # float -- he new font size, in user space units. DEFAULT 10.0

context.show_text(string)
```

Font Slants:

* `FONT_SLANT_NORMAL` (default)
* `FONT_SLANT_ITALIC`
* `FONT_SLANT_OBLIQUE`

Font Weights:

* `FONT_WEIGHT_NORMAL` (default)
* `FONT_WEIGHT_BOLD`

## Creating the image

```py
surface.show_page()    # Emits and clears the current page for backends that support multiple pages. Use copy_page() if you don't want to clear the page.

surface.copy_page()   # Emits the current page for backends that support multiple pages, but doesn't clear it, so that the contents of the current page will be retained for the next page. Use show_page() if you want to get an empty page after the emission.

surface.write_to_png("filename")    # Writes the contents of Surface to filename as a PNG image
```
