//
//  BookEdition.swift
//  smart-library-app
//
//  Created by Riley Keane on 10/8/22.
//

import Foundation

struct BookEdition: Hashable, Identifiable {
    private let uuid = UUID()
    let id: String
    let title: String
    let description: String?
    let coverId: Int?
    let author: String?
    let authorIds: [String]?
    let publishedDate: String?
    let isbn13: String?
    let pages: Int?
}
