# Kindly SDK for iOS

Integrate Kindly Chat in your iOS app. 

* This SDK makes it easy to add chat to your app.
* Provides a chat UI that can be branded.    
* Made for iPhone and iPad.

## 📦 Installation

### Requirements

- iOS deployment target: 12.0+
- Swift Package Manager

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
pod 'Kindly', '~> 2.0'
```

## Usage

After installing the SDK, you can now use it in your iOS application. 

Initialize the SDK in your AppDelegate's didFinishLaunchingWithOptions method. Use the provided bot key to start the SDK.

```swift
import Kindly

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    KindlySDK.start(botKey: "BOT_KEY")
    return true
}
```

Display the chat interface in your desired view controller. You can call the displayChat method from the Kindly SDK and pass the desired language code.

```swift
KindlySDK.displayChat(languageCode: "en")
```

## 📋 Getting started

### Documentation

- Here you'll find the documentation and getting started guide.

[📚 Documentation](https://kindly-ai.github.io/sdk-chat-ios/)

[🔐 Kindly SDK Authentication](https://github.com/kindly-ai/sdk-chat-ios/wiki/Using-Authentication)

## Credits

Kindly SDK for iOS implements the following dependencies:

* [SwiftyGif](https://github.com/kirualex/SwiftyGif)
* [Starscream](https://github.com/daltoniam/Starscream)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
