# Link Interception

The Kindly SDK allows your app to intercept links that are clicked from within the chat UI. This lets you handle specific links yourself instead of letting the SDK open them.

## How It Works

When a link is clicked inside the SDK (bot message links, button links, source references, etc.), the SDK calls the `shouldHandleLink` delegate method **synchronously** before opening the link.

| Scenario | Result |
|----------|--------|
| Delegate not set | SDK handles the link normally |
| `shouldHandleLink` returns `true` | SDK handles the link normally |
| `shouldHandleLink` returns `false` | SDK does **not** open the link — your app handles it |

## Implementation

**1. Set the delegate:**

```swift
KindlySDK.delegate = self
```

**2. Conform to `KindlyChatClientDelegate`:**

```swift
extension ViewController: KindlyChatClientDelegate {
    func didPressButton(chatButton: ExternalChatButton, chatLog: [ExternalChatMessage]) {
        // Handle button press if needed
    }

    func shouldHandleLink(url: URL) -> Bool {
        // Example: intercept links to your own domain
        if url.host == "www.example.com" {
            // Handle the link yourself (e.g., navigate within your app)
            navigateToInternalPage(url: url)
            return false // Tell the SDK not to open it
        }
        return true // Let the SDK handle all other links
    }
}
```

## Notes

- The `shouldHandleLink` method has a default implementation that returns `true`, so you only need to implement it if you want to intercept links.
- The method is called synchronously — return your decision immediately.
- This applies to all links originating from within the SDK: bot message links, button links, inline HTML links, image links, and source reference links.
