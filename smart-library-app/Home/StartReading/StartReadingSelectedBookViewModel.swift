//
//  StartReadingSelectedBookViewModel.swift
//  smart-library-app
//
//  Created by Emma Painter on 7/10/2022.
//

import Foundation

@MainActor class StartReadingSelectedBookViewModel: ObservableObject {
    @Published var book: BookEdition?
    let bookApi = BookApi()
    
    func getBook(isbn: String) {
        Task {
            do {
                self.book = try await bookApi.getBook(isbn13: isbn)
            } catch let error {
                print(error) // TODO: RK - Error handling
            }
        }
    }
}
