//
//  Bookmark.swift
//  smart-library-app
//
//  Created by Emma Painter on 9/10/2022.
//

import Foundation
import CoreNFC

struct Bookmark: Codable {
    var bluetoothIdentifier: String
    var bookISBN13: String
    var currentPageNumber: Int
}
