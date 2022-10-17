//
//  ReadingBook.swift
//  smart-library-app
//
//  Created by Emma Painter on 6/10/2022.
//

import UIKit

// used for displaying information in the app
struct ReadingBook: Hashable {
    static func == (lhs: ReadingBook, rhs: ReadingBook) -> Bool {
        return lhs.book.isbn13 == rhs.book.isbn13 && lhs.bookmark.bluetoothIdentifier == rhs.bookmark.bluetoothIdentifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(book.isbn13)
        hasher.combine(bookmark.bluetoothIdentifier)
    }
    
    var book: BookEdition
    var bookmark: Bookmark
    var sessions = [ReadingSession]()
    
    func getTotalHoursReading() -> Int {
        return getTotalMinutesReading() / 60
    }
    
    func getTotalMinutesReading() -> Int {
        var time = 0
        for session in sessions {
            if let minutes = session.getTimeReading() {
                time += minutes
            }
        }
        return time
    }
    
    func getPagesPerHour() -> Int {
        return bookmark.currentPageNumber / getTotalHoursReading()
    }
    
    func getAverageMinutesPerDay() -> Int {
        return getTotalMinutesReading() / getNumberOfDaysSinceStartedReading()
    }
    
    func getNumberOfDaysSinceStartedReading() -> Int {
        return Calendar.current.dateComponents([.day], from: sessions[0].startTime, to: Date.now).day!
    }
    
    func getPagesPerDay() -> Int {
        return bookmark.currentPageNumber / getNumberOfDaysSinceStartedReading()
    }
    
    func getAverageMinutesPerSession() -> Int {
        return getTotalMinutesReading() / sessions.count
    }
    
    func getAveragePagesPerSession() -> Int {
        return bookmark.currentPageNumber / sessions.count
    }
}
