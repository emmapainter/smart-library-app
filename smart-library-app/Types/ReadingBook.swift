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
        let totalHoursReading = getTotalHoursReading()
        if (totalHoursReading == 0) { return 0 }
        return bookmark.currentPageNumber / totalHoursReading
    }
    
    func getAverageMinutesPerDay() -> Int {
        let numberOfDaysSinceStartedReading = getNumberOfDaysSinceStartedReading()
        if (numberOfDaysSinceStartedReading == 0) { return 0 }
        return getTotalMinutesReading() / numberOfDaysSinceStartedReading
    }
    
    func getNumberOfDaysSinceStartedReading() -> Int {
        if (sessions.count == 0) { return 0 }
        return Calendar.current.dateComponents([.day], from: sessions[0].startTime, to: Date.now).day!
    }
    
    func getPagesPerDay() -> Int {
        let numberOfDaysSinceStartedReading = getNumberOfDaysSinceStartedReading()
        if (numberOfDaysSinceStartedReading == 0) { return 0 }
        return bookmark.currentPageNumber / getNumberOfDaysSinceStartedReading()
    }
    
    func getAverageMinutesPerSession() -> Int {
        if (sessions.count == 0) { return 0 }
        return getTotalMinutesReading() / sessions.count
    }
    
    func getAveragePagesPerSession() -> Int {
        if (sessions.count == 0) { return 0 }
        return bookmark.currentPageNumber / sessions.count
    }
}
