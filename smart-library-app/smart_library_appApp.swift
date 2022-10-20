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
struct smart_library_appApp: App, BluetoothControllerDelegate {
    
    var user: User
    @State var showingPageAlert = true
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
        BluetoothController.shared.addDelegate(delegate: self)
        let _ = BluetoothController.shared
        
        if Auth.auth().currentUser != nil {
            user.loggedIn = true
        }
    }
    
    var body: some Scene {
        
        WindowGroup {
//            ContentView().alert("Important message", isPresented: $showingPageAlert) {
//                Button("OK", role: .cancel) {
//                }
//            }
            
            if user.loggedIn {
                MainTabView()
                .environmentObject(self.user)
            } else {
                SignInView()
                .environmentObject(self.user)
            }
        }
    }
    
    func showAlert() {
        self.showingPageAlert = true
    }
    
    @MainActor func bluetoothDeviceDidSendData(deviceUUID: UUID, data: String) {
        print("Device: \(deviceUUID.description)")
        print("Data: \(data)")
        
        guard let readingBook = user.getReadingBookFromBookmarkId(bookmarkId: deviceUUID.uuidString) else {
            Swift.print("Tried to update reading session for a book")
            return
        }
        
        if data == "1" {
            Task {
                do {
                    try await user.startReadingSession(readingBook: readingBook)
                } catch let error {
                    print(error)
                }
            }
        }
        
        if data == "0" {
            print("Stoped reading")
            showAlert()
            Task {
                do {
                    try await user.stopReadingSession(readingBook: readingBook, pages: 10)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
