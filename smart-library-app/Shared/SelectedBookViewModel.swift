//
//  SelectedBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import Foundation
import CoreNFC
import UIKit
import SwiftUI

private enum IdType {
    case id
    case isbn13
}

@MainActor class SelectedBookViewModel: NSObject, ObservableObject, NFCTagReaderSessionDelegate {
    @Published var book: BookEdition?
    @Published var authors: [Author]?
    var detectedBookmark: Bookmark?
    var session: NFCTagReaderSession?
    @Published var hasScannedBookmark = false
    var nfcMessage = ""
    
    let bookApi = BookApi()
    
    func getBook(isbn: String) {
        Task {
            do {
                try await getBookData(id: isbn, idType: .isbn13)
            } catch let error {
                print(error) // TODO: RK - Error handling
            }
        }
    }
    
    func getBook(id: String) {
        Task {
            do {
                try await getBookData(id: id, idType: .id)
            } catch let error {
                print(error) // TODO: RK - Error handling
            }
        }
    }
    
    private func getBookData(id: String, idType: IdType) async throws -> Void {
        
        var book: BookEdition?
        var authors: [Author]?
        
        // Fetch book data from api
        switch idType {
        case .id:
            book = try await bookApi.getBookEdition(id: id)
            break
        case .isbn13:
            book = try await bookApi.getBookEdition(isbn13: id)
            break
        }
        
        // Fetch authors (if the book data has any authors)
        if let book = book, let authorIds = book.authorIds {
            authors = try await bookApi.getBookAuthors(authorIds: authorIds)
        }
        
        // set view model data together to avoid them appearing on the screen separately
        self.book = book
        self.authors = authors
    }
    
    nonisolated func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        // This method is required to conform to the protocol but I don't think we need anything here
    }


    nonisolated func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        // TODO: EP - handle error
        print("Reader session complete")
    }

    // TODO: EP - Error handling for this entire method
    nonisolated func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        for nfcTag in tags {
            session.connect(to: nfcTag) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if case let .miFare(mifareTag) = nfcTag {
                    mifareTag.readNDEF { message, error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        message?.records.forEach { record in
                            if let string = String(data: record.payload, encoding: .ascii) {
                                print(string)
                                
                                defer {
                                    Task { @MainActor in
                                        // TODO: EP - send data to firebase
                                        self.nfcMessage = string
                                        self.hasScannedBookmark = true
                                    }
                                }
                                
                                session.invalidate()
                            }
                        }
                    }
                }
            }
        }
    }
}
