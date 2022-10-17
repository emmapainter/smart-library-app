//
//  ReadingBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 12/10/2022.
//

import Foundation
import UIKit

@MainActor class ReadingBookViewModel: NSObject, ObservableObject {
    @Published var book: ReadingBook?
    let libraryAPI = SmartLibraryAPI()
    
    func getBook(bookmarkBtId: String) {
        Task {
            do {
                try await self.getBookAsync(bookmarkBtId: bookmarkBtId)
            } catch {
                // TODO: EP - Error handling
            }
        }
    }
    
    private func getBookAsync(bookmarkBtId: String) async throws {
        book = try await libraryAPI.getBookForBookmarkWith(id: bookmarkBtId)
    }
}
