//
//  HomeView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/5/22.
//

import SwiftUI
import CodeScanner

struct HomeViewNavigationPath: Hashable {
    let btId: String
    let bookIsbn: String
}

struct HomeView: View {
    @State var navigationPath = NavigationPath()
    @EnvironmentObject private var user: User
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NowReading(rootNavigationPath: $navigationPath)
                Spacer()
            }
            .padding(16)
            .navigationTitle("Home")
            .navigationDestination(for: HomeViewNavigationPath.self, destination: { navPath in BluetoothPairingView(btId: navPath.btId, bookIsbn: navPath.bookIsbn)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

