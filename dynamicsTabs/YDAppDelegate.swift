import Cocoa

@NSApplicationMain
class YDAppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ notification: Notification) {

        print(NSApp.mainMenu)
        
    }

    @IBAction func saySomething(_ sender: Any) {
        print("whoop 2")
    }
}

