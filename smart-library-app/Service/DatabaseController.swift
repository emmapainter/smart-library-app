//
//  DatabaseController.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/17/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseController {
    let db = Firestore.firestore()
    
    func getBookmarks() async throws -> [Bookmark]? {
        guard let userId = Auth.auth().currentUser?.uid else { return nil }
        
        let bookmarkSnapshot = try await db.collection("users").document("/\(userId)").collection("bookmarks").getDocuments()
        let bookmarks = try bookmarkSnapshot.documents.map {try $0.data(as: Bookmark.self)}
        
        return bookmarks
    }
    
    func addBookmark(bookmark: Bookmark) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let _ = try await db.collection("users").document("/\(userId)").collection("bookmarks").addDocument(data: [
            "bluetoothIdentifier": bookmark.bluetoothIdentifier,
            "bookISBN13": bookmark.bookISBN13,
            "currentPageNumber": bookmark.currentPageNumber
        ])
    }
}
