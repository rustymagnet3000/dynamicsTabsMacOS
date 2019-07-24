import Cocoa

class YDHomeVC: NSViewController {
    
    @IBAction func btn_action(_ sender: Any) {

        let a = YDResultsModel(title: "tab a", logs: [YDLog(lineNo: 22, lineData: "giant"), YDLog(lineNo: 44, lineData: "camel")])
        let b = YDResultsModel(title: "tab b", logs: [YDLog(lineNo: 11, lineData: "brown"), YDLog(lineNo: 22, lineData: "recluse")])
        let c = YDResultsModel(title: "tab c", logs: [YDLog(lineNo: 1, lineData: "red"), YDLog(lineNo: 2, lineData: "back")])
        let tabvc = YDtabvc(nibName: YDNibIdentifier.ydtabvc, bundle: nil)
        let vc1 = YDplainVC(nibName: YDNibIdentifier.ydplainvc, bundle: nil)
        //vc1.tableViewData = a.logs
        let tabbaritem1 = NSTabViewItem.init(viewController: vc1)
        tabbaritem1.toolTip = "blah tooltip"
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateController(withIdentifier: YDStoryboardIdentifier.ydfoobarvc) as! NSViewController
        let tabbaritem2 = NSTabViewItem.init(viewController: vc2)
        
        tabvc.addTabViewItem(tabbaritem1)
        tabvc.addTabViewItem(tabbaritem2)
        self.presentAsModalWindow(tabvc)
    }
}
