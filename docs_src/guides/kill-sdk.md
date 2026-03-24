# Kill SDK

## Completely Terminate the SDK
```Swift
KindlySDK.kill()
```

The `kill()` method **completely terminates the SDK** and clears all state. This is more destructive than [`endChat()`](end-chat.md) which only disconnects the chat session.

## What kill() does

When you call `kill()`, the SDK will:
- 🔄 **Disconnect the chat session** (same as `endChat()`)
- 🧹 **Clear all session data** including messages and context
- ⚡ **Reset SDK initialization state** 
- 🔑 **Clear bot key and authentication** 
- 🎨 **Reset configuration and themes**
- 📡 **Emit termination events** for cleanup

## After calling kill()

After calling `kill()`, the SDK returns to an **uninitialized state**:
- ❌ You **cannot** call `displayChat()` or other SDK methods
- ✅ You **must** call `start()` again before using any SDK functions
- ✅ All configuration (themes, permissions, etc.) needs to be set up again

## Usage Examples

### Complete SDK Shutdown
```Swift
// Terminate the SDK completely
KindlySDK.kill().then { _ in
    print("✅ SDK completely terminated")
    // SDK is now in uninitialized state
}.catch { error in
    print("❌ Kill failed: \(error)")
}
```

### Switch to Different Bot (Alternative Method)
```Swift
// Method 1: Using kill() for explicit control
KindlySDK.kill().then { _ in
    // SDK is now uninitialized - must call start() again
    KindlySDK.start(botKey: "new-bot-key")
    KindlySDK.displayChat()
}

// Method 2: Automatic switching (recommended)
KindlySDK.start(botKey: "new-bot-key")  // SDK handles cleanup automatically
KindlySDK.displayChat()
```

## When to Use kill() vs endChat()

### Use `kill()` when:
- 🔄 **App shutdown**: Terminating the app or major state changes
- 🔀 **Complete reset**: Need to clear all SDK state and start fresh
- 🐛 **Error recovery**: Recovering from SDK errors or corruption
- 🧪 **Testing**: Ensuring clean state between test runs

### Use `endChat()` when:
- 💬 **End conversation**: User finishes chatting but may return later
- 🔄 **Temporary disconnect**: Preserving SDK state for quick reconnection
- 🎯 **Normal flow**: Standard chat lifecycle management

## Comparison

| Method | Session | SDK State | Bot Key | Config | Next Action |
|--------|---------|-----------|---------|--------|-------------|
| `endChat()` | ❌ Cleared | ✅ Preserved | ✅ Preserved | ✅ Preserved | `displayChat()` |
| `kill()` | ❌ Cleared | ❌ Reset | ❌ Cleared | ❌ Reset | `start()` required |

## Return Value

The `kill()` method returns a `Promise<Void>` that resolves when the termination is complete:

```Swift
KindlySDK.kill()
    .then { _ in
        // SDK termination completed successfully
        print("SDK killed successfully")
    }
    .catch { error in
        // Handle any cleanup errors
        print("Kill error: \(error)")
    }
```

## Best Practices

1. **Always wait for completion** before calling `start()` again:
   ```Swift
   KindlySDK.kill().then { _ in
       // Safe to reinitialize now
       KindlySDK.start(botKey: "new-bot")
   }
   ```

2. **Handle errors gracefully** in case cleanup fails:
   ```Swift
   KindlySDK.kill().catch { error in
       // Log error but continue with app flow
       print("Kill failed, but continuing: \(error)")
   }
   ```

3. **Use automatic bot switching** instead of manual kill/start when possible:
   ```Swift
   // Preferred: Automatic cleanup
   KindlySDK.start(botKey: "new-bot")
   
   // Instead of: Manual cleanup  
   KindlySDK.kill().then { _ in
       KindlySDK.start(botKey: "new-bot")
   }
   ```

For normal chat lifecycle management, prefer [`endChat()`](end-chat.md) over `kill()`.
