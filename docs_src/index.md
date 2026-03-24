# Kindly iOS SDK

The Kindly Chat SDK for iOS allows you to integrate a fully-featured customer support chat into your iOS application. The SDK provides a native UIKit-based chat interface with real-time messaging, push notifications, custom theming, and more.

## Installation

### Swift Package Manager

Add the Kindly SDK to your project via Xcode:

1. Go to **File > Add Package Dependencies**
2. Enter the repository URL: `https://github.com/kindly-ai/sdk-chat-ios`
3. Select the version you want to use

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kindly-ai/sdk-chat-ios", from: "2.0.0")
]
```

### CocoaPods

Add the following to your `Podfile`:

```ruby
pod 'Kindly'
```

Then run `pod install`.

## Quick Start

```swift
import Kindly

// Initialize the SDK
KindlySDK.start(botKey: "YOUR_BOT_KEY")

// Display the chat
KindlySDK.displayChat()
```

## Documentation

<div class="grid cards" markdown>

-   **Getting Started**

    ---

    Set up the SDK and configure it for your app

    [:octicons-arrow-right-24: Initialization](guides/initialization.md)
    [:octicons-arrow-right-24: Configuration](guides/config.md)

-   **Chat Lifecycle**

    ---

    Control how the chat UI is displayed and managed

    [:octicons-arrow-right-24: Launch Chat](guides/launch-chat.md)
    [:octicons-arrow-right-24: Close Chat](guides/close-chat.md)
    [:octicons-arrow-right-24: End Chat](guides/end-chat.md)
    [:octicons-arrow-right-24: Kill SDK](guides/kill-sdk.md)

-   **Features**

    ---

    Events, authentication, context, dialogues, and notifications

    [:octicons-arrow-right-24: Events](guides/events.md)
    [:octicons-arrow-right-24: Authentication](guides/authentication.md)
    [:octicons-arrow-right-24: Notifications](guides/notification-support.md)

-   **Customization**

    ---

    Theme the chat UI, handle links, and set up deep linking

    [:octicons-arrow-right-24: Custom Theming](guides/custom-theming.md)
    [:octicons-arrow-right-24: URL Schemes](guides/url-schemes.md)
    [:octicons-arrow-right-24: Link Interception](guides/link-interception.md)

</div>

## API Reference

Auto-generated documentation for all public classes, protocols, enums, and structs.

[:octicons-book-24: Browse API Reference](api-reference/index.md){ .md-button }
