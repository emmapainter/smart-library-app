//
//  ReadingSession.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import Foundation

struct ReadingSession: Identifiable {
    var id = UUID()
    var startTime: Date
    var endTime: Date?
    var numberOfPages: Int?
    var bookISBN13: String
    var bookmarkId: String
}
