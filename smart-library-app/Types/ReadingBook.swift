//
//  ReadingBook.swift
//  smart-library-app
//
//  Created by Emma Painter on 6/10/2022.
//

import UIKit

// used for displaying information in the app
struct ReadingBook: Hashable {
    static func == (lhs: ReadingBook, rhs: ReadingBook) -> Bool {
        return lhs.book.isbn13 == rhs.book.isbn13 && lhs.bookmark.bluetoothIdentifier == rhs.bookmark.bluetoothIdentifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(book.isbn13)
        hasher.combine(bookmark.bluetoothIdentifier)
    }
    
    var book: BookEdition
    var bookmark: Bookmark
}
