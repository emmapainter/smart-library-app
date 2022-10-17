//
//  BookAPIProtocol.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

protocol BookAPIProtocol {
    func getBookEdition(id: String) async throws -> BookEdition
    func getBookEdition(isbn13: String) async throws -> BookEdition
    func getBookAuthors(authorIds: [String]) async throws -> [Author]
    func searchBooks(searchQuery: String) async throws -> [Book]
    func getBookCover(isbn13: String) async throws -> String?
    func getNumberOfPages(isbn13: String) async throws -> Int?
}
