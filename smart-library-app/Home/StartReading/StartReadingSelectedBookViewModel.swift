//
//  StartReadingSelectedBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import Foundation

@MainActor class StartReadingSelectedBookViewModel: ObservableObject {
    @Published var book: BookEdition?
    @Published var authors: [Author]?
    
    let bookApi = BookApi()
    
    func getBook(isbn: String) {
        Task {
            do {
                try await getBookData(isbn: isbn)
            } catch let error {
                print(error) // TODO: RK - Error handling
            }
        }
    }
    
    private func getBookData(isbn: String) async throws -> Void {
        
        // Fetch book data from api
        let book = try await bookApi.getBookEdition(isbn13: isbn)
        var authors: [Author]?
        
        // Fetch authors (if the book data has any authors)
        if let authorIds = book.authorIds {
            authors = try await bookApi.getBookAuthors(authorIds: authorIds)
        }
        
        // set view model data together to avoid them appearing on the screen separately
        self.book = book
        self.authors = authors
    }
}
