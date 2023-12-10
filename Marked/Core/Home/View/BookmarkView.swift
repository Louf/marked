//
//  BookmarkView.swift
//  Marked
//
//  Created by Louis Farmer on 12/5/23.
//

import SwiftUI

struct BookmarkView: View {
    let bookmark: Bookmark
    
    @State private var url = ""
    @State private var description = ""
    @State private var favorite: Bool
    
    @State private var URLValid: Bool = false
    
    @State private var showErrorAlert = false
    
    @State private var showVisitedCount = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            //If there is a URL, show something, if not, show a icon
                            Button {
                                showVisitedCount = true
                            } label: {
                                AsyncImage(url: URL(string: "https://icons.duckduckgo.com/ip3/\(stripURL(bookmark.url)).ico"))
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                            
                            TextField("Bookmark URL...", text: $url, axis: .vertical)
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                        TextField("Bookmark description...", text: $description, axis: .vertical)
                            .lineLimit(5...10)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                            .padding(.top, 10)
                        
                        HStack {
                            Button{
                                //Toggle the actual data store each time the favorite is toggled
                                favorite.toggle()
                                updateFavorite()
                            } label: {
                                Image(systemName: bookmark.favorite ? "star.fill" : "star")
                                    .padding()
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .background(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            Button{
                                dismiss()
                            } label: {
                                Text("Cancel")
                                    .padding()
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .background(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            Button{
                                saveBookmark()
                                dismiss()
                            } label: {
                                Text("Save")
                                    .padding()
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .background(.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .opacity((description.isEmpty || url.isEmpty) ? 0.6 : 1)
                            .disabled(url.isEmpty || description.isEmpty)
                        }
                        .padding(.top, 10)
                        
                        //Small easter egg if you press the image icon you can see how many times you've used the bookmark
                        if showVisitedCount {
                            Text("Times used: \(bookmark.timesUsed) 🥲")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        }
                    }
                    .font(.footnote)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .navigationTitle(bookmark.url)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .padding()
            .alert(isPresented: Binding(
                get: { showErrorAlert },
                set: { showErrorAlert = $0 ? false : showErrorAlert }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text("An error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func saveBookmark() {
        print(formatURL(url))
        //Check here to make sure the bookmark is a URL and not just text
        bookmark.url = formatURL(url)
        //Make sure the description contains something
        bookmark.desc = description
    }
    
    private func updateFavorite() {
        bookmark.favorite.toggle()
    }
    
    init(bookmark: Bookmark) {
        self.bookmark = bookmark
        _url = State(initialValue: bookmark.url)
        _description = State(initialValue: bookmark.desc)
        _favorite = State(initialValue: bookmark.favorite)
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView(bookmark: dev.bookmark)
    }
}
