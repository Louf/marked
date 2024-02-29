import SwiftUI

struct CreateBookmarkView: View {
    @State private var url = ""
    @State private var description = ""
    @State private var favorite = false
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            //If there is a URL, show something, if not, show a icon
                            AsyncImage(url: URL(string: "https://icons.duckduckgo.com/ip3/\(stripURL(url)).ico"))
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
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
                            .padding(.vertical, 10)
                        
                        Button{
                            //Toggle the actual data store each time the favorite is toggled
                            favorite.toggle()
                        } label: {
                            Image(systemName: favorite ? "star.fill" : "star")
                                .padding()
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                                .frame(maxWidth: .infinity)
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    // x mark only appears if there is text, and clears the text when pressed
//                    if !url.isEmpty {
//                        Button {
//                            url = ""
//                        } label: {
//                            Image(systemName: "xmark")
//                                .resizable()
//                                .frame(width: 12, height: 12)
//                                .foregroundStyle(Color.gray)
//                        }
//                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Bookmark")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color(.black))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        addItem()
                        dismiss()
                    }
                    .opacity(url.isEmpty ? 0.5 : 1.0)
                    .disabled(url.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(.black))
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newBookmark = Bookmark(url: formatURL(url), desc: description, favorite: favorite, time: Date(), timesUsed: 0)
            modelContext.insert(newBookmark)
        }
    }
}

#Preview {
    CreateBookmarkView()
}
