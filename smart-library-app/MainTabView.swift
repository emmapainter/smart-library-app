//
//  TabView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/19/22.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var user: User
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SignInView()
                .tabItem {
                    Label("Bookshelf", systemImage: "books.vertical")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .onAppear {
            Task {
                do {
                    try await user.fetchUserData()
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
