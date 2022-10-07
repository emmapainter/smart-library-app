//
//  NowReadingView.swift
//  smart-library-app
//
//  Created by Emma Painter on 6/10/2022.
//

import SwiftUI
import CodeScanner

struct NowReading: View {
    @State var currentBooks = [ReadingBook]()
    @State private var isShowingScanner = false
    @State private var scannedBook: BookData?
    @State private var isLoading = false
    
    let bookDatabase = BookDatabase()

    var body: some View {
        VStack {
            HStack {
                Text("Now Reading")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top, 36.0)
            Button {
                isShowingScanner = true
            } label: {
                HStack {
                    Text("Start a new book")
                    Image(systemName: "plus")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(SecondaryButtonStyle())
            if (isLoading) {
                ProgressView()
            } else {
                Text(scannedBook?.title ?? "")
            }
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

struct NowReadingView_Previews: PreviewProvider {
    static var previews: some View {
        NowReading()
    }
}
