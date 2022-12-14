//
//  ChooseBookSheetView.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import SwiftUI
import CodeScanner

struct StartReadingChooseBookView: View {
    @State private var navigationPath = NavigationPath()
    @Binding var isShowingSheet: Bool
    @Binding var rootNavigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                NavigationLink(destination: CodeScannerView(codeTypes: [.ean13], simulatedData: "‎9780747532743", completion: handleScan)) {
                    Text("Scan")
                }
                .buttonStyle(PrimaryButtonStyle())
                Text("or")
                    .padding()
                NavigationLink(destination: SearchView(), label: {
                    Text("Search")
                })
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding(16)
            .navigationBarTitle(Text("Choose a Book"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.isShowingSheet = false
            }) {
                Text("Cancel").bold()
            })
            .navigationDestination(for: String.self, destination: { isbn in  StartReadingSelectedBookView(isbn: isbn, rootNavigationPath: $rootNavigationPath, isShowingSheet: $isShowingSheet)
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
