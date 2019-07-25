# macOS Dynamics TabViewController
### Design thoughts
I  focused on `NSTabBarViewController` and `NSTableView` to help a user skip between lots of data.  As this project grew older, I would move to newer U.I. controls like macOS's `Tabbed Windows`.

### Technical baggage
I originally thought in pure iOS terms. I was constantly trying to port `Classes` I knew well (`UIViewController`, `UITabBarViewController`) to the macOS world (`NSViewController`, `NSTabBarViewController`).  That idea drowned quickly.  Just look at the richness of the macOS `NSTableView` control to understand why you can't treat these `Classes` as synonyms of each other.

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
