import Foundation

struct YDSpidersFearFactor {
    var elements: [(Int, String)]
    
    init(_ elements: KeyValuePairs<Int, String>) {
        self.elements = Array(elements)
    }
}

struct YDTabModel {
    
    let title: String
    let results: YDSpidersFearFactor

    init(title: String, results: YDSpidersFearFactor) {
        self.title = title
        self.results = results
    }
}





