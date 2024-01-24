//
//  BookmarkCell.swift
//  Marked
//
//  Created by Louis Farmer on 12/5/23.
//

import SwiftUI

struct BookmarkCell: View {
    
    let bookmark: Bookmark
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: "https://icons.duckduckgo.com/ip3/\(stripURL(bookmark.url)).ico"))
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    VStack (alignment: .leading) {
                        Text(stripURL(bookmark.url))
                            .fontWeight(.semibold)
                        Text(bookmark.desc)
                            .lineLimit(1)
                    }
                }
                
                Divider()
            }
        }
    }
    
}


//Custom dev.bookmark for sample data until we have real data
struct BookmarkCell_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkCell(bookmark: dev.bookmark)
    }
}
