import Cocoa

class YDWindowController: NSWindowController {
    
    override var windowNibName: NSNib.Name? {
        return "YDWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        print("in YDWindowController")

        if let ydwindow = window, let screen = window?.screen {
            
            ydwindow.minSize = NSSize(width: 200, height: 200 )
            
            let offsetFromLeftOfScreen: CGFloat = 300
            let offsetFromTopOfScreen: CGFloat = 300
            
            let screenRect = screen.visibleFrame
            let newOriginY = screenRect.maxY - ydwindow.frame.height - offsetFromTopOfScreen
            ydwindow.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOriginY))
            
            self.window = ydwindow
        }
    }
}
