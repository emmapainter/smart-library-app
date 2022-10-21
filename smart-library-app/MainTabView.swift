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
    @State var deviceUUID: UUID?
    
    var body: some View {
        ContentView().alert("Update your page number", isPresented: $showingPageAlert) {
            TextField("Enter your page number", text: $pageNumber)
            Button("OK", role: .cancel) {
                guard let deviceUUID = deviceUUID, let readingBook = user.getReadingBookFromBookmarkId(bookmarkId: deviceUUID.uuidString) else {
                    Swift.print("Tried to update reading session for a book")
                    return
                }
                
                guard let pageNumber = Int(pageNumber) else {return}
                
                let currentPage = readingBook.bookmark.currentPageNumber
                let numberOfPagesRead = pageNumber - currentPage
                
                
                Task {
                    do {
                        try await user.setPageNumbers(readingBook: readingBook, pages: max(numberOfPagesRead, 0))
                        
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
            Task {
                do {
                    if (try await user.stopReadingSession(readingBook: readingBook)) {
                        self.deviceUUID = deviceUUID
                        self.showingPageAlert = true
                    }
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
