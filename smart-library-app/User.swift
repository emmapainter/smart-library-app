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
                try await fetchUserData()
            } catch let error {
                print(error)
            }
        }
    }
    
    func fetchUserData() async throws {
        self.bookmarks = try await self.smartLibrary.getBookmarks()
        self.readingBooks = try await self.smartLibrary.getCurrentBooks(bookmarks: self.bookmarks)
        for bookmark in bookmarks {
            connectBookmarks(bookmark: bookmark)
        }
    }
    
    func addBookmark(bluetoothIdentifier: String, bookISBN13: String, currentPageNumber: Int) {
        var newBookmark = Bookmark(bluetoothIdentifier: bluetoothIdentifier, bookISBN13: bookISBN13, currentPageNumber: currentPageNumber)
        Task {
            do {
                let bookmarkId = try await db.addBookmark(bookmark: newBookmark)
                newBookmark.id = bookmarkId
                bookmarks.append(newBookmark)

                let book = try await getBookForBookmark(bookmark: newBookmark)
                self.readingBooks.append(book)
            }
        }
    }
    
    func startReadingSession(readingBook: ReadingBook) async throws {
        var newReadingSession = ReadingSession(startTime: Date.now, bookISBN13: readingBook.bookmark.bookISBN13, bookmarkId: readingBook.bookmark.bluetoothIdentifier, inProgress: true)
        let readingBookIndex = readingBooks.firstIndex(of: readingBook)
        
        guard let readingBookIndex = readingBookIndex else {
            print("tried to add a reading session to a book not available in user")
            return
        }
        
        
        let readingSessionId = try db.addReadingSession(readingSession: newReadingSession)
        newReadingSession.id = readingSessionId
        readingBooks[readingBookIndex].sessions.append(newReadingSession)
    }
    
    func stopReadingSession(readingBook: ReadingBook, pages: Int) async throws {
        let currentReadingSession = try await db.getInProgressReadingSession(bookmark: readingBook.bookmark)
        
        guard var currentReadingSession = currentReadingSession else {
            print("Tried to end a reading session when no current session existed")
            return
        }
                
        currentReadingSession.endTime = Date.now
        currentReadingSession.numberOfPages = pages
        currentReadingSession.inProgress = false
        
        var bookmark = readingBook.bookmark
        bookmark.currentPageNumber += currentReadingSession.numberOfPages ?? 0
        
        // update bookmark and readingSession in user object
        guard let readingBookIndex = readingBooks.firstIndex(of: readingBook) else {
            print("tried to add a reading session to a book not available in user")
            return
        }
        
        readingBooks[readingBookIndex].bookmark = bookmark
        try db.updateBookmark(bookmark: bookmark)
        
        guard let sessionIndex = readingBooks[readingBookIndex].sessions.firstIndex(where: {$0.id == currentReadingSession.id}) else {
            print("tried to add a reading session to a book not available in user")
            return
        }
        
        readingBooks[readingBookIndex].sessions[sessionIndex] = currentReadingSession
        try db.updateReadingSession(session: currentReadingSession)
    }
    
    func getBookForBookmark(bookmark: Bookmark) async throws -> ReadingBook {
        let book = try await smartLibrary.getBookEdition(isbn13: bookmark.bookISBN13)
        return ReadingBook(book: book, bookmark: bookmark)
    }
    
    func connectBookmarks(bookmark: Bookmark) {
        print("connecting")
        BluetoothController.shared.startScanning(btDeviceUuid: UUID(uuidString: bookmark.bluetoothIdentifier))
    }
}

