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

## Distributing the app

### APK vs Bundle

- APK: android executable, contains all assets of the app (multiple versions for each device). The user downloads all the assets.
- Bundle: split the assets based on device specs. The users downloads only the assets needed for the target device.

### APK generation & [App Signing](https://developer.android.com/studio/publish/app-signing)

- **Key store path**: location where the keystore file will be stored.
- **Key store password**: secure password for the keystore (**to be remembered**).
- **Key alias**: identifying name for the key (**to be remembered**).
- **Key password**: secure password for the key (**to be remembered**).

The keystore identifies the app and it's developers. It's needed for APK generation and releases distribution.
