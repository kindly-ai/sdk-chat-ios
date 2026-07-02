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
pod 'Kindly', '~> 3.0'
```

## Usage

After installing the SDK, you can now use it in your iOS application.

Initialize the SDK in your AppDelegate's didFinishLaunchingWithOptions method. Use the provided bot key to start the SDK. The `market` slug is **required** — pass the market configured for your bot (find your slugs in the Kindly platform under Settings → General → Details & markets):

```swift
import Kindly

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    KindlySDK.start(botKey: "BOT_KEY", languageCode: "en", market: "YOUR_MARKET")
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

### Authentication (JWT)

If your bot uses authenticated chat, provide a callback that supplies a fresh JWT whenever the SDK needs one:

```swift
KindlySDK.start(botKey: "BOT_KEY", languageCode: "en", market: "YOUR_MARKET") { chatId, promise in
    // Fetch a JWT for chatId from your backend, then:
    promise.fulfill("JWT_TOKEN")
    // Or on failure:
    // promise.reject(error)
}
```

See the [Authentication guide](https://kindly-ai.github.io/sdk-chat-ios-sources/guides/authentication/) for details.

## 📋 Documentation

* [Getting Started & Guides](https://kindly-ai.github.io/sdk-chat-ios-sources/)
* [API Reference](https://kindly-ai.github.io/sdk-chat-ios-sources/api-reference/)

## Credits

Kindly SDK for iOS implements the following dependencies:

* [Sentry](https://github.com/getsentry/sentry-cocoa) - Crash reporting
