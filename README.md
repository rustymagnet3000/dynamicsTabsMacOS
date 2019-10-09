# macOS Dynamics TabViewController
### Things to Add
I started writing this `macOS` demo to dynamically create a `NSTabViewController` with any number of `NSViewControllers`.  But I kept using the project to explore Apple Classes.

# Fun APIs
### Popover ViewController that disappears
```
self.present(tabvc, asPopoverRelativeTo: self.view.frame, of: self.view, preferredEdge: .minY, behavior: .transient)
```
### Hide rows
```
tableOutlet.hideRows(at: tableOutlet.selectedRowIndexes, withAnimation: .slideDown)
```
### Simple Table properties
```
tableOutlet.tableColumns[0].title = "Foobar"
tableOutlet.usesAlternatingRowBackgroundColors = true
tableOutlet.allowsColumnResizing = true
```
### Drag and Drop multiple rows
`stackoverflow` was filled with answers for dragging single rows and rows that had unique values.  I wanted to support dragging multiple rows that may have the same description.  

![multiple_rows_delete_rows](readme_images/drag_rows_delete_rows.gif)

The most elegant answer was here:
```
https://www.natethompson.io/2019/03/23/nstableview-drag-and-drop.html
```
### Find Index of Original Row(s)
```
func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {

guard let items = info.draggingPasteboard.pasteboardItems else { return false }
let oldIndexes: [Int] = items.compactMap{ $0.integer(forType: .YDPasteboardType) }
....
...
..
.
```
### Drag rows to Trash
This was simpler than expected.
```
tableOutlet.setDraggingSourceOperationMask([.copy, .delete], forLocal: false)


func tableView(_ tableView: NSTableView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
if operation == .delete
.....
....
...
..
```
### Removing Storyboards from Project
I struggled with this . The following articles helped.

Issue 1: I started to "right click" in the MainMenu.xib file on the `FileOwners` to compare a working app and my app. I had a missing connection to the `AppDelegate`.

Issue 2: I never saw the MainMenu.  Always the Window but never the menu.  This was due to a small setting inside `Info.plist` called `Application is agent (UIElement) = YES`.

Issue 3: If you created an empty XIB-only macOS project, there was a line inside the `Info.plist` called `Main nib file base name`.  You had to set that to the `MainMenu.Xib` file.

Issue 4: the menu appeared but the Window never appeared.  This was caused by setting the `override var windowNibName: NSNib.Name?` to the name of Menu class instead of the WindowController class.

Issue 5: I could not `Open` the file without xCode.  If I opened `Terminal` and typed `open /Users/..../DerivedData/..../Debug/dynamicsTabs.app` it would fail. Inside `Console.app` I would see the error reported as: `Error #17  (os/kern) invalid right attempting to add send right to port`.  Well, it seemed related to the location of `DerivedData`.  It all worked when you copied the `dynamicsTabs.app` to the `Desktop`.
```
https://pinkstone.co.uk/how-to-create-a-macos-project-without-storyboards-in-xcode-8/
https://jameshfisher.com/2017/03/20/how-is-mainmenu-xib-loaded/

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
