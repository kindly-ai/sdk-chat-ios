# URL Schemes

The Kindly SDK supports deep linking via custom URL schemes. This allows your app to open the chat and trigger specific dialogues from external links.

## Supported URL Format

```
kindly://chat/dialogue/{dialogue_id}
```

When handled, the SDK will:
- If already connected: trigger the dialogue immediately
- If started but not connected: open the chat UI, connect, and trigger the dialogue
- If not started: return `false` (you must call `start()` first)

## Register the URL Scheme

Add the `kindly` URL scheme to your app's `Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>kindly</string>
        </array>
        <key>CFBundleURLName</key>
        <string>com.yourapp.kindly</string>
    </dict>
</array>
```

## Handle the URL

**UIKit (AppDelegate):**

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    if KindlySDK.handleURL(url) {
        return true
    }
    // Handle other URL schemes
    return false
}
```

**UIKit (SceneDelegate):**

```swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    guard let url = URLContexts.first?.url else { return }
    KindlySDK.handleURL(url)
}
```

**SwiftUI:**

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    KindlySDK.handleURL(url)
                }
        }
    }
}
```

## Return Value

`handleURL(_:)` returns `true` if the URL was recognized and handled by the SDK, `false` otherwise.
