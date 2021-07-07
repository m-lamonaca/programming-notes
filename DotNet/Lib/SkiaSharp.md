# SkiaSharp

```cs
SKImageInfo info = new SKImageInfo(width, height);

using (SKSurface surface = SKSurface.Create(info))
{
    SKCanvas canvas = surface.Canvas;
    canvas.DrawColor(SKColors.<color>);

    using (SKPaint paint = new SKPaint())
    {
        paint.Color = SKColors.Blue;
        paint.IsAntialias = true;
        paint.StrokeWidth = 5;
        paint.Style = SKPaintStyle.Stroke;

        // draw
        canvas.DrawLine(x0, y0, x1, y1, paint);

    }

    // save to file
    using (var image = surface.Snapshot())
    {
        using (var data = image.Encode(SKEncodedImageFormat.Png, 100))
        {
            using (var stream = File.OpenWrite(png_filename))
            {
                data.SaveTo(stream);
            }
        }
    }
}
```
