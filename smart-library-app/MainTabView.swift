//
//  TabView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/19/22.
//

import SwiftUI

struct MainTabView: View, BluetoothControllerDelegate {
    @EnvironmentObject private var user: User
    @State var showingPageAlert = false
    @State var pageNumber = ""
    var deviceUUID: UUID?
    
    var body: some View {
        ContentView().alert("Important message", isPresented: $showingPageAlert) {
            TextField("Enter your page number", text: $pageNumber)
            Button("OK", role: .cancel) {
                guard let deviceUUID = deviceUUID, let readingBook = user.getReadingBookFromBookmarkId(bookmarkId: deviceUUID.uuidString) else {
                    Swift.print("Tried to update reading session for a book")
                    return
                }
                
                Task {
                    do {
                        print(pageNumber)
                        try await user.stopReadingSession(readingBook: readingBook, pages: 10)
                    } catch let error {
                        print(error)
                    }
                    
                }
            }
        }
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
            BluetoothController.shared.addDelegate(delegate: self)
            Task {
                do {
                    try await user.fetchUserData()
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    @MainActor mutating func bluetoothDeviceDidSendData(deviceUUID: UUID, data: String) {
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
            self.deviceUUID = deviceUUID
            showingPageAlert = true
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
