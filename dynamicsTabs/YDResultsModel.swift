import Foundation

struct YDResultsModel {
    
    let title: String
    let logs: KeyValuePairs<Int, String>

    init(title: String, logs: KeyValuePairs<Int, String>) {
        self.title = title
        self.logs = logs
    }
}
