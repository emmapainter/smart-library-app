//
//  SmartLibraryAPIProtocol.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import Foundation

protocol SmartLibraryAPIProtocol {
    func getCurrentBooks(bookmarks: [Bookmark]) async throws -> [ReadingBook]
    func getBookForBookmark(bookmark: Bookmark) async throws -> ReadingBook
    func searchAllBooks(for searchQuery: String) async throws -> [Book]
}
