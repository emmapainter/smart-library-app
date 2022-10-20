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
    
    func getBookmarks() async throws -> [Bookmark] {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        
        let bookmarkSnapshot = try await db.collection("users").document("/\(userId)").collection("bookmarks").getDocuments()
        let bookmarks = try bookmarkSnapshot.documents.map {try $0.data(as: Bookmark.self)}
        
        return bookmarks
    }
    
    func getReadingSessionsFor(book isbn13: String) async throws -> [ReadingSession] {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        
        let sessionsSnapshot = try await db.collection("users").document("/\(userId)").collection("sessions").whereField("bookISBN13", isEqualTo: isbn13).order(by: "startTime", descending: false).getDocuments()
        let sessions = try sessionsSnapshot.documents.map {try $0.data(as: ReadingSession.self)}
        
        return sessions
    }
    
    func addBookmark(bookmark: Bookmark) async throws -> String {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        
        let newDocReference = try await db.collection("users").document("/\(userId)").collection("bookmarks").addDocument(data: [
            "bluetoothIdentifier": bookmark.bluetoothIdentifier,
            "bookISBN13": bookmark.bookISBN13,
            "currentPageNumber": bookmark.currentPageNumber
        ])
        
        return newDocReference.documentID
    }
    
    func updateBookmark(bookmark: Bookmark) throws {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        guard let bookmarkId = bookmark.id else { fatalError("Tried to update a bookmark without an id") }
        
        let _ = try db.collection("users").document("/\(userId)").collection("bookmarks").document(bookmarkId).setData(from: bookmark)
    }
    
    func addReadingSession(readingSession: ReadingSession) throws -> String {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        
        let collectionRef =  db.collection("users").document("/\(userId)").collection("sessions")
        let newDocReference = try collectionRef.addDocument(from: readingSession)
        print("Book stored with new document reference: \(newDocReference)")
        
        return newDocReference.documentID
    }
    
    func getInProgressReadingSession(bookmark: Bookmark) async throws -> ReadingSession? {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        
        let sessionsSnapshot = try await db.collection("users").document("/\(userId)").collection("sessions").whereField("bookISBN13", isEqualTo: bookmark.bookISBN13).whereField("inProgress", isEqualTo: true).getDocuments()
        
        let session = try sessionsSnapshot.documents.first?.data(as: ReadingSession.self)
        return session
    }
    
    func updateReadingSession(session: ReadingSession) throws {
        guard let userId = Auth.auth().currentUser?.uid else { fatalError("No user is authenticated") }
        guard let sessionId = session.id else { fatalError("Tried to update a session without an id") }
        
        let _ = try db.collection("users").document("/\(userId)").collection("sessions").document(sessionId).setData(from: session)
    }
}
