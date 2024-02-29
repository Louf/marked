import Foundation
import SwiftData

@Model
final class Bookmark {
    var url: String
    var desc: String
    var favorite: Bool = false
    var time: Date
    var timesUsed = 0
    
    init(url: String, desc: String, favorite: Bool, time: Date, timesUsed: Int) {
        self.url = url
        self.desc = desc
        self.favorite = favorite
        self.time = time
        self.timesUsed = timesUsed
    }
}
