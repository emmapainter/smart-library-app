//
//  UserAPI.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import Foundation

class UserAPI: UserAPIProtocol {
    let bookAPI = BookApi()
    
    func getCurrentBooks() async throws -> [ReadingBook] {
        var books = [ReadingBook]()
        do {
            let bookmarks = try await getBookmarks()
            for bookmark in bookmarks {
                books.append(try await self.getBookForBookmark(bookmark: bookmark))
            }
            return books
        } catch {
            // TODO: EP - Error handling
        }
        return [ReadingBook]()
    }
    
    func getBookmarks() async throws -> [Bookmark] {
        // TODO: EP - actual implementation
        return [
            Bookmark(bluetoothIdentifier: "1", bookISBN13: "9781408891384", currentPageNumber: 100),
            Bookmark(bluetoothIdentifier: "2", bookISBN13: "9781529029581", currentPageNumber: 19),
            Bookmark(bluetoothIdentifier: "3", bookISBN13: "9780241988725", currentPageNumber: 170),
            Bookmark(bluetoothIdentifier: "4", bookISBN13: "9780571334650", currentPageNumber: 98),
            Bookmark(bluetoothIdentifier: "5", bookISBN13: "9781786892720", currentPageNumber: 200)
        ]
    }
    
    func getBookmarkWith(id bluetoothId: String) async throws -> Bookmark {
        // TODO: EP - actual implementation
        return Bookmark(bluetoothIdentifier: "2", bookISBN13: "9781529029581", currentPageNumber: 19)
    }
    
    func getBookForBookmark(bookmark: Bookmark) async throws -> ReadingBook {
        let book = try await bookAPI.getBookEdition(isbn13: bookmark.bookISBN13)
        return ReadingBook(book: book, bookmark: bookmark)
    }
}
