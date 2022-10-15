//
//  NowReadingViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import Foundation
import UIKit
import SwiftUI

@MainActor class NowReadingViewModel: NSObject, ObservableObject {
    let userAPI = UserAPI()
    @Published var readingBooks: [ReadingBook]?
    
    
    func getBooks() {
        Task {
            do {
                try await self.getCurrentBooks()
                print(readingBooks)
            } catch let error {
                print(error.localizedDescription) // TODO: EP - Error handling
            }
        }
    }
    
    private func getCurrentBooks() async throws {
        readingBooks = try await userAPI.getCurrentBooks()
    }
}
