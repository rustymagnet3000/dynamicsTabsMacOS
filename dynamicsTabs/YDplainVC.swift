import Cocoa

class YDplainVC: NSViewController {

    @IBOutlet weak var tableOutlet: NSTableView!
    var customTitle: String = "YDplainVC"
    let tableViewData: KeyValuePairs = ["Florence Griffith-Joyner": 10.49,
                                      "Evelyn Ashford": 10.76,
                                      "Evelyn Ashford": 10.79,
                                      "Marlies Gohr": 10.81]

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
        var cellText: String = "default"
        
        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = CellIdentifiers.keyCell
            cellText = String(tableViewData[row].key)
        } else if tableColumn == tableView.tableColumns[1] {
            cellIdentifier = CellIdentifiers.valueCell
            cellText = String(tableViewData[row].value)
        }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: self) as? NSTableCellView {
            
            cell.textField?.stringValue = cellText
            
            return cell
        }
        return nil
    }
}
