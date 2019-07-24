import Cocoa

class YDplainVC: NSViewController {

    @IBOutlet weak var tableOutlet: NSTableView!
    var customTitle: String = "YDplainVC"
    var tableViewData: [[String : String]] = [["keyColumn":"alice","valueColumn":"bob"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = customTitle
        tableOutlet.usesAlternatingRowBackgroundColors = true
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
    }
}

extension YDplainVC: NSTableViewDataSource, NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let keyCell = "keyColumn"
        static let valueCell = "valueColumn"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var cellIdentifier: String = ""
        
        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = CellIdentifiers.keyCell
        } else if tableColumn == tableView.tableColumns[1] {
            cellIdentifier = CellIdentifiers.valueCell
        }
        

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: self) as? NSTableCellView {
            cell.textField?.stringValue = tableViewData[row][cellIdentifier] ?? "bug"
            return cell
        }
        return nil
    }
}
