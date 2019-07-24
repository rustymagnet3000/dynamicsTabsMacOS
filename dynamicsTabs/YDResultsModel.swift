import Foundation

struct YDLog {
    let lineNo: Int
    let lineData: String
}

class YDResultsModel: NSObject {
    
    let title: String
    let logs: [YDLog]

    init(title: String, logs: [YDLog]) {
        self.title = title
        self.logs = logs
    }
}
