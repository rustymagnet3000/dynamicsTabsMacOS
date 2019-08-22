import Cocoa

class YDPasteboardWriter: NSObject, NSPasteboardWriting {
    var detail: String
    var index: Int
    
    init(detail: String, at index: Int) {
        self.detail = detail
        self.index = index
    }
    
    func writableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        return [.string, .YDPasteboardType]
    }

    func pasteboardPropertyList(forType type: NSPasteboard.PasteboardType) -> Any? {
        switch type {
        case .string:
            return detail
        case .YDPasteboardType:
            return index
        default:
            return nil
        }
    }
}

extension NSPasteboard.PasteboardType {
    static let YDPasteboardType = NSPasteboard.PasteboardType("YD.random.fooBar")
}

extension NSPasteboardItem {
    open func integer(forType type: NSPasteboard.PasteboardType) -> Int? {
        guard let data = data(forType: type) else { return nil }
        let plist = try? PropertyListSerialization.propertyList(
            from: data,
            options: .mutableContainers,
            format: nil)
        return plist as? Int
    }
}
