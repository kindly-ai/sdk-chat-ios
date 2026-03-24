# Initialization

## Initialize the SDK

The first step to use the Kindly SDK is to initialize it with your bot key:

```Swift
KindlySDK.start(botKey: "YOUR_BOT_KEY")
```

You can also specify a language code (defaults to "en" if not provided):

```Swift
KindlySDK.start(botKey: "YOUR_BOT_KEY", languageCode: "en")
```

You can also specify the behavior type to choose between native UI and web-based UI:

```Swift
// Use native iOS UI (default)
KindlySDK.start(botKey: "YOUR_BOT_KEY", languageCode: "en", behaviorType: .native)

// Use web-based UI in a WebView
KindlySDK.start(botKey: "YOUR_BOT_KEY", languageCode: "en", behaviorType: .web)
```

You can also provide an authentication callback if your bot requires authentication:

```Swift
KindlySDK.start(botKey: "YOUR_BOT_KEY", languageCode: "en", behaviorType: .native) { chatId, promise in
    // Generate JWT token
    // On success, call
    promise.fulfill("JWT_TOKEN")
    // On error
    promise.reject(ERROR)
}
```

## Change Language at Runtime

You can change the language after initialization using:

```Swift
KindlySDK.setLanguage("lt")  // Change to Lithuanian
```

The language setting will persist across chat sessions until explicitly changed.

## Behavior Types

The SDK supports two display modes:

### Native Behavior (Default)

- Uses native iOS UI components
- Fully integrated with iOS design patterns
- Optimal performance and user experience
- Full feature support

### Web Behavior

- Displays the chat interface in a WebView
- Uses the same web-based chat interface as your website
- Consistent cross-platform appearance
- Automatic chat opening and closing
- JavaScript bridge for seamless integration

```Swift
// Native behavior (recommended for most apps)
KindlySDK.start(botKey: "YOUR_BOT_KEY", behaviorType: .native)

// Web behavior (for consistent web experience)
KindlySDK.start(botKey: "YOUR_BOT_KEY", behaviorType: .web)
```

**Note:** The behavior type can only be set during SDK initialization and cannot be changed at runtime.

## Bot Switching and Reinitialization

The SDK intelligently handles bot switching and reinitialization scenarios when you call `start()` multiple times with different parameters.

### Automatic Bot Key Switching

When you call `start()` with a **different bot key**, the SDK automatically:

1. **Detects the change**: Compares the new bot key with the current one
2. **Performs cleanup**: Calls `disconnect()` internally to end the current session
3. **Resets state**: Clears SDK initialization flags and session data  
4. **Reinitializes**: Connects to the new bot seamlessly

```swift
// First initialization
KindlySDK.start(botKey: "bot-key-1")
KindlySDK.displayChat()

// Later, switch to different bot - automatic cleanup happens
KindlySDK.start(botKey: "bot-key-2")  // SDK handles cleanup internally
KindlySDK.displayChat()
```

### Behavior Type Changes

When you call `start()` with the **same bot key but different behavior type**:

```swift
// Start with native behavior
KindlySDK.start(botKey: "YOUR_BOT_KEY", behaviorType: .native)

// Switch to web behavior with same bot - automatic reinitialization
KindlySDK.start(botKey: "YOUR_BOT_KEY", behaviorType: .web)
```

The SDK will automatically disconnect and reinitialize with the new behavior type.

### Connection State Handling  

When the SDK is **disconnected** (e.g., after calling `endChat()`), calling `start()` with the same bot key and behavior type will **reconnect**:

```swift
KindlySDK.start(botKey: "YOUR_BOT_KEY")
KindlySDK.displayChat()

// Later, end the chat
KindlySDK.endChat()

// Reconnect with same bot key - allowed reconnection
KindlySDK.start(botKey: "YOUR_BOT_KEY")  // Reconnects instead of skipping
KindlySDK.displayChat()
```

### Skipping Duplicate Initialization

The SDK **skips initialization** only when all conditions are met:
- Same bot key
- Same behavior type  
- **Still connected** (not disconnected)

```swift
KindlySDK.start(botKey: "YOUR_BOT_KEY", behaviorType: .native)
// This second call will be skipped - no changes needed
KindlySDK.start(botKey: "YOUR_BOT_KEY", behaviorType: .native)  
```

### Best Practices for Bot Switching

### Option 1: Automatic Switching (Recommended)
```swift
// SDK handles cleanup automatically
KindlySDK.start(botKey: "new-bot-key")
KindlySDK.displayChat()
```

### Option 2: Explicit End-then-Start
```swift
// Explicit control over the lifecycle
KindlySDK.endChat().then(on: DispatchQueue.main) { _ in
    KindlySDK.start(botKey: "new-bot-key")
    KindlySDK.displayChat()
}
```

Both approaches work identically - choose based on your preference for explicit vs automatic lifecycle management.

For more details on authentication, see [Authentication](authentication.md).
