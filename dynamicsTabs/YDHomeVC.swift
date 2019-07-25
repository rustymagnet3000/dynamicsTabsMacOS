import Cocoa

class YDHomeVC: NSViewController {
    
    @IBAction func btn_action(_ sender: Any) {

        let a = YDResultsModel(title: "scary", logs: [11: "Camel",
                                                      12: "Wolf",
                                                      13: "Giant Huntsmen"])

        let b = YDResultsModel(title: "non scary", logs: [1: "Harvestman",
                                                      13: "Daddy Long Legs",
                                                      21: "Inchy Wincy"])

        let c = YDResultsModel(title: "killers", logs: [20: "Brasilian Wandering",
                                                      13: "Shelob",
                                                      21: "Funnel Web"])
        
        var nTabResults: [YDResultsModel] = []
        let tabvc = YDtabvc(nibName: YDNibIdentifier.ydtabvc, bundle: nil)

        nTabResults.append(a)
        nTabResults.append(b)
        nTabResults.append(c)
        
        for i in nTabResults {
            let vc = YDplainVC(nibName: YDNibIdentifier.ydplainvc, bundle: nil)
            vc.tableViewData = i.logs
            let tabbaritem = NSTabViewItem.init(viewController: vc)
            tabbaritem.label = i.title           
            tabvc.addTabViewItem(tabbaritem)
        }
 
        self.presentAsModalWindow(tabvc)
    }
}
