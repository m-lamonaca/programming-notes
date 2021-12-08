# OpenGL Textures

A texture is a 2D image (even 1D and 3D textures exist) used to add detail to an object. Because it's possible to insert a lot of detail in a single image, it's possible give the illusion the object is extremely detailed without having to specify extra vertices.

In order to map a texture to the triangle we need to tell each vertex of the triangle which part of the texture it corresponds to.  
Each vertex should thus have a **texture coordinate** associated with them that specifies what part of the texture image to sample from.  
Fragment interpolation then does the rest for the other fragments.

Texture coordinates range from `0` to `1` in the `x` and `y` axis. Retrieving the texture color using texture coordinates is called **sampling**.  
Texture coordinates start at `(0,0)` for the lower left corner of a texture image to `(1,1)` for the upper right corner of a texture image.

## Texture Wrapping

Texture coordinates usually range from `(0,0)` to `(1,1)` but what happens if coordinates outside this range are specified? The default behavior of OpenGL is to repeat the texture images.

But there are more options OpenGL offers:

- `GL_REPEAT`: The default behavior for textures. Repeats the texture image.
- `GL_MIRRORED_REPEAT`: Same as `GL_REPEAT` but mirrors the image with each repeat.
- `GL_CLAMP_TO_EDGE`: Clamps the coordinates between `0` and `1`. The result is that higher coordinates become clamped to the edge, resulting in a stretched edge pattern.
- `GL_CLAMP_TO_BORDER`: Coordinates outside the range are now given a user-specified border color.

```cpp
// s, t, r => coordinate axis
glTexParameteri(<texture_target>, <axis_option>, <texture_wrap_mode>);

glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT)
```

If `GL_CLAMP_TO_BORDER` is chosen, then the border color must be also specified.

```cpp
float borderColor[] = { 1.0f, 1.0f, 0.0f, 1.0f };
glTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_BORDER_COLOR, borderColor);
```

## Texture Filtering

Texture coordinates do not depend on resolution but can be any floating point value, thus OpenGL has to figure out which texture pixel (also known as a **texel**) to map the texture coordinate to. This becomes especially important with a very large object and a low resolution texture.

There are several options available but the most important options are `GL_NEAREST` and `GL_LINEAR`.

`GL_NEAREST` (also known as nearest neighbor or _point filtering_) is the default texture filtering method of OpenGL. When set to GL_NEAREST, OpenGL selects the texel that center is closest
to the texture coordinate.

`GL_LINEAR` (also known as _(bi)linear filtering_) takes an interpolated value from the texture coordinates neighboring texels, approximating a color between the texels.  
The smaller the distance from the texture coordinate to a texel's center, the more that texel's color contributes to the sampled color.

Texture filtering can be set for _magnifying_ and _minifying_ operations (when scaling up or downwards).

```cpp
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
```

## Mipmaps

Since the objects that are far away and probably produce a few fragments, OpenGL has difficulties retrieving the right color value for its fragment from a high resolution texture, since it has to pick a texture color for a fragment that spans a large part of the texture.  
This will produce visible artifacts on small objects, not to mention the waste of memory bandwidth using high resolution textures on small objects.

To solve this issue OpenGL uses a concept called **mipmaps** that is basically a collection of texture images where each subsequent texture is twice as small compared to the previous one.  
After a certain distance threshold from the viewer, OpenGL will use a different mipmap texture that best suits the distance to the object.  
Because the object is far away, the smaller resolution will not be noticeable to the user. OpenGL is then able to sample the correct texels, and there's less cache memory involved when sampling that part of the mipmaps.

Creating a collection of mipmapped textures for each texture image is cumbersome to do manually, but luckily OpenGL is able to do all the work with a single call to `glGenerateMipmaps`
after the texture is created.

When switching between mipmaps levels during rendering OpenGL may show some artifacts like sharp edges visible between the two mipmap layers.  
Just like normal texture filtering, it is also possible to filter between mipmap levels using NEAREST and LINEAR filtering for switching between mipmap levels.

To specify the filtering method between mipmap levels it'ss possible to replace the original filtering methods with one of the following four options:

- `GL_NEAREST_MIPMAP_NEAREST`: takes the nearest mipmap to match the pixel size and uses nearest neighbor interpolation for texture sampling.
- `GL_LINEAR_MIPMAP_NEAREST`: takes the nearest mipmap level and samples that level using linear interpolation.
- `GL_NEAREST_MIPMAP_LINEAR`: linearly interpolates between the two mipmaps that most closely match the size of a pixel and samples the interpolated level via nearest neighbor interpolation.
- `GL_LINEAR_MIPMAP_LINEAR`: linearly interpolates between the two closest mipmaps and samples the interpolated level via linear interpolation.

Just like texture filtering it's possible to set the filtering method to one of the 4 aforementioned methods using `glTexParameteri`:

```cpp
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
```

A common mistake is to set one of the mipmap filtering options as the magnification filter. This doesn't have any effect since mipmaps are primarily used for when textures get downscaled: texture magnification doesn't use mipmaps and giving it a mipmap filtering option will generate an OpenGL `GL_INVALID_ENUM` error code.
