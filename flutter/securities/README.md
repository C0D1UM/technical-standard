# Security

Flutter is a cross-platform development framework, to improve security for Flutter apps, sometimes we have to configure both native Android and iOS apps.

## Android Broadcast Receiver

It's possible that the receiver will accept broadcasts from unknown sources, putting the application at risk.

To prevent Broadcast Receiver from being exported, please add the following code to **AndroidManifest.xml**.

```xml
<application . . .
      android:exported="false" >
    . . .
</application>
```

## Signed with v1 signature scheme

According to an [official](https://source.android.com/security/apksigning#v1)
> v1 signatures do not protect some parts of the APK, such as ZIP metadata. The APK verifier needs to process lots of untrusted (not yet verified) data structures and then discard data not covered by the signatures. This offers a sizeable attack surface. Moreover, the APK verifier must uncompress all compressed entries, consuming more time and memory. To address these issues, Android 7.0 introduced APK Signature Scheme v2.

To avoid v1 signatures, set minSdkVersion 24 (Android 7.0) or higher in **build.gradle**.

> **_Note:_**  Devices with a lower SDK version will not be able to install the application.

SDK versions can be found [here](https://developer.android.com/studio/releases/platforms).

```gradle
// Example: use SDK version 26 (Android 8.0) as minSdkVersion
android {
    . . .

    defaultConfig {
        . . .
        minSdkVersion 26
    }
}
```

## Stack Smashing Protection

When the stack of an application is forced to overflow, stack smashing occurs. This could lead to the app being subverted and crashing.

To enable Stack Smashing Protection in an iOS app, follow these steps

1. In Xcode, select your target in the "Targets" section, then click the "Build Settings" tab to view the target's settings.
1. Make sure that the "-fstack-protector-all" option is selected in the "Other C Flags" section.
1. Make sure that Position Independent Executables (PIE) support is enabled.

## ADB backup

A malicious APK file can be injected into the backup archive by an attacker.

To disable backup, put this code to **AndroidManifest.xml** .

```xml
<application . . .
      android:allowBackup="false" >
    . . .
</application>
```

## App Content Protection

Some applications may include sensitive data. Please take the following steps to protect your data from screenshots, screensharing, and seeing what's going on while apps are running in the background.

### Android

In **MainActivity.kt**, put this code.

```kt
. . .

import android.os.Bundle
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        . . .

        getWindow().addFlags(LayoutParams.FLAG_SECURE)
        super.onCreate(savedInstanceState)
    }

    . . .
}
```

### iOS

In **AppDelegate.swift**, put this code.

```swift
. . .

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  . . .
    
  override func applicationWillResignActive(
    _ application: UIApplication
  ) {
    . . .

    self.window.isHidden = true;
  }
  
  override func applicationDidBecomeActive(
    _ application: UIApplication
  ) {
    . . .

    self.window.isHidden = false;
  }
}
```
