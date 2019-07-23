import Cocoa

class YDHomeVC: NSViewController {
    
    @IBAction func btn_action(_ sender: Any) {

        let a = YDtabvc(nibName: YDNibIdentifier.ydtabvc, bundle: nil)
        let vc1 = NSViewController(nibName: YDNibIdentifier.ydplainvc, bundle: nil)
        let b = NSTabViewItem.init(viewController: vc1)
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateController(withIdentifier: YDStoryboardIdentifier.ydfoobarvc) as! NSViewController
        let c = NSTabViewItem.init(viewController: vc2)
        
        a.addTabViewItem(b)
        a.addTabViewItem(c)
        self.presentAsModalWindow(a)
    }
}
