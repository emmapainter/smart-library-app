//
//  UserAPIProtocol.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import Foundation

protocol UserAPIProtocol {
    func getCurrentBooks() async throws -> [ReadingBook]
    func getBookmarks() async throws -> [Bookmark]
}
