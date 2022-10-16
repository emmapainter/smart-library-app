//
//  UserAPIProtocol.swift
//  smart-library-app
//
//  Created by Emma Painter on 13/10/2022.
//

import Foundation

protocol UserAPIProtocol {
    func getBookmarks() async throws -> [Bookmark]
    func getBookmarkWith(id bluetoothId: String) async throws -> Bookmark
}
