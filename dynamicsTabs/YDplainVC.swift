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
    }
}

extension YDplainVC: NSTableViewDataSource, NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: rowIndexes, requiringSecureCoding: false)
            pboard.declareTypes([accountPasteboardType], owner: self)
            pboard.setData(data, forType: accountPasteboardType)
        }
        catch {
            return false
        }
        
        
        
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
        
        var oldIndexes = [Int]()

        info.enumerateDraggingItems(options: NSDraggingItemEnumerationOptions.concurrent,
                                            for: tableView,
                                            classes: [NSPasteboardItem.self],
                                            searchOptions: [:],
                                            using: {(draggingItem, idx, stop) in
                                            
                                                if let str = (draggingItem.item as! NSPasteboardItem).string(forType: self.accountPasteboardType) {
                                                    
                                                    let account = self.tableViewData.elements.first(where: { $0.1 == str })
                                                    
                                                    if let originalRow = self.tableViewData.elements.firstIndex(where: { $0.1 == account!.1 }) {
                                                      oldIndexes.append(originalRow)
                                                    }
                                                }
        })
        
        var oldIndexOffset = 0
        var newIndexOffset = 0
        
        tableView.beginUpdates()
        for oldIndex in oldIndexes {
            if oldIndex < row {
                tableView.moveRow(at: oldIndex + oldIndexOffset, to: row - 1)
                oldIndexOffset -= 1
            } else {
                tableView.moveRow(at: oldIndex, to: row + newIndexOffset)
                newIndexOffset += 1
            }
        }
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


