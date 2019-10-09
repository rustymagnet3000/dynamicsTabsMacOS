import Cocoa

class YDtabvc: NSTabViewController, NSWindowDelegate {

    public var size = NSSize(width: 500, height: 800)
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.view.window?.delegate = self
        self.view.window?.minSize = size
        self.view.window?.center()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        var frame = self.view.window!.frame
        frame.size = size
        self.view.window?.setFrame(frame, display: true)
    }
}
