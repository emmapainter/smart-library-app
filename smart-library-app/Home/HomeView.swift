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
                Button("Scan your book") {
                    isShowingScanner = true
                }
                if (isLoading) {
                    ProgressView()
                    .padding(10)
                } else {
                    Text(scannedBook?.title ?? "")
                    .padding(10)
                }
                
            }
            .navigationTitle("Home")
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.ean13], simulatedData: "‎9780439708180", completion: handleScan)
        }
        
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        scannedBook = nil
        
        switch result {
        case .success(let result):
            isLoading = true
            let scannedISBN = result.string
            
            bookDatabase.getBookByIsbn(isbn: scannedISBN, completion: {(book) -> Void in
                scannedBook = book
                isLoading = false
            })
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
