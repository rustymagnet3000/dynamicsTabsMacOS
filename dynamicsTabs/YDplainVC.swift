import Cocoa

class YDplainVC: NSViewController {

    @IBOutlet weak var tableOutlet: NSTableView!
    var tableViewData: YDSpidersFearFactor = YDSpidersFearFactor([:])
    
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
        tableOutlet.registerForDraggedTypes([.string, .YDPasteboardType])
        tableOutlet.setDraggingSourceOperationMask([.copy, .delete], forLocal: false)
        tableOutlet.target = self
        tableOutlet.doubleAction = #selector(ydTableviewDoubleClick(_:))
    }
    
    @objc func ydTableviewDoubleClick(_ sender:AnyObject) {
        tableOutlet.hideRows(at: tableOutlet.selectedRowIndexes, withAnimation: .slideDown)
    }
}

extension YDplainVC: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: NSTableView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        if operation == .delete,
            let items = session.draggingPasteboard.pasteboardItems
        {
            let indexes = items.compactMap {
                $0.integer(forType: .YDPasteboardType)
            }

            tableView.removeRows(at: IndexSet(indexes), withAnimation: .slideUp)
        }
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: rowIndexes, requiringSecureCoding: false)
            pboard.declareTypes([.YDPasteboardType], owner: self)
            pboard.setData(data, forType: .YDPasteboardType)
        }
        catch {
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        return YDPasteboardWriter(detail: tableViewData.elements[row].1, at: row)
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {

        
        guard dropOperation == .above else { return [] }
        
        if let source = info.draggingSource as? NSTableView,
            source === tableView
        {
            tableView.draggingDestinationFeedbackStyle = .gap
        } else {
            tableView.draggingDestinationFeedbackStyle = .regular
        }
        return .move
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        
        guard let items = info.draggingPasteboard.pasteboardItems else { return false }
        let oldIndexes: [Int] = items.compactMap{ $0.integer(forType: .YDPasteboardType) }

        tableView.beginUpdates()
        var oldIndexOffset = 0
        var newIndexOffset = 0
        
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

extension YDplainVC {
    func copy(sender: AnyObject?){
        
        var textToDisplayInPasteboard = ""
        
        let indexSet = self.tableOutlet.selectedRowIndexes
        
        for (_, rowIndex) in indexSet.enumerated() {
            print(rowIndex)
            
        }
        
        let pasteBoard = NSPasteboard.general
        
        pasteBoard.clearContents()
        
        pasteBoard.setString(textToDisplayInPasteboard, forType:.YDPasteboardType)
        
        
        
    }
}
