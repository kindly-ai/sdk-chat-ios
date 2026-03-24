# Context

## Set Context
```Swift
KindlySDK.setNewContext(_ context: [String: String])
```
This context will be sent on **connect**, or next **message sent**, or **next button click**. 

The context will be cleared automatically afterward

## Clear the Context Manually   
```Swift
KindlySDK.clearNewContext()
```