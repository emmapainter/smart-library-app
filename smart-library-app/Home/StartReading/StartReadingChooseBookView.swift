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
    @State private var isShowingStartReading = false
    @State private var navigationPath = NavigationPath()
    let bookDatabase = BookDatabase()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NavigationLink(destination: CodeScannerView(codeTypes: [.ean13], simulatedData: "‎9780439708180", completion: handleScan)) {
                    Text("Scan")
                        .frame(maxWidth: .infinity)
                    
                }
                .buttonStyle(PrimaryButtonStyle())
                Text("or")
                    .padding()
                Button {
                    print("Search")
                } label: {
                    Text("Search")
                        .frame(maxWidth: .infinity)
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
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            let scannedISBN = result.string
            
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
