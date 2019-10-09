import Cocoa

class YDWindowController: NSWindowController {
    
    @IBOutlet weak var tableOutlet: NSTableView!
    var tableViewData: [[String : String]] = [
                                                ["keyColumn":"darth","valueColumn":"vader"],
                                                ["keyColumn":"darth","valueColumn":"sidious"]
                                            ]
    
    override var windowNibName: NSNib.Name? {
        return "YDWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        let a = IndexSet(arrayLiteral: 0,1)
        tableOutlet.delegate = self
        tableOutlet.usesStaticContents = true
        tableOutlet.usesAlternatingRowBackgroundColors = true
        tableOutlet.insertRows(at: a, withAnimation: .slideDown)

        if let ydwindow = window, let screen = window?.screen {
            
            ydwindow.minSize = NSSize(width: 200, height: 200 )
            let offsetFromLeftOfScreen: CGFloat = 300
            let offsetFromTopOfScreen: CGFloat = 300
            let screenRect = screen.visibleFrame
            let newOriginY = screenRect.maxY - ydwindow.frame.height - offsetFromTopOfScreen
            ydwindow.setFrameOrigin(NSPoint(x: offsetFromLeftOfScreen, y: newOriginY))
            
            self.window = ydwindow
        }
    }
}

extension YDWindowController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let keyCell = "keyColumn"
        static let valueCell = "valueColumn"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        print("in delegate")
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

