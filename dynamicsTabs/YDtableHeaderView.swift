import Cocoa

class YDtableHeaderView: NSTableHeaderView {

    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    
    override init(frame frameRect: NSRect)
    {
        super.init(frame: frameRect)
        self.wantsLayer = true
        print("init in YDtableHeaderView" )
        self.layer?.backgroundColor = CGColor.clear
    }
    

}
