# App.xaml

## Root Tag

The `<Application>` tag begins with two XML namespace declarations, both of which are URIs.

The default namespace belongs to **Xamarin**. This is the XML namespace (`xmlns`) for elements in the file with no prefix, such as the `ContentPage` tag.
The URI includes the year that this namespace came into being and the word *forms* as an abbreviation for Xamarin.Forms.

The second namespace is associated with a prefix of `x` by convention, and it belongs to **Microsoft**. This namespace refers to elements and attributes that are intrinsic to XAML and are found in every XAML implementation.
The word *winfx* refers to a name once used for the .NET Framework 3.0, which introduced WPF and XAML.

The `x:Class` attribute can appear only on the root element of a XAML file. It specifies the .NET namespace and name of a derived class. The base class of this derived class is the root element.

In other words, this `x:Class` specification indicates that the `App` class in the `AppName` namespace derives from `Application`.
That's exactly the same information as the `App` class definition in the `App.xaml.cs` file.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Application xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="AppName.App">
</Application>
```

## Shared Resources

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Application xmlns="http://xamarin.com/schemas/2014/forms"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="AppName.App">

    <!-- collection of shared resources definitions -->
    <Application.Resources>

        <!-- Application resource dictionary -->
        <ResourceDictionary>
            <!-- Key-Value Pair -->
            <Type x:Key="DictKey">value<Type>
        </ResourceDictionary>

        <!-- define a reusable style -->
        <Style x:Key="Style Name" TargetType="Element Type">
            <!-- set properties of the style -->
            <Setter Property="PropertyName" Value="PropertyValue">
        </Style>

    </Application.Resources>
</Application>
```
