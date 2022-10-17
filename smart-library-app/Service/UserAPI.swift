//
//  UserAPI.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import Foundation

class UserAPI: UserAPIProtocol {
    let bookAPI = BookApi()
    let db = DatabaseController()
    
    func getCurrentBooks() async throws -> [ReadingBook] {
        var books = [ReadingBook]()
        do {
            let bookmarks = try await getBookmarks()
            for bookmark in bookmarks {
                books.append(try await self.getBookForBookmark(bookmark: bookmark))
            }
            return books
        } catch let error{
            // TODO: EP - Error handling
            print(error.localizedDescription)
        }
        return [ReadingBook]()
    }
    
    func getBookmarks() async throws -> [Bookmark] {
        var bookmarks = [Bookmark]()
        let bookmarksResponse = try await db.getBookmarks()
        
        if let bookmarksResponse = bookmarksResponse {
            bookmarks = bookmarksResponse
        }
        
        return bookmarks
    }
    
    func getBookmarkWith(id bluetoothId: String) async throws -> Bookmark {
        // TODO: EP - get from Firebase
        return Bookmark(bluetoothIdentifier: "2", bookISBN13: "9781529029581", currentPageNumber: 19)
    }
    
    func getReadingSessionsFor(book isbn13: String) async throws -> [ReadingSession] {
        // TODO: EP - get from Firebase
        return [
            ReadingSession(startTime: DateFormat().formatter.date(from: "10/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "10/08/2022 10:30"), numberOfPages: 20, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "11/08/2022 16:07")!, endTime: DateFormat().formatter.date(from: "11/08/2022 16:15"), numberOfPages: 5, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "12/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "12/08/2022 10:17"), numberOfPages: 16, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "13/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "13/08/2022 10:38"), numberOfPages: 3, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "14/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "14/08/2022 10:50"), numberOfPages: 27, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "15/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "15/08/2022 10:20"), numberOfPages: 31, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "17/08/2022 10:00")!, endTime: DateFormat().formatter.date(from: "17/08/2022 11:58"), numberOfPages: 7, bookISBN13: "9781786892720", bookmarkId: "1")
        ]
    }
}
