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
    
    @State private var isPresentingConfirm: Bool = false
    
    var body: some View {
        let numberOfBookmarks = calcNumberOfBookmarks()
        let timeSaved = calcTimeSaved()
        
        NavigationStack {
            ScrollView {
                LazyVStack {
                    HStack (spacing: 15){
                        HStack {
                            Text("\(numberOfBookmarks)")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("bookmarks")
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.brightness(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        HStack {
                            Text("\(timeSaved)")
                                .font(.largeTitle)
                                .padding()
                            
                            Text("seconds saved")
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.brightness(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    
                    Button (role: .destructive) {
                        isPresentingConfirm = true
                    } label: {
                        HStack {
                            Text("Delete all bookmarks")
                                .foregroundStyle(.black)
                                .padding()
                            Spacer()
                            Image(systemName: "trash")
                                .tint(.red)
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.brightness(0.35))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .confirmationDialog("Are you sure?",
                      isPresented: $isPresentingConfirm) {
                      Button("Delete all items?", role: .destructive) {
                        deleteAllData()
                       }
                     }

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
    
    //Delete all bookmarks
    func deleteAllData() {
        do {
            try modelContext.delete(model: Bookmark.self)
        } catch {
            print("Failed to delete all bookmarks")
        }
    }
}

#Preview {
    SettingsView()
}
