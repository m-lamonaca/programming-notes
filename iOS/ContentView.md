# ContentView

A page of the app.

## Views, Functions & Variables

`@State` allows the view to respond to every change of the anotated variable. This variables get initialized by the view in which they belong and are not "recieved" from external objects.
SwiftUI memorizes internally the value of the `@State` property and updates the view every time it changes.

`@Binding` is used for properties that are passed to the view from another. The recieveing view can read the binfing value, react to changes and modify it's value.
`@Binding` variables are passed with the prefix `$`,

### Simple View

- Simplest view.
- Permits the visualization of simple UIs.
- Constituited bay a body of type `View`

```swift
struct SimpleViewName: View {

    let CONSTANT: Type
    @State var variable: Type

    func func(){
        @Binding var variable: Type
        // code here
    }

    // property needed
    var body: some View {
        // view contents
    }
}
```

### HStack, VStack, ZStack

Used to organize elements without dealing with constraints or forcing the visualization on devices wih differents screen sizes.

```swift
struct ContentView: View {
    var body: some View {

        // cannot have multiple stack at the same level
        VStack {
            HStack {
                View()
            }
        }
    }
}
```

### Table View

Most common view to present array contents, it automatically hendles the scrolling of the page with the *bounce* effect.
I can be inegrate d in a `NavigaionView` to handle a `DeailView` of a selectted item in the list.

The basic object that creates the table view is the `List()`. It's job is to create a "cell" for every element in the array.
The array can be filttered with a *search bar*.
The array elements can be grouped with the `Section()` object that groups cells under a common name un the table.

```swift
// view name can be any
struct TableView: View {
    var array = [...]

    var body: some View {
        List(array) { iem in
            TableCell(item: item)
        }
    }
}

// view name can be any
struct TableCell: View {
    let item: Any

    var body: some View {
        // cell content
    }
}
```

Every cell can have a link to visualize he details of the selected object. This is done by using `NavigationView` and `NavigationLink`.

The `NavigationView` contains the list and the property `.navigationBarTitle()` sets the view title.
It's possible to add other controls in the top part of the view (buttons, ...) using the property `.navigationBarItems()`.

```swift
struct ContentView: View {
    let array = [...]
    var body: some View {
        NavigationView {
            List(array) { item in
                NavigationLink(destination: View()) {
                    // link UI
                }
            }.navigationBarTitle(Text("Title"))
        }
    }
}
```

### Tab Bar View

This view handles a bar on the botom of the screen with links to simple or more comlpex views.
This is useful for designing pages that can be easely navigated by the user.

```swift
struct TabBarView: View {
    var body: some View {

        // first tab
        Text("Tab Title")
            .tabItem{
                // tab selector design example
                Image(systemImage: "house.fill")
                Text("Home")
            }

        // n-th tab
        Text("Tab Title")
        .tabItem{
            // tab selector design
        }
    }
}
```

The `TabBar` conostruction is made applying the `.tabItem{}` parameter to the object or page that the tab will link to.
It's possible to specify up to 5 `.tabItem{}` elements that will be displayed singularly in the `TabBar`.

Fron the 6th elemnet onwards, the first 4 elemens will appear normally, meanwhile the 5th will become a "more" element that will open a `TableView` with the list of the other `.tabItem{}` elements. This page permis to define which elements will be visible.

It's possible to integrate the NavigationView in the TabBar in two ways:

- inserting it as a container for the whole `TabBar` (at the moment of the transistion to the detail page the `TabBar` will be hidden)
- inserting it as a container of a single `.tabItem{}` (the transition will happen inside the `TabBar` that will then remain visible)

## View Elements

### Text

```swift
Text("")
```

### Shapes

```swift
Rectangle()
Circle()
```

### Spacing

```swift
Divider()
Spacer()
```

### Image

[System Images](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/)

```swift
Image(systemName: "sfsymbol")
```

### Button

```swift
Button(action: { /* statements */ }) {
    Text("Label")
    //or
    Image(systemName = "sfsymbol")
}

// button with alert popup
Button(action: { /* statements */ }) {
    Text("abel")
}.action(isPresented: $boolBinding) {
    Alert(title: Text("Alert Popup Title"), message: Text("Alert Message"))
}
```

### Style Options

Common syle options:

- `padding()`: adds an internal padding to the object.
- `foregroundColor()`: defines the color of the text or containd object.
- `background()`: defines the background color.
- `font()`: sets font type, size, weight, ...
- `cornerRadius()`: modifies the angles of the containing box.
- `frame()`: sets a fixed size for the object.
- `resizable()`, `scaleToFill()`, `scaleToFit()`: habled the resizing of an object inside another.
- `clipShape()`: overlays a shape over the object
- `overlay()`:  overlays an element over the object, more complex than clipShape
- `shadow()`: Sets the object's shadow
- `lineLimit()`: limits the number of visible lines in `TextField`

```swift
View().styleOption()
// or
View {

}.styleOPtion()
```

## Forms & Input

```swift
Form {
    Section (header: Text("Section Title")) {
        // form components
    }
}
```

### Picker

```swift
// list item picker
Picker(selction: $index, label: Text("Selection Title")) {
    ForEach(0..<itemArray.count){
        Text(itemArray[$0]).tag($0)  // tag adds the index of the selected item to the info of the Text()
    }
}
```

### Stepper

```swift
Stepper("\(number)", value: $number, in: start...end)
```

### TextField

```swift
TextField("Placeholder Text", text: $result)
    .keyboardType(.<kb_type>)
```

### Slider

```swift
Slider(value: $numVariable)
```

## API Interaction

```swift
@State private var apiItems = [<struct>]()

// struct sould be Identifiable & Codable

func loadData() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
    else { print("Invalid URL") return }

    let request = URLRequest(url: url)

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let response = try? JSONDecoder().decode([TaskEntry].self, from: data) {
                DispatchQueue.main.async {
                    self.itemsApi = response
                }
                return
            }
        }
    }.resume()
}
```
