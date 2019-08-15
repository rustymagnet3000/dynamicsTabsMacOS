import Cocoa

class YDplainVC: NSViewController {

    @IBOutlet weak var tableOutlet: NSTableView!
    var tableViewData: YDSpidersFearFactor = YDSpidersFearFactor([:])
    let accountPasteboardType = NSPasteboard.PasteboardType(rawValue: "random.fooBar")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOutlet.headerView = YDtableHeaderView()
        tableOutlet.usesAlternatingRowBackgroundColors = true
        tableOutlet.allowsColumnResizing = true
        tableOutlet.intercellSpacing = NSSize(width: 10, height: 15)
        tableOutlet.allowsMultipleSelection = true
        tableOutlet.delegate = self
        tableOutlet.dataSource = self
        tableOutlet.tableColumns[0].title = "Line"
        tableOutlet.tableColumns[1].title = "Details"
        tableOutlet.registerForDraggedTypes([accountPasteboardType])
        tableOutlet.target = self
        tableOutlet.doubleAction = #selector(ydTableviewDoubleClick(_:))
    }
    
    @objc func ydTableviewDoubleClick(_ sender:AnyObject) {

        tableOutlet.hideRows(at: tableOutlet.selectedRowIndexes, withAnimation: .slideDown)
        var a: [String] = []
        for i in tableOutlet.selectedRowIndexes {
            a.append(tableViewData.elements[i].1)
        }
    }
}

extension YDplainVC: NSTableViewDataSource, NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let spider = tableViewData.elements[row]
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(spider.1, forType: accountPasteboardType)
        return pasteboardItem
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        if dropOperation == .above {
            return .move
        } else {
            return []
        }
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard
            let item = info.draggingPasteboard.pasteboardItems?.first,
            let str = item.string(forType: accountPasteboardType),
            let account = tableViewData.elements.first(where: { $0.1 == str }),
            let originalRow = tableViewData.elements.firstIndex(where: { $0.1 == account.1 })
        else {
            return false
        }
        
        var newRow = row
        if originalRow < newRow {
            newRow = row - 1
        }

        tableView.beginUpdates()
        tableView.moveRow(at: originalRow, to: row)
        tableView.endUpdates()
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


