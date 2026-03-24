# End Chat

## Disconnect the Chat
_clears the context as well_ 
```Swift
KindlySDK.endChat()
```

**Important:** The `endChat()` method now **preserves the SDK initialization state**. This means:
- ✅ The SDK remains initialized and ready for use
- ✅ You can call `displayChat()` again without needing to call `start()` 
- ✅ Bot key, authentication, and configuration are preserved
- ✅ Only the active chat session and context are cleared

If you need to **completely terminate the SDK**, use [`kill()`](kill-sdk.md) instead.

## Bot Switching Workflows

When switching between different bots, you have two workflow options:

### Option 1: Automatic Switching (Recommended)

The SDK automatically handles cleanup when you switch bot keys:

```Swift
// Current bot
KindlySDK.start(botKey: "bot-1")
KindlySDK.displayChat()

// Switch to different bot - no explicit endChat() needed
KindlySDK.start(botKey: "bot-2")  // SDK handles cleanup internally  
KindlySDK.displayChat()
```

### Option 2: Explicit End-then-Start

For explicit control over the chat lifecycle:

```Swift
// End current chat first
KindlySDK.endChat().then(on: DispatchQueue.main) { _ in
    // Start with new bot after cleanup completes
    KindlySDK.start(botKey: "new-bot-key")
    KindlySDK.displayChat()
}
```

**Both approaches work identically** - the SDK ensures proper cleanup and reinitialization in both cases.

## When to Use endChat()

Use `endChat()` explicitly when you want to:
- **Disconnect completely**: Stop the chat service without switching to another bot
- **Clear session data**: Ensure all messages and context are cleared
- **Explicit lifecycle control**: Have fine-grained control over connection timing

The `endChat()` method returns a Promise that resolves when cleanup is complete, allowing you to chain subsequent operations safely.