//
//  HomeView.swift
//  Marked
//
//  Created by Louis Farmer on 12/5/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) var openURL
    
    //Query sort to make sure that the newly added items are on top
    @Query(sort: \Bookmark.time, order: .reverse) private var bookmarks: [Bookmark]
    @Query(filter: #Predicate<Bookmark>  { $0.favorite }, sort: \Bookmark.time, order: .reverse) private var favoriteBookmarks: [Bookmark]
    
    @State var filterFavorites = false
    @State var searchText = ""
    
    
    
    var body: some View {
        //A more simple way of declaring which set of results we are looking at
        let searchSet: [Bookmark] = filterFavorites ? favoriteBookmarks : bookmarks
        
        //Now another filtering down for the search bar so that we can search for a specific bookmark
        var filtered: [Bookmark] {
            guard searchText.isEmpty == false else { return searchSet }
            
            return searchSet.filter { $0.url.lowercased().contains(searchText.lowercased()) || $0.desc.lowercased().contains(searchText.lowercased()) }
        }
        
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(filtered) { bookmark in
                        //Took away the NavigationLink and put it inside the BookmarkCell
                        //This means that the whole cell isn't the link
                        HStack {
                            Button {
                                //Must be a url otherwise won't work
                                openURL(URL(string: bookmark.url)!)
                                bookmark.timesUsed += 1
                            } label: {
                                BookmarkCell(bookmark: bookmark)
                            }
                            
                            
                            if bookmark.favorite {
                                Image(systemName: "star.fill")
                                    .tint(.black)
                            }
                            
                            Menu {
                                Button {
                                    bookmark.favorite.toggle()
                                } label: {
                                    Image(systemName: bookmark.favorite ? "star.fill" : "star")
                                        .tint(.black)
                                    Text("Favorite")
                                }
                                
                                NavigationLink {
                                    BookmarkView(bookmark: bookmark)
                                } label: {
                                    Image(systemName: "pencil")
                                    Text("Edit")
                                }
                                
                                Button {
                                    deleteItem(bookmark: bookmark)
                                }label: {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .tint(.black)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Bookmarks")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button {
                            filterFavorites.toggle()
                        } label: {
                            Image(systemName: filterFavorites ? "star.fill" : "star")
                                .tint(.black)
                            Text(filterFavorites ? "Show all" : "Show favorites only")
                        }
                    } label: {
                        Image(systemName: filterFavorites ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                            .tint(.black)
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.black))
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search")
    }

    private func deleteItem(bookmark: Bookmark) {
        withAnimation {
            modelContext.delete(bookmark)
        }
    }
}

#Preview {
    HomeView()
}
