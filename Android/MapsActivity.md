# Maps Activity

[Google Maps Docs](https://developers.google.com/maps/documentation/android-sdk/intro)

Activity sould be **Google Maps Activity**.

In `google_maps_api.xml`:

```xml
<resources>
    <string name="google_maps_key" templateMergeStartegy="preserve", translateble="false">API_KEY</string>
</resources>
```

## Activity Layout (xml)

```xml
<!-- a fragment to contain the map -->
<fragment xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:map="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/<fragment_id>"
    android:name="com.google.android.gms.maps.SupportMapFragment"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".<Activity>" />
```

## Activity Class (kotlin)

```kotlin
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.maps.model.MarkerOptions

class MapsActivity : AppCompatActivity(), OnMapReadyCallback,
        GoogleMap.OnInfoWindowClickListener,
        GoogleMap.OnMarkerClickListener,
        GoogleMap.OnCameraIdleListener{

    private lateinit var mMap: GoogleMap  // declare but not valorize

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.<activity_xml>)

        // add the map to a fragment
        val mapFragment = supportFragmentManager.findFragmentById(R.id.<fragment_id>) as SupportMapFragment
        mapFragment.getMapAsync(this)

    }

    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap
        mMap.setOnMarkerClickListener(this)
        mMap.setOnInfoWindowClickListener(this)

        // Add a marker and move the camera
        val location = LatLng(-34.0, 151.0)  // set loaction with latitude and longitude
        mMap.addMarker(MarkerOptions().position(location).title("Marker in ..."))  // ad the marker to the map with a name and position

        mMap.moveCamera(CameraUpdateFactory.newLatLng(location))  // move camera to the marker
    }

    override fun onInfoWindowClick(p0: Marker?) {

    }

    override fun onMarkerClick(p0: Marker?): Boolean {

    }

    override fun onCameraIdle() {

    }
}
```
