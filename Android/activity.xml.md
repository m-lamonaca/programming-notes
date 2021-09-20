# Activity.xml

## Resources

### Colors, Style, Strings

These resources are located in `app/src/main/res/values/<resource_type>.xml`  
`@color/colorName` -> access to *color definition* in `colors.xml`  
`@string/stringName` -> access to *string definition* in `strings.xml` (useful for localization)  
`@style/styleName` -> access to *style definition* in `styles.xml`

In `colors.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!--  app bar color  -->
    <color name="colorPrimary">#6200EE</color>
    <!--  status bar color  -->
    <color name="colorPrimaryDark">#3700B3</color>

    <color name="colorAccent">#03DAC5</color>

    <!--  other color definitions  -->
</resources>
```

In `strings.xml`:

```xml
<resources>
    <string name="app_name"> AppName </string>

    <!-- other strings definitions -->
</resources>
```

In `styles.xml`:

```xml
<resources>

    <!-- Base application theme. -->
    <style name="AppTheme" parent="Theme.AppCompat.Light.DarkActionBar">
        <!-- Customize your theme here. -->
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <item name="colorAccent">@color/colorAccent</item>
    </style>

</resources>
```

## View & View Group

A **View** contains a specific element of the layout.  
A **View Group** or **Layout** is a container of Views.

```xml
<View settings/>

<ViewGroup settings>
    ...
</ViewGroup>

```

`android:layout_width`, `android:layout_height`:

* fixed value (dp, sp)  
* match_parent  
* wrap_content

## ViewGroups

### [RelativeLayout](https://developer.android.com/reference/android/widget/RelativeLayout.LayoutParams)

The relative layout containing the view uses the value of these layout parameters to determine where to position the view on the screen.  
If the view is not contained within a relative layout, these attributes are ignored.

```xml
<RelativeLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent">

</RelativeLayout>
```

`android:layout_above`: Positions the bottom edge of this view above the given anchor view ID.
`android:layout_alignBaseline`: Positions the baseline of this view on the baseline of the given anchor view ID.
`android:layout_alignBottom`: Makes the bottom edge of this view match the bottom edge of the given anchor view ID.
`android:layout_alignEnd`: Makes the end edge of this view match the end edge of the given anchor view ID.
`android:layout_alignLeft`: Makes the left edge of this view match the left edge of the given anchor view ID.
`android:layout_alignParentBottom`: If true, makes the bottom edge of this view match the bottom edge of the parent.
`android:layout_alignParentEnd`: If true, makes the end edge of this view match the end edge of the parent.
`android:layout_alignParentLeft`: If true, makes the left edge of this view match the left edge of the parent.
`android:layout_alignParentRight`: If true, makes the right edge of this view match the right edge of the parent.
`android:layout_alignParentStart`: If true, makes the start edge of this view match the start edge of the parent.
`android:layout_alignParentTop`: If true, makes the top edge of this view match the top edge of the parent.
`android:layout_alignRight`: Makes the right edge of this view match the right edge of the given anchor view ID.
`android:layout_alignStart`: Makes the start edge of this view match the start edge of the given anchor view ID.
`android:layout_alignTop`: Makes the top edge of this view match the top edge of the given anchor view ID.
`android:layout_alignWithParentIfMissing`: If set to true, the parent will be used as the anchor when the anchor cannot be be found for layout_toLeftOf, layout_toRightOf, etc.
`android:layout_below`: Positions the top edge of this view below the given anchor view ID.
`android:layout_centerHorizontal`: If true, centers this child horizontally within its parent.
`android:layout_centerInParent`: If true, centers this child horizontally and vertically within its parent.
`android:layout_centerVertical`: If true, centers this child vertically within its parent.
`android:layout_toEndOf`: Positions the start edge of this view to the end of the given anchor view ID.
`android:layout_toLeftOf`: Positions the right edge of this view to the left of the given anchor view ID.
`android:layout_toRightOf`: Positions the left edge of this view to the right of the given anchor view ID.
`android:layout_toStartOf`: Positions the end edge of this view to the start of the given anchor view ID.

### [LinearLayout](https://developer.android.com/reference/android/widget/LinearLayout.LayoutParams)

Layout that arranges other views either horizontally in a single column or vertically in a single row.

```xml
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical">  <!-- or horizontal -->

</LinearLayout>
```

`android:layout_weight`: Indicates how much of the extra space in the LinearLayout is allocated to the view associated with these LayoutParams.
`android:layout_margin`: Specifies extra space on the left, top, right and bottom sides of this view.
`android:layout_marginBottom`: Specifies extra space on the bottom side of this view.
`android:layout_marginEnd`: Specifies extra space on the end side of this view.
`android:layout_marginHorizontal`: Specifies extra space on the left and right sides of this view.
`android:layout_marginLeft`: Specifies extra space on the left side of this view.
`android:layout_marginRight`: Specifies extra space on the right side of this view.
`android:layout_marginStart`: Specifies extra space on the start side of this view.
`android:layout_marginTop`: Specifies extra space on the top side of this view.
`android:layout_marginVertical`: Specifies extra space on the top and bottom sides of this view.
`android:layout_height`: Specifies the basic height of the view.
`android:layout_width`: Specifies the basic width of the view.  

## Views

```xml
<!--ID is necessary for identification -->
<View
    android:id="@+id/uniqueId"
    android:layout_width="value"
    android:layout_height="value"
/>
```

### TextView

To add `...` to truncate a string:

```xml
<!-- maxLines + ellipsize works only in API 22+ -->
<TextView
    maxLines="n"
    ellipsize="end" />
```

### ScrollView

The scroll view can only have one child. If the child is a layout than the layout can contain many elements.

```xml
<ScrollView
    android:id="@+id/uniqueId"
    android:layout_width="value"
    android:layout_height="value">
        <!-- single child -->
</ScrollView>
```

### RecyclerView

List of items

In `build.gradle`:

```gradle
dependencies {
    implementation "androidx.recyclerview:recyclerview:<version>"
    // For control over item selection of both touch and mouse driven selection
    implementation "androidx.recyclerview:recyclerview-selection:<version>"
}
```

In `activity.xml`:

```xml
<!-- VIewGroup for a list of items -->
<androidx.recycleview.widget.RecycleView
    android:id="@+id/uniquieId"
    android:layout_width="value"
    android:layout_height="value">
```

In `recyclerViewItem.xml`:

```xml
<!-- list item layout -->
```

### WebView

```xml
<WebView
    android:id="@+id/uniquieId"
    android:layout_width="value"
    android:layout_height="value">
```

## Constraints

If a view is *anchored on both sides* and the width/height is set to `0dp` the view will expand to touch the elements to which is anchored.
