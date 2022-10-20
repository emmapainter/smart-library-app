//
//  smart_library_appApp.swift
//  smart-library-app
//
//  Created by Emma Painter on 23/9/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct smart_library_appApp: App {
    
    var user: User
    @State var pageNumber: Int?

    init(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        FirebaseApp.configure()
        self.user = User()
        
        // Start bluetooth paring when app opens
        let _ = BluetoothController.shared
        
        if Auth.auth().currentUser != nil {
            user.loggedIn = true
        }
    }
    
    var body: some Scene {
        
        WindowGroup {            
            if user.loggedIn {
                MainTabView()
                .environmentObject(self.user)
            } else {
                SignInView()
                .environmentObject(self.user)
            }
        }
    }
}
