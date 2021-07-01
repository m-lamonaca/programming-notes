# Fragments & FragmentActivity

[Documentation](https://developer.android.com/guide/components/fragments)

A **Fragment** represents a behavior or a portion of user interface in a `FragmentActivity`. It's possible to combine multiple fragments in a single activity to build a multi-pane UI and reuse a fragment in multiple activities.  
Think of a fragment as a *modular section of an activity*, which has its *own* lifecycle, receives its *own* input events, and which you can add or remove while the activity is running (sort of like a "sub activity" that you can reuse in different activities).

![Fragment](../.images/android_fragments.png)

A fragment must always be hosted in an activity and the fragment's lifecycle is *directly affected* by the host activity's lifecycle.

![Fragment Lifecycle](../.images/android_fragment-lifecycle.png)

## Minimal Fragment Functions

Usually, you should implement at least the following lifecycle methods:

`onCreate()`
The system calls this when creating the fragment. Within your implementation, you should initialize essential components of the fragment that you want to retain when the fragment is paused or stopped, then resumed.

`onCreateView()`
The system calls this when it's time for the fragment to draw its user interface for the first time. To draw a UI for your fragment, you must return a View from this method that is the root of your fragment's layout. You can return null if the fragment does not provide a UI.

`onPause()`
The system calls this method as the first indication that the user is leaving the fragment (though it doesn't always mean the fragment is being destroyed). This is usually where you should commit any changes that should be persisted beyond the current user session (because the user might not come back).

## Fragment Subclasses

`DialogFragment`
Displays a floating dialog. Using this class to create a dialog is a good alternative to using the dialog helper methods in the Activity class, because you can incorporate a fragment dialog into the back stack of fragments managed by the activity, allowing the user to return to a dismissed fragment.

`ListFragment`
Displays a list of items that are managed by an adapter (such as a SimpleCursorAdapter), similar to ListActivity. It provides several methods for managing a list view, such as the onListItemClick() callback to handle click events. (Note that the preferred method for displaying a list is to use RecyclerView instead of ListView. In this case you would need to create a fragment that includes a RecyclerView in its layout. See Create a List with RecyclerView to learn how.)

`PreferenceFragmentCompat`
Displays a hierarchy of Preference objects as a list. This is used to create a settings screen for your application.

## Fragment Insertion in Layout (Method 1)

In `Activity.xml`:

```xml
<!-- Activity.xml boilerplate -->

<!-- Fragment drawn at Activity start cannot be drawn on event -->
<fragment
        android:name="com.<app>.<Fragment>"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:id="@+id/fragment_id" />

<!-- Activity.xml boilerplate -->
```

In `Fragment.kt`:

```kotlin
package <package>

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

/**
 * A simple [Fragment] subclass.
 */
class FirstFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle? ): View? {
        // Inflate the layout for this fragment (draw and insert fragment in Activity)
        return inflater.inflate(R.layout.<fragment_xml>, container, false)
    }

    //called after fragment is drawn (ACTIONS GO HERE)
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {

    }
}
```

## Fragment Insertion in Layout (Method 2)

```xml
<!-- Activity.xml boilerplate -->
<layout
        android:id="@+id/containerID"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

<!-- Activity.xml boilerplate -->
```

In `Activity.kt`:

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.<activity_xml>)

    val fragmentID = FragmentClass()

    //insert fragment from kotlin (can be triggered by event)
    supportFragmentManager
        .beginTransaction()
        .add(R.id.<containerID>, fragmentID)
        .commit()

    //replace fragment from kotlin (can be triggered by event)
    supportFragmentManager
        .beginTransaction()
        .replace(R.id.<containerID>, fragmentID)
        .addToBackStack(null)  // remember order of loaded fragment (keep alive previous fragments)
        .commit()
}
```

## Passing Values from Activity to Fragment

In `Activity.kt`:

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.<activity_xml>)

    val fragmentID = FragmentClass()

    val bundle = Bundle()
    bundle.putString("key", "value")  //passed value
    fragmentID.arguments = bundle

    //insert fragment from kotlin (can be triggered by event)
    supportFragmentManager
        .beginTransaction()
        .add(R.id.<containerID>, fragmentID)
        .commit()
}
```

In `Fragment.kt`:

```kotlin
override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle? ): View? {

    value = arguments?.getString("key")  //read passed value

    // Inflate the layout for this fragment (draw and insert fragment in Activity)
    return inflater.inflate(R.layout.<fragment_xml>, container, false)
}
```

![f](https://blog.avenuecode.com/hs-fs/hubfs/The%20activity%20and%20fragment%20lifecycles%20(1).png?width=640&name=The%20activity%20and%20fragment%20lifecycles%20(1).png)
