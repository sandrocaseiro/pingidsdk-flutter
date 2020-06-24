# pingidsdk plugin

Flutter plugin to support [PingID SDK](https://www.pingidentity.com/en/lp/b/pingid-sdk.html) Integration. Currently implemented all events and mostly methods of the SDK v1.11. 

[![pub package](https://img.shields.io/pub/v/pingidsdk.svg)](https://pub.dev/packages/pingidsdk)

## Usage

Add `pingidsdk` as as dependency and download the [PingID SDK Integration Kit](https://www.pingidentity.com/en/resources/downloads/pingid.html). You may need to create an account to do so.

To use the authentication flows, you will also need a linked Firebase project.

Import the package in your .dart file and get the PingIDSDK instance
```dart
import 'package:pingidsdk/pingidsdk.dart' as ping;

final ping.PingIDSDK _ping = ping.PingIDSDK.instance;
```

All PingID SDK events are available throught Streams, so you need to listen for them and after they are no longer needed, you should call `.cancel()` to prevent leaks.

```dart
StreamSubscription<ping.PairingCompleted> _pairingCompletedSub;

@overrride
void initState() {
    super.initState();
    init();
}

Future<void> init() async {
    _pairingCompletedSub = _ping.pairingCompleted.listen((args) async {
      //Pairing completed event called from native code
    });

    //Calling SDK method from Flutter
    bool isTrusted = await _ping.deviceIsTrusted;
}

@override
void dispose() {
    _pairingCompletedSub.cancel();
    super.dispose();
}
```

For instructions on how does PingID SDK works, please check Ping Identity [documentation](https://apidocs.pingidentity.com/pingid-sdk/guide/mobile-api/).

## Installation

### Android integration

1. Add the PingID_SDK.aar module as PingID_SDK to your project using [this instructions](https://developer.android.com/studio/projects/android-library#AddDependency).

2. Update your `[project]/android/local.properties` file with your PingID application.
```properties
...
ping.applicationId=YOUR_APP_ID
```

If you wish to use authentication as well, you need to also make the following changes: 

1. Using the [Firebase Console](https://console.firebase.google.com/) add an Android app to your project: Follow the assistant, download the generated `google-services.json` file and place it inside `android/app`.

2. Add the classpath to the `[project]/android/build.gradle` file.
```gradle
dependencies {
  ...
  // Add the google services classpath
  classpath 'com.google.gms:google-services:4.3.2'
}
```
3. Add the apply plugin to the `[project]/android/app/build.gradle` file.
```gradle
apply plugin: 'com.google.gms.google-services'
```
4. Update your `[project]/android/local.properties` file with your Firebase's project Push Sender ID.
```properties
...
ping.pushSenderId=YOUR_PUSH_SENDER_ID
```

### iOS Integration

1. Create the [APNS Certificates](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html) from your Apple Developer account and upload them to PingOne.

2. On your project navigator, go to General and then drag the PingID_SDK.xcframework to Frameworks, Libraries, and Embedded Content

3. Go to Signing & Capabilities and enable *Push Notifications* and *Background Modes -> Remote notifications*

4. You need to create as bridge to PingID ObjC code, you can use the file created by Flutter for that `Runner-Bridging-Header.h`
```objectivec
#import "GeneratedPluginRegistrant.h"
#import <PingID_SDK/PingId.h>
```

5. Add `NSLocationWhenInUseUsageDescription` to your project's `Info.plist`

6. Create a file called `Ping.plist` with your Ping configuration:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Your PingID SDK Application ID -->
    <key>APPLICATION_ID</key>
    <string>APP_ID</string>
    <!-- Use Sandbox APNS certificate -->
    <key>DEBUG_CERTIFICATE</key>
    <true/>
</dict>
</plist>
```
