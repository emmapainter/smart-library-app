//
//  HomeView.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/5/22.
//

import SwiftUI
import CodeScanner

struct HomeView: View {
    
    @State private var isShowingScanner = false
    @State private var scannedBook: BookData?
    @State private var isLoading = false
    
    let bookDatabase = BookDatabase()
    
    var body: some View {
        NavigationStack {
            VStack {
                NowReading()
                Spacer()
            }
            .padding(16)
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
