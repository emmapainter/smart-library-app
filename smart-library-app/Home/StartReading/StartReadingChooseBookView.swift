//
//  ChooseBookSheetView.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import SwiftUI
import CodeScanner

struct StartReadingChooseBookView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigationPath = NavigationPath()
    let bookDatabase = BookDatabase()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NavigationLink(destination: CodeScannerView(codeTypes: [.ean13], simulatedData: "‎9780141037257", completion: handleScan)) {
                    Text("Scan")
                }
                .buttonStyle(PrimaryButtonStyle())
                Text("or")
                    .padding()
                Button("Search") {
                    print("Search")
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding(16)
            .navigationBarTitle(Text("Choose a Book"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.dismiss()
            }) {
                Text("Cancel").bold()
            })
            .navigationDestination(for: String.self, destination: { isbn in  StartReadingSelectedBookView(isbn: isbn)
            })
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let scannedISBN = result.string
            navigationPath.append(scannedISBN)
            
        case .failure(let error):
            // TODO: RK - Error handling
            print("Something went wrong... \(error.localizedDescription)")
        }
    }
}

struct ChooseBookSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StartReadingChooseBookView()
    }
}
