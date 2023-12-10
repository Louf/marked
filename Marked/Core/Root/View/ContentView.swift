//
//  ContentView.swift
//  Marked
//
//  Created by Louis Farmer on 12/3/23.
//

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
