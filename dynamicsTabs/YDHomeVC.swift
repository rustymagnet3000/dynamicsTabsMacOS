import Cocoa

class YDHomeVC: NSViewController {
    
    @IBAction func btn_action(_ sender: Any) {

        var a = YDSpidersFearFactor([5: "Wolf", 1: "Huntsmen", 3: "Wandering", 2: "Trapdoor"])
        a.elements.append((1, "Redback"))
        a.elements.reverse()
        let b = YDSpidersFearFactor([5: "Black Widow", 1: "Moustache", 3: "Baboon", 2: "Harvestman"])
        
        let x = YDTabModel(title: "scary", results: a)
        let y = YDTabModel(title: "spitters", results: b)
        
        
 
        var nTabResults: [YDTabModel] = []
        
        let tabvc = YDtabvc(nibName: YDNibIdentifier.ydtabvc, bundle: nil)
        nTabResults.append(x)
        nTabResults.append(y)
        
        
        for i in nTabResults {
            let vc = YDplainVC(nibName: YDNibIdentifier.ydplainvc, bundle: nil)
            vc.tableViewData = i.results
            
            let tabbaritem = NSTabViewItem.init(viewController: vc)
            tabbaritem.label = i.title           
            tabvc.addTabViewItem(tabbaritem)
        }
        
        self.presentAsModalWindow(tabvc)
    }
}
