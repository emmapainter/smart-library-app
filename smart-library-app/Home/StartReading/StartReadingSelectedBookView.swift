//
//  StartReadingSelectedBookView.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import SwiftUI

struct StartReadingSelectedBookView: View {
    var isbn: String
    let bookDatabase = BookDatabase()
    @StateObject var viewModel: StartReadingSelectedBookViewModel = StartReadingSelectedBookViewModel()
    
    var body: some View {
        if let book = viewModel.book {
            Text(book.title ?? "-")
        } else {
            ProgressView()
                .onAppear() {
                    viewModel.getBook(isbn: isbn)
                }
        }
    }
}

struct StartReadingSelectedBookView_Previews: PreviewProvider {
    static var previews: some View {
        StartReadingSelectedBookView(isbn: "‎9780439708180")
    }
}
