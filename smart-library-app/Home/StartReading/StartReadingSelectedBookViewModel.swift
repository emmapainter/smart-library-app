//
//  StartReadingSelectedBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import Foundation

private enum IdType {
    case id
    case isbn13
}

@MainActor class StartReadingSelectedBookViewModel: ObservableObject {
    @Published var book: BookEdition?
    @Published var authors: [Author]?
    
    let bookApi = BookApi()
    
    func getBook(isbn: String) {
        Task {
            do {
                try await getBookData(id: isbn, idType: .isbn13)
            } catch let error {
                print(error) // TODO: RK - Error handling
            }
        }
    }
    
    func getBook(id: String) {
        Task {
            do {
                try await getBookData(id: id, idType: .id)
            } catch let error {
                print(error) // TODO: RK - Error handling
            }
        }
    }
    
    private func getBookData(id: String, idType: IdType) async throws -> Void {
        
        var book: BookEdition?
        var authors: [Author]?
        
        // Fetch book data from api
        switch idType {
        case .id:
            book = try await bookApi.getBookEdition(id: id)
            break
        case .isbn13:
            book = try await bookApi.getBookEdition(isbn13: id)
            break
        }
        
        // Fetch authors (if the book data has any authors)
        if let book = book, let authorIds = book.authorIds {
            authors = try await bookApi.getBookAuthors(authorIds: authorIds)
        }
        
        // set view model data together to avoid them appearing on the screen separately
        self.book = book
        self.authors = authors
    }
}
