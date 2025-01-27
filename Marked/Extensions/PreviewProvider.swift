import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let bookmark = Bookmark(url: "dev.to", desc: "Developer sharing platform", favorite: false, time: Date(), timesUsed: 0)
}

