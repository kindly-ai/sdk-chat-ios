# API Reference

Complete auto-generated API documentation for all public symbols in the Kindly iOS SDK, including classes, protocols, enums, structs, and typealiases.

Generated with [Jazzy](https://github.com/realm/jazzy) from the SDK source code.

[Browse Full API Reference](jazzy/index.html){ .md-button .md-button--primary }

## Key Types

| Type | Description |
|------|-------------|
| `KindlyChatClient` | Main SDK client — handles initialization, chat lifecycle, and event emission |
| `KindlySDK` | Public entry point with static convenience methods (`start`, `displayChat`, `endChat`, etc.) |
| `KindlyChatClientDelegate` | Protocol for receiving button press and link interception callbacks |
| `Theme` | Protocol for defining custom chat color themes |
| `CustomTheme` | Struct implementing `Theme` with customizable color properties |
| `KindlySDKConfig` | Configuration object for permissions, crash reporting, and auth callbacks |
| `Promise` | Lightweight promise implementation used for async operations |
| `ExternalChatMessage` | Public representation of a chat message (for events and delegates) |
| `ExternalChatButton` | Public representation of a chat button (for delegates) |
