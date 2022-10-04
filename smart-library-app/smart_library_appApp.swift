//
//  smart_library_appApp.swift
//  smart-library-app
//
//  Created by Emma Painter on 23/9/2022.
//

import SwiftUI

@main
struct smart_library_appApp: App {
    
    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                ContentView()
                    .tabItem {
                        Label("Bookshelf", systemImage: "books.vertical")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
        }
    }
}
