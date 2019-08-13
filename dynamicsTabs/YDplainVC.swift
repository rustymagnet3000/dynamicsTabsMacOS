import Cocoa

class YDplainVC: NSViewController {

    @IBOutlet weak var tableOutlet: NSTableView!
    var tableViewData: YDSpidersFearFactor = YDSpidersFearFactor([:])
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlet.usesAlternatingRowBackgroundColors = true
        tableOutlet.allowsColumnResizing = true
        tableOutlet.intercellSpacing = NSSize(width: 10, height: 15)
        tableOutlet.allowsMultipleSelection = true
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
        tableOutlet.tableColumns[0].title = "Line"
        tableOutlet.tableColumns[1].title = "Details"
        
        tableOutlet.target = self
        tableOutlet.doubleAction = #selector(ydTableviewDoubleClick(_:))
        
        let a = NSPoint(x: 10, y: 10)
        let b = tableOutlet.canDragRows(with: tableOutlet.selectedRowIndexes, at: a)
    }

    
    @objc func ydTableviewDoubleClick(_ sender:AnyObject) {

        tableOutlet.hideRows(at: tableOutlet.selectedRowIndexes, withAnimation: .slideDown)
        
        var a: [String] = []
        for i in tableOutlet.selectedRowIndexes {
            a.append(tableViewData.elements[i].1)
        }
        
//        NSPasteboard.general.clearContents()
//        NSPasteboard.general.writeObjects(a as [NSPasteboardWriting])
        // a.1.write(fileURL?.absoluteString ?? "oops")
        
    }
}

extension YDplainVC: NSTableViewDataSource, NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
    fileprivate enum CellIdentifiers {
        static let keyCell = "keyColumn"
        static let valueCell = "valueColumn"
    }
    
    @objc override func copy() -> Any {
        print("copy my line")
        return "blah"
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableViewData.elements.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        
        var cellIdentifier: String = ""
        var cellText: String = "default"
        

        if tableColumn == tableView.tableColumns[0] {
            cellIdentifier = CellIdentifiers.keyCell
            cellText = String(tableViewData.elements[row].0)
        }
        else if tableColumn == tableView.tableColumns[1] {
            cellIdentifier = CellIdentifiers.valueCell
            cellText = String(tableViewData.elements[row].1)
        }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: self) as? NSTableCellView {
            cell.textField?.stringValue = cellText
            return cell
        }
        
        return nil
    }
}


extension YDplainVC: NSPasteboardWriting {
    func writableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        return [.string]
    }
    
    func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
        let plist: Any?
        
        switch type {
        case .string:
            plist = "foobar"
        default:
            plist = nil
        }
        
        return plist
    }
    
}
