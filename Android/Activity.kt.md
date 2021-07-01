# Android App Activity.kt

## Logging

```kotlin
Log.i("tag", "logValue")    //info log
Log.d("tag", "logValue")    //debug log
Log.w("tag", "logValue")    //warning log
Log.e("tag", "logValue")    //error log
Log.c("tag", "logValue")    //critical log
```

## Activity Life Cycle

![Life Cycle](../.images/android_activity-lifecycle.png)

```kotlin
package com.its.<appname>

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {

    //entry point of the activity
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.<activity_xml>)
    }

    override fun onStart() {
    }

    override fun onResume() {
    }

    override fun onPause() {
    }

    override fun onStop() {
    }

    override fun onRestart() {
    }

    override fun onDestroy() {
    }
}
```

### Passing data between activities

In *lauching* activity:

```kotlin
private fun openActivity() {

        //target to open Intent(opener, opened)
        val intent = Intent(this, Activity::class.java)

        //pass data to lauched activity
        intent.putExtra("identifier", value)  

        startActivity(intent)  //launch another activity
    }
```

In *launched* activity:

```kotlin
val identifier = intent.get<Type>Extra("identifier")
```

## Hooks

### Resources Hooks

```kotlin
R.<resourceType>.<resourceName>    //access to reource

ContextCompat.getColor(this, colorResource)    //extract color from resources
getString(stringResource)    //extract string from resources
```

### XML hooks

Changes in xml made in kotlin are applied after the app is drawn thus overwriting instructions in xml.

In `activity.xml`:

```xml
<View
    android:id="@+id/<id>"/>
```

in `Activity.kt`:

```kotlin
var element = findViewById(R.id.<id>)    //old method

<id>.poperty = value    //access and modify view contents
```

## Activity Components

### Snackbar

Componed derived from material design. If using old API material design dependency must be set in gradle.

In `build.gradle (Module:app)`:

```gradle
dependencies {
    implementation 'com.google.android.material:material:<sem_ver>'
}
```

In `Activity.kt`:

```kotlin
import com.google.android.material.snackbar.Snackbar

Snackbar
    .make(activityID, message, Snackbar.TIME_ALIVE)  //create snackbar
    .setAction("Button Name", { action })  //add button to snackbar
    .show()
```

## Opening External Content

### Opening URLs

```kotlin
val url = "https://www.google.com"
val intent = Intent(Intent.ACTION_VIEW)

intent.setData(Uri.parse(url))
startActivity(intent)
```

### Sharing Content

```kotlin
val intent = Intent(Intent.ACTION_SEND)

intent.setType("text/plain")  //specifying shared content type
intent.putExtra(Intent.EXTRA_MAIL, "mail@address")  //open mail client and precompile field if share w/ mail
intent.putExtra(Intent.EXTRA_SUBJECT, "subject")
intent.putExtra(Intent.EXTRA_TEXT, "text")  //necessary since type is text
startActivity(Initent.startChooser(intent, "chooser title"))  //let user choose the share app
```

### App Google Maps

