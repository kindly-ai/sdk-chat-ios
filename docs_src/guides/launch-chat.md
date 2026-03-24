# Launch Chat

## Display the SDK UI

```Swift
KindlySDK.displayChat()
```

## Display the SDK UI with a dialogueId
Launch the chat with a pre-defined dialogueId that will be triggered automatically
```Swift
KindlySDK.displayChat(triggerDialogueId: "trigger_dialogue_id")
```

**Note:** Language is set during initialization with `KindlySDK.start()`. If you need to change the language, use `KindlySDK.setLanguage()` before displaying the chat.