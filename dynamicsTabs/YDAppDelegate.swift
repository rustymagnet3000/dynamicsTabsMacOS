import Cocoa

@NSApplicationMain
class YDAppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    @IBOutlet weak var window: NSWindow!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        

        let mainMenu = NSMenu(title:"MainMenu")
        
        
        var menuItem = mainMenu.addItem(withTitle:"Application", action:nil, keyEquivalent:"")
        var submenu = NSMenu(title:"Application")
        populateApplicationMenu(submenu)
        mainMenu.setSubmenu(submenu, for:menuItem)

        NSApp.mainMenu = mainMenu
        
    }
    private func populateApplicationMenu(_ menu:NSMenu) {
        var title = NSLocalizedString("About", comment:"About menu item") + " " + "foobar"
        var menuItem = menu.addItem(withTitle:title, action:#selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent:"")
        menuItem.target = NSApp
        
        menu.addItem(NSMenuItem.separator())
        
        
    }
    
    @objc func saySomething() {
        print("whoop")
    }
    @IBAction func saySomething(_ sender: Any) {
        print("whoop 2")
    }
}

