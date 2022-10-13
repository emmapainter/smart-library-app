//
//  StartReadingSelectedBookViewModel.swift
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

@MainActor class StartReadingSelectedBookViewModel: NSObject, ObservableObject, NFCTagReaderSessionDelegate {
    @Published var book: BookEdition?
    @Published var authors: [Author]?
    var detectedBookmark: Bookmark?
    var session: NFCTagReaderSession?
    var navigationController: StartReadingNavigationController?
    
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
        print("Reader session active")
    }


    nonisolated func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print("Reader session complete")
    }

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
                                
                                // TODO: EP - Error handling
                                
                                defer {
                                    Task { @MainActor in
                                        self.bookmarkFound(nfcMessage: string)
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
    
    // TODO: Update naming of "nfcMessage" to reflect what we are actually storing on nfc
    func bookmarkFound(nfcMessage: String) {
//        var readingBook = ReadingBook(book: self.book!, progress: 0)
        // TODO: EP - Assign to bookmark
        navigationController?.rootNavigationPath.append(nfcMessage)
        navigationController?.isShowingSheet = false
    }
}
