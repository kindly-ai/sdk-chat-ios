# Kindly SDK for iOS

Integrate Kindly Chat in your iOS app.

* This SDK makes it easy to add chat to your app.
* Provides a chat UI that can be branded.
* Made for iPhone and iPad.

## 📦 Installation

### Requirements

* iOS deployment target: 15.0+

### How to install

#### Swift Package Manager

Add the GitHub Repo URL to your Xcode project.
_In the Xcode menu bar, select "File" -> "Add Packages..."_

```
https://github.com/kindly-ai/sdk-chat-ios
```

#### Cocoapods

You can also use CocoaPods to install the Kindly SDK. Add the following line to your `Podfile`:

```ruby
pod 'Kindly', '~> 2.1'
```

## Usage

After installing the SDK, you can now use it in your iOS application.

Initialize the SDK in your AppDelegate's didFinishLaunchingWithOptions method. Use the provided bot key to start the SDK.

```swift
import Kindly

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    KindlySDK.start(botKey: "BOT_KEY", languageCode: "en")
    return true
}
```

Display the chat interface in your desired view controller.

```swift
KindlySDK.displayChat()
```

You can also change the language at runtime if needed:

```swift
KindlySDK.setLanguage("lt")  // Change to Lithuanian
```

## 📋 Documentation

* [Getting Started & Guides](https://kindly-ai.github.io/sdk-chat-ios-sources/)
* [API Reference](https://kindly-ai.github.io/sdk-chat-ios-sources/api-reference/)

## Credits

Kindly SDK for iOS implements the following dependencies:

* [Sentry](https://github.com/getsentry/sentry-cocoa) - Crash reporting
