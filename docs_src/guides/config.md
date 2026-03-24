# Configuration

Enable crash reporting

```swift
KindlySDK.enableCrashReporting = true
```

Sentry is bundled with the SDK and used automatically for crash reporting when enabled.

Enable verbose logging (useful for debugging)

```swift
KindlySDK.verboseLogging = true
```

## Chat State

Check if the chat UI is currently displayed

```swift
let isDisplayed = KindlySDK.isChatDisplayed
```

## Notification Handling

Get the notification delegate for handling push notifications

```swift
UNUserNotificationCenter.current().delegate = KindlySDK.notificationDelegate
```

## Attachments

Allow form attachments from camera

```swift
KindlySDK.config.allowCameraAccess = true
```

Allow form attachments from photo library

```swift
KindlySDK.config.allowPhotoLibraryAccess = true
```

