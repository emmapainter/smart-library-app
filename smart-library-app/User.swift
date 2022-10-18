//
//  User.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/17/22.
//

import Foundation

@MainActor
class User: ObservableObject {
    @Published var bookmarks = [Bookmark]()
    @Published var readingBooks = [ReadingBook]()
    private let smartLibrary = SmartLibraryAPI()
    private let db = DatabaseController()
    
    init() {
        Task { @MainActor in
            do {
                self.bookmarks = try await self.smartLibrary.getBookmarks()
//                print(self.bookmarks)
                self.readingBooks = try await self.smartLibrary.getCurrentBooks(bookmarks: self.bookmarks)
//                print(self.readingBooks)
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
        let book = try await smartLibrary.getBookEdition(isbn13: bookmark.bookISBN13)
        return ReadingBook(book: book, bookmark: bookmark)
    }
}

