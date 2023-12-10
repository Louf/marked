//
//  ProfileView.swift
//  Marked
//
//  Created by Louis Farmer on 12/5/23.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var bookmarks: [Bookmark]
    
    var body: some View {
        var numberOfBookmarks = calcNumberOfBookmarks()
        var timeSaved = calcTimeSaved()
        
        NavigationStack {
            ScrollView {
                LazyVStack {
                    HStack (spacing: 15){
                        VStack (alignment: .leading) {
                            Text("\(numberOfBookmarks)")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("bookmarks")
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.brightness(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        VStack (alignment: .leading) {
                            Text("\(timeSaved)")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("seconds saved")
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.brightness(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func calcNumberOfBookmarks() -> Int {
        return bookmarks.count
    }
    
    func calcTimeSaved() -> Int {
        var temp = 0
        for bookmark in bookmarks {
            temp += bookmark.timesUsed * 10
        }
        return temp
    }
}

#Preview {
    SettingsView()
}
