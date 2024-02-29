import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        MarkedTabView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Bookmark.self)
}
