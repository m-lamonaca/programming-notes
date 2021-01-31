# Gradle & Building

## `build.gradle` (Module)

```gradle
android {

    defaultconfig{

        applicationId <string>  // app package name

        minSdkVersion <int>  // min API version
        targetSdkVersion <int>  // actual API version

        versionCode <int>  // unique code for each release
        versionName "<string>"
    }
}
```

## Distribuiting the app

### APK vs Bundle

- APK: android executable, contains all assets of the app (multiplr versions for each device). The user downloads all the assets.
- Bundle: split the assets based on dedvice specs. The users donwloads only the assest needed for the target device.

### APK generation & [App Signing](https://developer.android.com/studio/publish/app-signing)

- **Key store path**: location where the keystore file will be stored.
- **Key store password**: secure password for the keystore (**to be rememberd**).
- **Key alias**: identifying name for the key (**to be rememberd**).
- **Key password**: secure password for the key (**to be rememberd**).

The ketstore identifies the app and it's developers. It's needed for APK generation and releases distribution.
