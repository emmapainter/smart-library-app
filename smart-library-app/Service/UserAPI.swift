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
                let book = try await bookAPI.getBookEdition(isbn13: bookmark.bookISBN13)
                books.append(ReadingBook(book: book, bookmark: bookmark))
            }
        } catch {
            // TODO: EP - Error handling
        }
        return [ReadingBook]()
    }
    
    func getBookmarks() async throws -> [Bookmark] {
        return [Bookmark(bluetoothIdentifier: "1", bookISBN13: "9781761102943", currentPageNumber: 100), Bookmark(bluetoothIdentifier: "2", bookISBN13: "9781529029581", currentPageNumber: 19)]
    }
}
