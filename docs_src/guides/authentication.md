# Authentication

## Setup
To use authentication with the Kindly SDK, you can initialize the SDK by adding an argument to the `start` method. Here's an example of how to set the `authTokenCallback` using the `start` method:

`KindlySDK.start(botKey: String, authTokenCallback: (_ chatId: String, _ promise: Promise<String>) -> (String))`

```swift
KindlySDK.start(botKey: "BOT_KEY") { chatId, promise in
    // Generate JWT token
    // On success, call
    promise.fulfill("JWT_TOKEN")
    // On error
    promise.reject(ERROR)
}
```

Inside the `authTokenCallback` closure, you can generate a JWT token and fulfill the promise with the token on success. If there is an error, you can reject the promise with the appropriate error.



Additionally, there is another way to set the `authTokenCallback` using the `KindlySDK.config.getAuthToken` property. Here's an example of how to do it:

```swift
KindlySDK.start(botKey: "BOT_KEY")
KindlySDK.config.getAuthToken = { chatId, promise in
    // Generate JWT token
    // On success, call
    promise.fulfill("JWT_TOKEN")
    // On error
    promise.reject(ERROR)
}
```

In this example, you set the `botKey` directly in the `start` method. Then, you assign a closure to the `KindlySDK.config.getAuthToken` property. Inside the closure, you can generate the JWT token and fulfill the promise with the token. You can also reject the promise with an error if needed.

Remember to replace `BOT_KEY` with your actual bot key.

## Manually Save Authentication Token

If you need to manually save an authentication token (for example, if you retrieve it from another source):

```swift
let success = KindlySDK.saveAuthToken("YOUR_JWT_TOKEN")
```

The method returns a boolean indicating whether the token was successfully saved to the keychain.

