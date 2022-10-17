//
//  HomeView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/5/22.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    @State var navigationPath = NavigationPath()
    @EnvironmentObject private var user: User
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NowReading(rootNavigationPath: $navigationPath)
                Spacer()
                Button("Add book") {
                    user.addBookmark(bluetoothIdentifier: "12345", bookISBN13: "9781783789146", currentPageNumber: 10)
                }
            }
            .padding(16)
            .navigationTitle("Home")
            .navigationDestination(for: String.self, destination: { btId in  BluetoothPairingView(btId: btId)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

