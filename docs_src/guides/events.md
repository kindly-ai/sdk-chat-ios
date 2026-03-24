# Events

The Kindly SDK provides a unified event system that allows you to subscribe to all SDK events and state changes in real-time. This matches the web API pattern and provides a comprehensive way to monitor SDK behavior.

## Event Types

The SDK emits the following event types:

- **`kindly:load`** - Settings and configuration loaded
- **`kindly:message`** - New messages (sent/received)
- **`kindly:buttonclick`** - Button interactions
- **`kindly:ui`** - UI actions (open, close, end chat, etc.)
- **`kindly:state`** - State changes (connection, display status)

## Basic Usage

### Subscribe to All Events

```swift
import Combine
import Kindly

class MyEventHandler {
    private var cancellables = Set<AnyCancellable>()
    
    func setupEventListening() {
        KindlySDK.events
            .sink { event in
                print("Event: \(event.type.rawValue)")
                print("Timestamp: \(event.timestamp)")
                
                switch event.detail {
                case .load(let settings):
                    print("Settings loaded: \(settings.name)")
                    
                case .message(let newMessage, let chatLog):
                    print("New message: \(newMessage.text ?? "No text")")
                    
                case .buttonClick(let button, let buttonType, _, _):
                    print("Button clicked: \(button.label)")
                    
                case .ui(let action):
                    print("UI Action: \(action.type.rawValue)")
                    
                case .state(let state):
                    print("State changed - Connected: \(state.isConnected)")
                    
                case .globalIcon:
                    // Note: globalIcon events are not currently implemented in mobile SDKs
                    break
                }
            }
            .store(in: &cancellables)
    }
}
```

### Subscribe to State Changes Only

```swift
KindlySDK.state
    .sink { state in
        print("Chat displayed: \(state.isChatDisplayed)")
        print("SDK started: \(state.isStarted)")
        print("Socket connected: \(state.isSocketConnected)")
        print("Fully connected: \(state.isConnected)")
        print("Connection state: \(state.connectionState)")
    }
    .store(in: &cancellables)
```

## Event Details

### Load Event
Emitted when SDK settings are loaded from the server.

```swift
KindlySDK.events
    .filter { $0.type == .load }
    .sink { event in
        if case .load(let settings) = event.detail {
            print("Bot: \(settings.name) (ID: \(settings.id))")
            print("Languages: \(settings.languages.map { $0.code })")
            print("Theme: \(settings.style.background != nil ? "Custom" : "Default")")
        }
    }
    .store(in: &cancellables)
```

### Message Event
Emitted for both incoming and outgoing messages.

```swift
KindlySDK.events
    .filter { $0.type == .message }
    .sink { event in
        if case .message(let newMessage, let chatLog) = event.detail {
            print("Message from \(newMessage.from): \(newMessage.text ?? "")")
            print("Chat has \(chatLog.count) total messages")
        }
    }
    .store(in: &cancellables)
```

### Button Click Event
Emitted when users interact with chat buttons.

```swift
KindlySDK.events
    .filter { $0.type == .buttonClick }
    .sink { event in
        if case .buttonClick(let button, let buttonType, let chatLog, let lastMessage) = event.detail {
            print("Button: \(button.label)")
            print("Type: \(buttonType)")
            print("Value: \(button.value ?? "")")
        }
    }
    .store(in: &cancellables)
```

### UI Events
Emitted for user interface actions like opening/closing chat, language changes, etc.

```swift
KindlySDK.events
    .filter { $0.type == .ui }
    .sink { event in
        if case .ui(let action) = event.detail {
            switch action.type {
            case .openChatBubble:
                print("Chat opened")
            case .closeChatBubble:
                print("Chat closed")
            case .endChat:
                print("Chat ended")
            case .restartChat:
                print("Chat restarted")
            case .changeLanguage:
                print("Language changed to: \(action.languageCode ?? "")")
            case .downloadChat:
                print("Chat downloaded")
            case .deleteChat:
                print("Chat deleted")
            case .showFeedback:
                print("Feedback form shown")
            case .submitFeedback:
                print("Feedback submitted")
            case .dismissFeedback:
                print("Feedback dismissed")
            }
        }
    }
    .store(in: &cancellables)
```

### State Events
Emitted when SDK connection or display state changes.

```swift
KindlySDK.state
    .sink { state in
        if state.isConnected {
            print("✅ SDK is fully connected and ready!")
        } else if state.isStarted && !state.isSocketConnected {
            print("⚠️ SDK started but socket disconnected")
        } else if !state.isStarted {
            print("⏳ SDK not started yet")
        }
    }
    .store(in: &cancellables)
```

## Advanced Usage

### Track Chat Display Changes

```swift
KindlySDK.state
    .map { $0.isChatDisplayed }
    .removeDuplicates() // Only emit when value changes
    .sink { isDisplayed in
        if isDisplayed {
            print("📱 Chat interface is now visible")
        } else {
            print("🙈 Chat interface is now hidden")
        }
    }
    .store(in: &cancellables)
```

### Monitor Connection Health

```swift
KindlySDK.state
    .map { state in
        (state.isStarted, state.isSocketConnected, state.isConnected)
    }
    .removeDuplicates { $0 == $1 }
    .sink { isStarted, isSocketConnected, isConnected in
        switch (isStarted, isSocketConnected, isConnected) {
        case (true, true, true):
            print("🟢 Fully connected")
        case (true, false, false):
            print("🟡 Started but disconnected")
        case (false, _, _):
            print("🔴 Not started")
        default:
            print("🟡 Partial connection")
        }
    }
    .store(in: &cancellables)
```

### Filter Multiple Event Types

```swift
KindlySDK.events
    .filter { event in
        [.message, .buttonClick, .ui].contains(event.type)
    }
    .sink { event in
        print("User interaction event: \(event.type.rawValue)")
    }
    .store(in: &cancellables)
```

## Event Data Models

### KindlyEvent
```swift
struct KindlyEvent {
    let type: KindlyEventType
    let timestamp: TimeInterval
    let detail: KindlyEventDetail
}
```

### KindlyEventState
```swift
struct KindlyEventState {
    let isChatDisplayed: Bool
    let isStarted: Bool
    let isSocketConnected: Bool
    let isConnected: Bool
    let connectionState: String
}
```

For more detailed information about event data structures, see the SDK source code documentation.

## Memory Management

Always store your Combine cancellables to prevent memory leaks:

```swift
private var cancellables = Set<AnyCancellable>()

// In deinit or when done
cancellables.removeAll()
``` 