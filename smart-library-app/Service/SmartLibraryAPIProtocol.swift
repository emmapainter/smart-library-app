//
//  SmartLibraryAPIProtocol.swift
//  smart-library-app
//
//  Created by Emma Painter on 17/10/2022.
//

import Foundation

protocol SmartLibraryAPIProtocol {
    func getCurrentBooks() async throws -> [ReadingBook]
    func getBookForBookmarkWith(id bluetoothId: String) async throws -> ReadingBook
    func searchAllBooks(for searchQuery: String) async throws -> [Book]
}
