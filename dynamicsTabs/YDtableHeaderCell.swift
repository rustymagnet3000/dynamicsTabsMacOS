import Cocoa

final class YDtableHeaderCell: NSTableHeaderCell {

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override init(textCell: String)
    {
        super.init(textCell: textCell)
        self.font = NSFont.boldSystemFont(ofSize: 24)
    }

    override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
        self.drawInterior(withFrame: cellFrame, in: controlView)
    }

    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        let titleRect = self.titleRect(forBounds: cellFrame)
        self.attributedStringValue.draw(in: titleRect)
    }

    
}
