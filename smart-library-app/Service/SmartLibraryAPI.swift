//
//  SmartLibraryAPI.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import Foundation

struct SmartLibraryAPI: SmartLibraryAPIProtocol, BookAPIProtocol {
    
    let db = DatabaseController()
    let bookAPI = BookAPI()
    
    // MARK: SmartLibraryAPIProtocol methods
    func getCurrentBooks(bookmarks: [Bookmark]) async throws -> [ReadingBook] {
        var books = [ReadingBook]()
        do {
            for bookmark in bookmarks {
                var book = try await self.getBookForBookmark(bookmark: bookmark)
                let sessions = try await db.getReadingSessionsFor(book: bookmark.bookISBN13)
                book.setReadingSessions(readingSessions: sessions)
                books.append(book)
            }
            return books
        } catch let error{
            // TODO: EP - Error handling
            print(error.localizedDescription)
        }
        return [ReadingBook]()
    }
    
    func getBookForBookmark(bookmark: Bookmark) async throws -> ReadingBook {
        let book = try await bookAPI.getBookEdition(isbn13: bookmark.bookISBN13)
        let sessions = [ReadingSession]()
        return ReadingBook(book: book, bookmark: bookmark, sessions: sessions)
    }
    
    func searchAllBooks(for searchQuery: String) async throws -> [Book] {
        return try await bookAPI.searchBooks(searchQuery: searchQuery)
    }
    
    func getBookmarks() async throws -> [Bookmark] {
        return try await db.getBookmarks()
    }
    
    func getReadingSessionsFor(book isbn13: String) async throws -> [ReadingSession] {
        return try await db.getReadingSessionsFor(book: isbn13)
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
