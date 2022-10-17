//
//  User.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/17/22.
//

import Foundation

class User: ObservableObject {
    @Published var bookmarks = [Bookmark]()
    @Published var readingBooks = [ReadingBook]()
    private let db = DatabaseController()
    private let bookAPI = BookApi()
    
    init() {
        Task { @MainActor in
            do {
                let bookmarks = try await db.getBookmarks()
                guard let bookmarks = bookmarks else { return }
                self.bookmarks = bookmarks
                
                for bookmark in bookmarks {
                    let book = try await getBookForBookmark(bookmark: bookmark)
                    self.readingBooks.append(book)
                }
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func addBookmark(bluetoothIdentifier: String, bookISBN13: String, currentPageNumber: Int) {
        let newBookmark = Bookmark(bluetoothIdentifier: bluetoothIdentifier, bookISBN13: bookISBN13, currentPageNumber: currentPageNumber)
        Task {
            do {
                try await db.addBookmark(bookmark: newBookmark)
                bookmarks.append(newBookmark)
                
                let book = try await getBookForBookmark(bookmark: newBookmark)
                self.readingBooks.append(book)
            }
        }
    }
    
    func getBookForBookmark(bookmark: Bookmark) async throws -> ReadingBook {
        let book = try await bookAPI.getBookEdition(isbn13: bookmark.bookISBN13)
        return ReadingBook(book: book, bookmark: bookmark)
    }
}

