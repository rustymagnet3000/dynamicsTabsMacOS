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
This was tricky as there were so many poor answers when dragging multiple rows.  I eventually found all answers in here:
```
https://www.natethompson.io/2019/03/23/nstableview-drag-and-drop.html
```
For a long time, I could not understand how to find the original indexes of dragged rows.

```
func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {

guard let items = info.draggingPasteboard.pasteboardItems else { return false }
let oldIndexes: [Int] = items.compactMap{ $0.integer(forType: .YDPasteboardType) }
```
### Drag rows to Trash
This was simple than I expected.
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
I struggled with this piece.
```
https://pinkstone.co.uk/how-to-create-a-macos-project-without-storyboards-in-xcode-8/
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
