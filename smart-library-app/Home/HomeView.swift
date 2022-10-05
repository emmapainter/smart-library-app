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
    @State private var scannedISBN = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Scan your book") {
                    isShowingScanner = true
                }
                Text(scannedISBN)
                    .padding(10)
                
            }
            .navigationTitle("Home")
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.ean13], simulatedData: "9780804139298", completion: handleScan)
        }
        
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            scannedISBN = result.string
        case .failure(let error):
            // TODO: RK - Error handling
            print("Something went wrong... \(error.localizedDescription)")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
