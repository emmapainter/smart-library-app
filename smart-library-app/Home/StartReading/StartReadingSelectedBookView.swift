//
//  StartReadingSelectedBookView.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import SwiftUI
import CoreNFC

struct StartReadingSelectedBookView: View {
    var id: String?
    var isbn: String?
    @StateObject var viewModel = StartReadingSelectedBookViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        
        if let book = viewModel.book {
            VStack {
                Spacer()
                AsyncImage(
                    url: viewModel.book?.getImageUrl(size: .large),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .cornerRadius(10)
                    },
                    placeholder: {
                        ProgressView()
                    })
                .padding(.bottom)
                        .frame(height: 300)
                Text(book.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text(viewModel.authors?.map {$0.name}.joined(separator: ", ") ?? "-")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.top, 3.0)
                Spacer()
                Button("Start Reading") {
                    scanBookmark(self)
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(16)
            .alert("Near field communication not enabled", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Near field communication is required to scan your bookmark, please enable NFC permissions in your settings.")
            }
        } else {
            ProgressView()
                .onAppear() {
                    if let isbn = isbn {
                        viewModel.getBook(isbn: isbn)
                    }
                    
                    if let id = id {
                        viewModel.getBook(id: id)
                    }
                }
        }
    }
    
    func scanBookmark(_ sender: Any) {
        guard NFCTagReaderSession.readingAvailable else {
            showingAlert = true
            return
        }
        viewModel.session = NFCTagReaderSession(pollingOption: .iso14443, delegate: viewModel)
        viewModel.session?.alertMessage = "Tap your bookmark to assign it to this book."
        viewModel.session?.begin()
    }
}

struct StartReadingSelectedBookView_Previews: PreviewProvider {
    static var previews: some View {
        StartReadingSelectedBookView(isbn: "‎9780747532743")
    }
}
