import Foundation

struct YDLog {
    let lineNo: Int
    let lineData: String
}

class YDResultsModel: NSObject {
    
    let generic_vc = YDGenericVC()
    
    let logs = [YDLog(lineNo: 22, lineData: "foo"),
                 YDLog(lineNo: 44, lineData: "bar")]

}