[Documentation](https://developers.google.com/maps/documentation/urls/android-intents)

```kotlin
val uri = Uri.parse("geo: <coordinates>")
val intent = Intent(Intent.ACTION_VIEW, uri)
intent.setPackage("com.google.android.apps.maps")  //app to be opened
startActivity(intent)
```

### Make a call (wait for user)

Preset phone number for the call, user needs to press call button to initiate dialing.

```kotlin
fun call() {
    val intent = Intent(Intent.ACTION_DIAL)
    intent.setData(Uri.parse("tel: <phone number>"))
    startActivity(intent)
}

```

### Make a call (directly)

In `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CALL_PHONE" />
```

```kotlin
//https://developer.android.com/training/permissions/requesting

//intercept OS response to permission popup
override fun onRequestPermissionResult(requestCode: Int, permissins: Array<out String>, grantResults: IntArray) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults)
}

fun checkCallPermission() {
    //check if permission to make a call has been granted
    if (ContextCompact.checkSelfPermission(context!!, android.Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
        // i permission has not been granted request it (opens OS popup, no listener aviable)
        ActivityCompat.requestPermissions(context!!, arrrayOf(android.Manifest.permission.CALL_PHONE), requestCode)  //request code neeeds to be specific for the permission
    } else {
        call()  //if permission has been already given
    }
}

@SuppressLint("MissingPermission")  // suppress warnig of unhandled permission (handled in checkCallPermission)
fun call() {
    val intent = Intent(Intent.ACTION_DIAL, Uri.parse("tel: <phone number>"))
    startActivity(intent)
}
```

## Lists (with RecyclerView)

A [LayoutManager][1] is responsible for measuring and positioning item views within a `RecyclerView` as well as determining the policy for when to recycle item views that are no longer visible to the user.
By changing the `LayoutManager` a `RecyclerView` can be used to implement a standard vertically *scrolling list*, a *uniform grid*, *staggered grids*, *horizontally scrolling collections* and more.
Several stock layout managers are provided for general use.

[Adapters][2] provide a binding from an app-specific data set to views that are displayed within a `RecyclerView`.

[1]:https://developer.android.com/reference/kotlin/androidx/recyclerview/widget/RecyclerView.LayoutManager
[2]:https://developer.android.com/reference/kotlin/androidx/recyclerview/widget/RecyclerView.Adapter

```kotlin
var array: ArrayList<T>? = null  //create ArrayList of elements to be displayed
var adapter: RecyclerViewItemAdapter? = null  //create adapter to draw the list in the Activity

array.add(item)  //add item to ArrayList

// create LayoutManager for the recyclerView
val layoutManager = <ViewGroup>LayoutManager(context, <ViewGroup>LayoutManager.VERTICAL, reverseLayout: Bool)
recycleView.LayoutManager = layoutManager  // assign LayoutManager for the recyclerView

// handle adapter var containing null value
if (array != null) {
    adapter = RecyclerViewItemAdapter(array!!)  // valorize adapter with a adaper object
    recyclerView.adapter = adapter  // assing adapter to the recyclerView
}

// add or remom item

// tell the adapter that something is changed
adapter?.notifyDataSetChanged()
```

## WebView

[WebView Docs](https://developerandroid.com/reference/android/webkit/WebView)

```kotlin
webView.webViewClient = object : WebViewClient() {

    // avoid openiing browsed by default, open webview instead
    override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
        view?.loadUrl(url)  // handle every url
        return true
    }

    override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {

        // stay in WebView until website changes
        if (Uri.parse(url).host == "www.website.domain") {
            return false
        }

        Intent(Intent.ACTION_VIEW, Uri.parse(url).apply){
            startActivity(this)  // open br br owser/app when the website changes to external URL
        }
        return true
    }

    webView.settings.javaScriptEnabled = true  // enable javascript
    webView.addJavaScriptInterface(webAppInterface(this, "Android"))  // create bridge between js on website an app

    // if in webView use android back butto to go to previous webpage (if possible)
    override fun onKeyDown(keyCode: Int, event: KeyEvent?) :Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK && webVew,canGoBack()) {  // if previous url exists & back button pressed
            webView.goBack()  // go to previous URL
            return true
        }
    }
}
```

## Web Requests (Using Volley)

[Volley Docs](https://developer.android.com/training/volley)

### Import & Permissions

Import in `build.gradle`:

```kotlin
implementation 'com.android.volley:volley:1.1.1'
```

Perrmissions in `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### Make the request

Subsequnt requests sould be delayed to avoid allowing the user to make too frequent requests.

```kotlin
private lateinit var queue: RequestQueue

override fun onCreate(savedInstanceState: Bundle?){
    queue = Volley.newRequestQueue(context)
}

// response is a String
private fun simpleRequest() {

    var url = "www.website.domain"

    var stringRequest = StringRequest(Request.Method.GET, url, Response.Listener<String> {
        Log.d()
    },
    Response.ErrorListener{
        Log.e()
    })

    stringRequest.TAG = "TAG"  // assign a tag to the request

    queue.add(stringRequest) // add request to the queue
}

// response is JSON Object
private fun getJsonObjectRequest(){
    // GET -> jsonRequest = null
    // POST -> jsonRequest = JsonObject
    var stringRequest = JsonObjectRequest(Request.Method.GET, url, jsonRequest, Response.Listener<String> {
        Log.d()
        // read end use JSON
    },
    Response.ErrorListener{
        Log.e()
    })

    queue.add(stringRequest) // add request to the queue
}

// response is array of JSON objects
private fun getJSONArrayRequest(){
    // GET -> jsonRequest = null
    // POST -> jsonRequest = JsonObject
    var stringRequest = JsonArrayRequest(Request.Method.GET, url, jsonRequest, Response.Listener<String> {
        Log.d()
        // read end use JSON
    },
    Response.ErrorListener{
        Log.e()
    })

    queue.add(stringRequest) // add request to the queue
}


override fun onStop() {
    super.onStop()
    queue?.cancellAll("TAG")  //  delete all request with a particular tag when the activity is closed (avoid crash)
}
```

### Parse JSON Request

```kotlin
Response.Litener { response ->
    var value = response.getSting("key")
}
```

## Data Persistance

### Singleton

Object instantiated during app init and is destroid only on app closing. It can be used for data persistance since is not affected by the destruction of an activity.

```kotlin
// Context: Interface to global information about an application environment.
class Singleton consturctor(context: Context) {

    companion object {

        @Volatile
        private var INSTANCE: Singleton? = null

        // syncronized makes sure that all instances of the singleton are actually the only existing one
        fun getInstance(context: Contecxt) = INSTANCE ?: syncronized(this) {
            INSTANCE ?: Singleton(context).also {
                INSTANCE = it
            }
        }
    }
}
```

### SharedPreferences

[SharedPreferences Docs](https://developer.android.com/training/data-storage/shared-preferences)

**Get a handle to shared preferences**:

- `getSharedPreferences()` — Use this if you need multiple shared preference files identified by name, which you specify with the first parameter. You can call this from any Context in your app.
- `getPreferences()` — Use this from an Activity if you need to use only one shared preference file for the activity. Because this retrieves a default shared preference file that belongs to the activity, you don't need to supply a name.

```kotlin
val sharedPref = activity?.getSharedPreferences( getString(R.string.preference_file_key), Context.MODE_PRIVATE )
val sharedPref = activity?.getPreferences(Context.MODE_PRIVATE)
```

**Write to shared preferences**:

To write to a shared preferences file, create a `SharedPreferences.Editor` by calling `edit()` on your SharedPreferences.

Pass the keys and values to write with methods such as `putInt()` and `putString()`. Then call `apply()` or `commit()` to save the changes.

```kotlin
val sharedPref = activity?.getPreferences(Context.MODE_PRIVATE) ?: return
with (sharedPref.edit()) {
    putInt(getString(R.string.key), value)
    commit()  // or apply()
}
```

`apply()` changes the in-memory `SharedPreferences` object immediately but writes the updates to disk *asynchronously*.
Alternatively, use `commit()` to write the data to disk *synchronously*. But because *commit()* is synchronous, avoid calling it from your main thread because it could pause the UI rendering.

**Read from shared preferences**:

To retrieve values from a shared preferences file, call methods such as getInt() and getString(), providing the key for the wanted value, and optionally a default value to return if the key isn't present.

```kotlin
val sharedPref = activity?.getPreferences(Context.MODE_PRIVATE) ?: return
val defaultValue = resources.getInteger(R.integer.default_value_key)
val value = sharedPref.getInt(getString(R.string.key), defaultValue)
```
