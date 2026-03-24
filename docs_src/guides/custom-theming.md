# Custom Theming

Customize the appearance of the Kindly chat interface by setting your own color theme. The SDK provides two methods for theme customization:

1. Using a complete Theme object
2. Specifying individual colors

## Setting a Complete Theme

Create and configure a custom theme by implementing the `Theme` protocol or using the provided `CustomTheme` struct:

```swift
// Create a custom theme
let darkTheme = CustomTheme(
    background: UIColor.black,
    botMessageBackground: UIColor.darkGray,
    botMessageText: UIColor.white,
    buttonBackground: UIColor.blue,
    buttonText: UIColor.white, 
    userMessageBackground: UIColor.systemBlue,
    userMessageText: UIColor.white,
    chatLogElements: UIColor.lightGray
    // Add other color properties as needed
)

// Apply the custom theme
KindlyChatClient.setCustomTheme(darkTheme)
```

## Setting Individual Colors

For convenience, you can also specify just the colors you want to customize without creating a complete theme:

```swift
KindlyChatClient.setCustomTheme(
    background: UIColor.white,
    botMessageBackground: UIColor.lightGray,
    botMessageText: UIColor.black,
    buttonBackground: UIColor.blue,
    buttonText: UIColor.white,
    userMessageBackground: UIColor.blue,
    userMessageText: UIColor.white,
    chatLogElements: UIColor.gray
    // Only specify the colors you want to customize
)
```

## Available Theme Properties

The theme properties are divided into two categories:

### API-defined Colors (from Kindly settings)

These colors are defined in the Kindly settings (app.kindly.ai) and are fetched with your bot configuration:

| Property | Description |
|----------|-------------|
| `background` | Main background color of the chat interface |
| `botMessageBackground` | Background color for bot message bubbles |
| `botMessageText` | Text color for bot messages |
| `buttonBackground` | Background color for buttons |
| `buttonOutline` | Outline color for buttons |
| `buttonText` | Text color for buttons |
| `chatLogElements` | Color for chat log elements like timestamps |
| `navBarBackground` | Background color for the navigation bar (maps to header_background in API) |
| `navBarText` | Text color for the navigation bar (maps to header_text in API) |
| `inputBackground` | Background color for the input field |
| `inputText` | Text color for the input field |
| `userMessageBackground` | Background color for user message bubbles |
| `userMessageText` | Text color for user messages |

### Manually Added Colors

These colors are not defined in the Kindly settings but are used by the SDK for additional UI elements:

| Property | Description |
|----------|-------------|
| `buttonSelectedBackground` | Background color for selected buttons |
| `defaultShadow` | Default shadow color |
| `inputCursor` | Color for the input cursor |
| `maintenanceHeaderBackground` | Background color for maintenance alerts |

## Clearing Custom Theme

To clear a custom theme and revert to the default or API-provided theme:

```swift
KindlySDK.clearCustomTheme()
```

This will:
- ✅ Remove any user-defined custom theme
- ✅ Revert to the theme from Kindly settings (if available)
- ✅ Fall back to the default SDK theme if no API theme exists
- ✅ Apply changes immediately to any displayed chat interface

## Theme Priority

When setting a custom theme:

1. **User-defined theme** (set via `setCustomTheme`) takes precedence over any other theme
2. **API theme** (from Kindly settings configured in app.kindly.ai) is used if no user theme is set
3. **Default SDK theme** is applied if neither user nor API themes are available

### Theme Priority Examples

```swift
// Set a custom theme (highest priority)
KindlySDK.setCustomTheme(
    background: UIColor.black,
    botMessageBackground: UIColor.gray
)

// Later, clear custom theme to use API theme
KindlySDK.clearCustomTheme()  // Reverts to API or default theme

// Set custom theme again (overrides API theme)
KindlySDK.setCustomTheme(background: UIColor.white)
``` 