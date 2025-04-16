# Legacy TableView Helper Files

These files contain the old implementation of the chat view controller's table view management system that was used before switching to UITableViewDiffableDataSource.

They are kept here for reference and in case we need to revert back to the older implementation for any reason.

## Files

- **TableUpdateQueue.swift**: Handles sequential table view updates to prevent conflicts
- **TableDataDictionary+Extensions.swift**: Helper methods for dictionary-based table data storage
- **TableDataObservableDictionary+Extensions.swift**: Observable version of the dictionary-based storage
- **ChatViewControllerTableViewHelpers.swift**: Helper methods for the ChatViewController to manipulate the table
- **TableDataArray+Extensions.swift**: Helper methods for array-based table data storage
- **ChatViewControllerTableViewDelegate.swift**: Contains the old UITableViewDelegate and UITableViewDataSource implementations before switching to diffable data source

## History

The app previously used iOS 12 as the minimum supported version, which required using a custom implementation for managing table view data and updates. With the minimum SDK now set to iOS 13, the app uses the modern UITableViewDiffableDataSource API provided by Apple. 