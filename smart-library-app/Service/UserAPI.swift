//
//  UserAPI.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import Foundation

class UserAPI: UserAPIProtocol {
    func getBookmarks() async throws -> [Bookmark] {
        // TODO: EP - get from Firebase
        return [
            Bookmark(bluetoothIdentifier: "1", bookISBN13: "9781408891384", currentPageNumber: 350),
            Bookmark(bluetoothIdentifier: "2", bookISBN13: "9781529029581", currentPageNumber: 19),
            Bookmark(bluetoothIdentifier: "3", bookISBN13: "9780241988725", currentPageNumber: 170),
            Bookmark(bluetoothIdentifier: "4", bookISBN13: "9780571334650", currentPageNumber: 98),
            Bookmark(bluetoothIdentifier: "5", bookISBN13: "9781786892720", currentPageNumber: 63)
        ]
    }
    
    func getBookmarkWith(id bluetoothId: String) async throws -> Bookmark {
        // TODO: EP - get from Firebase
        return Bookmark(bluetoothIdentifier: "2", bookISBN13: "9781529029581", currentPageNumber: 19)
    }
    
    func getReadingSessionsFor(book isbn13: String) async throws -> [ReadingSession] {
        // TODO: EP - get from Firebase
        return [
            ReadingSession(startTime: DateFormat().formatter.date(from: "10/08/2022")!, numberOfPages: 20, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "11/08/2022")!, numberOfPages: 5, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "12/08/2022")!, numberOfPages: 16, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "13/08/2022")!, numberOfPages: 3, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "14/08/2022")!, numberOfPages: 27, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "15/08/2022")!, numberOfPages: 31, bookISBN13: "9781786892720", bookmarkId: "1"),
            ReadingSession(startTime: DateFormat().formatter.date(from: "17/08/2022")!, numberOfPages: 7, bookISBN13: "9781786892720", bookmarkId: "1")
        ]
    }
}
