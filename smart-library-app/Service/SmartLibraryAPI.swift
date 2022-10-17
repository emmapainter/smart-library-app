//
//  SmartLibraryAPI.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import Foundation

struct SmartLibraryAPI: SmartLibraryAPIProtocol, UserAPIProtocol, BookAPIProtocol {
    
    let bookAPI = BookAPI()
    let userAPI = UserAPI()
    
    // MARK: SmartLibraryAPIProtocol methods
    func getCurrentBooks() async throws -> [ReadingBook] {
        var books = [ReadingBook]()
        do {
            let bookmarks = try await userAPI.getBookmarks()
            for bookmark in bookmarks {
                books.append(try await self.getBookForBookmarkWith(id: bookmark.bluetoothIdentifier))
            }
            return books
        } catch let error{
            // TODO: EP - Error handling
            print(error.localizedDescription)
        }
        return [ReadingBook]()
    }
    
    func getBookForBookmarkWith(id bluetoothId: String) async throws -> ReadingBook {
        let bookmark = try await userAPI.getBookmarkWith(id: bluetoothId)
        let book = try await bookAPI.getBookEdition(isbn13: bookmark.bookISBN13)
        let sessions = try await userAPI.getReadingSessionsFor(book: bookmark.bookISBN13)
        return ReadingBook(book: book, bookmark: bookmark, sessions: sessions)
    }
    
    func searchAllBooks(for searchQuery: String) async throws -> [Book] {
        return try await bookAPI.searchBooks(searchQuery: searchQuery)
    }
    
    // MARK: UserAPIProtocol methods
    func getBookmarks() async throws -> [Bookmark] {
        return try await userAPI.getBookmarks()
    }
    
    func getBookmarkWith(id bluetoothId: String) async throws -> Bookmark {
        return try await userAPI.getBookmarkWith(id: bluetoothId)
    }
    
    func getReadingSessionsFor(book isbn13: String) async throws -> [ReadingSession] {
        return try await userAPI.getReadingSessionsFor(book: isbn13)
    }
    
    // MARK: BookAPIProtocol methods
    func getBookEdition(id: String) async throws -> BookEdition {
        return try await bookAPI.getBookEdition(id: id)
    }
    
    func getBookEdition(isbn13: String) async throws -> BookEdition {
        return try await bookAPI.getBookEdition(isbn13: isbn13)
    }
    
    func getBookAuthors(authorIds: [String]) async throws -> [Author] {
        return try await bookAPI.getBookAuthors(authorIds: authorIds)
    }
    
    func searchBooks(searchQuery: String) async throws -> [Book] {
        return try await bookAPI.searchBooks(searchQuery: searchQuery)
    }
    
    func getBookCover(isbn13: String) async throws -> String? {
        return try await bookAPI.getBookCover(isbn13: isbn13)
    }
    
    func getNumberOfPages(isbn13: String) async throws -> Int? {
        return try await bookAPI.getNumberOfPages(isbn13: isbn13)
    }
}
