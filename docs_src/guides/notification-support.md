# Notification Support

## Push Notifications in Handover
First provide the SDK with the Apple push notification token using:

```Swift
KindlySDK.setAPNSDeviceToken(_ deviceToken: Data)
```

```Swift
KindlySDK.setAPNSDeviceToken(_ deviceToken: String)
```

## When a Push Notification is Received
Forward the notification to SDK using

```Swift
KindlySDK.notificationReceived(_ userInfo: [AnyHashable : Any])
```

```Swift
KindlySDK.notificationReceived(_ notification: UNNotification)
```
The SDK will double-check if notification type is a Kindly notification before handling it

## Check if a Notification is from Kindly
To determine if a notification should be handled by the Kindly SDK or another notification provider (like mParticle or Braze), use the following helper method:

```Swift
let isKindlyNotification = KindlySDK.isKindlyNotification(_ userInfo: [AnyHashable : Any])
```

This can be particularly useful when integrating with multiple push notification providers. Example usage:

```Swift
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    if KindlySDK.isKindlyNotification(userInfo) {
        // Handle with Kindly SDK
        KindlySDK.notificationReceived(userInfo)
    } else {
        // Handle with another notification provider (e.g., mParticle/Braze)
        otherNotificationProvider.handleNotification(userInfo)
    }
    
    completionHandler(.newData)
}
```

## When a Notification is Clicked
```Swift
KindlySDK.notificationResponseReceived(_ response: UNNotificationResponse)
```