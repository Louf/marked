//
//  MarkedTabView.swift
//  Marked
//
//  Created by Louis Farmer on 12/3/23.
//

import SwiftUI
import SwiftData

struct MarkedTabView: View {
    
    @State private var selectedTab = 0
    @State private var lastSelectedTab = 0
    @State private var showCreateThreadView = false
    
    var body: some View {
        ZStack (alignment: .bottom){
            TabView(selection: $selectedTab) {
                Group {
                    HomeView()
                        .tabItem {
                            Image(systemName: selectedTab == 0 ? "list.clipboard.fill" : "list.clipboard")
                                .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                        }
                        .tag(0)
                    
                    Spacer()
                        .tabItem {
                           EmptyView()
                        }
                        .tag(1)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: selectedTab == 2 ? "gear.circle.fill" : "gear.circle")
                                .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                        }
                        .tag(2)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
            }
            
            .tint(.black)
            //fullScreenCover means that we don't see the background behind the sheet, much nicer
            .fullScreenCover(isPresented: $showCreateThreadView){
                CreateBookmarkView()
            }
            
            Button {
                showCreateThreadView = true
            } label: {
                Image(systemName: "plus")
                    .tint(Color.white)
            }
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .clipShape(Circle())
            .padding(.bottom, 5)
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: selectedTab) { [selectedTab] newValue in
           if newValue == 1 { // replace 2 with your index
               self.selectedTab = selectedTab // reset the selection in case we somehow press the middle tab
           }
        }
    }
    
    
}

#Preview {
    MarkedTabView()
}
