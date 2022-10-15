//
//  smart_library_appApp.swift
//  smart-library-app
//
//  Created by Emma Painter on 23/9/2022.
//

import SwiftUI

@main
struct smart_library_appApp: App, BluetoothControllerDelegate {
    
    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Start bluetooth paring when app opens
        let _ = BluetoothController.shared
        BluetoothController.shared.addDelegate(delegate: self)
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
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
    
    func bluetoothDeviceDidSendData(deviceUUID: UUID, data: String) {
        print("Device: \(deviceUUID.description)")
        print("Data: \(data)")
    }
}
