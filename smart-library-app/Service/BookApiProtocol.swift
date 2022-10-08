//
//  BookApiProtocol.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

protocol BookApiProtocol {
//    func getBook(id: String) async throws -> Book
//    func getBook(isbn13: String) async throws -> Book
    func searchBooks(searchQuery: String) async throws -> [Book]
}
