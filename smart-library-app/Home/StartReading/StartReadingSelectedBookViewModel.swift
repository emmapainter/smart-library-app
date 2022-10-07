//
//  StartReadingSelectedBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import Foundation

class StartReadingSelectedBookViewModel: ObservableObject {
    @Published var book: BookData?
    let bookDatabase = BookDatabase()
    
    func getBook(isbn: String) {
        bookDatabase.getBookByIsbn(isbn: isbn) { book in
            self.book = book
        }
    }
}
