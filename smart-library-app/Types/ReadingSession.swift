//
//  ReadingSession.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ReadingSession: Codable, Identifiable {
    @DocumentID var id: String?
    var startTime: Date
    var endTime: Date?
    var numberOfPages: Int?
    var bookISBN13: String
    var bookmarkId: String
    var inProgress: Bool
    
    func getTimeReading() -> Int? {
        guard let endTime = endTime else {
            return nil
        }
        
        let diffSeconds = Int(endTime.timeIntervalSince1970 - startTime.timeIntervalSince1970)
        return diffSeconds / 60
    }
}

