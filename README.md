# macOS Dynamics TabViewController
### Things to Add
M demo was able to dynamically create a `NSTabViewController` and populate with any number of `NSViewControllers`.  Next step was to enjoy some of the macOS APIs and subclass some interesting Apple Classes.

```
Drag and Drop rows
Copy rows to Pasteboard like a pro
Add custom Gestures
Use the Menu Bar
```

### Design thoughts
I  focused on `NSTabBarViewController` and `NSTableView` to help a user skip between lots of data.  As this project grew older, I would move to newer U.I. controls like macOS's `Tabbed Windows`.

### Keep it small stupid
Everytime I worked on the UI I really had to keep this project small.  The more complex it became, the longer it took to do simple things.

### Technical baggage
I originally thought in pure iOS terms. I was constantly trying to port `Classes` I knew well (`UIViewController`, `UITabBarViewController`) to the macOS world (`NSViewController`, `NSTabBarViewController`).  That idea drowned quickly.  Just look at the richness of the macOS `NSTableView` control to understand why you can't treat these `Classes` as synonyms of each other.


# Fun APIs
### Popover ViewController that disappears
```
self.present(tabvc, asPopoverRelativeTo: self.view.frame, of: self.view, preferredEdge: .minY, behavior: .transient)
```
### Hide rows
```
tableOutlet.hideRows(at: tableOutlet.selectedRowIndexes, withAnimation: .slideDown)
```
### Table properties
```
tableOutlet.tableColumns[0].title = "Foobar"
tableOutlet.usesAlternatingRowBackgroundColors = true
tableOutlet.allowsColumnResizing = true
```
### Drag and Drop rows
```
let a = NSPoint(x: 10, y: 10)
let b = tableOutlet.canDragRows(with: tableOutlet.selectedRowIndexes, at: a)
```
### Copy rows
The amount of documentation on NSPasteboard was lacking.  But you could find great stuff on github:
```
https://github.com/JxbSir/Teambition-Inc/blob/3c07c8e7c723e67c52985a8d6b4ec81e090c5249/Teambition/Task/Content/TaskBaseViewController.swift

https://github.com/brentsimmons/NetNewsWire/blob/70312aa75c15a18a8dcaf14ad15679e4a15c3403/Shared/SmartFeeds/SmartFeedPasteboardWriter.swift

https://github.com/nakajijapan/teiten/blob/a4490c142ee1e67faa5ca294cea03b4b3f1810a8/teiten/Classes/FileEntity.swift
```
### Writing the User Interface
I wanted to write all of the code. I didn't want `XIB` files or `Storyboards`.  But at some point, you find writing everything is code is hardwork.  macOS is poorly documented compared to iOS.  Small things become slow and cumbersome.  

I went stepped back in time and used  `xib` files, as I had spent a lot of time with `Storyboards` in other projects.

I planned to get more comfortable on macOS and then I would retrofit the project and remove `xib` files.

### The first breakthrough
After reading lots of articles, I found one article that clicked:
```
https://www.raywenderlich.com/613-windows-and-windowcontroller-tutorial-for-macos
```
This pointed out I could achieve what I wanted with little code and get some great side-benefits with macOS specific UI Classes.


### References
```
// bug on NSTabViewControllers
https://stackoverflow.com/questions/37005622/control-a-nstabviewcontroller-from-parent-view

https://www.raywenderlich.com/704-macos-view-controllers-tutorial

https://www.albertomoral.com/blog/2017/10/7/create-nstableview-programatically-without-storyboards

https://stackoverflow.com/questions/39319177/programmatically-create-an-nsviewcontroller-without-an-xib-in-swift-3

https://medium.com/hyperoslo/how-to-write-an-nsviewcontroller-without-interface-builder-on-macos-760283648f12
```
